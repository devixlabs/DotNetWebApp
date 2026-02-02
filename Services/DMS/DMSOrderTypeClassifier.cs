using DotNetWebApp.Services.DMS.Models;

namespace DotNetWebApp.Services.DMS;

/// <summary>
/// Static helper for DMS order type classification and display
/// Order types are stored in gs_num1 field (not computed)
/// Types 1-4 are active, types 11-14 are deleted (type + 10)
/// </summary>
public static class DMSOrderTypeClassifier
{
    /// <summary>
    /// Maps gs_num1 database value directly to OrderType enum
    /// </summary>
    /// <param name="gsNum1">Value from gai_scheduler.gs_num1 field</param>
    /// <returns>OrderType enum value</returns>
    public static OrderType ClassifyFromDatabase(long? gsNum1)
    {
        if (!gsNum1.HasValue)
            return OrderType.SO; // Default to SO if not set

        return (OrderType)gsNum1.Value;
    }

    /// <summary>
    /// Gets display name and color code for an order type
    /// Used for UI color coding and labels
    /// </summary>
    /// <param name="type">OrderType enum value</param>
    /// <returns>Tuple of (TypeName, ColorCode)</returns>
    public static (string TypeName, string ColorCode) GetTypeDisplay(OrderType type)
    {
        return type switch
        {
            OrderType.SO => ("Sales Order", "SeaShell"),
            OrderType.PO => ("Purchase Order", "LightSkyBlue"),
            OrderType.ICT_NL => ("ICT Northlake", "LightSalmon"),
            OrderType.ICT_CPFG => ("ICT CPFG", "LightSlateGray"),
            OrderType.Deleted_SO => ("Deleted SO", "LightGray"),
            OrderType.Deleted_PO => ("Deleted PO", "LightGray"),
            OrderType.Deleted_ICT_NL => ("Deleted ICT NL", "LightGray"),
            OrderType.Deleted_ICT_CPFG => ("Deleted ICT CPFG", "LightGray"),
            _ => ("Unknown", "White")
        };
    }

    /// <summary>
    /// Checks if an order type is deleted (types 11-14)
    /// </summary>
    /// <param name="type">OrderType enum value</param>
    /// <returns>True if type >= 11, false otherwise</returns>
    public static bool IsDeleted(OrderType type) => (int)type >= 11;

    /// <summary>
    /// Checks if an order is an ICT transfer (Northlake or CPFG)
    /// </summary>
    /// <param name="type">OrderType enum value</param>
    /// <returns>True if ICT_NL or ICT_CPFG, false otherwise</returns>
    public static bool IsICT(OrderType type) =>
        type == OrderType.ICT_NL ||
        type == OrderType.ICT_CPFG ||
        type == OrderType.Deleted_ICT_NL ||
        type == OrderType.Deleted_ICT_CPFG;

    /// <summary>
    /// Gets the active (non-deleted) version of an order type
    /// Used for undelete operations
    /// </summary>
    /// <param name="type">OrderType enum value (possibly deleted)</param>
    /// <returns>Active version of the type (type - 10 if deleted)</returns>
    public static OrderType GetActiveType(OrderType type)
    {
        if (IsDeleted(type))
            return (OrderType)((int)type - 10);
        return type;
    }

    /// <summary>
    /// Gets the deleted version of an order type
    /// Used for delete operations
    /// </summary>
    /// <param name="type">OrderType enum value (active)</param>
    /// <returns>Deleted version of the type (type + 10)</returns>
    public static OrderType GetDeletedType(OrderType type)
    {
        if (!IsDeleted(type))
            return (OrderType)((int)type + 10);
        return type; // Already deleted
    }
}
