using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Models.Generated.WEBAPPMisc;
using DotNetWebApp.Services.InventoryAllocation.Models;
using DotNetWebApp.Services.InventoryAllocation.Validators;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace DotNetWebApp.Services.InventoryAllocation;

/// <summary>
/// Implementation of inventory allocation service for inventory allocation operations.
/// Uses EF Core for writes, Dapper for complex reads.
/// Uses TWO Dapper services: Primary (WEBAPP) for Deacom queries, Secondary (WEBAPPMisc) for allocation queries.
/// </summary>
public class InventoryAllocationService : IInventoryAllocationService
{
    private readonly SecondaryDbContext _context;
    private readonly IDapperQueryService _primaryDapper;   // WEBAPP database - for dttord, dmprod, dtfifo
    private readonly IDapperQueryService _secondaryDapper; // WEBAPPMisc database - for webapp_allocate, webapp_lock
    private readonly IFIFOAllocationEngine _fifoEngine;
    private readonly ILockService _lockService;
    private readonly PaymentValidator _paymentValidator;
    private readonly ILogger<InventoryAllocationService> _logger;

    /// <summary>
    /// Permission ID for allocators.
    /// </summary>
    public const int ALLOCATOR_PERMISSION_ID = 674;

    /// <summary>
    /// Permission ID for deallocators.
    /// </summary>
    public const int DEALLOCATOR_PERMISSION_ID = 681;

