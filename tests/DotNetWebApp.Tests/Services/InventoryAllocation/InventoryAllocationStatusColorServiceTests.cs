using DotNetWebApp.Services.InventoryAllocation;
using DotNetWebApp.Services.InventoryAllocation.Models;
using Xunit;

namespace DotNetWebApp.Tests.Services.InventoryAllocation;

/// <summary>
/// Tests for InventoryAllocationStatusColorService.
/// Business Rule: 4 status colors:
/// - NotAllocated: White
/// - PartiallyAllocated: Gold
/// - FullyAllocated: LightCoral
/// - OverAllocated: Red
/// </summary>
public class InventoryAllocationStatusColorServiceTests
{
    [Theory]
    [InlineData(InventoryAllocationStatus.NotAllocated, "White")]
    [InlineData(InventoryAllocationStatus.PartiallyAllocated, "Gold")]
    [InlineData(InventoryAllocationStatus.FullyAllocated, "LightCoral")]
    [InlineData(InventoryAllocationStatus.OverAllocated, "Red")]
    public void GetColor_ReturnsCorrectColor(InventoryAllocationStatus status, string expectedColor)
    {
        Assert.Equal(expectedColor, InventoryAllocationStatusColorService.GetColor(status));
    }

    [Theory]
    [InlineData(InventoryAllocationStatus.NotAllocated, "allocation-not-allocated")]
    [InlineData(InventoryAllocationStatus.PartiallyAllocated, "allocation-partial")]
    [InlineData(InventoryAllocationStatus.FullyAllocated, "allocation-full")]
    [InlineData(InventoryAllocationStatus.OverAllocated, "allocation-over")]
    public void GetCssClass_ReturnsCorrectClass(InventoryAllocationStatus status, string expectedClass)
    {
        Assert.Equal(expectedClass, InventoryAllocationStatusColorService.GetCssClass(status));
    }

    [Theory]
    [InlineData(InventoryAllocationStatus.NotAllocated, "background-color: White;")]
    [InlineData(InventoryAllocationStatus.PartiallyAllocated, "background-color: Gold;")]
    [InlineData(InventoryAllocationStatus.FullyAllocated, "background-color: LightCoral;")]
    [InlineData(InventoryAllocationStatus.OverAllocated, "background-color: Red;")]
    public void GetRowStyle_ReturnsCorrectStyle(InventoryAllocationStatus status, string expectedStyle)
    {
        Assert.Equal(expectedStyle, InventoryAllocationStatusColorService.GetRowStyle(status));
    }

    [Theory]
    [InlineData(100, 0, InventoryAllocationStatus.NotAllocated)]
    [InlineData(100, 50, InventoryAllocationStatus.PartiallyAllocated)]
    [InlineData(100, 99, InventoryAllocationStatus.PartiallyAllocated)]
    [InlineData(100, 100, InventoryAllocationStatus.FullyAllocated)]
    [InlineData(100, 101, InventoryAllocationStatus.OverAllocated)]
    [InlineData(100, 150, InventoryAllocationStatus.OverAllocated)]
    [InlineData(0, 0, InventoryAllocationStatus.NotAllocated)]
    public void GetStatus_CalculatesCorrectly(decimal ordered, decimal allocated, InventoryAllocationStatus expected)
    {
        Assert.Equal(expected, InventoryAllocationStatusColorService.GetStatus(ordered, allocated));
    }

    [Theory]
    [InlineData(InventoryAllocationStatus.NotAllocated, "Not Allocated")]
    [InlineData(InventoryAllocationStatus.PartiallyAllocated, "Partially Allocated")]
    [InlineData(InventoryAllocationStatus.FullyAllocated, "Fully Allocated")]
    [InlineData(InventoryAllocationStatus.OverAllocated, "Over Allocated")]
    public void GetStatusText_ReturnsCorrectText(InventoryAllocationStatus status, string expectedText)
    {
        Assert.Equal(expectedText, InventoryAllocationStatusColorService.GetStatusText(status));
    }

    [Fact]
    public void GetLockedRowStyle_NotLocked_ReturnsEmpty()
    {
        Assert.Empty(InventoryAllocationStatusColorService.GetLockedRowStyle(false, "", "user1"));
        Assert.Empty(InventoryAllocationStatusColorService.GetLockedRowStyle(false, "user2", "user1"));
    }

    [Fact]
    public void GetLockedRowStyle_LockedByCurrentUser_ReturnsLightBlue()
    {
        var style = InventoryAllocationStatusColorService.GetLockedRowStyle(true, "user1", "user1");
        Assert.Contains("LightBlue", style);
    }

    [Fact]
    public void GetLockedRowStyle_LockedByOther_ReturnsGray()
    {
        var style = InventoryAllocationStatusColorService.GetLockedRowStyle(true, "user2", "user1");
        Assert.Contains("LightGray", style);
        Assert.Contains("opacity", style);
    }

    [Fact]
    public void GetLockedRowStyle_CaseInsensitive()
    {
        // Should match case-insensitively
        var style = InventoryAllocationStatusColorService.GetLockedRowStyle(true, "User1", "user1");
        Assert.Contains("LightBlue", style);

        var style2 = InventoryAllocationStatusColorService.GetLockedRowStyle(true, "USER1", "user1");
        Assert.Contains("LightBlue", style2);
    }

    [Fact]
    public void GetColor_UnknownStatus_ReturnsWhite()
    {
        // Test default case
        Assert.Equal("White", InventoryAllocationStatusColorService.GetColor((InventoryAllocationStatus)999));
    }

    [Fact]
    public void GetStatusText_UnknownStatus_ReturnsUnknown()
    {
        Assert.Equal("Unknown", InventoryAllocationStatusColorService.GetStatusText((InventoryAllocationStatus)999));
    }

    // Edge cases
    [Fact]
    public void GetStatus_DecimalPrecision()
    {
        // Test decimal precision
        Assert.Equal(InventoryAllocationStatus.FullyAllocated, InventoryAllocationStatusColorService.GetStatus(100.00m, 100.00m));
        Assert.Equal(InventoryAllocationStatus.PartiallyAllocated, InventoryAllocationStatusColorService.GetStatus(100.00m, 99.99m));
        Assert.Equal(InventoryAllocationStatus.OverAllocated, InventoryAllocationStatusColorService.GetStatus(100.00m, 100.01m));
    }
}
