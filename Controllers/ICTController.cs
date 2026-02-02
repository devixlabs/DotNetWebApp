using DotNetWebApp.Services.ICT;
using DotNetWebApp.Services.ICT.Models;
using Microsoft.AspNetCore.Mvc;

namespace DotNetWebApp.Controllers;

/// <summary>
/// Controller for ICT (Inter-Company Transfer) operations.
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class ICTController : ControllerBase
{
    private readonly IICTService _ictService;
    private readonly ILogger<ICTController> _logger;

    public ICTController(
        IICTService ictService,
        ILogger<ICTController> logger)
    {
        _ictService = ictService;
        _logger = logger;
    }

    /// <summary>
    /// Create new ICT order.
    /// </summary>
    [HttpPost("orders")]
    [ProducesResponseType(typeof(ICTOrder), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<ICTOrder>> CreateOrder([FromBody] CreateICTOrderRequest request)
    {
        try
        {
            var order = await _ictService.CreateOrderAsync(request);
            return CreatedAtAction(nameof(GetOrder), new { orderNumber = order.OrderNumber }, order);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating ICT order");
            return StatusCode(500, new { error = "Failed to create order", message = ex.Message });
        }
    }

    /// <summary>
    /// Get ICT order by order number.
    /// </summary>
    [HttpGet("orders/{orderNumber}")]
    [ProducesResponseType(typeof(ICTOrder), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<ActionResult<ICTOrder>> GetOrder(string orderNumber)
    {
        var order = await _ictService.GetOrderAsync(orderNumber);

        if (order == null)
            return NotFound(new { error = $"Order {orderNumber} not found" });

        return Ok(order);
    }

    /// <summary>
    /// List all ICT orders for a warehouse.
    /// </summary>
    [HttpGet("orders")]
    [ProducesResponseType(typeof(IEnumerable<ICTOrderSummary>), StatusCodes.Status200OK)]
    public async Task<ActionResult<IEnumerable<ICTOrderSummary>>> ListOrders(
        [FromQuery] int warehouseId,
        [FromQuery] DateTime? currentDate = null)
    {
        var orders = await _ictService.ListOrdersAsync(warehouseId, currentDate);
        return Ok(orders);
    }

    /// <summary>
    /// Add line item to ICT order.
    /// </summary>
    [HttpPost("orders/{orderNumber}/items")]
    [ProducesResponseType(typeof(int), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<int>> AddLineItem(
        string orderNumber,
        [FromBody] AddLineItemRequest request)
    {
        try
        {
            request.OrderNumber = orderNumber; // Ensure order number matches route
            int lineItemId = await _ictService.AddLineItemAsync(request);
            return Created($"/api/ict/orders/{orderNumber}/items/{lineItemId}", lineItemId);
        }
        catch (InvalidOperationException ex)
        {
            // Validation error
            return BadRequest(new { error = ex.Message });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error adding line item to order {OrderNumber}", orderNumber);
            return StatusCode(500, new { error = "Failed to add line item", message = ex.Message });
        }
    }

    /// <summary>
    /// Remove line item from order.
    /// </summary>
    [HttpDelete("items/{lineItemId}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> RemoveLineItem(int lineItemId)
    {
        bool removed = await _ictService.RemoveLineItemAsync(lineItemId);

        if (!removed)
            return NotFound(new { error = $"Line item {lineItemId} not found" });

        return NoContent();
    }

    /// <summary>
    /// Submit ICT order (finalize totals).
    /// </summary>
    [HttpPost("orders/{orderNumber}/submit")]
    [ProducesResponseType(typeof(SubmitOrderResult), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<SubmitOrderResult>> SubmitOrder(string orderNumber)
    {
        var result = await _ictService.SubmitOrderAsync(orderNumber);

        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    /// <summary>
    /// Delete ICT order and all line items.
    /// </summary>
    [HttpDelete("orders/{orderNumber}")]
    [ProducesResponseType(typeof(DeleteOrderResult), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<DeleteOrderResult>> DeleteOrder(
        string orderNumber,
        [FromQuery] int warehouseId)
    {
        var result = await _ictService.DeleteOrderAsync(orderNumber, warehouseId);

        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    /// <summary>
    /// Get available products for ICT transfer.
    /// </summary>
    [HttpGet("products")]
    [ProducesResponseType(typeof(IEnumerable<ICTProduct>), StatusCodes.Status200OK)]
    public async Task<ActionResult<IEnumerable<ICTProduct>>> GetAvailableProducts(
        [FromQuery] int warehouseId)
    {
        var products = await _ictService.GetAvailableProductsAsync(warehouseId);
        return Ok(products);
    }

    /// <summary>
    /// Get manufacturing jobs for ICT planning.
    /// </summary>
    [HttpGet("jobs")]
    [ProducesResponseType(typeof(IEnumerable<ManufacturingJob>), StatusCodes.Status200OK)]
    public async Task<ActionResult<IEnumerable<ManufacturingJob>>> GetManufacturingJobs(
        [FromQuery] DateTime? currentDate = null)
    {
        var jobs = await _ictService.GetManufacturingJobsAsync(currentDate ?? DateTime.Today);
        return Ok(jobs);
    }

    /// <summary>
    /// Validate product quantity against warehouse availability.
    /// </summary>
    [HttpGet("products/{productCode}/validate")]
    [ProducesResponseType(typeof(QuantityValidationResult), StatusCodes.Status200OK)]
    public async Task<ActionResult<QuantityValidationResult>> ValidateQuantity(
        string productCode,
        [FromQuery] decimal quantity,
        [FromQuery] int warehouseId)
    {
        var result = await _ictService.ValidateQuantityAsync(productCode, quantity, warehouseId);
        return Ok(result);
    }
}
