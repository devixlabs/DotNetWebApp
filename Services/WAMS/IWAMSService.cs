using DotNetWebApp.Services.WAMS.Models;

namespace DotNetWebApp.Services.WAMS;

/// <summary>
/// Service interface for WAMS (Web App Management System) operations
/// Manages order status workflow, AppID grouping, and personnel assignments
/// </summary>
public interface IWAMSService
{
    /// <summary>
    /// Retrieves all orders for a specific warehouse and date
    /// Excludes deleted orders (gs_num1 > 10)
    /// </summary>
    /// <param name="warehouseId">Warehouse ID (3=Chicago, 92=NYC)</param>
    /// <param name="date">Date to filter orders by start date</param>
    /// <param name="statusFilter">Optional status filter (null = all statuses)</param>
    /// <returns>List of WAMS orders</returns>
    Task<IEnumerable<WAMSOrder>> ListOrdersAsync(int warehouseId, DateTime date, string? statusFilter = null);

    /// <summary>
    /// Retrieves a single order by order number and warehouse
    /// </summary>
    /// <param name="orderNumber">Order number (gs_ordnum)</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>Order if found, null otherwise</returns>
    Task<WAMSOrder?> GetOrderAsync(long orderNumber, int warehouseId);

    /// <summary>
    /// Changes status of a single order with validation
    /// Validates transition using StatusTransitionValidator
    /// Sets gs_datechkin = GETDATE() on CheckIn, NULL on revert to NA
    /// </summary>
    /// <param name="orderNumber">Order number to update</param>
    /// <param name="newStatus">New dock status</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>Result with success flag, message, and updated order numbers</returns>
    Task<StatusChangeResult> ChangeStatusAsync(long orderNumber, DockStatus newStatus, int warehouseId);

    /// <summary>
    /// Batch changes status for all orders with the same AppID
    /// All orders with gs_appid = @appId are updated together in single transaction
    /// Validates each transition using StatusTransitionValidator
    /// </summary>
    /// <param name="appId">AppID grouping identifier (gs_appid)</param>
    /// <param name="newStatus">New dock status</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>Result with success flag, message, and count of updated orders</returns>
    Task<StatusChangeResult> BatchChangeStatusByAppIDAsync(string appId, DockStatus newStatus, int warehouseId);

    /// <summary>
    /// Clears check-in date for an order (sets gs_datechkin = NULL)
    /// Equivalent to reverting status from CheckIn to NA
    /// </summary>
    /// <param name="orderNumber">Order number to update</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>True if successful, false otherwise</returns>
    Task<bool> ClearCheckInAsync(long orderNumber, int warehouseId);

    /// <summary>
    /// Soft deletes an order by adding 10 to gs_num1 (type + 10)
    /// Validates: status = NA, security level <= 2, not already deleted
    /// Example: SO (type 1) becomes Deleted_SO (type 11)
    /// </summary>
    /// <param name="orderNumber">Order number to delete</param>
    /// <param name="securityLevel">User's security level (1=Admin, 2=User, 5+=View Only)</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>True if successful, false otherwise</returns>
    Task<bool> DeleteOrderAsync(long orderNumber, int securityLevel, int warehouseId);

    /// <summary>
    /// Undeletes an order by subtracting 10 from gs_num1 (type - 10)
    /// Validates: order must be deleted (gs_num1 >= 11)
    /// Example: Deleted_SO (type 11) becomes SO (type 1)
    /// </summary>
    /// <param name="orderNumber">Order number to undelete</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>True if successful, false otherwise</returns>
    Task<bool> UndeleteOrderAsync(long orderNumber, int warehouseId);

    /// <summary>
    /// Updates forklift operator for a single order
    /// </summary>
    /// <param name="orderNumber">Order number to update</param>
    /// <param name="operatorUsername">Operator username (gs_forkop)</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>True if successful, false otherwise</returns>
    Task<bool> UpdateForkliftOperatorAsync(long orderNumber, string operatorUsername, int warehouseId);

    /// <summary>
    /// Batch updates forklift operator for all orders with the same AppID
    /// All orders with gs_appid = @appId are updated together
    /// </summary>
    /// <param name="appId">AppID grouping identifier</param>
    /// <param name="operatorUsername">Operator username</param>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>True if successful, false otherwise</returns>
    Task<bool> BatchUpdateForkliftByAppIDAsync(string appId, string operatorUsername, int warehouseId);

    /// <summary>
    /// Retrieves list of available forklift operators for a warehouse
    /// Filters by d2_d1id=687 for Chicago users
    /// </summary>
    /// <param name="warehouseId">Warehouse ID</param>
    /// <returns>List of operators with username and full name</returns>
    Task<IEnumerable<OperatorInfo>> GetAvailableOperatorsAsync(int warehouseId);
}
