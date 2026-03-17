namespace DotNetWebApp.Services.InventoryAllocation.Models;

/// <summary>
/// Inventory allocation status enum for order inventory allocation state.
/// </summary>
public enum InventoryAllocationStatus
{
    NotAllocated = 0,
    PartiallyAllocated = 1,
    FullyAllocated = 2,
    OverAllocated = 3
}

/// <summary>
/// Order eligibility result for allocation.
/// </summary>
public class EligibilityResult
{
    public bool IsEligible { get; set; }
    public string Reason { get; set; } = string.Empty;

    public static EligibilityResult Eligible() => new() { IsEligible = true };
    public static EligibilityResult NotEligible(string reason) => new() { IsEligible = false, Reason = reason };
}

/// <summary>
/// Result of inventory allocation operation.
/// </summary>
public class InventoryAllocationResult
{
    public bool Success { get; set; }
    public string ErrorMessage { get; set; } = string.Empty;
    public decimal QuantityAllocated { get; set; }
    public decimal QuantityShort { get; set; }
    public List<AllocatedLot> AllocatedLots { get; set; } = new();

    public static InventoryAllocationResult Succeeded(decimal allocated, List<AllocatedLot>? lots = null)
        => new() { Success = true, QuantityAllocated = allocated, AllocatedLots = lots ?? new() };

    public static InventoryAllocationResult Failed(string error)
        => new() { Success = false, ErrorMessage = error };

    public static InventoryAllocationResult Partial(decimal allocated, decimal @short, List<AllocatedLot>? lots = null)
        => new() { Success = true, QuantityAllocated = allocated, QuantityShort = @short, AllocatedLots = lots ?? new() };
}

/// <summary>
/// Lot allocated from FIFO inventory.
/// </summary>
public class AllocatedLot
{
    public string LotNumber { get; set; } = string.Empty;
    public string ProductCode { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public string Location { get; set; } = string.Empty;
    public DateTime? ExpirationDate { get; set; }
    public DateTime? ReceiptDate { get; set; }
}

/// <summary>
/// Inventory lot from dtfifo table.
/// </summary>
public class InventoryLot
{
    public int FifoId { get; set; }
    public string ProductCode { get; set; } = string.Empty;
    public string LotNumber { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public decimal OnHand { get; set; }
    public decimal Allocated { get; set; }
    public decimal Reserved { get; set; }
    public DateTime? ExpirationDate { get; set; }
    public DateTime? ReceiptDate { get; set; }
    public string InventoryType { get; set; } = string.Empty;
    public int WarehouseId { get; set; }

    public decimal Available => Math.Max(0, OnHand - Allocated - Reserved);
}

/// <summary>
/// Lock result for pessimistic locking.
/// </summary>
public class LockResult
{
    public bool Success { get; set; }
    public string LockedBy { get; set; } = string.Empty;
    public DateTime? LockDate { get; set; }
    public string Message { get; set; } = string.Empty;

    public static LockResult Acquired() => new() { Success = true };
    public static LockResult AlreadyOwned() => new() { Success = true, Message = "Lock already owned" };
    public static LockResult LockedByOther(string username, DateTime lockDate)
        => new() { Success = false, LockedBy = username, LockDate = lockDate, Message = $"Locked by {username}" };
    public static LockResult Failed(string error) => new() { Success = false, Message = error };
}

/// <summary>
/// Order lock record from webapp_lock table.
/// </summary>
public class OrderLock
{
    public int LockIndex { get; set; }
    public int LockId { get; set; }
    public long OrderNumber { get; set; }
    public string Username { get; set; } = string.Empty;
    public DateTime LockDate { get; set; }
}

/// <summary>
/// Inventory allocation order summary for grid display.
/// </summary>
public class InventoryAllocationOrderSummary
{
    public string OrderNumber { get; set; } = string.Empty;
    public DateTime DueShipDate { get; set; }
    public string CustomerName { get; set; } = string.Empty;
    public string Carrier { get; set; } = string.Empty;
    public int WarehouseId { get; set; }
    public int TotalLines { get; set; }
    public int AllocatedLines { get; set; }
    public decimal TotalOrdered { get; set; }
    public decimal TotalAllocated { get; set; }
    public InventoryAllocationStatus Status { get; set; }
    public bool OkToShip { get; set; }
    public string LockedBy { get; set; } = string.Empty;
    public int Priority { get; set; }
    public decimal BalanceDue { get; set; }
    public decimal TotalDue { get; set; }
    public int TermsId { get; set; }
}

/// <summary>
/// Order line item for inventory allocation detail.
/// </summary>
public class InventoryAllocationLineItem
{
    public int LineIndex { get; set; }
    public string OrderNumber { get; set; } = string.Empty;
    public string ProductCode { get; set; } = string.Empty;
    public string ProductDescription { get; set; } = string.Empty;
    public decimal OrderedQuantity { get; set; }
    public decimal AllocatedQuantity { get; set; }
    public decimal PickedQuantity { get; set; }
    public InventoryAllocationStatus Status { get; set; }
    public List<InventoryAllocationRecord> Allocations { get; set; } = new();
}

/// <summary>
/// Individual allocation record from webapp_allocate table.
/// </summary>
public class InventoryAllocationRecord
{
    public int Index { get; set; }
    public int WarehouseId { get; set; }
    public string OrderNumber { get; set; } = string.Empty;
    public string ProductCode { get; set; } = string.Empty;
    public string LotNumber { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public decimal PickedQuantity { get; set; }
    public DateTime AllocationDate { get; set; }
    public string Location { get; set; } = string.Empty;
    public string Allocator { get; set; } = string.Empty;
}

/// <summary>
/// Request to allocate an order.
/// </summary>
public class AllocateOrderRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
}

/// <summary>
/// Request to deallocate an order.
/// </summary>
public class DeallocateOrderRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public string? ProductCode { get; set; }
    public string? LotNumber { get; set; }
}

/// <summary>
/// Available inventory for allocation display.
/// </summary>
public class AvailableInventory
{
    public string ProductCode { get; set; } = string.Empty;
    public string LotNumber { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public decimal OnHand { get; set; }
    public decimal Allocated { get; set; }
    public decimal Available { get; set; }
    public DateTime? ExpirationDate { get; set; }
    public int DaysUntilExpiration { get; set; }
}
