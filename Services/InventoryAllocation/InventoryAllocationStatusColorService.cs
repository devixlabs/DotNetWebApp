using DotNetWebApp.Services.InventoryAllocation.Models;

namespace DotNetWebApp.Services.InventoryAllocation;

/// <summary>
/// Color coding service for inventory allocation status display.
/// Business Rule: 4 status colors:
/// - NotAllocated: White
/// - PartiallyAllocated: Gold
/// - FullyAllocated: LightCoral
/// - OverAllocated: Red (error condition)
/// </summary>
public static class InventoryAllocationStatusColorService
{
    /// <summary>
    /// Get color name for allocation status.
    /// </summary>
    public static string GetColor(InventoryAllocationStatus status)
    {
        return status switch
        {
            InventoryAllocationStatus.NotAllocated => "White",
            InventoryAllocationStatus.PartiallyAllocated => "Gold",
            InventoryAllocationStatus.FullyAllocated => "LightCoral",
            InventoryAllocationStatus.OverAllocated => "Red",
            _ => "White"
        };
    }

    /// <summary>
    /// Get CSS class name for allocation status.
    /// </summary>
    public static string GetCssClass(InventoryAllocationStatus status)
    {
        return status switch
        {
            InventoryAllocationStatus.NotAllocated => "allocation-not-allocated",
            InventoryAllocationStatus.PartiallyAllocated => "allocation-partial",
            InventoryAllocationStatus.FullyAllocated => "allocation-full",
            InventoryAllocationStatus.OverAllocated => "allocation-over",
            _ => "allocation-not-allocated"
        };
    }

    /// <summary>
    /// Get row style string for Radzen DataGrid.
    /// </summary>
    public static string GetRowStyle(InventoryAllocationStatus status)
    {
        return $"background-color: {GetColor(status)};";
    }

    /// <summary>
    /// Calculate allocation status from quantities.
    /// </summary>
    public static InventoryAllocationStatus GetStatus(decimal orderedQty, decimal allocatedQty)
    {
        if (allocatedQty == 0)
            return InventoryAllocationStatus.NotAllocated;

        if (allocatedQty < orderedQty)
            return InventoryAllocationStatus.PartiallyAllocated;

        if (allocatedQty == orderedQty)
            return InventoryAllocationStatus.FullyAllocated;

        return InventoryAllocationStatus.OverAllocated; // Should not happen, indicates error
    }

    /// <summary>
    /// Get status display text.
    /// </summary>
    public static string GetStatusText(InventoryAllocationStatus status)
    {
        return status switch
        {
            InventoryAllocationStatus.NotAllocated => "Not Allocated",
            InventoryAllocationStatus.PartiallyAllocated => "Partially Allocated",
            InventoryAllocationStatus.FullyAllocated => "Fully Allocated",
            InventoryAllocationStatus.OverAllocated => "Over Allocated",
            _ => "Unknown"
        };
    }

    /// <summary>
    /// Get locked row style.
    /// </summary>
    public static string GetLockedRowStyle(bool isLocked, string lockedBy, string currentUser)
    {
        if (!isLocked || string.IsNullOrEmpty(lockedBy))
            return string.Empty;

        // Gray out if locked by someone else
        if (!string.Equals(lockedBy, currentUser, StringComparison.OrdinalIgnoreCase))
            return "background-color: LightGray; opacity: 0.8;";

        // Highlight if locked by current user
        return "background-color: LightBlue;";
    }
}
