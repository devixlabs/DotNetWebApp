using DotNetWebApp.Services.ICT.Models;

namespace DotNetWebApp.Services.ICT;

/// <summary>
/// Service for managing ICT (Inter-Company Transfer) operations.
/// </summary>
public interface IICTService
{
    /// <summary>
    /// Create new ICT order with header in gai_scheduler.
    /// </summary>
    /// <param name="request">Order creation request</param>
    /// <returns>Created ICT order</returns>
    Task<ICTOrder> CreateOrderAsync(CreateICTOrderRequest request);

    /// <summary>
    /// Add line item to ICT order (gai_allocate).
    /// Calculates pallets, weights, and validates quantity.
    /// </summary>
    /// <param name="request">Line item addition request</param>
    /// <returns>Line item ID (all_index)</returns>
    Task<int> AddLineItemAsync(AddLineItemRequest request);

    /// <summary>
    /// Remove line item from order.
    /// PRESERVED BUG: Product count not decremented correctly.
    /// </summary>
    /// <param name="lineItemId">Line item ID (all_index)</param>
    /// <returns>True if deleted successfully</returns>
    Task<bool> RemoveLineItemAsync(int lineItemId);

    /// <summary>
    /// Get complete ICT order with all line items.
    /// </summary>
    /// <param name="orderNumber">ICT order number</param>
    /// <returns>Complete order, or null if not found</returns>
    Task<ICTOrder?> GetOrderAsync(string orderNumber);

    /// <summary>
    /// List all ICT orders for a warehouse.
    /// </summary>
    /// <param name="warehouseId">Warehouse ID (3=CPFG, 92=Northlake)</param>
    /// <param name="currentDate">Filter by order date (optional)</param>
    /// <returns>List of order summaries</returns>
    Task<IEnumerable<ICTOrderSummary>> ListOrdersAsync(int warehouseId, DateTime? currentDate = null);

    /// <summary>
    /// Submit order for fulfillment (finalizes quantities, calculates totals).
    /// </summary>
    /// <param name="orderNumber">ICT order number</param>
    /// <returns>Submission result</returns>
    Task<SubmitOrderResult> SubmitOrderAsync(string orderNumber);

    /// <summary>
    /// Delete ICT order and all line items.
    /// CRITICAL: Must delete from BOTH gai_scheduler and gai_allocate.
    /// </summary>
    /// <param name="orderNumber">ICT order number</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>Delete result</returns>
    Task<DeleteOrderResult> DeleteOrderAsync(string orderNumber, int warehouseId);

    /// <summary>
    /// Get available products for ICT transfer at a warehouse.
    /// </summary>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>List of available products with inventory</returns>
    Task<IEnumerable<ICTProduct>> GetAvailableProductsAsync(int warehouseId);

    /// <summary>
    /// Get open manufacturing jobs for ICT planning.
    /// Calculates ship dates (+8 business days from finish date).
    /// </summary>
    /// <param name="currentDate">Filter jobs from this date forward</param>
    /// <returns>List of manufacturing jobs</returns>
    Task<IEnumerable<ManufacturingJob>> GetManufacturingJobsAsync(DateTime currentDate);

    /// <summary>
    /// Validate requested quantity against warehouse availability.
    /// </summary>
    /// <param name="productCode">Product code</param>
    /// <param name="requestedQuantity">Requested quantity</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>Validation result</returns>
    Task<QuantityValidationResult> ValidateQuantityAsync(
        string productCode,
        decimal requestedQuantity,
        int warehouseId);
}
