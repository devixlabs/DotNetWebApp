using DotNetWebApp.Services.PrePick;
using DotNetWebApp.Services.PrePick.Models;
using Microsoft.AspNetCore.Mvc;

namespace DotNetWebApp.Controllers;

/// <summary>
/// API controller for PrePick workflow operations.
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class PrePickController : ControllerBase
{
    private readonly IPrePickService _prePickService;
    private readonly ILogger<PrePickController> _logger;

    public PrePickController(
        IPrePickService prePickService,
        ILogger<PrePickController> logger)
    {
        _prePickService = prePickService;
        _logger = logger;
    }

    /// <summary>
    /// GET /api/prepick/orders?warehouseId=X&startDate=Y&endDate=Z
    /// List PrePick orders for a warehouse.
    /// </summary>
    [HttpGet("orders")]
    public async Task<ActionResult<IEnumerable<PrePickOrder>>> ListOrders(
        [FromQuery] int warehouseId,
        [FromQuery] DateTime? startDate = null,
        [FromQuery] DateTime? endDate = null)
    {
        try
        {
            var orders = await _prePickService.ListOrdersAsync(warehouseId, startDate, endDate);
            return Ok(orders);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to list PrePick orders");
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// GET /api/prepick/orders/{orderNumber}?warehouseId=X
    /// Get a single PrePick order.
    /// </summary>
    [HttpGet("orders/{orderNumber}")]
    public async Task<ActionResult<PrePickOrder>> GetOrder(
        string orderNumber,
        [FromQuery] int warehouseId)
    {
        try
        {
            var order = await _prePickService.GetOrderAsync(orderNumber, warehouseId);
            if (order == null)
                return NotFound(new { error = $"Order {orderNumber} not found" });

            return Ok(order);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get PrePick order {OrderNumber}", orderNumber);
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// POST /api/prepick/orders/{orderNumber}/picker
    /// Assign a picker to an order.
    /// </summary>
    [HttpPost("orders/{orderNumber}/picker")]
    public async Task<ActionResult<AssignmentResult>> AssignPicker(
        string orderNumber,
        [FromQuery] int warehouseId,
        [FromBody] AssignPickerRequest request)
    {
        request.OrderNumber = orderNumber;

        try
        {
            var result = await _prePickService.AssignPickerAsync(request, warehouseId);
            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to assign picker to order {OrderNumber}", orderNumber);
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// POST /api/prepick/orders/{orderNumber}/auditor
    /// Assign an auditor to an order.
    /// </summary>
    [HttpPost("orders/{orderNumber}/auditor")]
    public async Task<ActionResult<AssignmentResult>> AssignAuditor(
        string orderNumber,
        [FromQuery] int warehouseId,
        [FromBody] AssignAuditorRequest request)
    {
        request.OrderNumber = orderNumber;

        try
        {
            var result = await _prePickService.AssignAuditorAsync(request, warehouseId);
            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to assign auditor to order {OrderNumber}", orderNumber);
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// POST /api/prepick/orders/{orderNumber}/assembler
    /// Assign an assembler to an order.
    /// </summary>
    [HttpPost("orders/{orderNumber}/assembler")]
    public async Task<ActionResult<AssignmentResult>> AssignAssembler(
        string orderNumber,
        [FromQuery] int warehouseId,
        [FromBody] AssignAssemblerRequest request)
    {
        request.OrderNumber = orderNumber;

        try
        {
            var result = await _prePickService.AssignAssemblerAsync(request, warehouseId);
            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to assign assembler to order {OrderNumber}", orderNumber);
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// POST /api/prepick/orders/{orderNumber}/clockout
    /// Clock out a worker.
    /// </summary>
    [HttpPost("orders/{orderNumber}/clockout")]
    public async Task<ActionResult<AssignmentResult>> ClockOut(
        string orderNumber,
        [FromQuery] int warehouseId,
        [FromBody] ClockOutRequest request)
    {
        request.OrderNumber = orderNumber;

        try
        {
            var result = await _prePickService.ClockOutAsync(request, warehouseId);
            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to clock out worker for order {OrderNumber}", orderNumber);
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// PUT /api/prepick/orders/{orderNumber}
    /// Update order details (allocator, team leader, notes, status).
    /// </summary>
    [HttpPut("orders/{orderNumber}")]
    public async Task<ActionResult<AssignmentResult>> UpdateOrder(
        string orderNumber,
        [FromQuery] int warehouseId,
        [FromBody] UpdateOrderRequest request)
    {
        request.OrderNumber = orderNumber;

        try
        {
            var result = await _prePickService.UpdateOrderAsync(request, warehouseId);
            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to update order {OrderNumber}", orderNumber);
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// GET /api/prepick/operators?warehouseId=X
    /// Get available operators for a warehouse.
    /// </summary>
    [HttpGet("operators")]
    public async Task<ActionResult<IEnumerable<AvailableOperator>>> GetOperators(
        [FromQuery] int warehouseId)
    {
        try
        {
            var operators = await _prePickService.GetAvailableOperatorsAsync(warehouseId);
            return Ok(operators);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get operators");
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// GET /api/prepick/allocators
    /// Get available allocators.
    /// </summary>
    [HttpGet("allocators")]
    public async Task<ActionResult<IEnumerable<AvailableAllocator>>> GetAllocators()
    {
        try
        {
            var allocators = await _prePickService.GetAvailableAllocatorsAsync();
            return Ok(allocators);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get allocators");
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// GET /api/prepick/teamleaders
    /// Get available team leaders.
    /// </summary>
    [HttpGet("teamleaders")]
    public async Task<ActionResult<IEnumerable<AvailableTeamLeader>>> GetTeamLeaders()
    {
        try
        {
            var teamLeaders = await _prePickService.GetAvailableTeamLeadersAsync();
            return Ok(teamLeaders);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get team leaders");
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// POST /api/prepick/batch/allocator
    /// Batch update allocator for multiple orders.
    /// </summary>
    [HttpPost("batch/allocator")]
    public async Task<ActionResult<AssignmentResult>> BatchUpdateAllocator(
        [FromQuery] int warehouseId,
        [FromBody] BatchUpdateRequest request)
    {
        try
        {
            var result = await _prePickService.BatchUpdateAllocatorAsync(
                request.OrderNumbers,
                request.Value,
                warehouseId);

            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to batch update allocator");
            return StatusCode(500, new { error = ex.Message });
        }
    }

    /// <summary>
    /// POST /api/prepick/batch/teamleader
    /// Batch update team leader for multiple orders.
    /// </summary>
    [HttpPost("batch/teamleader")]
    public async Task<ActionResult<AssignmentResult>> BatchUpdateTeamLeader(
        [FromQuery] int warehouseId,
        [FromBody] BatchUpdateRequest request)
    {
        try
        {
            var result = await _prePickService.BatchUpdateTeamLeaderAsync(
                request.OrderNumbers,
                request.Value,
                warehouseId);

            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to batch update team leader");
            return StatusCode(500, new { error = ex.Message });
        }
    }
}

/// <summary>
/// Request for batch update operations.
/// </summary>
public class BatchUpdateRequest
{
    public IEnumerable<string> OrderNumbers { get; set; } = [];
    public string Value { get; set; } = string.Empty;
}
