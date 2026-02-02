using DotNetWebApp.Services.Allocation.Models;

namespace DotNetWebApp.Services.Allocation;

/// <summary>
/// Color coding service for allocation status display.
/// Business Rule: 4 status colors:
/// - NotAllocated: White
/// - PartiallyAllocated: Gold
/// - FullyAllocated: LightCoral
/// - OverAllocated: Red (error condition)
/// </summary>
public static class AllocationStatusColorService
{
    /// <summary>
    /// Get color name for allocation status.
    /// </summary>
    public static string GetColor(AllocationStatus status)
    {
        return status switch
        {
            AllocationStatus.NotAllocated => "White",
            AllocationStatus.PartiallyAllocated => "Gold",
            AllocationStatus.FullyAllocated => "LightCoral",
            AllocationStatus.OverAllocated => "Red",
            _ => "White"
        };
    }

    /// <summary>
    /// Get CSS class name for allocation status.
    /// </summary>
    public static string GetCssClass(AllocationStatus status)
    {
        return status switch
        {
            AllocationStatus.NotAllocated => "allocation-not-allocated",
            AllocationStatus.PartiallyAllocated => "allocation-partial",
            AllocationStatus.FullyAllocated => "allocation-full",
            AllocationStatus.OverAllocated => "allocation-over",
            _ => "allocation-not-allocated"
        };
    }

    /// <summary>
    /// Get row style string for Radzen DataGrid.
    /// </summary>
    public static string GetRowStyle(AllocationStatus status)
    {
        return $"background-color: {GetColor(status)};";
    }

    /// <summary>
    /// Calculate allocation status from quantities.
    /// </summary>
    public static AllocationStatus GetStatus(decimal orderedQty, decimal allocatedQty)
    {
        if (allocatedQty == 0)
            return AllocationStatus.NotAllocated;

        if (allocatedQty < orderedQty)
            return AllocationStatus.PartiallyAllocated;

        if (allocatedQty == orderedQty)
            return AllocationStatus.FullyAllocated;

        return AllocationStatus.OverAllocated; // Should not happen, indicates error
    }

    /// <summary>
    /// Get status display text.
    /// </summary>
    public static string GetStatusText(AllocationStatus status)
    {
        return status switch
        {
            AllocationStatus.NotAllocated => "Not Allocated",
            AllocationStatus.PartiallyAllocated => "Partially Allocated",
            AllocationStatus.FullyAllocated => "Fully Allocated",
            AllocationStatus.OverAllocated => "Over Allocated",
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
