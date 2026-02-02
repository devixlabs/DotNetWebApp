using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Models.Generated.GAIMisc;
using DotNetWebApp.Services.Allocation.Models;
using DotNetWebApp.Services.Allocation.Validators;
using Microsoft.Extensions.DependencyInjection;

namespace DotNetWebApp.Services.Allocation;

/// <summary>
/// FIFO (First In, First Out) allocation engine.
/// Business Rules:
/// - Order by receipt date (FIFO: oldest first)
/// - Then by expiration date (expiring soonest)
/// - Filter: lot restrictions, shelf-life, inventory type exclusions
/// - Excluded inventory types: staging, icxfer, sal-reserv, quarantine
/// - Excluded locations: 19-*, 20-* prefixed
/// </summary>
public interface IFIFOAllocationEngine
{
    /// <summary>
    /// Allocate inventory to order line using FIFO algorithm.
    /// </summary>
    Task<AllocationResult> AllocateAsync(
        string orderNumber,
        string productCode,
        decimal quantityNeeded,
        int warehouseId,
        int customerId,
        DateTime orderDate);

    /// <summary>
    /// Get available inventory lots for product using FIFO ordering.
    /// </summary>
    Task<IEnumerable<InventoryLot>> GetAvailableLotsAsync(
        string productCode,
        int warehouseId,
        DateTime orderDate,
        int? customerMinShelfDays = null);
}

/// <summary>
/// Implementation of FIFO allocation engine.
/// Uses dtfifo table for inventory, gai_allocate for allocations.
/// </summary>
public class FIFOAllocationEngine : IFIFOAllocationEngine
{
    private readonly SecondaryDbContext _context;
    private readonly IDapperQueryService _primaryDapper;   // GAI database - for dtfifo
    private readonly IDapperQueryService _secondaryDapper; // GAIMisc database - for gai_allocate
    private readonly ShelfLifeValidator _shelfLifeValidator;
    private readonly ILogger<FIFOAllocationEngine> _logger;

    /// <summary>
    /// Inventory types excluded from allocation.
    /// </summary>
    private static readonly string[] ExcludedInventoryTypes = new[]
    {
        "staging",
        "icxfer",
        "sal-reserv",
        "quarantine"
    };

