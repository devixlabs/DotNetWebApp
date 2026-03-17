using DotNetWebApp.Services.WAMS.Models;

namespace DotNetWebApp.Services.WAMS.Validators;

/// <summary>
/// Validates delete and undelete operations for WAMS orders
/// Delete constraints: status = NA, security level <= 2, not already deleted
/// Undelete constraints: order must be deleted (type >= 11)
/// </summary>
public class DeleteValidator
{
    /// <summary>
    /// Validates if an order can be deleted
    /// </summary>
    /// <param name="status">Current dock status</param>
    /// <param name="securityLevel">User's security level (1=Admin, 2=User, 5+=View Only)</param>
    /// <param name="orderType">Current order type</param>
    /// <returns>Tuple of (IsValid, ErrorMessage). ErrorMessage is empty if valid.</returns>
    public (bool IsValid, string ErrorMessage) CanDelete(
        DockStatus status,
        int securityLevel,
        OrderType orderType)
    {
        // Check if already deleted
        if (WAMSOrderTypeClassifier.IsDeleted(orderType))
            return (false, "Order is already deleted");

        // Check security level: only admin (1) and user (2) can delete
        if (securityLevel > 2)
            return (false, "Only admin/users can delete orders (security level <= 2)");

        // Check status: can only delete orders with status = N/A
        if (status != DockStatus.NA)
            return (false, "Can only delete orders with status 'N/A'. Order must not have started workflow.");

        return (true, "");
    }

    /// <summary>
    /// Validates if an order can be undeleted
    /// </summary>
    /// <param name="orderType">Current order type</param>
    /// <returns>Tuple of (IsValid, ErrorMessage). ErrorMessage is empty if valid.</returns>
    public (bool IsValid, string ErrorMessage) CanUndelete(OrderType orderType)
    {
        // Check if order is actually deleted
        if (!WAMSOrderTypeClassifier.IsDeleted(orderType))
            return (false, "Order is not deleted");

        return (true, "");
    }

    /// <summary>
    /// Validates if an order can be undeleted based on security level
    /// </summary>
    /// <param name="orderType">Current order type</param>
    /// <param name="securityLevel">User's security level (1=Admin, 2=User, 5+=View Only)</param>
    /// <returns>Tuple of (IsValid, ErrorMessage). ErrorMessage is empty if valid.</returns>
    public (bool IsValid, string ErrorMessage) CanUndelete(OrderType orderType, int securityLevel)
    {
        // Check if order is actually deleted
        var (isDeleted, deleteError) = CanUndelete(orderType);
        if (!isDeleted)
            return (false, deleteError);

        // Check security level: only admin (1) and user (2) can undelete
        if (securityLevel > 2)
            return (false, "Only admin/users can undelete orders (security level <= 2)");

        return (true, "");
    }

    /// <summary>
    /// Gets a user-friendly message explaining why an order cannot be deleted
    /// </summary>
    /// <param name="status">Current dock status</param>
    /// <param name="securityLevel">User's security level</param>
    /// <param name="orderType">Current order type</param>
    /// <returns>Detailed error message</returns>
    public string GetDeleteReasonMessage(
        DockStatus status,
        int securityLevel,
        OrderType orderType)
    {
        if (WAMSOrderTypeClassifier.IsDeleted(orderType))
            return "This order has already been deleted.";

        if (securityLevel > 2)
            return $"Your security level ({securityLevel}) does not allow deleting orders. Only Admin and User roles can delete.";

        if (status != DockStatus.NA)
            return $"Orders can only be deleted when status is 'N/A'. This order has status '{status}' and has started the workflow.";

        return "Unknown reason - order cannot be deleted.";
    }

    /// <summary>
    /// Gets a user-friendly message explaining why an order cannot be undeleted
    /// </summary>
    /// <param name="orderType">Current order type</param>
    /// <param name="securityLevel">User's security level</param>
    /// <returns>Detailed error message</returns>
    public string GetUndeleteReasonMessage(OrderType orderType, int securityLevel)
    {
        if (!WAMSOrderTypeClassifier.IsDeleted(orderType))
            return "This order is not deleted and does not need to be undeleted.";

        if (securityLevel > 2)
            return $"Your security level ({securityLevel}) does not allow undeleting orders. Only Admin and User roles can undelete.";

        return "Unknown reason - order cannot be undeleted.";
    }
}