    public InventoryAllocationService(
        SecondaryDbContext context,
        [FromKeyedServices("Primary")] IDapperQueryService primaryDapper,
        [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper,
        IFIFOAllocationEngine fifoEngine,
        ILockService lockService,
        PaymentValidator paymentValidator,
        ILogger<InventoryAllocationService> logger)
    {
        _context = context;
        _primaryDapper = primaryDapper;
        _secondaryDapper = secondaryDapper;
        _fifoEngine = fifoEngine;
        _lockService = lockService;
        _paymentValidator = paymentValidator;
        _logger = logger;
    }

    public async Task<IEnumerable<InventoryAllocationOrderSummary>> GetOrdersForAllocationAsync(
        int warehouseId,
        DateTime? shipDate = null)
    {
        DateTime targetDate = shipDate ?? DateTime.Today;

        // Query eligible orders from Deacom
        // Business Rule: Order is eligible when:
        // - Status = 'C' (Confirmed)
        // - WarehouseId matches
        // - Not shipped (to_shipped IS NULL)
        // - OrderType IN ('s', 'm')
        // - Payment valid (termsId != 51 OR balance <= totalDue * 0.03)
        const string sql = @"
            SELECT
                CAST(to_ordnum AS VARCHAR) AS OrderNumber,
                CAST(to_dueship AS DATE) AS DueShipDate,
                bi.bi_name AS CustomerName,
                tr.tr_name AS Carrier,
                to_waid AS WarehouseId,
                (SELECT COUNT(*) FROM dtord WHERE or_toid = to_id AND or_quant > 0) AS TotalLines,
                (SELECT COUNT(DISTINCT all_codenum) FROM WEBAPPMisc.dbo.webapp_allocate
                 WHERE all_ordernum = to_ordnum AND all_id = to_waid AND all_pick = 0) AS AllocatedLines,
                (SELECT ISNULL(SUM(or_quant), 0) FROM dtord WHERE or_toid = to_id) AS TotalOrdered,
                (SELECT ISNULL(SUM(all_qty), 0) FROM WEBAPPMisc.dbo.webapp_allocate
                 WHERE all_ordernum = to_ordnum AND all_id = to_waid AND all_pick = 0) AS TotalAllocated,
                IIF(to_teid = 51 AND to_balance > (to_totdue * 0.03), 0, 1) AS OkToShip,
                ISNULL((SELECT TOP 1 gl_username FROM WEBAPPMisc.dbo.webapp_lock
                        WHERE gl_ordnum = to_ordnum AND gl_id = 1), '') AS LockedBy,
                0 AS Priority,
                to_balance AS BalanceDue,
                to_totdue AS TotalDue,
                to_teid AS TermsId
            FROM dttord
            JOIN dmbill bi ON bi.bi_id = to_biid
            JOIN dmtruk tr ON tr.tr_id = to_trid
            WHERE to_status = 'C'
              AND to_waid = @WarehouseId
              AND to_shipped IS NULL
              AND to_ordtype IN ('s', 'm')
              AND CAST(to_dueship AS DATE) = @ShipDate
              AND (to_teid <> 51 OR to_balance <= (to_totdue * 0.03))
            ORDER BY to_dueship, to_ordnum";

        var orders = await _primaryDapper.QueryAsync<InventoryAllocationOrderSummary>(sql, new
        {
            WarehouseId = warehouseId,
            ShipDate = targetDate.Date
        });

        // Calculate status for each order
        foreach (var order in orders)
        {
            order.Status = InventoryAllocationStatusColorService.GetStatus(order.TotalOrdered, order.TotalAllocated);
        }

        return orders;
    }

    public async Task<InventoryAllocationOrderSummary?> GetOrderDetailAsync(string orderNumber, int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        const string sql = @"
            SELECT
                CAST(to_ordnum AS VARCHAR) AS OrderNumber,
                CAST(to_dueship AS DATE) AS DueShipDate,
                bi.bi_name AS CustomerName,
                tr.tr_name AS Carrier,
                to_waid AS WarehouseId,
                (SELECT COUNT(*) FROM dtord WHERE or_toid = to_id AND or_quant > 0) AS TotalLines,
                (SELECT COUNT(DISTINCT all_codenum) FROM WEBAPPMisc.dbo.webapp_allocate
                 WHERE all_ordernum = to_ordnum AND all_id = to_waid AND all_pick = 0) AS AllocatedLines,
                (SELECT ISNULL(SUM(or_quant), 0) FROM dtord WHERE or_toid = to_id) AS TotalOrdered,
                (SELECT ISNULL(SUM(all_qty), 0) FROM WEBAPPMisc.dbo.webapp_allocate
                 WHERE all_ordernum = to_ordnum AND all_id = to_waid AND all_pick = 0) AS TotalAllocated,
                IIF(to_teid = 51 AND to_balance > (to_totdue * 0.03), 0, 1) AS OkToShip,
                ISNULL((SELECT TOP 1 gl_username FROM WEBAPPMisc.dbo.webapp_lock
                        WHERE gl_ordnum = to_ordnum AND gl_id = 1), '') AS LockedBy,
                0 AS Priority,
                to_balance AS BalanceDue,
                to_totdue AS TotalDue,
                to_teid AS TermsId
            FROM dttord
            JOIN dmbill bi ON bi.bi_id = to_biid
            JOIN dmtruk tr ON tr.tr_id = to_trid
            WHERE to_ordnum = @OrderNumber
              AND to_waid = @WarehouseId";

        var order = await _primaryDapper.QuerySingleAsync<InventoryAllocationOrderSummary?>(sql, new
        {
            OrderNumber = ordNum,
            WarehouseId = warehouseId
        });

        if (order != null)
        {
            order.Status = InventoryAllocationStatusColorService.GetStatus(order.TotalOrdered, order.TotalAllocated);
        }

        return order;
    }

    public async Task<IEnumerable<InventoryAllocationLineItem>> GetOrderLineItemsAsync(string orderNumber, int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        const string sql = @"
            SELECT
                or_id AS LineIndex,
                CAST(to_ordnum AS VARCHAR) AS OrderNumber,
                pr.pr_codenum AS ProductCode,
                pr.pr_descrip AS ProductDescription,
                or_quant AS OrderedQuantity,
                ISNULL((SELECT SUM(all_qty) FROM WEBAPPMisc.dbo.webapp_allocate
                        WHERE all_ordernum = to_ordnum AND all_codenum = pr.pr_codenum AND all_id = @WarehouseId AND all_pick = 0), 0) AS AllocatedQuantity,
                ISNULL((SELECT SUM(all_qty) FROM WEBAPPMisc.dbo.webapp_allocate
                        WHERE all_ordernum = to_ordnum AND all_codenum = pr.pr_codenum AND all_id = @WarehouseId AND all_pick <> 0), 0) AS PickedQuantity
            FROM dtord
            JOIN dttord ON or_toid = to_id
            JOIN dmprod pr ON pr.pr_id = or_prid
            WHERE to_ordnum = @OrderNumber
              AND to_waid = @WarehouseId
              AND or_quant > 0
              AND pr.pr_stocked = 1
              AND pr.pr_codenum NOT LIKE 'BXS%'
            ORDER BY or_id";

        var lines = await _primaryDapper.QueryAsync<InventoryAllocationLineItem>(sql, new
        {
            OrderNumber = ordNum,
            WarehouseId = warehouseId
        });

        // Calculate status and get allocations for each line
        foreach (var line in lines)
        {
            line.Status = InventoryAllocationStatusColorService.GetStatus(line.OrderedQuantity, line.AllocatedQuantity);
            line.Allocations = (await GetLineAllocationsAsync(orderNumber, line.ProductCode, warehouseId)).ToList();
        }

        return lines;
    }

    public async Task<EligibilityResult> CheckEligibilityAsync(string orderNumber, int warehouseId)
    {
        var order = await GetOrderDetailAsync(orderNumber, warehouseId);

        if (order == null)
        {
            return EligibilityResult.NotEligible("Order not found or not in this warehouse");
        }

        // Check payment validation
        if (!_paymentValidator.ValidatePayment(order.TermsId, order.BalanceDue, order.TotalDue))
        {
            return _paymentValidator.GetPaymentEligibility(order.TermsId, order.BalanceDue, order.TotalDue);
        }

        return EligibilityResult.Eligible();
    }

    public async Task<InventoryAllocationResult> AllocateOrderAsync(
        string orderNumber,
        string username,
        int warehouseId)
    {
        _logger.LogInformation(
            "Starting order allocation: Order={OrderNumber}, User={Username}, Warehouse={Warehouse}",
            orderNumber, username, warehouseId);

        // Check eligibility
        var eligibility = await CheckEligibilityAsync(orderNumber, warehouseId);
        if (!eligibility.IsEligible)
        {
            return InventoryAllocationResult.Failed(eligibility.Reason);
        }

        // Acquire lock
        var lockResult = await _lockService.AcquireLockAsync(orderNumber, username, warehouseId);
        if (!lockResult.Success)
        {
            return InventoryAllocationResult.Failed($"Order is locked by {lockResult.LockedBy}");
        }

        try
        {
            // Get line items to allocate
            var lineItems = await GetOrderLineItemsAsync(orderNumber, warehouseId);
            var results = new List<InventoryAllocationResult>();
            decimal totalAllocated = 0;
            decimal totalShort = 0;

            foreach (var line in lineItems)
            {
                // Skip already fully allocated lines
                if (line.AllocatedQuantity >= line.OrderedQuantity)
                    continue;

                decimal needed = line.OrderedQuantity - line.AllocatedQuantity;

                var result = await _fifoEngine.AllocateAsync(
                    orderNumber,
                    line.ProductCode,
                    needed,
                    warehouseId,
                    customerId: 0, // TODO: Get from order
                    DateTime.Today);

                totalAllocated += result.QuantityAllocated;
                totalShort += result.QuantityShort;
                results.Add(result);
            }

            _logger.LogInformation(
                "Order allocation complete: Order={OrderNumber}, Allocated={Allocated}, Short={Short}",
                orderNumber, totalAllocated, totalShort);

            if (totalShort > 0)
            {
                return InventoryAllocationResult.Partial(totalAllocated, totalShort);
            }

            return InventoryAllocationResult.Succeeded(totalAllocated);
        }
        finally
        {
            // Always release lock
            await _lockService.ReleaseLockAsync(orderNumber, username, warehouseId);
        }
    }

    public async Task<InventoryAllocationResult> AllocateLineItemAsync(
        string orderNumber,
        string productCode,
        decimal quantity,
        string username,
        int warehouseId)
    {
        // Acquire lock
        var lockResult = await _lockService.AcquireLockAsync(orderNumber, username, warehouseId);
        if (!lockResult.Success)
        {
            return InventoryAllocationResult.Failed($"Order is locked by {lockResult.LockedBy}");
        }

        try
        {
            return await _fifoEngine.AllocateAsync(
                orderNumber,
                productCode,
                quantity,
                warehouseId,
                customerId: 0,
                DateTime.Today);
        }
        finally
        {
            await _lockService.ReleaseLockAsync(orderNumber, username, warehouseId);
        }
    }

    public async Task<bool> DeallocateOrderAsync(string orderNumber, string username, int warehouseId)
    {
        _logger.LogInformation(
            "Starting order deallocation: Order={OrderNumber}, User={Username}, Warehouse={Warehouse}",
            orderNumber, username, warehouseId);

        // Acquire lock
        var lockResult = await _lockService.AcquireLockAsync(orderNumber, username, warehouseId);
        if (!lockResult.Success)
        {
            _logger.LogWarning("Cannot deallocate - order locked by {LockedBy}", lockResult.LockedBy);
            return false;
        }

        try
        {
            long ordNum = long.Parse(orderNumber);

            // Delete all unpicked allocations for order using EF Core
            var allocations = await _context.Set<Webapp_allocate>()
                .Where(a => a.all_ordernum == ordNum &&
                           a.all_id == warehouseId &&
                           a.all_pick == 0)
                .ToListAsync();

            if (allocations.Any())
            {
                _context.Set<Webapp_allocate>().RemoveRange(allocations);
                await _context.SaveChangesAsync();

                _logger.LogInformation(
                    "Deallocated {Count} records for order {OrderNumber}",
                    allocations.Count, orderNumber);
            }

            return true;
        }
        finally
        {
            await _lockService.ReleaseLockAsync(orderNumber, username, warehouseId);
        }
    }

    public async Task<bool> DeallocateLineItemAsync(
        string orderNumber,
        string productCode,
        string username,
        int warehouseId)
    {
        // Acquire lock
        var lockResult = await _lockService.AcquireLockAsync(orderNumber, username, warehouseId);
        if (!lockResult.Success)
        {
            return false;
        }

        try
        {
            long ordNum = long.Parse(orderNumber);

            var allocations = await _context.Set<Webapp_allocate>()
                .Where(a => a.all_ordernum == ordNum &&
                           a.all_codenum == productCode &&
                           a.all_id == warehouseId &&
                           a.all_pick == 0)
                .ToListAsync();

            if (allocations.Any())
            {
                _context.Set<Webapp_allocate>().RemoveRange(allocations);
                await _context.SaveChangesAsync();

                _logger.LogInformation(
                    "Deallocated {Count} records for product {ProductCode} on order {OrderNumber}",
                    allocations.Count, productCode, orderNumber);
            }

            return allocations.Any();
        }
        finally
        {
            await _lockService.ReleaseLockAsync(orderNumber, username, warehouseId);
        }
    }

    public async Task<InventoryAllocationStatus> GetOrderStatusAsync(string orderNumber, int warehouseId)
    {
        var order = await GetOrderDetailAsync(orderNumber, warehouseId);

        if (order == null)
            return InventoryAllocationStatus.NotAllocated;

        return order.Status;
    }

    public async Task<bool> HasAllocatorPermissionAsync(string username)
    {
        return await CheckPermissionAsync(username, ALLOCATOR_PERMISSION_ID);
    }

    public async Task<bool> HasDeallocatorPermissionAsync(string username)
    {
        return await CheckPermissionAsync(username, DEALLOCATOR_PERMISSION_ID);
    }

    public async Task<IEnumerable<AvailableInventory>> GetAvailableInventoryAsync(
        string productCode,
        int warehouseId)
    {
        var lots = await _fifoEngine.GetAvailableLotsAsync(productCode, warehouseId, DateTime.Today);

        return lots.Select(lot => new AvailableInventory
        {
            ProductCode = lot.ProductCode,
            LotNumber = lot.LotNumber,
            Location = lot.Location,
            OnHand = lot.OnHand,
            Allocated = lot.Allocated,
            Available = lot.Available,
            ExpirationDate = lot.ExpirationDate,
            DaysUntilExpiration = lot.ExpirationDate.HasValue
                ? (lot.ExpirationDate.Value - DateTime.Today).Days
                : int.MaxValue
        });
    }

    // Private helpers

    private async Task<IEnumerable<InventoryAllocationRecord>> GetLineAllocationsAsync(
        string orderNumber,
        string productCode,
        int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        const string sql = @"
            SELECT
                all_index AS [Index],
                all_id AS WarehouseId,
                CAST(all_ordernum AS VARCHAR) AS OrderNumber,
                all_codenum AS ProductCode,
                all_userlot AS LotNumber,
                all_qty AS Quantity,
                ISNULL(all_pick, 0) AS PickedQuantity,
                all_date AS AllocationDate,
                ISNULL(all_chr1, '') AS Location,
                ISNULL(all_chr2, '') AS Allocator
            FROM webapp_allocate
            WHERE all_ordernum = @OrderNumber
              AND all_codenum = @ProductCode
              AND all_id = @WarehouseId
            ORDER BY all_date";

        return await _secondaryDapper.QueryAsync<InventoryAllocationRecord>(sql, new
        {
            OrderNumber = ordNum,
            ProductCode = productCode,
            WarehouseId = warehouseId
        });
    }

    private async Task<bool> CheckPermissionAsync(string username, int permissionId)
    {
        // Query dtd2 for permission value
        // d2_d1id = permission ID, d2_recid = user ID
        const string sql = @"
            SELECT CASE WHEN d2_value = 'Yes' THEN 1 ELSE 0 END
            FROM dtd2
            JOIN webappsystem.dbo.dxuser ON us_id = d2_recid
            WHERE d2_d1id = @PermissionId
              AND LOWER(us_login) = LOWER(@Username)";

        var result = await _primaryDapper.QuerySingleAsync<int?>(sql, new
        {
            PermissionId = permissionId,
            Username = username
        });

        // For MVP, if permission not found, allow access
        // TODO: Implement proper permission checking in production
        // Result of 1 = has permission, null = not found (default allow)
        return result == 1 || result == null;
    }
}
