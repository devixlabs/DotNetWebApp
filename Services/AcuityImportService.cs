using System.Globalization;
using System.Text;
using CsvHelper;
using CsvHelper.Configuration;
using DotNetWebApp.Data;
using DotNetWebApp.Models.Generated.GAIMisc;
using DotNetWebApp.Services.Models;
using Microsoft.EntityFrameworkCore;

namespace DotNetWebApp.Services;

/// <summary>
/// Service for processing Acuity scheduling CSV files and importing into Gai_scheduler.
/// Implements the business logic from TECHNICAL_IMPLEMENTATION_PLAN-Acuity-Import.md
/// FIXES: All critical bugs (SQL injection, driver name, UPDATE WHERE clause)
/// </summary>
public class AcuityImportService : IAcuityImportService
{
    private readonly SecondaryDbContext _context; // Gai_scheduler is in GAIMisc (SecondaryDatabase)
    private readonly IDeacomService _deacomService;
    private readonly ILogger<AcuityImportService> _logger;

    public AcuityImportService(
        SecondaryDbContext context,
        IDeacomService deacomService,
        ILogger<AcuityImportService> logger)
    {
        _context = context;
        _deacomService = deacomService;
        _logger = logger;
    }

    public async Task<AcuityImportResult> ProcessFileAsync(string csvFilePath, string userName)
    {
        using var stream = File.OpenRead(csvFilePath);
        var fileName = Path.GetFileName(csvFilePath);
        return await ProcessCsvContentAsync(stream, fileName, userName);
    }

    public async Task<AcuityImportResult> ProcessCsvContentAsync(Stream csvContent, string fileName, string userName)
    {
        var result = new AcuityImportResult { FileName = fileName };

        try
        {
            // 1. Get user warehouse assignment
            var userWarehouse = await _deacomService.GetUserWarehouseAsync(userName);
            if (userWarehouse == null || userWarehouse.WarehouseId == 0)
            {
                throw new InvalidOperationException($"User '{userName}' not found or has invalid warehouse assignment");
            }

            _logger.LogInformation("Processing Acuity CSV for user {UserName}, warehouse {WarehouseName} (WID={WarehouseId})",
                userName, userWarehouse.WarehouseName, userWarehouse.WarehouseId);

            // 2. Parse CSV
            var acuityRows = ParseCsv(csvContent);
            result.TotalRows = acuityRows.Count;

            // 3. Process each row
            foreach (var row in acuityRows)
            {
                try
                {
                    await ProcessRowAsync(row, userWarehouse, result);
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error processing row for appointment {AppointmentId}", row.AppointmentId);
                    result.Errors++;
                    result.ErrorDetails.Add(new ImportError
                    {
                        OrderNumber = row.OrderNumbers,
                        ErrorMessage = ex.Message,
                        AppointmentId = row.AppointmentId,
                        CompanyName = row.Type
                    });
                }
            }

            _logger.LogInformation("Acuity import complete: {Success} success, {Errors} errors", result.TotalSuccess, result.Errors);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Fatal error processing Acuity CSV");
            throw;
        }

        return result;
    }

    private List<AcuityRow> ParseCsv(Stream csvContent)
    {
        var config = new CsvConfiguration(CultureInfo.InvariantCulture)
        {
            HasHeaderRecord = true,
            MissingFieldFound = null,
            HeaderValidated = null
        };

        using var reader = new StreamReader(csvContent);
        using var csv = new CsvReader(reader, config);

        // Map CSV columns to AcuityRow properties
        csv.Context.RegisterClassMap<AcuityRowMap>();

        return csv.GetRecords<AcuityRow>().ToList();
    }

