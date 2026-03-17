using DotNetWebApp.Services.InventoryPicking.Models;

namespace DotNetWebApp.Services.InventoryPicking;

/// <summary>
/// Service interface for InventoryPicking workflow operations.
/// Manages picker, auditor, and assembler assignments for orders.
/// </summary>
public interface IInventoryPickingService
{
    /// <summary>
    /// Get a single InventoryPicking order by order number.
    /// </summary>
    Task<InventoryPickingOrder?> GetOrderAsync(string orderNumber, int warehouseId);

    /// <summary>
    /// List InventoryPicking orders for a warehouse within a date range.
    /// </summary>
    Task<IEnumerable<InventoryPickingOrder>> ListOrdersAsync(
        int warehouseId,
        DateTime? startDate = null,
        DateTime? endDate = null);

    /// <summary>
    /// Assign a picker to an order.
    /// No validation required - picker can be assigned at any time.
    /// </summary>
    Task<AssignmentResult> AssignPickerAsync(AssignPickerRequest request, int warehouseId);

    /// <summary>
    /// Assign an auditor to an order.
    /// Validates: Must have picker, must be allocated (with carrier exceptions).
    /// </summary>
    Task<AssignmentResult> AssignAuditorAsync(AssignAuditorRequest request, int warehouseId);

    /// <summary>
    /// Assign an assembler to an order.
    /// No validation required - assembler can be assigned at any time.
    /// </summary>
    Task<AssignmentResult> AssignAssemblerAsync(AssignAssemblerRequest request, int warehouseId);

    /// <summary>
    /// Clock out a worker (picker, auditor, or assembler).
    /// Validates timestamp (can't equal clock-in).
    /// </summary>
    Task<AssignmentResult> ClockOutAsync(ClockOutRequest request, int warehouseId);

    /// <summary>
    /// Update order allocator, team leader, notes, or status.
    /// </summary>
    Task<AssignmentResult> UpdateOrderAsync(UpdateOrderRequest request, int warehouseId);

    /// <summary>
    /// Get available forklift operators filtered by warehouse.
    /// </summary>
    Task<IEnumerable<AvailableOperator>> GetAvailableOperatorsAsync(int warehouseId);

    /// <summary>
    /// Get available allocators.
    /// </summary>
    Task<IEnumerable<AvailableAllocator>> GetAvailableAllocatorsAsync();

    /// <summary>
    /// Get available team leaders.
    /// </summary>
    Task<IEnumerable<AvailableTeamLeader>> GetAvailableTeamLeadersAsync();

    /// <summary>
    /// Batch update allocator for multiple orders.
    /// </summary>
    Task<AssignmentResult> BatchUpdateAllocatorAsync(
        IEnumerable<string> orderNumbers,
        string allocator,
        int warehouseId);

    /// <summary>
    /// Batch update team leader for multiple orders.
    /// </summary>
    Task<AssignmentResult> BatchUpdateTeamLeaderAsync(
        IEnumerable<string> orderNumbers,
        string teamLeader,
        int warehouseId);
}
