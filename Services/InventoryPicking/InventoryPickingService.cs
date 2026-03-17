using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Models.Generated.WEBAPPMisc;
using DotNetWebApp.Services.InventoryPicking.Models;
using DotNetWebApp.Services.InventoryPicking.Validators;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace DotNetWebApp.Services.InventoryPicking;

/// <summary>
/// Implementation of InventoryPicking service for order picking/auditing/assembly workflow.
/// Uses EF Core for writes (INSERT/UPDATE) and Dapper for complex reads.
/// Uses TWO Dapper services: Primary (WEBAPP) for Deacom queries, Secondary (WEBAPPMisc) for scheduler queries.
/// </summary>
public class InventoryPickingService : IInventoryPickingService
{
    private readonly SecondaryDbContext _context;
    private readonly IDapperQueryService _primaryDapper;   // WEBAPP database - for dttord, dmprod queries
    private readonly IDapperQueryService _secondaryDapper; // WEBAPPMisc database - for webapp_scheduler queries
    private readonly AuditorAssignmentValidator _auditorValidator;
    private readonly TimestampValidator _timestampValidator;
    private readonly ILogger<InventoryPickingService> _logger;

    public InventoryPickingService(
        SecondaryDbContext context,
        [FromKeyedServices("Primary")] IDapperQueryService primaryDapper,
        [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper,
        AuditorAssignmentValidator auditorValidator,
        TimestampValidator timestampValidator,
        ILogger<InventoryPickingService> logger)
    {
        _context = context;
        _primaryDapper = primaryDapper;
        _secondaryDapper = secondaryDapper;
        _auditorValidator = auditorValidator;
        _timestampValidator = timestampValidator;
        _logger = logger;
    }

    public async Task<InventoryPickingOrder?> GetOrderAsync(string orderNumber, int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        // Get scheduler data
        var scheduler = await _context.Set<Webapp_scheduler>()
            .FirstOrDefaultAsync(s => s.gs_ordnum == ordNum && s.gs_id == warehouseId);

        if (scheduler == null)
            return null;

        return MapSchedulerToOrder(scheduler);
    }

    public async Task<IEnumerable<InventoryPickingOrder>> ListOrdersAsync(
        int warehouseId,
        DateTime? startDate = null,
        DateTime? endDate = null)
    {
        // Default to today if no dates specified
        DateTime date1 = startDate ?? DateTime.Today;
        DateTime date2 = endDate ?? DateTime.Today;

        // Query from webapp_scheduler for InventoryPicking orders
        // Orders are identified by NOT ending in 99 (ICT orders end in 99)
        const string sql = @"
            SELECT
                gs_ordnum AS OrderNumber,
                gs_datestart AS DueShipDate,
                gs_datestart AS DockTime,
                ISNULL(gs_carrier, '') AS CarrierName,
                ISNULL(gs_company, '') AS BillToName,
                ISNULL(gs_company, '') AS ShipToName,
                ISNULL(gs_chr1, '') AS Allocator,
                ISNULL(gs_chr4, '') AS TeamLeader,
                ISNULL(gs_picker, '') AS PickerUsername,
                gs_pickerin AS PickerClockIn,
                gs_pickerout AS PickerClockOut,
                ISNULL(gs_auditor, '') AS AuditorUsername,
                gs_auditorin AS AuditorClockIn,
                gs_auditorout AS AuditorClockOut,
                ISNULL(gs_assembler, '') AS AssemblerUsername,
                gs_assemblerin AS AssemblerClockIn,
                gs_assemblerout AS AssemblerClockOut,
                0 AS CrossDock,
                1 AS OkToShip,
                ISNULL(gs_forkop, '') AS CsrLogin,
                '' AS FollowUp,
                ISNULL(gs_notes, '') AS Notes,
                ISNULL(gs_pallets, 0) AS PalletCount,
                ISNULL(gs_pronum, 0) AS ProductCount,
                '' AS FollowUpNotes,
                ISNULL(gs_num2, 0) AS PrintStatus,
                0 AS IsExport,
                ISNULL(gs_num1, 0) AS StatusCode,
                IIF(gs_ordnum % 100 = 99, 1, 0) AS IsIct,
                @WarehouseId AS WarehouseId
            FROM webapp_scheduler
            WHERE gs_id = @WarehouseId
              AND gs_ordnum % 100 <> 99
              AND CAST(gs_datestart AS DATE) >= @Date1
              AND CAST(gs_datestart AS DATE) <= @Date2
            ORDER BY gs_datestart, gs_ordnum";

        var orders = await _secondaryDapper.QueryAsync<InventoryPickingOrder>(sql, new
        {
            WarehouseId = warehouseId,
            Date1 = date1.Date,
            Date2 = date2.Date
        });

        return orders;
    }

    public async Task<AssignmentResult> AssignPickerAsync(AssignPickerRequest request, int warehouseId)
    {
        // No validation required for picker
        long ordNum = long.Parse(request.OrderNumber);

        try
        {
            var scheduler = await GetOrCreateSchedulerAsync(ordNum, warehouseId);

            scheduler.gs_picker = request.PickerUsername;
            scheduler.gs_pickerin = request.ClockIn;
            scheduler.gs_pickerout = null;

            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Assigned picker {Picker} to order {OrderNumber}",
                request.PickerUsername, request.OrderNumber);

            return AssignmentResult.Succeeded();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to assign picker to order {OrderNumber}", request.OrderNumber);
            return AssignmentResult.Failed(ex.Message);
        }
    }

