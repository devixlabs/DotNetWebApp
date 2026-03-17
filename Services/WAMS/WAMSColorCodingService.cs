using DotNetWebApp.Services.WAMS.Models;

namespace DotNetWebApp.Services.WAMS;

/// <summary>
/// Provides color coding for WAMS orders based on type and status
/// Used by Blazor UI for visual differentiation
/// </summary>
public class WAMSColorCodingService
{
    /// <summary>
    /// Gets background color for order type (used in Order Number column)
    /// </summary>
    /// <param name="type">Order type enum</param>
    /// <returns>CSS color name</returns>
    public static string GetOrderTypeColor(OrderType type)
    {
        var (_, color) = WAMSOrderTypeClassifier.GetTypeDisplay(type);
        return color;
    }

    /// <summary>
    /// Gets background color for dock status (used for entire row)
    /// Status colors override type colors for the full row
    /// </summary>
    /// <param name="status">Dock status enum</param>
    /// <returns>CSS color name</returns>
    public static string GetStatusColor(DockStatus status)
    {
        return status switch
        {
            DockStatus.CheckIn => "Orange",
            DockStatus.Loading => "Yellow",
            DockStatus.Unloading => "LemonChiffon",
            DockStatus.Shipped => "PaleGreen",
            DockStatus.Received => "MediumAquamarine",
            DockStatus.NA => "White",
            _ => "White"
        };
    }

    /// <summary>
    /// Gets complete row style including background color based on status
    /// Used in RadzenDataGrid RowRender callback
    /// </summary>
    /// <param name="order">WAMS order</param>
    /// <returns>CSS style string for the row</returns>
    public static string GetRowStyle(WAMSOrder order)
    {
        // Status color takes precedence for entire row
        string color = GetStatusColor(order.StatusEnum);
        return $"background-color: {color};";
    }

    /// <summary>
    /// Gets cell-specific style for Order Number column
    /// Shows order type color with bold text
    /// </summary>
    /// <param name="type">Order type enum</param>
    /// <returns>CSS style string for the cell</returns>
    public static string GetOrderNumberCellStyle(OrderType type)
    {
        string color = GetOrderTypeColor(type);
        return $"background-color: {color}; font-weight: bold;";
    }

    /// <summary>
    /// Gets cell-specific style for Dock column
    /// Shows orange background if order is checked in
    /// </summary>
    /// <param name="checkInDate">Check-in date (nullable)</param>
    /// <returns>CSS style string for the cell, or empty string if not checked in</returns>
    public static string GetDockCellStyle(DateTime? checkInDate)
    {
        return checkInDate.HasValue
            ? "background-color: Orange;"
            : "";
    }

    /// <summary>
    /// Gets badge color class for status badges
    /// Used in Radzen Badge components
    /// </summary>
    /// <param name="status">Dock status enum</param>
    /// <returns>Radzen BadgeStyle enum value as string</returns>
    public static string GetStatusBadgeStyle(DockStatus status)
    {
        return status switch
        {
            DockStatus.NA => "Light",
            DockStatus.CheckIn => "Warning",
            DockStatus.Loading => "Info",
            DockStatus.Unloading => "Secondary",
            DockStatus.Shipped => "Success",
            DockStatus.Received => "Primary",
            _ => "Light"
        };
    }

    /// <summary>
    /// Gets badge color class for order type badges
    /// </summary>
    /// <param name="type">Order type enum</param>
    /// <returns>Radzen BadgeStyle enum value as string</returns>
    public static string GetOrderTypeBadgeStyle(OrderType type)
    {
        return type switch
        {
            OrderType.SO => "Info",
            OrderType.PO => "Primary",
            OrderType.ICT_NYC or OrderType.ICT_Chicago => "Warning",
            OrderType.Deleted_SO or OrderType.Deleted_PO or
            OrderType.Deleted_ICT_NYC or OrderType.Deleted_ICT_Chicago => "Light",
            _ => "Light"
        };
    }

    /// <summary>
    /// Gets a user-friendly display name for status
    /// Converts enum to readable string (e.g., "CheckIn" -> "Check In")
    /// </summary>
    /// <param name="status">Dock status enum</param>
    /// <returns>Display string</returns>
    public static string GetStatusDisplayName(DockStatus status)
    {
        return status switch
        {
            DockStatus.NA => "N/A",
            DockStatus.CheckIn => "Check In",
            DockStatus.Loading => "Loading",
            DockStatus.Unloading => "Unloading",
            DockStatus.Shipped => "Shipped",
            DockStatus.Received => "Received",
            _ => "Unknown"
        };
    }

    /// <summary>
    /// Parses status string from database to DockStatus enum
    /// Handles various formats: "N/A", "Check In", "CheckIn", etc.
    /// </summary>
    /// <param name="statusString">Status string from database</param>
    /// <returns>DockStatus enum value</returns>
    public static DockStatus ParseStatus(string? statusString)
    {
        if (string.IsNullOrWhiteSpace(statusString))
            return DockStatus.NA;

        // Normalize: remove spaces, convert to lowercase
        var normalized = statusString.Replace(" ", "").Replace("/", "").ToLower();

        return normalized switch
        {
            "na" => DockStatus.NA,
            "checkin" => DockStatus.CheckIn,
            "loading" => DockStatus.Loading,
            "unloading" => DockStatus.Unloading,
            "shipped" => DockStatus.Shipped,
            "received" => DockStatus.Received,
            _ => DockStatus.NA // Default to NA for unrecognized values
        };
    }

    /// <summary>
    /// Converts DockStatus enum to database string format
    /// </summary>
    /// <param name="status">Dock status enum</param>
    /// <returns>String for database storage</returns>
    public static string ToStatusString(DockStatus status)
    {
        return status switch
        {
            DockStatus.NA => "N/A",
            DockStatus.CheckIn => "Check In",
            DockStatus.Loading => "Loading",
            DockStatus.Unloading => "Unloading",
            DockStatus.Shipped => "Shipped",
            DockStatus.Received => "Received",
            _ => "N/A"
        };
    }
}
