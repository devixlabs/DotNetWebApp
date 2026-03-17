using DotNetWebApp.Services.InventoryAllocation.Models;

namespace DotNetWebApp.Services.InventoryAllocation;

/// <summary>
/// Inventory allocation service interface for inventory allocation operations.
/// Handles order eligibility, FIFO allocation, locking, and permissions.
/// </summary>
public interface IInventoryAllocationService
{
    /// <summary>
    /// Get orders available for allocation in warehouse.
    /// </summary>
    Task<IEnumerable<InventoryAllocationOrderSummary>> GetOrdersForAllocationAsync(
        int warehouseId,
        DateTime? shipDate = null);

    /// <summary>
    /// Get order detail with line items and allocations.
    /// </summary>
    Task<InventoryAllocationOrderSummary?> GetOrderDetailAsync(string orderNumber, int warehouseId);

    /// <summary>
    /// Get line items for order with allocation status.
    /// </summary>
    Task<IEnumerable<InventoryAllocationLineItem>> GetOrderLineItemsAsync(string orderNumber, int warehouseId);

    /// <summary>
    /// Check if order is eligible for allocation.
    /// </summary>
    Task<EligibilityResult> CheckEligibilityAsync(string orderNumber, int warehouseId);

    /// <summary>
    /// Allocate inventory to entire order.
    /// </summary>
    Task<InventoryAllocationResult> AllocateOrderAsync(
        string orderNumber,
        string username,
        int warehouseId);

    /// <summary>
    /// Allocate inventory to specific line item.
    /// </summary>
    Task<InventoryAllocationResult> AllocateLineItemAsync(
        string orderNumber,
        string productCode,
        decimal quantity,
        string username,
        int warehouseId);

    /// <summary>
    /// Deallocate inventory from order (reverse allocation).
    /// </summary>
    Task<bool> DeallocateOrderAsync(string orderNumber, string username, int warehouseId);

    /// <summary>
    /// Deallocate specific line item.
    /// </summary>
    Task<bool> DeallocateLineItemAsync(
        string orderNumber,
        string productCode,
        string username,
        int warehouseId);

    /// <summary>
    /// Get allocation status for order.
    /// </summary>
    Task<InventoryAllocationStatus> GetOrderStatusAsync(string orderNumber, int warehouseId);

    /// <summary>
    /// Verify user has allocation permission (674=Allocator).
    /// </summary>
    Task<bool> HasAllocatorPermissionAsync(string username);

    /// <summary>
    /// Verify user has deallocation permission (681=DeAllocator).
    /// </summary>
    Task<bool> HasDeallocatorPermissionAsync(string username);

    /// <summary>
    /// Get available inventory for product.
    /// </summary>
    Task<IEnumerable<AvailableInventory>> GetAvailableInventoryAsync(
        string productCode,
        int warehouseId);
}
