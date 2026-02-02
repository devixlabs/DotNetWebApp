using DotNetWebApp.Services.Allocation;
using DotNetWebApp.Services.Allocation.Models;
using Microsoft.AspNetCore.Mvc;

namespace DotNetWebApp.Controllers;

/// <summary>
/// API controller for allocation operations.
/// Provides endpoints for order allocation, deallocation, and inventory lookup.
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class AllocationController : ControllerBase
{
    private readonly IAllocationService _allocationService;
    private readonly ILockService _lockService;
    private readonly ILogger<AllocationController> _logger;

    public AllocationController(
        IAllocationService allocationService,
        ILockService lockService,
        ILogger<AllocationController> logger)
    {
        _allocationService = allocationService;
        _lockService = lockService;
        _logger = logger;
    }

    /// <summary>
    /// Get orders available for allocation.
    /// </summary>
    [HttpGet("orders")]
    public async Task<ActionResult<IEnumerable<AllocationOrderSummary>>> GetOrders(
        [FromQuery] int warehouseId = 3,
        [FromQuery] DateTime? shipDate = null)
    {
        var orders = await _allocationService.GetOrdersForAllocationAsync(warehouseId, shipDate);
        return Ok(orders);
    }

    /// <summary>
    /// Get order detail with allocation status.
    /// </summary>
    [HttpGet("orders/{orderNumber}")]
    public async Task<ActionResult<AllocationOrderSummary>> GetOrder(
        string orderNumber,
        [FromQuery] int warehouseId = 3)
    {
        var order = await _allocationService.GetOrderDetailAsync(orderNumber, warehouseId);

        if (order == null)
            return NotFound($"Order {orderNumber} not found");

        return Ok(order);
    }

    /// <summary>
    /// Get line items for order with allocation details.
    /// </summary>
    [HttpGet("orders/{orderNumber}/lines")]
    public async Task<ActionResult<IEnumerable<AllocationLineItem>>> GetOrderLines(
        string orderNumber,
        [FromQuery] int warehouseId = 3)
    {
        var lines = await _allocationService.GetOrderLineItemsAsync(orderNumber, warehouseId);
        return Ok(lines);
    }

    /// <summary>
    /// Check order eligibility for allocation.
    /// </summary>
    [HttpGet("orders/{orderNumber}/eligibility")]
    public async Task<ActionResult<EligibilityResult>> CheckEligibility(
        string orderNumber,
        [FromQuery] int warehouseId = 3)
    {
        var result = await _allocationService.CheckEligibilityAsync(orderNumber, warehouseId);
        return Ok(result);
    }

    /// <summary>
    /// Allocate inventory to order.
    /// </summary>
    [HttpPost("orders/{orderNumber}/allocate")]
    public async Task<ActionResult<AllocationResult>> AllocateOrder(
        string orderNumber,
        [FromBody] AllocateOrderRequest request,
        [FromQuery] int warehouseId = 3)
    {
        if (string.IsNullOrEmpty(request.Username))
            return BadRequest("Username is required");

        // Check permission
        if (!await _allocationService.HasAllocatorPermissionAsync(request.Username))
        {
            return Forbid($"{request.Username} does not have allocator permission (674)");
        }

        var result = await _allocationService.AllocateOrderAsync(orderNumber, request.Username, warehouseId);

        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    /// <summary>
    /// Allocate inventory to specific line item.
    /// </summary>
    [HttpPost("orders/{orderNumber}/lines/{productCode}/allocate")]
    public async Task<ActionResult<AllocationResult>> AllocateLineItem(
        string orderNumber,
        string productCode,
        [FromBody] AllocateOrderRequest request,
        [FromQuery] decimal quantity,
        [FromQuery] int warehouseId = 3)
    {
        if (string.IsNullOrEmpty(request.Username))
            return BadRequest("Username is required");

        if (!await _allocationService.HasAllocatorPermissionAsync(request.Username))
        {
            return Forbid($"{request.Username} does not have allocator permission (674)");
        }

        var result = await _allocationService.AllocateLineItemAsync(
            orderNumber, productCode, quantity, request.Username, warehouseId);

        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    /// <summary>
    /// Deallocate inventory from order.
    /// </summary>
    [HttpPost("orders/{orderNumber}/deallocate")]
    public async Task<ActionResult> DeallocateOrder(
        string orderNumber,
        [FromBody] DeallocateOrderRequest request,
        [FromQuery] int warehouseId = 3)
    {
        if (string.IsNullOrEmpty(request.Username))
            return BadRequest("Username is required");

        // Check permission
        if (!await _allocationService.HasDeallocatorPermissionAsync(request.Username))
        {
            return Forbid($"{request.Username} does not have deallocator permission (681)");
        }

        var success = await _allocationService.DeallocateOrderAsync(orderNumber, request.Username, warehouseId);

        if (!success)
            return BadRequest("Failed to deallocate order");

        return Ok(new { Message = "Order deallocated successfully" });
    }

    /// <summary>
    /// Deallocate specific line item.
    /// </summary>
    [HttpPost("orders/{orderNumber}/lines/{productCode}/deallocate")]
    public async Task<ActionResult> DeallocateLineItem(
        string orderNumber,
        string productCode,
        [FromBody] DeallocateOrderRequest request,
        [FromQuery] int warehouseId = 3)
    {
        if (string.IsNullOrEmpty(request.Username))
            return BadRequest("Username is required");

        if (!await _allocationService.HasDeallocatorPermissionAsync(request.Username))
        {
            return Forbid($"{request.Username} does not have deallocator permission (681)");
        }

        var success = await _allocationService.DeallocateLineItemAsync(
            orderNumber, productCode, request.Username, warehouseId);

        if (!success)
            return BadRequest("Failed to deallocate line item");

        return Ok(new { Message = "Line item deallocated successfully" });
    }

    /// <summary>
    /// Get allocation status for order.
    /// </summary>
    [HttpGet("orders/{orderNumber}/status")]
    public async Task<ActionResult<AllocationStatus>> GetOrderStatus(
        string orderNumber,
        [FromQuery] int warehouseId = 3)
    {
        var status = await _allocationService.GetOrderStatusAsync(orderNumber, warehouseId);
        return Ok(new { Status = status, StatusText = AllocationStatusColorService.GetStatusText(status) });
    }

    /// <summary>
    /// Get available inventory for product.
    /// </summary>
    [HttpGet("inventory/{productCode}")]
    public async Task<ActionResult<IEnumerable<AvailableInventory>>> GetAvailableInventory(
        string productCode,
        [FromQuery] int warehouseId = 3)
    {
        var inventory = await _allocationService.GetAvailableInventoryAsync(productCode, warehouseId);
        return Ok(inventory);
    }

    /// <summary>
    /// Acquire lock for order.
    /// </summary>
    [HttpPost("locks/{orderNumber}/acquire")]
    public async Task<ActionResult<LockResult>> AcquireLock(
        string orderNumber,
        [FromBody] LockRequest request,
        [FromQuery] int warehouseId = 3)
    {
        if (string.IsNullOrEmpty(request.Username))
            return BadRequest("Username is required");

        var result = await _lockService.AcquireLockAsync(orderNumber, request.Username, warehouseId);
        return Ok(result);
    }

    /// <summary>
    /// Release lock for order.
    /// </summary>
    [HttpPost("locks/{orderNumber}/release")]
    public async Task<ActionResult> ReleaseLock(
        string orderNumber,
        [FromBody] LockRequest request,
        [FromQuery] int warehouseId = 3)
    {
        if (string.IsNullOrEmpty(request.Username))
            return BadRequest("Username is required");

        var success = await _lockService.ReleaseLockAsync(orderNumber, request.Username, warehouseId);

        if (!success)
            return BadRequest("Failed to release lock - may be owned by another user");

        return Ok(new { Message = "Lock released successfully" });
    }

    /// <summary>
    /// Get lock status for order.
    /// </summary>
    [HttpGet("locks/{orderNumber}")]
    public async Task<ActionResult<OrderLock>> GetLock(
        string orderNumber,
        [FromQuery] int warehouseId = 3)
    {
        var lockInfo = await _lockService.GetLockAsync(orderNumber, warehouseId);

        if (lockInfo == null)
            return Ok(new { IsLocked = false });

        return Ok(new { IsLocked = true, Lock = lockInfo });
    }

    /// <summary>
    /// Release all locks for user.
    /// </summary>
    [HttpPost("locks/release-all")]
    public async Task<ActionResult> ReleaseAllUserLocks([FromBody] LockRequest request)
    {
        if (string.IsNullOrEmpty(request.Username))
            return BadRequest("Username is required");

        await _lockService.ReleaseAllUserLocksAsync(request.Username);
        return Ok(new { Message = "All locks released successfully" });
    }

    /// <summary>
    /// Release expired locks (maintenance endpoint).
    /// </summary>
    [HttpPost("locks/release-expired")]
    public async Task<ActionResult> ReleaseExpiredLocks()
    {
        var count = await _lockService.ReleaseExpiredLocksAsync();
        return Ok(new { Message = $"Released {count} expired locks" });
    }
}

/// <summary>
/// Request model for lock operations.
/// </summary>
public class LockRequest
{
    public string Username { get; set; } = string.Empty;
}