    public FIFOAllocationEngine(
        SecondaryDbContext context,
        [FromKeyedServices("Primary")] IDapperQueryService primaryDapper,
        [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper,
        ShelfLifeValidator shelfLifeValidator,
        ILogger<FIFOAllocationEngine> logger)
    {
        _context = context;
        _primaryDapper = primaryDapper;
        _secondaryDapper = secondaryDapper;
        _shelfLifeValidator = shelfLifeValidator;
        _logger = logger;
    }

    public async Task<AllocationResult> AllocateAsync(
        string orderNumber,
        string productCode,
        decimal quantityNeeded,
        int warehouseId,
        int customerId,
        DateTime orderDate)
    {
        var result = new AllocationResult();
        decimal remainingQty = quantityNeeded;

        _logger.LogInformation(
            "Starting FIFO allocation: Order={OrderNumber}, Product={ProductCode}, Qty={Quantity}, Warehouse={Warehouse}",
            orderNumber, productCode, quantityNeeded, warehouseId);

        // Get available lots sorted by FIFO
        var availableLots = await GetAvailableLotsAsync(productCode, warehouseId, orderDate);
        var lots = availableLots.ToList();

        if (!lots.Any())
        {
            _logger.LogWarning(
                "No available inventory for product {ProductCode} in warehouse {Warehouse}",
                productCode, warehouseId);

            return AllocationResult.Failed("No available inventory after restrictions/shelf-life filters");
        }

        long ordNum = long.Parse(orderNumber);

        // Allocate from each lot in FIFO order
        foreach (var lot in lots)
        {
            if (remainingQty <= 0)
                break;

            decimal toAllocate = Math.Min(lot.Available, remainingQty);

            if (toAllocate > 0)
            {
                // Insert allocation record
                await InsertAllocationAsync(new AllocationRecord
                {
                    WarehouseId = warehouseId,
                    OrderNumber = orderNumber,
                    ProductCode = productCode,
                    LotNumber = lot.LotNumber,
                    Quantity = toAllocate,
                    AllocationDate = DateTime.Now,
                    Location = lot.Location
                });

                result.AllocatedLots.Add(new AllocatedLot
                {
                    LotNumber = lot.LotNumber,
                    ProductCode = productCode,
                    Quantity = toAllocate,
                    Location = lot.Location,
                    ExpirationDate = lot.ExpirationDate,
                    ReceiptDate = lot.ReceiptDate
                });

                _logger.LogDebug(
                    "Allocated {Quantity} from lot {LotNumber} at {Location}",
                    toAllocate, lot.LotNumber, lot.Location);

                remainingQty -= toAllocate;
            }
        }

        result.QuantityAllocated = quantityNeeded - remainingQty;
        result.QuantityShort = Math.Max(0, remainingQty);
        result.Success = true;

        _logger.LogInformation(
            "FIFO allocation complete: Allocated={Allocated}, Short={Short}, Lots={LotCount}",
            result.QuantityAllocated, result.QuantityShort, result.AllocatedLots.Count);

        return result;
    }

    public async Task<IEnumerable<InventoryLot>> GetAvailableLotsAsync(
        string productCode,
        int warehouseId,
        DateTime orderDate,
        int? customerMinShelfDays = null)
    {
        int minShelfDays = customerMinShelfDays ?? ShelfLifeValidator.DEFAULT_MIN_SHELF_LIFE_DAYS;
        DateTime minExpiration = orderDate.AddDays(minShelfDays);

        // Build excluded types condition
        string excludedTypesCondition = string.Join(" AND ", ExcludedInventoryTypes.Select(t => $"fi_type <> '{t}'"));

        // Query available inventory with FIFO ordering
        // Business Rules:
        // - Filter by warehouse
        // - Exclude staging, icxfer, sal-reserv, quarantine
        // - Exclude year-prefixed locations (19-*, 20-*)
        // - Filter by shelf life (30 days minimum)
        // - Order by receipt date, then expiration date (FIFO)
        string sql = $@"
            SELECT
                fi_id AS FifoId,
                pr.pr_code AS ProductCode,
                fi_userlot AS LotNumber,
                lo.lo_name AS Location,
                fi_balance AS OnHand,
                ISNULL((SELECT SUM(all_qty) FROM GAIMisc.dbo.gai_allocate
                        WHERE all_codenum = pr.pr_code AND all_userlot = fi_userlot AND all_pick = 0), 0) AS Allocated,
                0 AS Reserved,
                fi_expires AS ExpirationDate,
                fi_recdate AS ReceiptDate,
                fi_type AS InventoryType,
                fi_waid AS WarehouseId
            FROM dtfifo
            JOIN dmprod pr ON pr.pr_id = fi_prid
            JOIN dmloc lo ON lo.lo_id = fi_loid
            WHERE fi_waid = @WarehouseId
              AND pr.pr_code = @ProductCode
              AND fi_balance > 0
              AND {excludedTypesCondition}
              AND lo.lo_name NOT LIKE '19-%'
              AND lo.lo_name NOT LIKE '20-%'
              AND (fi_expires IS NULL OR fi_expires > @MinExpiration)
            ORDER BY fi_recdate ASC, fi_expires ASC";

        var lots = await _primaryDapper.QueryAsync<InventoryLot>(sql, new
        {
            WarehouseId = warehouseId,
            ProductCode = productCode,
            MinExpiration = minExpiration
        });

        // Filter to only available lots (OnHand > Allocated + Reserved)
        return lots.Where(lot => lot.Available > 0);
    }

    private async Task InsertAllocationAsync(AllocationRecord record)
    {
        var allocation = new Gai_allocate
        {
            all_id = record.WarehouseId,
            all_ordernum = long.Parse(record.OrderNumber),
            all_codenum = record.ProductCode,
            all_userlot = record.LotNumber,
            all_qty = (int)record.Quantity,
            all_pick = 0, // Not picked
            all_date = DateTime.Now,
            all_chr1 = record.Location,
            all_chr2 = record.Allocator
        };

        _context.Set<Gai_allocate>().Add(allocation);
        await _context.SaveChangesAsync();
    }
}