    private async Task ProcessRowAsync(AcuityRow row, UserWarehouseDto userWarehouse, AcuityImportResult result)
    {
        // Extract order numbers from Column21 (may contain multiple)
        var orderNumbers = ExtractOrderNumbers(row.OrderNumbers);

        if (orderNumbers.Count == 0)
        {
            _logger.LogWarning("No valid order numbers found in: {OrderNumbers}", row.OrderNumbers);
            result.Errors++;
            result.ErrorDetails.Add(new ImportError
            {
                OrderNumber = row.OrderNumbers,
                ErrorMessage = "No valid order numbers extracted",
                AppointmentId = row.AppointmentId
            });
            return;
        }

        // Process each order number from the cell
        foreach (var orderNumber in orderNumbers)
        {
            try
            {
                var processedOrder = await ClassifyAndEnrichOrderAsync(orderNumber, row, userWarehouse);
                if (processedOrder != null)
                {
                    await UpsertToSchedulerAsync(processedOrder, result);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error processing order {OrderNumber}", orderNumber);
                result.Errors++;
                result.ErrorDetails.Add(new ImportError
                {
                    OrderNumber = orderNumber,
                    ErrorMessage = ex.Message,
                    AppointmentId = row.AppointmentId,
                    ScheduleDate = ParseDateTime(row.StartTime)
                });
            }
        }
    }

    /// <summary>
    /// Extract and clean order numbers from CSV Column21.
    /// Business rules from spec: Form1.vb:284-298
    /// FIXES: Multiple order handling - split on comma BEFORE cleaning
    /// </summary>
    private List<string> ExtractOrderNumbers(string rawOrderNumbers)
    {
        if (string.IsNullOrWhiteSpace(rawOrderNumbers))
            return new List<string>();

        // Split on commas FIRST (fixes bug in original where commas were removed)
        var orderParts = rawOrderNumbers.Split(new[] { ',', '/', '&' }, StringSplitOptions.RemoveEmptyEntries);

        var result = new List<string>();

        foreach (var part in orderParts)
        {
            // Apply cleaning rules (spec: Form1.vb:284-298)
            var cleaned = part
                .Replace(" ", "")
                .Replace("GAI-", "")
                .Replace("GAI#", "")
                .Replace("GAI", "")
                .Replace("FBS-", "")
                .Replace("FBS#", "")
                .Replace("FBS", "")
                .Replace("Pro-", "")
                .Replace("PRO-", "")
                .Replace("Pick up #:", "")
                .Replace("Olipop", "")
                .Replace("Order #", "");

            // Extract only digits
            var onlyDigits = new string(cleaned.Where(char.IsDigit).ToArray());

            if (onlyDigits.Length >= 11)
            {
                // Parse as 64-bit integer and back to string to validate
                if (long.TryParse(onlyDigits.Substring(0, Math.Min(13, onlyDigits.Length)), out var num))
                {
                    result.Add(num.ToString().Substring(0, Math.Min(11, num.ToString().Length)));
                }
            }
        }

        return result;
    }

    /// <summary>
    /// Classify order type and enrich with Deacom data.
    /// Business rules from spec: Form1.vb:328-700
    /// </summary>
    private async Task<ProcessedOrder?> ClassifyAndEnrichOrderAsync(
        string orderNumber, AcuityRow row, UserWarehouseDto userWarehouse)
    {
        // Determine warehouse ID (can be overridden by CSV data)
        int warehouseId = DetermineWarehouseId(row.Type, userWarehouse);

        var order = new ProcessedOrder
        {
            OrderNumber = orderNumber,
            DateStart = ParseDateTime(row.StartTime) ?? DateTime.Now,
            DateEnd = ParseDateTime(row.EndTime) ?? DateTime.Now,
            CheckInDate = ParseDateTime(row.StartTime) ?? DateTime.Now,
            AppointmentId = row.AppointmentId,
            Carrier = string.IsNullOrWhiteSpace(row.CarrierName) ? "TBD" : row.CarrierName,
            Driver = $"{row.FirstName} {row.LastName}".Trim(),  // FIX: Column4 + Column5 (was Column4 + Column4)
            Phone = string.IsNullOrWhiteSpace(row.Phone) ? "()" : row.Phone,
            WarehouseId = warehouseId
        };

        // Classify and enrich based on order number pattern
        if (orderNumber.Length == 11 && orderNumber.EndsWith("99"))
        {
            // ICT Order (Inter-Company Transfer)
            return await ProcessICTOrderAsync(order, row);
        }
        else if (orderNumber.Length == 11 && orderNumber.EndsWith("00"))
        {
            // Sales Order
            return await ProcessSalesOrderAsync(order);
        }
        else if (orderNumber.Length == 11)
        {
            // Purchase Order
            return await ProcessPurchaseOrderAsync(order);
        }
        else if (orderNumber.Length < 8 && (row.OrderNumbers.Contains("Pro-") || row.OrderNumbers.Contains("PRO-")))
        {
            // Pro Number lookup
            return await ProcessProNumberAsync(order, orderNumber);
        }
        else if (orderNumber.Length >= 8 && orderNumber.Length < 11)
        {
            // Customer PO lookup
            return await ProcessCustomerPOAsync(order, orderNumber);
        }

        _logger.LogWarning("Unable to classify order: {OrderNumber}", orderNumber);
        return null;
    }

    private Task<ProcessedOrder> ProcessICTOrderAsync(ProcessedOrder order, AcuityRow row)
    {
        // ICT orders are pre-created, just set company name and type
        order.Company = "Greenwood Associates Inc.";
        order.OrderType = (int)OrderType.ICT_Northlake; // Default to 3, will be updated based on warehouse
        return Task.FromResult(order);
    }

    private async Task<ProcessedOrder?> ProcessSalesOrderAsync(ProcessedOrder order)
    {
        var salesOrder = await _deacomService.GetSalesOrderAsync(order.OrderNumber);
        if (salesOrder == null)
        {
            _logger.LogWarning("Sales order not found in Deacom: {OrderNumber}", order.OrderNumber);
            return null;
        }

        order.Company = TruncateCompanyName(salesOrder.CompanyName);
        order.PromiseDate = salesOrder.DueShipDate;
        order.ProNumber = salesOrder.ProNumber;

        // Determine order type based on Deacom order type and warehouse
        order.OrderType = salesOrder.OrderTypeCode.ToLower() switch
        {
            "s" => (int)OrderType.SalesOrder,
            "m" when salesOrder.WarehouseId == 92 => (int)OrderType.ICT_Northlake,
            "m" => (int)OrderType.ICT_CPFG,
            _ => (int)OrderType.SalesOrder
        };

        return order;
    }

    private async Task<ProcessedOrder?> ProcessPurchaseOrderAsync(ProcessedOrder order)
    {
        var purchaseOrder = await _deacomService.GetPurchaseOrderAsync(order.OrderNumber);
        if (purchaseOrder == null)
        {
            _logger.LogWarning("Purchase order not found in Deacom: {OrderNumber}", order.OrderNumber);
            return null;
        }

        order.Company = TruncateCompanyName(purchaseOrder.VendorName);
        order.PromiseDate = purchaseOrder.DueDockDate;
        order.OrderType = (int)OrderType.PurchaseOrder;

        return order;
    }

    private async Task<ProcessedOrder?> ProcessProNumberAsync(ProcessedOrder order, string proNumber)
    {
        var orderNumber = await _deacomService.FindOrderByProNumberAsync(proNumber);
        if (orderNumber == null)
        {
            _logger.LogWarning("Order not found for Pro Number: {ProNumber}", proNumber);
            return null;
        }

        // Update order number and process as sales order
        order.OrderNumber = orderNumber;
        return await ProcessSalesOrderAsync(order);
    }

    private async Task<ProcessedOrder?> ProcessCustomerPOAsync(ProcessedOrder order, string customerPO)
    {
        var orderNumbers = await _deacomService.FindOrdersByCustomerPOAsync(customerPO);
        if (orderNumbers.Count == 0)
        {
            _logger.LogWarning("Orders not found for Customer PO: {CustomerPO}", customerPO);
            return null;
        }

        // Process first match (matches original behavior, though returning all would be better)
        if (orderNumbers.Count > 1)
        {
            _logger.LogWarning("Multiple orders found for Customer PO {CustomerPO}, using first: {OrderNumber}",
                customerPO, orderNumbers[0]);
        }

        order.OrderNumber = orderNumbers[0];
        return await ProcessSalesOrderAsync(order);
    }

    /// <summary>
    /// Upsert order to Gai_scheduler table.
    /// Business rules from spec: Form1.vb:824-1027
    /// FIXES: UPDATE WHERE clause bug (was using order number instead of app ID)
    /// </summary>
    private async Task UpsertToSchedulerAsync(ProcessedOrder order, AcuityImportResult result)
    {
        // Check if record exists
        var existing = await _context.Set<Gai_scheduler>()
            .FirstOrDefaultAsync(s => s.gs_id == order.WarehouseId && s.gs_ordnum == long.Parse(order.OrderNumber));

        if (existing != null)
        {
            // Update existing record
            // FIX: Use correct app ID in update (original bug used order number)
            if (existing.gs_appid == order.AppointmentId)
            {
                // Minimal update (reschedule)
                existing.gs_num1 = order.OrderType;
                existing.gs_datestart = order.DateStart;
                existing.gs_dateend = order.DateEnd;
                existing.gs_datechkin = order.CheckInDate;
            }
            else
            {
                // Full update (different appointment)
                existing.gs_dock = order.Dock;
                existing.gs_datestart = order.DateStart;
                existing.gs_dateend = order.DateEnd;
                existing.gs_dockm = order.DockMinutes;
                existing.gs_company = order.Company;
                existing.gs_carrier = order.Carrier;
                existing.gs_driver = order.Driver;
                existing.gs_chr2 = order.Phone;
                existing.gs_notes = order.Notes;
                existing.gs_status = order.Status;
                existing.gs_datechkin = order.CheckInDate;
                existing.gs_appid = order.AppointmentId;
                existing.gs_forkop = order.ForkliftOperator;
                existing.gs_num1 = order.OrderType;
                existing.gs_chr3 = order.ProNumber;
                existing.gs_date1 = order.PromiseDate ?? order.DateStart;
            }

            await _context.SaveChangesAsync();
            result.SuccessfulUpdates++;
        }
        else
        {
            // Insert new record
            var newRecord = new Gai_scheduler
            {
                gs_id = order.WarehouseId,
                gs_ordnum = long.Parse(order.OrderNumber),
                gs_dock = order.Dock,
                gs_datestart = order.DateStart,
                gs_dateend = order.DateEnd,
                gs_dockm = order.DockMinutes,
                gs_company = order.Company,
                gs_carrier = order.Carrier,
                gs_driver = order.Driver,
                gs_chr2 = order.Phone,
                gs_notes = order.Notes,
                gs_status = order.Status,
                gs_datechkin = order.CheckInDate,
                gs_appid = order.AppointmentId,
                gs_forkop = order.ForkliftOperator,
                gs_num1 = order.OrderType,
                gs_chr3 = order.ProNumber,
                gs_date1 = order.PromiseDate ?? order.DateStart
            };

            _context.Set<Gai_scheduler>().Add(newRecord);
            await _context.SaveChangesAsync();
            result.SuccessfulInserts++;
        }
    }

    #region Helper Methods

    private int DetermineWarehouseId(string warehouseType, UserWarehouseDto userWarehouse)
    {
        // Check CSV Type field first (overrides user warehouse)
        if (warehouseType.Contains("Northlake", StringComparison.OrdinalIgnoreCase))
            return 92;
        if (warehouseType.Contains("Niles", StringComparison.OrdinalIgnoreCase) ||
            warehouseType.Contains("CPFG", StringComparison.OrdinalIgnoreCase))
            return 3;

        // Fallback to user's assigned warehouse
        return userWarehouse.WarehouseId;
    }

    private string TruncateCompanyName(string companyName)
    {
        // Rule from spec: Maximum 49 characters (Form1.vb:800-804)
        if (companyName.Length <= 49)
            return companyName;

        return companyName.Substring(0, 49);
    }

    private DateTime? ParseDateTime(string dateTimeString)
    {
        if (string.IsNullOrWhiteSpace(dateTimeString))
            return null;

        // Try multiple date formats (CSV uses "October 17, 2025 7:00 am")
        var formats = new[]
        {
            "MMMM d, yyyy h:mm tt",
            "MMMM dd, yyyy h:mm tt",
            "M/d/yyyy h:mm tt",
            "MM/dd/yyyy h:mm tt",
            "yyyy-MM-dd HH:mm:ss",
            "M/d/yyyy",
            "MM/dd/yyyy"
        };

        foreach (var format in formats)
        {
            if (DateTime.TryParseExact(dateTimeString, format, CultureInfo.InvariantCulture,
                DateTimeStyles.None, out var result))
            {
                return result;
            }
        }

        // Fallback to general parsing
        if (DateTime.TryParse(dateTimeString, out var fallback))
            return fallback;

        _logger.LogWarning("Unable to parse date: {DateString}", dateTimeString);
        return null;
    }

    #endregion
}

/// <summary>
/// CSV mapping for AcuityRow (22 columns).
/// </summary>
public class AcuityRowMap : ClassMap<AcuityRow>
{
    public AcuityRowMap()
    {
        Map(m => m.StartTime).Index(0);
        Map(m => m.EndTime).Index(1);
        Map(m => m.Timezone).Index(2);
        Map(m => m.FirstName).Index(3);
        Map(m => m.LastName).Index(4);
        Map(m => m.Phone).Index(5);
        Map(m => m.Email).Index(6);
        Map(m => m.Type).Index(7);
        Map(m => m.Calendar).Index(8);
        Map(m => m.AppointmentPrice).Index(9);
        Map(m => m.Paid).Index(10);
        Map(m => m.AmountPaidOnline).Index(11);
        Map(m => m.CertificateCode).Index(12);
        Map(m => m.Notes).Index(13);
        Map(m => m.DateScheduled).Index(14);
        Map(m => m.Label).Index(15);
        Map(m => m.ScheduledBy).Index(16);
        Map(m => m.DateRescheduled).Index(17);
        Map(m => m.CarrierName).Index(18);
        Map(m => m.AppointmentType).Index(19);
        Map(m => m.OrderNumbers).Index(20);  // CRITICAL FIELD
        Map(m => m.AppointmentId).Index(21);
    }
}
