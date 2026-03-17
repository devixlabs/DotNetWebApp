using DotNetWebApp.Services.InventoryPicking.Models;

namespace DotNetWebApp.Services.InventoryPicking;

/// <summary>
/// Service for determining row and cell colors based on order status.
/// Colors from spec:
/// - Status1 (gs_num1=1): LightYellow
/// - Status2 (gs_num1=2): Tan
/// - Status3 (gs_num1=3): LightSalmon
/// - Status4 (gs_num1=4): DarkGray
/// - In Progress: Yellow
/// - Completed: LightGreen
/// - Check-in: Orange
/// - Printed (gs_num2=10 or 11): LemonChiffon
/// - No Dock Booking: Aquamarine
/// - Has Dock Booking: Thistle
/// </summary>
public class ColorCodingService
{
    /// <summary>
    /// Get the status color based on status code (gs_num1).
    /// </summary>
    public static string GetStatusColor(int statusCode)
    {
        return statusCode switch
        {
            1 => "LightYellow",
            2 => "Tan",
            3 => "LightSalmon",
            4 => "DarkGray",
            _ => "White"
        };
    }

    /// <summary>
    /// Get dock booking color.
    /// </summary>
    public static string GetDockColor(int crossDock)
    {
        return crossDock == 0 ? "Aquamarine" : "Thistle";
    }

    /// <summary>
    /// Get operation status color (picker/auditor/assembler).
    /// </summary>
    public static string GetOperationColor(string? operatorName, DateTime? clockIn, DateTime? clockOut)
    {
        if (!string.IsNullOrEmpty(operatorName))
        {
            if (clockIn.HasValue && !clockOut.HasValue)
                return "Yellow";  // In progress
            if (clockIn.HasValue && clockOut.HasValue)
                return "LightGreen";  // Completed
        }
        return "White";
    }

    /// <summary>
    /// Get row style for an InventoryPicking order.
    /// </summary>
    public string GetRowStyle(InventoryPickingOrder order)
    {
        return $"background-color: {GetStatusColor(order.StatusCode)};";
    }

    /// <summary>
    /// Get cell style for picker column.
    /// </summary>
    public string GetPickerCellStyle(InventoryPickingOrder order)
    {
        string color = GetOperationColor(order.PickerUsername, order.PickerClockIn, order.PickerClockOut);
        return $"background-color: {color};";
    }

    /// <summary>
    /// Get cell style for auditor column.
    /// </summary>
    public string GetAuditorCellStyle(InventoryPickingOrder order)
    {
        // Check if printed (gs_num2=10 or 11)
        if (order.PrintStatus == 10 || order.PrintStatus == 11)
            return "background-color: LemonChiffon;";

        string color = GetOperationColor(order.AuditorUsername, order.AuditorClockIn, order.AuditorClockOut);
        return $"background-color: {color};";
    }

    /// <summary>
    /// Get cell style for assembler column.
    /// </summary>
    public string GetAssemblerCellStyle(InventoryPickingOrder order)
    {
        string color = GetOperationColor(order.AssemblerUsername, order.AssemblerClockIn, order.AssemblerClockOut);
        return $"background-color: {color};";
    }

    /// <summary>
    /// Get CSS class for row based on order status.
    /// </summary>
    public static string GetRowCssClass(InventoryPickingOrder order)
    {
        return order.StatusCode switch
        {
            1 => "prepick-status-1",
            2 => "prepick-status-2",
            3 => "prepick-status-3",
            4 => "prepick-status-4",
            _ => ""
        };
    }

    /// <summary>
    /// Get CSS class for operation cell based on progress.
    /// </summary>
    public static string GetOperationCssClass(string? operatorName, DateTime? clockIn, DateTime? clockOut)
    {
        if (!string.IsNullOrEmpty(operatorName))
        {
            if (clockIn.HasValue && !clockOut.HasValue)
                return "prepick-in-progress";  // Yellow
            if (clockIn.HasValue && clockOut.HasValue)
                return "prepick-completed";  // LightGreen
        }
        return "";
    }
}
