using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Models.Generated.GAIMisc;
using DotNetWebApp.Models.Generated.GAI;
using DotNetWebApp.Services.ICT.Calculators;
using DotNetWebApp.Services.ICT.Models;
using DotNetWebApp.Services.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace DotNetWebApp.Services.ICT;

/// <summary>
/// Implementation of ICT service for warehouse-to-warehouse transfers.
/// Uses EF Core for writes (INSERT/UPDATE/DELETE) and Dapper for complex reads.
/// Uses TWO Dapper services: Primary (GAI) for product queries, Secondary (GAIMisc) for order queries.
/// </summary>
public class ICTService : IICTService
{
    private readonly SecondaryDbContext _context;
    private readonly IDapperQueryService _primaryDapper;   // GAI database - for dmprod, dtfifo, dtjob queries
    private readonly IDapperQueryService _secondaryDapper; // GAIMisc database - for gai_scheduler, gai_allocate queries
    private readonly IICTOrderNumberService _orderNumberService;
    private readonly IDeacomService _deacomService;
    private readonly ILogger<ICTService> _logger;

    public ICTService(
        SecondaryDbContext context,
        [FromKeyedServices("Primary")] IDapperQueryService primaryDapper,
        [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper,
        IICTOrderNumberService orderNumberService,
        IDeacomService deacomService,
        ILogger<ICTService> logger)
    {
        _context = context;
        _primaryDapper = primaryDapper;
        _secondaryDapper = secondaryDapper;
        _orderNumberService = orderNumberService;
        _deacomService = deacomService;
        _logger = logger;
    }

    public async Task<ICTOrder> CreateOrderAsync(CreateICTOrderRequest request)
    {
        string orderNumber = await _orderNumberService.GenerateNextOrderNumberAsync();
        DateTime now = DateTime.Now;

        // Determine order type based on destination warehouse
        int orderType = request.DestinationWarehouseId == 3 ? 4 : 3; // 4=ICT CPFG, 3=ICT Northlake

        var newOrder = new Gai_scheduler
        {
            gs_id = request.DestinationWarehouseId,
            gs_ordnum = long.Parse(orderNumber),
            gs_dock = string.Empty,
            gs_datestart = now,
            gs_dateend = now,
            gs_dockm = TimeSpan.Zero,
            gs_company = "Greenwood Associates, Inc.",
            gs_carrier = "TBD",
            gs_driver = "TBD",
            gs_chr2 = "TBD",
            gs_notes = string.IsNullOrEmpty(request.Notes) ? "Notes" : request.Notes,
            gs_status = "N/A",
            gs_datechkin = now,
            gs_appid = orderNumber,
            gs_forkop = string.Empty,
            gs_chr1 = string.Empty,
            gs_num1 = orderType,
            gs_chr3 = request.JobNumber ?? string.Empty,
            gs_date1 = now,
            gs_chr4 = string.Empty,
            gs_picker = string.Empty,
            gs_auditor = string.Empty,
            gs_assembler = string.Empty,
            gs_log1 = false,
            gs_dec3 = 99,
            gs_chr5 = "Ready for dispatch",
            gs_chr6 = "TBD"
        };

        try
        {
            _context.Set<Gai_scheduler>().Add(newOrder);
            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Created ICT order {OrderNumber} for warehouse {WarehouseId}",
                orderNumber, request.DestinationWarehouseId);

            return new ICTOrder
            {
                OrderNumber = orderNumber,
                SourceWarehouseId = request.SourceWarehouseId,
                DestinationWarehouseId = request.DestinationWarehouseId,
                CreatedDate = now,
                Notes = request.Notes ?? string.Empty,
                JobNumber = request.JobNumber ?? string.Empty,
                LineItems = new List<LineItem>()
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to create ICT order");
            throw;
        }
    }

    public async Task<int> AddLineItemAsync(AddLineItemRequest request)
    {
        // Get product information from Deacom
        var product = await GetProductDetailsAsync(request.ProductCode);
        if (product == null)
            throw new ArgumentException($"Product not found: {request.ProductCode}");

        // Validate quantity
        var validation = await ValidateQuantityAsync(
            request.ProductCode,
            request.Quantity,
            product.WarehouseId);

        if (!validation.IsValid)
            throw new InvalidOperationException(validation.ErrorMessage);

        // PRESERVED BUG: Truncate description to 50 chars
        string description = TruncateDescription(request.Description);

        // Calculate pallets and weights
        int pallets = PalletCalculator.CalculatePallets(
            request.Quantity,
            product.CasesPerPallet,
            40); // Default 40 if not specified

        decimal netWeight = WeightCalculator.CalculateNetWeight(
            request.Quantity,
            product.UnitNetWeight);

        decimal grossWeight = WeightCalculator.CalculateGrossWeight(
            request.Quantity,
            product.UnitNetWeight,
            product.TareWeight);

        // Create line item entity
        var lineItem = new Gai_allocate
        {
            all_id = product.WarehouseId,
            all_ordernum = long.Parse(request.OrderNumber),
            all_codenum = request.ProductCode,
            all_userlot = string.Empty,
            all_qty = (int?)request.Quantity,
            all_pick = 0,
            all_date = DateTime.Today,
            all_chx1 = string.Empty,
            all_chx2 = string.Empty,
            all_chr1 = product.UnitOfMeasure,
            all_chr2 = string.Empty,
            all_dec1 = 0,
            all_date1 = DateTime.Now,
            all_chx3 = string.Empty,
            all_int1 = 0,
            all_chr3 = request.JobNumber ?? string.Empty,
            all_description = description,
            all_um = product.UnitOfMeasure,
            all_int2 = pallets,
            all_dec3 = 99,
            all_nwt = netWeight,
            all_gwt = grossWeight
        };

        try
        {
            _context.Set<Gai_allocate>().Add(lineItem);
            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Added line item {LineItemId} to order {OrderNumber}: {ProductCode} x {Quantity}",
                lineItem.all_index, request.OrderNumber, request.ProductCode, request.Quantity);

            return lineItem.all_index;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex,
                "Failed to add line item to order {OrderNumber}",
                request.OrderNumber);
            throw;
        }
    }

    public async Task<bool> RemoveLineItemAsync(int lineItemId)
    {
        try
        {
            var lineItem = await _context.Set<Gai_allocate>()
                .FirstOrDefaultAsync(a => a.all_index == lineItemId);

            if (lineItem == null)
            {
                _logger.LogWarning("Line item {LineItemId} not found", lineItemId);
                return false;
            }

            _context.Set<Gai_allocate>().Remove(lineItem);
            await _context.SaveChangesAsync();

            _logger.LogInformation("Removed line item {LineItemId}", lineItemId);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to remove line item {LineItemId}", lineItemId);
            throw;
        }
    }

    public async Task<ICTOrder?> GetOrderAsync(string orderNumber)
    {
        long ordNum = long.Parse(orderNumber);

        // Get header
        var header = await _context.Set<Gai_scheduler>()
            .FirstOrDefaultAsync(s => s.gs_ordnum == ordNum && s.gs_ordnum % 100 == 99 && s.gs_dec3 == 99);

        if (header == null)
            return null;

        // Get line items
        var lineItems = await _context.Set<Gai_allocate>()
            .Where(a => a.all_ordernum == ordNum && a.all_dec3 == 99)
            .Select(a => new LineItem
            {
                Id = a.all_index,
                OrderNumber = a.all_ordernum.ToString(),
                ProductCode = a.all_codenum ?? string.Empty,
                Description = a.all_description ?? string.Empty,
                Quantity = (decimal)(a.all_qty ?? 0),
                Pallets = a.all_int2 ?? 0,
                NetWeight = a.all_nwt ?? 0,
                GrossWeight = a.all_gwt ?? 0,
                UnitOfMeasure = a.all_um ?? string.Empty,
                JobNumber = a.all_chr3 ?? string.Empty
            })
            .ToListAsync();

        return new ICTOrder
        {
            OrderNumber = orderNumber,
            DestinationWarehouseId = (int)header.gs_id,
            SourceWarehouseId = (int)header.gs_id == 3 ? 92 : 3, // Opposite warehouse
            CreatedDate = header.gs_datestart ?? DateTime.Now,
            JobNumber = header.gs_chr3 ?? string.Empty,
            Notes = header.gs_notes ?? string.Empty,
            LineItems = lineItems
        };
    }

    public async Task<IEnumerable<ICTOrderSummary>> ListOrdersAsync(
        int warehouseId,
        DateTime? currentDate = null)
    {
        string sql = @"
            SELECT
                gs_ordnum AS OrderNumber,
                gs_id AS WarehouseId,
                gs_datestart AS CreatedDate,
                COUNT(all_index) AS LineCount,
                ISNULL(SUM(all_int2), 0) AS TotalPallets,
                ISNULL(SUM(all_nwt), 0) AS TotalNetWeight,
                ISNULL(SUM(all_gwt), 0) AS TotalGrossWeight
            FROM gai_scheduler
            LEFT JOIN gai_allocate ON gs_ordnum = all_ordernum AND all_dec3 = 99
            WHERE gs_id = @WarehouseId
              AND gs_ordnum % 100 = 99
              AND gs_dec3 = 99";

        if (currentDate.HasValue)
        {
            sql += " AND CAST(gs_datestart AS DATE) = @CurrentDate";
        }

        sql += @"
            GROUP BY gs_ordnum, gs_id, gs_datestart
            ORDER BY gs_datestart DESC";

        // Use SECONDARY Dapper (GAIMisc database) for gai_scheduler/gai_allocate queries
        return await _secondaryDapper.QueryAsync<ICTOrderSummary>(sql, new { WarehouseId = warehouseId, CurrentDate = currentDate?.Date });
    }

    public async Task<SubmitOrderResult> SubmitOrderAsync(string orderNumber)
    {
        long ordNum = long.Parse(orderNumber);

        try
        {
            // Get totals from line items
            var lineTotals = await _context.Set<Gai_allocate>()
                .Where(a => a.all_ordernum == ordNum && a.all_dec3 == 99)
                .GroupBy(a => a.all_ordernum)
                .Select(g => new
                {
                    ProductCount = g.Count(),
                    TotalPallets = g.Sum(a => a.all_int2),
                    TotalNetWeight = g.Sum(a => a.all_nwt),
                    TotalGrossWeight = g.Sum(a => a.all_gwt)
                })
                .FirstOrDefaultAsync();

            if (lineTotals == null)
            {
                return new SubmitOrderResult
                {
                    Success = false,
                    ErrorMessage = "No line items found for this order"
                };
            }

            // Update order header with totals
            var order = await _context.Set<Gai_scheduler>()
                .FirstOrDefaultAsync(s => s.gs_ordnum == ordNum);

            if (order == null)
            {
                return new SubmitOrderResult
                {
                    Success = false,
                    ErrorMessage = "Order not found"
                };
            }

            order.gs_num4 = lineTotals.ProductCount;
            order.gs_num5 = lineTotals.TotalPallets ?? 0;
            order.gs_pronum = lineTotals.ProductCount;
            order.gs_pallets = lineTotals.TotalPallets ?? 0;
            order.gs_nwt = lineTotals.TotalNetWeight ?? 0;
            order.gs_gwt = lineTotals.TotalGrossWeight ?? 0;

            await _context.SaveChangesAsync();

            _logger.LogInformation("Submitted ICT order {OrderNumber}", orderNumber);

            return new SubmitOrderResult
            {
                Success = true,
                SubmittedDate = DateTime.Now
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to submit order {OrderNumber}", orderNumber);
            return new SubmitOrderResult
            {
                Success = false,
                ErrorMessage = ex.Message
            };
        }
    }

    public async Task<DeleteOrderResult> DeleteOrderAsync(string orderNumber, int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        try
        {
            // Delete from scheduler (header)
            var schedulerRecords = _context.Set<Gai_scheduler>()
                .Where(s => s.gs_id == warehouseId && s.gs_ordnum == ordNum);
            int schedulerRows = await schedulerRecords.CountAsync();
            _context.Set<Gai_scheduler>().RemoveRange(schedulerRecords);

            // Delete from allocate (line items)
            var allocateRecords = _context.Set<Gai_allocate>()
                .Where(a => a.all_id == warehouseId && a.all_ordernum == ordNum);
            int allocateRows = await allocateRecords.CountAsync();
            _context.Set<Gai_allocate>().RemoveRange(allocateRecords);

            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Deleted ICT order {OrderNumber}: {SchedulerRows} scheduler row(s), {AllocateRows} allocate row(s)",
                orderNumber, schedulerRows, allocateRows);

            return new DeleteOrderResult
            {
                Success = true,
                SchedulerRowsDeleted = schedulerRows,
                AllocateRowsDeleted = allocateRows
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to delete order {OrderNumber}", orderNumber);
            return new DeleteOrderResult
            {
                Success = false,
                ErrorMessage = ex.Message
            };
        }
    }

    public async Task<IEnumerable<ICTProduct>> GetAvailableProductsAsync(int warehouseId)
    {
        // This query matches the spec exactly
        const string sql = @"
            SELECT
                pr_codenum AS ProductCode,
                pr_descrip AS Description,
                SUM(fi_balance) AS AvailableQuantity,
                d2_value AS CasesPerPallet,
                un_name AS UnitOfMeasure,
                IIF(AVG(fi_catchwgt)=0, pr_unitwgt, AVG(fi_catchwgt)) AS NetWeight,
                IIF(AVG(fi_catchwgt)=0, pr_unitwgt, AVG(fi_catchwgt)) + pr_tarewgt AS GrossWeight
            FROM dmprod
            JOIN dtfifo ON pr_id = fi_prid
            LEFT JOIN dtstaging ON fi_group = st_figroup
            LEFT JOIN dtd2 ON d2_d1id = 224 AND d2_recid = pr_id
            JOIN dmunit ON dmunit.un_id = pr_unid
            WHERE pr_active = 1
              AND pr_stocked = 1
              AND fi_zeroed IS NULL
              AND st_id IS NULL
              AND fi_waid = @WarehouseId
              AND pr_user9 IN (4, 5, 14, 15)
            GROUP BY pr_codenum, pr_descrip, pr_unitwgt, pr_tarewgt, d2_value, un_name
            ORDER BY pr_codenum";

        // Use PRIMARY Dapper (GAI database) for dmprod, dtfifo queries
        return await _primaryDapper.QueryAsync<ICTProduct>(sql, new { WarehouseId = warehouseId });
    }

    public async Task<IEnumerable<ManufacturingJob>> GetManufacturingJobsAsync(DateTime currentDate)
    {
        const string sql = @"
            SELECT
                jo_jobnum AS JobNumber,
                jo_planfinish AS FinishDate,
                pr_codenum AS ProductCode,
                CAST(lj_planquant AS INT) AS PlannedQuantity,
                un_name AS UnitOfMeasure
            FROM dtjob
            JOIN dtljob ON lj_joid = jo_id
            JOIN dmprod ON lj_prid = pr_id
            JOIN dmunit ON dmunit.un_id = pr_unid
            WHERE jo_closed IS NULL
              AND jo_type = 'a'
              AND pr_level = 50
              AND CAST(jo_planfinish AS DATE) >= @CurrentDate
              AND lj_planquant <> 0
            ORDER BY jo_planfinish";

        // Use PRIMARY Dapper (GAI database) for dtjob, dtljob, dmprod queries
        var jobs = (await _primaryDapper.QueryAsync<ManufacturingJob>(sql, new { CurrentDate = currentDate.Date })).ToList();

        // Calculate ship dates (+8 business days from finish date)
        foreach (var job in jobs)
        {
            job.ShipDate = BusinessDayCalculator.AddBusinessDays(job.FinishDate, 8);
        }

        return jobs;
    }

    public async Task<QuantityValidationResult> ValidateQuantityAsync(
        string productCode,
        decimal requestedQuantity,
        int warehouseId)
    {
        if (requestedQuantity <= 0)
        {
            return QuantityValidationResult.Invalid(
                "Request Quantity can't be greater than Warehouse Quantity Or Quantity = 0");
        }

        // Get available quantity from warehouse
        const string sql = @"
            SELECT ISNULL(SUM(fi_balance), 0)
            FROM dtfifo
            JOIN dmprod ON pr_id = fi_prid
            LEFT JOIN dtstaging ON fi_group = st_figroup
            WHERE pr_codenum = @ProductCode
              AND fi_waid = @WarehouseId
              AND fi_zeroed IS NULL
              AND st_id IS NULL";

        // Use PRIMARY Dapper (GAI database) for dtfifo, dmprod queries
        decimal? warehouseQuantity = await _primaryDapper.QuerySingleAsync<decimal?>(sql, new { ProductCode = productCode, WarehouseId = warehouseId });

        if (requestedQuantity > (warehouseQuantity ?? 0))
        {
            return QuantityValidationResult.Invalid(
                "Request Quantity can't be greater than Warehouse Quantity Or Quantity = 0");
        }

        return QuantityValidationResult.Valid();
    }

    // Helper methods

    /// <summary>
    /// PRESERVED BUG: Truncate description to 50 characters without warning.
    /// </summary>
    private string TruncateDescription(string description)
    {
        if (string.IsNullOrEmpty(description))
            return description ?? string.Empty;

        return description.Length > 50
            ? description.Substring(0, 50)
            : description;
    }

    private async Task<ProductDetails?> GetProductDetailsAsync(string productCode)
    {
        const string sql = @"
            SELECT TOP 1
                pr_codenum AS ProductCode,
                pr_descrip AS Description,
                fi_waid AS WarehouseId,
                un_name AS UnitOfMeasure,
                IIF(AVG(fi_catchwgt)=0, pr_unitwgt, AVG(fi_catchwgt)) AS UnitNetWeight,
                pr_tarewgt AS TareWeight,
                d2_value AS CasesPerPallet
            FROM dmprod
            JOIN dtfifo ON pr_id = fi_prid
            LEFT JOIN dtd2 ON d2_d1id = 224 AND d2_recid = pr_id
            JOIN dmunit ON dmunit.un_id = pr_unid
            WHERE pr_codenum = @ProductCode
              AND fi_zeroed IS NULL
            GROUP BY pr_codenum, pr_descrip, fi_waid, un_name, pr_unitwgt, pr_tarewgt, d2_value, fi_catchwgt";

        // Use PRIMARY Dapper (GAI database) for dmprod, dtfifo, dtd2, dmunit queries
        return await _primaryDapper.QuerySingleAsync<ProductDetails?>(sql, new { ProductCode = productCode });
    }

    private class ProductDetails
    {
        public string ProductCode { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int WarehouseId { get; set; }
        public string UnitOfMeasure { get; set; } = string.Empty;
        public decimal UnitNetWeight { get; set; }
        public decimal TareWeight { get; set; }
        public decimal? CasesPerPallet { get; set; }
    }
}
