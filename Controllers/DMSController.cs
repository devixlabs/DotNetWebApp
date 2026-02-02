using DotNetWebApp.Services.DMS;
using DotNetWebApp.Services.DMS.Models;
using Microsoft.AspNetCore.Mvc;

namespace DotNetWebApp.Controllers;

/// <summary>
/// REST API controller for DMS (Dock Management System) operations
/// Provides endpoints for order management, status workflow, and personnel assignment
/// </summary>
[ApiController]
[Route("api/dms")]
[Produces("application/json")]
public class DMSController : ControllerBase
{
    private readonly IDMSService _dmsService;
    private readonly ILogger<DMSController> _logger;

    public DMSController(
        IDMSService dmsService,
        ILogger<DMSController> logger)
    {
        _dmsService = dmsService;
        _logger = logger;
    }

    #region Order Retrieval

    /// <summary>
    /// Lists all orders for a specific warehouse and date
    /// </summary>
    /// <param name="warehouseId">Warehouse ID (3=CPFG, 92=Northlake)</param>
    /// <param name="date">Date to filter orders (defaults to today)</param>
    /// <param name="statusFilter">Optional status filter (e.g., "Check In", "Loading")</param>
    /// <returns>List of DMS orders</returns>
    /// <response code="200">Returns the list of orders</response>
    /// <response code="400">If parameters are invalid</response>
    /// <response code="500">If an error occurs</response>
    [HttpGet("orders")]
    [ProducesResponseType(typeof(IEnumerable<DMSOrder>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<IEnumerable<DMSOrder>>> ListOrders(
        [FromQuery] int warehouseId,
        [FromQuery] DateTime? date = null,
        [FromQuery] string? statusFilter = null)
    {
        try
        {
            if (warehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            var filterDate = date ?? DateTime.Today;
            var orders = await _dmsService.ListOrdersAsync(warehouseId, filterDate, statusFilter);

            _logger.LogInformation(
                "Listed {Count} orders for warehouse {WarehouseId} on date {Date}",
                orders.Count(), warehouseId, filterDate);

            return Ok(orders);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error listing orders for warehouse {WarehouseId}", warehouseId);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    /// <summary>
    /// Gets a single order by order number
    /// </summary>
    /// <param name="orderNumber">Order number</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>The order if found</returns>
    /// <response code="200">Returns the order</response>
    /// <response code="404">If order not found</response>
    /// <response code="400">If parameters are invalid</response>
    /// <response code="500">If an error occurs</response>
    [HttpGet("orders/{orderNumber}")]
    [ProducesResponseType(typeof(DMSOrder), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<DMSOrder>> GetOrder(
        [FromRoute] long orderNumber,
        [FromQuery] int warehouseId)
    {
        try
        {
            if (orderNumber <= 0)
            {
                return BadRequest("Order number must be greater than 0");
            }

            if (warehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            var order = await _dmsService.GetOrderAsync(orderNumber, warehouseId);

            if (order == null)
            {
                return NotFound($"Order {orderNumber} not found in warehouse {warehouseId}");
            }

            return Ok(order);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting order {OrderNumber}", orderNumber);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    #endregion

    #region Status Management

    /// <summary>
    /// Changes the status of a single order
    /// </summary>
    /// <param name="orderNumber">Order number</param>
    /// <param name="request">Status change request with new status and warehouse ID</param>
    /// <returns>Status change result</returns>
    /// <response code="200">Status changed successfully</response>
    /// <response code="400">If transition is invalid</response>
    /// <response code="404">If order not found</response>
    /// <response code="500">If an error occurs</response>
    [HttpPost("orders/{orderNumber}/status")]
    [ProducesResponseType(typeof(StatusChangeResult), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<StatusChangeResult>> ChangeStatus(
        [FromRoute] long orderNumber,
        [FromBody] ChangeStatusRequest request)
    {
        try
        {
            if (orderNumber <= 0)
            {
                return BadRequest("Order number must be greater than 0");
            }

            if (request.WarehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            // Override order number from route
            request.OrderNumber = orderNumber;

            var result = await _dmsService.ChangeStatusAsync(
                request.OrderNumber,
                request.NewStatus,
                request.WarehouseId);

            if (!result.Success)
            {
                if (result.Message.Contains("not found", StringComparison.OrdinalIgnoreCase))
                {
                    return NotFound(result);
                }
                return BadRequest(result);
            }

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error changing status for order {OrderNumber}", orderNumber);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    /// <summary>
    /// Batch changes status for all orders with the same AppID
    /// </summary>
    /// <param name="request">Batch status change request with AppID, new status, and warehouse ID</param>
    /// <returns>Status change result with count of updated orders</returns>
    /// <response code="200">Status changed successfully for all orders</response>
    /// <response code="400">If transition is invalid or no orders found</response>
    /// <response code="500">If an error occurs</response>
    [HttpPost("orders/batch/status")]
    [ProducesResponseType(typeof(StatusChangeResult), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<StatusChangeResult>> BatchChangeStatusByAppID(
        [FromBody] BatchStatusByAppIDRequest request)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(request.AppId))
            {
                return BadRequest("AppID cannot be empty");
            }

            if (request.WarehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            var result = await _dmsService.BatchChangeStatusByAppIDAsync(
                request.AppId,
                request.NewStatus,
                request.WarehouseId);

            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error batch changing status for AppID {AppId}", request.AppId);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    /// <summary>
    /// Clears check-in date for an order (reverts to N/A status)
    /// </summary>
    /// <param name="orderNumber">Order number</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>Success status</returns>
    /// <response code="200">Check-in cleared successfully</response>
    /// <response code="404">If order not found</response>
    /// <response code="400">If parameters are invalid</response>
    /// <response code="500">If an error occurs</response>
    [HttpPost("orders/{orderNumber}/checkin/clear")]
    [ProducesResponseType(typeof(bool), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<bool>> ClearCheckIn(
        [FromRoute] long orderNumber,
        [FromQuery] int warehouseId)
    {
        try
        {
            if (orderNumber <= 0)
            {
                return BadRequest("Order number must be greater than 0");
            }

            if (warehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            var success = await _dmsService.ClearCheckInAsync(orderNumber, warehouseId);

            if (!success)
            {
                return NotFound($"Order {orderNumber} not found or could not be updated");
            }

            return Ok(success);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error clearing check-in for order {OrderNumber}", orderNumber);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    #endregion

    #region Delete/Undelete

    /// <summary>
    /// Soft deletes an order by adding 10 to type (e.g., SO type 1 becomes Deleted_SO type 11)
    /// Requires status = N/A and security level <= 2
    /// </summary>
    /// <param name="orderNumber">Order number</param>
    /// <param name="request">Delete request with security level and warehouse ID</param>
    /// <returns>Success status</returns>
    /// <response code="200">Order deleted successfully</response>
    /// <response code="400">If deletion constraints not met</response>
    /// <response code="403">If insufficient security level</response>
    /// <response code="404">If order not found</response>
    /// <response code="500">If an error occurs</response>
    [HttpDelete("orders/{orderNumber}")]
    [ProducesResponseType(typeof(bool), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<bool>> DeleteOrder(
        [FromRoute] long orderNumber,
        [FromQuery] int securityLevel,
        [FromQuery] int warehouseId)
    {
        try
        {
            if (orderNumber <= 0)
            {
                return BadRequest("Order number must be greater than 0");
            }

            if (warehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            if (securityLevel > 2)
            {
                return StatusCode(403, "Insufficient security level. Only Admin/User roles can delete orders.");
            }

            var success = await _dmsService.DeleteOrderAsync(orderNumber, securityLevel, warehouseId);

            if (!success)
            {
                return BadRequest($"Order {orderNumber} cannot be deleted. Check status is N/A and order is not already deleted.");
            }

            return Ok(success);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting order {OrderNumber}", orderNumber);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    /// <summary>
    /// Undeletes an order by subtracting 10 from type (e.g., Deleted_SO type 11 becomes SO type 1)
    /// </summary>
    /// <param name="orderNumber">Order number</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>Success status</returns>
    /// <response code="200">Order undeleted successfully</response>
    /// <response code="400">If order is not deleted</response>
    /// <response code="404">If order not found</response>
    /// <response code="500">If an error occurs</response>
    [HttpPost("orders/{orderNumber}/undelete")]
    [ProducesResponseType(typeof(bool), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<bool>> UndeleteOrder(
        [FromRoute] long orderNumber,
        [FromQuery] int warehouseId)
    {
        try
        {
            if (orderNumber <= 0)
            {
                return BadRequest("Order number must be greater than 0");
            }

            if (warehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            var success = await _dmsService.UndeleteOrderAsync(orderNumber, warehouseId);

            if (!success)
            {
                return BadRequest($"Order {orderNumber} cannot be undeleted. Order may not be deleted.");
            }

            return Ok(success);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error undeleting order {OrderNumber}", orderNumber);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    #endregion

    #region Personnel Management

    /// <summary>
    /// Updates forklift operator for a single order
    /// </summary>
    /// <param name="orderNumber">Order number</param>
    /// <param name="request">Update request with operator username and warehouse ID</param>
    /// <returns>Success status</returns>
    /// <response code="200">Operator updated successfully</response>
    /// <response code="404">If order not found</response>
    /// <response code="400">If parameters are invalid</response>
    /// <response code="500">If an error occurs</response>
    [HttpPut("orders/{orderNumber}/operator")]
    [ProducesResponseType(typeof(bool), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<bool>> UpdateForkliftOperator(
        [FromRoute] long orderNumber,
        [FromBody] UpdateOperatorRequest request)
    {
        try
        {
            if (orderNumber <= 0)
            {
                return BadRequest("Order number must be greater than 0");
            }

            if (string.IsNullOrWhiteSpace(request.OperatorUsername))
            {
                return BadRequest("Operator username cannot be empty");
            }

            if (request.WarehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            // Override order number from route
            request.OrderNumber = orderNumber;

            var success = await _dmsService.UpdateForkliftOperatorAsync(
                request.OrderNumber,
                request.OperatorUsername,
                request.WarehouseId);

            if (!success)
            {
                return NotFound($"Order {orderNumber} not found or could not be updated");
            }

            return Ok(success);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating operator for order {OrderNumber}", orderNumber);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    /// <summary>
    /// Batch updates forklift operator for all orders with the same AppID
    /// </summary>
    /// <param name="request">Batch update request with AppID, operator username, and warehouse ID</param>
    /// <returns>Success status</returns>
    /// <response code="200">Operator updated successfully for all orders</response>
    /// <response code="400">If no orders found or parameters invalid</response>
    /// <response code="500">If an error occurs</response>
    [HttpPut("orders/batch/operator")]
    [ProducesResponseType(typeof(bool), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<bool>> BatchUpdateForkliftByAppID(
        [FromBody] BatchUpdateOperatorRequest request)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(request.AppId))
            {
                return BadRequest("AppID cannot be empty");
            }

            if (string.IsNullOrWhiteSpace(request.OperatorUsername))
            {
                return BadRequest("Operator username cannot be empty");
            }

            if (request.WarehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            var success = await _dmsService.BatchUpdateForkliftByAppIDAsync(
                request.AppId,
                request.OperatorUsername,
                request.WarehouseId);

            if (!success)
            {
                return BadRequest($"No orders found with AppID {request.AppId} or could not be updated");
            }

            return Ok(success);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error batch updating operator for AppID {AppId}", request.AppId);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    /// <summary>
    /// Gets list of available forklift operators for a warehouse
    /// Filters by d2_d1id=687 for CPFG users
    /// </summary>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>List of operators</returns>
    /// <response code="200">Returns the list of operators</response>
    /// <response code="400">If warehouse ID is invalid</response>
    /// <response code="500">If an error occurs</response>
    [HttpGet("operators")]
    [ProducesResponseType(typeof(IEnumerable<OperatorInfo>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<IEnumerable<OperatorInfo>>> GetAvailableOperators(
        [FromQuery] int warehouseId)
    {
        try
        {
            if (warehouseId <= 0)
            {
                return BadRequest("Warehouse ID must be greater than 0");
            }

            var operators = await _dmsService.GetAvailableOperatorsAsync(warehouseId);

            return Ok(operators);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting available operators for warehouse {WarehouseId}", warehouseId);
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    #endregion
}