    public async Task<AssignmentResult> AssignAuditorAsync(AssignAuditorRequest request, int warehouseId)
    {
        long ordNum = long.Parse(request.OrderNumber);

        // Get current order state for validation
        var scheduler = await _context.Set<Webapp_scheduler>()
            .FirstOrDefaultAsync(s => s.gs_ordnum == ordNum && s.gs_id == warehouseId);

        if (scheduler == null)
            return AssignmentResult.Failed($"Order {request.OrderNumber} not found");

        // Validate auditor assignment
        var validation = await _auditorValidator.CanAssignAuditorAsync(
            request.OrderNumber,
            scheduler.gs_picker,
            scheduler.gs_carrier);

        if (!validation.IsValid)
            return AssignmentResult.Failed(validation.Message);

        try
        {
            scheduler.gs_auditor = request.AuditorUsername;
            scheduler.gs_auditorin = request.ClockIn;
            scheduler.gs_auditorout = null;

            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Assigned auditor {Auditor} to order {OrderNumber}",
                request.AuditorUsername, request.OrderNumber);

            return AssignmentResult.Succeeded();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to assign auditor to order {OrderNumber}", request.OrderNumber);
            return AssignmentResult.Failed(ex.Message);
        }
    }

    public async Task<AssignmentResult> AssignAssemblerAsync(AssignAssemblerRequest request, int warehouseId)
    {
        // No validation required for assembler
        long ordNum = long.Parse(request.OrderNumber);

        try
        {
            var scheduler = await GetOrCreateSchedulerAsync(ordNum, warehouseId);

            scheduler.gs_assembler = request.AssemblerUsername;
            scheduler.gs_assemblerin = request.ClockIn;
            scheduler.gs_assemblerout = null;

            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Assigned assembler {Assembler} to order {OrderNumber}",
                request.AssemblerUsername, request.OrderNumber);

            return AssignmentResult.Succeeded();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to assign assembler to order {OrderNumber}", request.OrderNumber);
            return AssignmentResult.Failed(ex.Message);
        }
    }

    public async Task<AssignmentResult> ClockOutAsync(ClockOutRequest request, int warehouseId)
    {
        long ordNum = long.Parse(request.OrderNumber);

        var scheduler = await _context.Set<Webapp_scheduler>()
            .FirstOrDefaultAsync(s => s.gs_ordnum == ordNum && s.gs_id == warehouseId);

        if (scheduler == null)
            return AssignmentResult.Failed($"Order {request.OrderNumber} not found");

        try
        {
            DateTime? clockIn;
            switch (request.WorkerType.ToLower())
            {
                case "picker":
                    clockIn = scheduler.gs_pickerin;
                    if (!clockIn.HasValue)
                        return AssignmentResult.Failed("Picker has not clocked in");

                    var pickerValidation = _timestampValidator.ValidateClockTimes(clockIn.Value, request.ClockOut);
                    if (!pickerValidation.IsValid)
                        return AssignmentResult.Failed(pickerValidation.Message);

                    scheduler.gs_pickerout = request.ClockOut;
                    break;

                case "auditor":
                    clockIn = scheduler.gs_auditorin;
                    if (!clockIn.HasValue)
                        return AssignmentResult.Failed("Auditor has not clocked in");

                    var auditorValidation = _timestampValidator.ValidateClockTimes(clockIn.Value, request.ClockOut);
                    if (!auditorValidation.IsValid)
                        return AssignmentResult.Failed(auditorValidation.Message);

                    scheduler.gs_auditorout = request.ClockOut;
                    break;

                case "assembler":
                    clockIn = scheduler.gs_assemblerin;
                    if (!clockIn.HasValue)
                        return AssignmentResult.Failed("Assembler has not clocked in");

                    var assemblerValidation = _timestampValidator.ValidateClockTimes(clockIn.Value, request.ClockOut);
                    if (!assemblerValidation.IsValid)
                        return AssignmentResult.Failed(assemblerValidation.Message);

                    scheduler.gs_assemblerout = request.ClockOut;
                    break;

                default:
                    return AssignmentResult.Failed($"Unknown worker type: {request.WorkerType}");
            }

            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Clocked out {WorkerType} for order {OrderNumber}",
                request.WorkerType, request.OrderNumber);

            return AssignmentResult.Succeeded();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to clock out {WorkerType} for order {OrderNumber}",
                request.WorkerType, request.OrderNumber);
            return AssignmentResult.Failed(ex.Message);
        }
    }

    public async Task<AssignmentResult> UpdateOrderAsync(UpdateOrderRequest request, int warehouseId)
    {
        long ordNum = long.Parse(request.OrderNumber);

        try
        {
            var scheduler = await GetOrCreateSchedulerAsync(ordNum, warehouseId);

            if (request.Allocator != null)
                scheduler.gs_chr1 = request.Allocator;

            if (request.TeamLeader != null)
                scheduler.gs_chr4 = request.TeamLeader;

            if (request.Notes != null)
                scheduler.gs_notes = request.Notes;

            if (request.StatusCode.HasValue)
                scheduler.gs_num1 = request.StatusCode.Value;

            await _context.SaveChangesAsync();

            _logger.LogInformation("Updated order {OrderNumber}", request.OrderNumber);

            return AssignmentResult.Succeeded();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to update order {OrderNumber}", request.OrderNumber);
            return AssignmentResult.Failed(ex.Message);
        }
    }

    public async Task<IEnumerable<AvailableOperator>> GetAvailableOperatorsAsync(int warehouseId)
    {
        // TODO: Query from Deacom dxuser with forklift flag (dtd2 d2_d1id=478)
        // For MVP, return dummy data
        const string sql = @"
            SELECT DISTINCT
                gs_chr1 AS Username,
                IIF(gs_id = 3, 1, 0) AS IsCpfgUser
            FROM webapp_scheduler
            WHERE gs_chr1 IS NOT NULL AND gs_chr1 <> ''
            UNION
            SELECT DISTINCT
                gs_picker AS Username,
                IIF(gs_id = 3, 1, 0) AS IsCpfgUser
            FROM webapp_scheduler
            WHERE gs_picker IS NOT NULL AND gs_picker <> ''";

        var operators = await _secondaryDapper.QueryAsync<AvailableOperator>(sql, new { });

        // Filter by warehouse
        return operators.Where(o =>
            (warehouseId == 3 && o.IsCpfgUser) ||
            (warehouseId == 92 && !o.IsCpfgUser) ||
            (warehouseId != 3 && warehouseId != 92)); // Other warehouses get all
    }

    public async Task<IEnumerable<AvailableAllocator>> GetAvailableAllocatorsAsync()
    {
        // Query from webapp_dmstech for users with allocator flag
        const string sql = @"
            SELECT DISTINCT gs_chr1 AS Username
            FROM webapp_dmstech
            WHERE gs_chr1 IS NOT NULL AND gs_chr1 <> ''
            ORDER BY gs_chr1";

        return await _secondaryDapper.QueryAsync<AvailableAllocator>(sql, new { });
    }

    public async Task<IEnumerable<AvailableTeamLeader>> GetAvailableTeamLeadersAsync()
    {
        // Query from webapp_dmstech for users with team leader flag
        const string sql = @"
            SELECT DISTINCT gs_chr1 AS Username
            FROM webapp_dmstech
            WHERE gs_chr1 IS NOT NULL AND gs_chr1 <> ''
            ORDER BY gs_chr1";

        return await _secondaryDapper.QueryAsync<AvailableTeamLeader>(sql, new { });
    }

    public async Task<AssignmentResult> BatchUpdateAllocatorAsync(
        IEnumerable<string> orderNumbers,
        string allocator,
        int warehouseId)
    {
        try
        {
            foreach (var orderNumber in orderNumbers)
            {
                long ordNum = long.Parse(orderNumber);
                var scheduler = await GetOrCreateSchedulerAsync(ordNum, warehouseId);
                scheduler.gs_chr1 = allocator;

                if (allocator == "Allocated")
                    scheduler.gs_notes = allocator;
                else if (string.IsNullOrEmpty(allocator))
                    scheduler.gs_notes = "Notes";
                else
                    scheduler.gs_notes = allocator;
            }

            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Batch updated allocator to {Allocator} for {Count} orders",
                allocator, orderNumbers.Count());

            return AssignmentResult.Succeeded();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to batch update allocator");
            return AssignmentResult.Failed(ex.Message);
        }
    }

    public async Task<AssignmentResult> BatchUpdateTeamLeaderAsync(
        IEnumerable<string> orderNumbers,
        string teamLeader,
        int warehouseId)
    {
        try
        {
            foreach (var orderNumber in orderNumbers)
            {
                long ordNum = long.Parse(orderNumber);
                var scheduler = await GetOrCreateSchedulerAsync(ordNum, warehouseId);
                scheduler.gs_chr4 = teamLeader;
            }

            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Batch updated team leader to {TeamLeader} for {Count} orders",
                teamLeader, orderNumbers.Count());

            return AssignmentResult.Succeeded();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to batch update team leader");
            return AssignmentResult.Failed(ex.Message);
        }
    }

    // Helper methods

    private async Task<Webapp_scheduler> GetOrCreateSchedulerAsync(long ordNum, int warehouseId)
    {
        var scheduler = await _context.Set<Webapp_scheduler>()
            .FirstOrDefaultAsync(s => s.gs_ordnum == ordNum && s.gs_id == warehouseId);

        if (scheduler == null)
        {
            scheduler = new Webapp_scheduler
            {
                gs_id = warehouseId,
                gs_ordnum = ordNum,
                gs_dock = string.Empty,
                gs_datestart = DateTime.Now,
                gs_dateend = DateTime.Now,
                gs_dockm = TimeSpan.Zero,
                gs_company = string.Empty,
                gs_carrier = string.Empty,
                gs_driver = string.Empty,
                gs_chr2 = string.Empty,
                gs_notes = "Notes",
                gs_status = "N/A",
                gs_datechkin = DateTime.Now,
                gs_appid = ordNum.ToString(),
                gs_forkop = string.Empty,
                gs_chr1 = string.Empty,
                gs_num1 = 0,
                gs_chr3 = string.Empty,
                gs_date1 = DateTime.Now,
                gs_chr4 = string.Empty,
                gs_picker = string.Empty,
                gs_auditor = string.Empty,
                gs_assembler = string.Empty,
                gs_log1 = false
            };

            _context.Set<Webapp_scheduler>().Add(scheduler);
        }

        return scheduler;
    }

    private static InventoryPickingOrder MapSchedulerToOrder(Webapp_scheduler scheduler)
    {
        return new InventoryPickingOrder
        {
            OrderNumber = scheduler.gs_ordnum.ToString(),
            DueShipDate = scheduler.gs_datestart,
            DockTime = scheduler.gs_datestart,
            CarrierName = scheduler.gs_carrier ?? string.Empty,
            BillToName = scheduler.gs_company ?? string.Empty,
            ShipToName = scheduler.gs_company ?? string.Empty,
            Allocator = scheduler.gs_chr1 ?? string.Empty,
            TeamLeader = scheduler.gs_chr4 ?? string.Empty,
            PickerUsername = scheduler.gs_picker ?? string.Empty,
            PickerClockIn = scheduler.gs_pickerin,
            PickerClockOut = scheduler.gs_pickerout,
            AuditorUsername = scheduler.gs_auditor ?? string.Empty,
            AuditorClockIn = scheduler.gs_auditorin,
            AuditorClockOut = scheduler.gs_auditorout,
            AssemblerUsername = scheduler.gs_assembler ?? string.Empty,
            AssemblerClockIn = scheduler.gs_assemblerin,
            AssemblerClockOut = scheduler.gs_assemblerout,
            CrossDock = 0,
            OkToShip = true,
            CsrLogin = scheduler.gs_forkop ?? string.Empty,
            FollowUp = string.Empty,
            Notes = scheduler.gs_notes ?? string.Empty,
            PalletCount = scheduler.gs_pallets ?? 0,
            ProductCount = scheduler.gs_pronum ?? 0,
            FollowUpNotes = string.Empty,
            PrintStatus = (int)(scheduler.gs_num2 ?? 0),
            IsExport = false,
            StatusCode = (int)(scheduler.gs_num1 ?? 0),
            IsIct = scheduler.gs_ordnum % 100 == 99,
            WarehouseId = (int)scheduler.gs_id
        };
    }
}
