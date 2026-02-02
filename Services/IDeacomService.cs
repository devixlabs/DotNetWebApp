using DotNetWebApp.Services.Models;

namespace DotNetWebApp.Services;

/// <summary>
/// Service for querying Deacom ERP system for order enrichment.
/// Provides lookups for sales orders, purchase orders, pro numbers, and customer POs.
/// </summary>
public interface IDeacomService
{
    /// <summary>
    /// Get sales order details by order number.
    /// </summary>
    /// <param name="orderNumber">11-digit order number ending in '00'</param>
    /// <returns>Sales order details or null if not found</returns>
    Task<SalesOrderDto?> GetSalesOrderAsync(string orderNumber);

    /// <summary>
    /// Get purchase order details by PO number.
    /// </summary>
    /// <param name="purNumber">Purchase order number</param>
    /// <returns>Purchase order details or null if not found</returns>
    Task<PurchaseOrderDto?> GetPurchaseOrderAsync(string purNumber);

    /// <summary>
    /// Find sales order by pro number.
    /// </summary>
    /// <param name="proNumber">Pro number (e.g., "208386")</param>
    /// <returns>Associated sales order number or null if not found</returns>
    Task<string?> FindOrderByProNumberAsync(string proNumber);

    /// <summary>
    /// Find sales orders by customer PO number.
    /// </summary>
    /// <param name="customerPO">Customer's PO number</param>
    /// <returns>List of matching order numbers (may be multiple)</returns>
    Task<List<string>> FindOrdersByCustomerPOAsync(string customerPO);

    /// <summary>
    /// Get user warehouse assignment from gai_dmstech.
    /// </summary>
    /// <param name="userName">Windows username</param>
    /// <returns>User warehouse info or null if not found</returns>
    Task<UserWarehouseDto?> GetUserWarehouseAsync(string userName);
}
