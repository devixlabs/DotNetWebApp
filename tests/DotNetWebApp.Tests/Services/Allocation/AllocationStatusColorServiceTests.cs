using DotNetWebApp.Services.Allocation;
using DotNetWebApp.Services.Allocation.Models;
using Xunit;

namespace DotNetWebApp.Tests.Services.Allocation;

/// <summary>
/// Tests for AllocationStatusColorService.
/// Business Rule: 4 status colors:
/// - NotAllocated: White
/// - PartiallyAllocated: Gold
/// - FullyAllocated: LightCoral
/// - OverAllocated: Red
/// </summary>
public class AllocationStatusColorServiceTests
{
    [Theory]
    [InlineData(AllocationStatus.NotAllocated, "White")]
    [InlineData(AllocationStatus.PartiallyAllocated, "Gold")]
    [InlineData(AllocationStatus.FullyAllocated, "LightCoral")]
    [InlineData(AllocationStatus.OverAllocated, "Red")]
    public void GetColor_ReturnsCorrectColor(AllocationStatus status, string expectedColor)
    {
        Assert.Equal(expectedColor, AllocationStatusColorService.GetColor(status));
    }

    [Theory]
    [InlineData(AllocationStatus.NotAllocated, "allocation-not-allocated")]
    [InlineData(AllocationStatus.PartiallyAllocated, "allocation-partial")]
    [InlineData(AllocationStatus.FullyAllocated, "allocation-full")]
    [InlineData(AllocationStatus.OverAllocated, "allocation-over")]
    public void GetCssClass_ReturnsCorrectClass(AllocationStatus status, string expectedClass)
    {
        Assert.Equal(expectedClass, AllocationStatusColorService.GetCssClass(status));
    }

    [Theory]
    [InlineData(AllocationStatus.NotAllocated, "background-color: White;")]
    [InlineData(AllocationStatus.PartiallyAllocated, "background-color: Gold;")]
    [InlineData(AllocationStatus.FullyAllocated, "background-color: LightCoral;")]
    [InlineData(AllocationStatus.OverAllocated, "background-color: Red;")]
    public void GetRowStyle_ReturnsCorrectStyle(AllocationStatus status, string expectedStyle)
    {
        Assert.Equal(expectedStyle, AllocationStatusColorService.GetRowStyle(status));
    }

    [Theory]
    [InlineData(100, 0, AllocationStatus.NotAllocated)]
    [InlineData(100, 50, AllocationStatus.PartiallyAllocated)]
    [InlineData(100, 99, AllocationStatus.PartiallyAllocated)]
    [InlineData(100, 100, AllocationStatus.FullyAllocated)]
    [InlineData(100, 101, AllocationStatus.OverAllocated)]
    [InlineData(100, 150, AllocationStatus.OverAllocated)]
    [InlineData(0, 0, AllocationStatus.NotAllocated)]
    public void GetStatus_CalculatesCorrectly(decimal ordered, decimal allocated, AllocationStatus expected)
    {
        Assert.Equal(expected, AllocationStatusColorService.GetStatus(ordered, allocated));
    }

    [Theory]
    [InlineData(AllocationStatus.NotAllocated, "Not Allocated")]
    [InlineData(AllocationStatus.PartiallyAllocated, "Partially Allocated")]
    [InlineData(AllocationStatus.FullyAllocated, "Fully Allocated")]
    [InlineData(AllocationStatus.OverAllocated, "Over Allocated")]
    public void GetStatusText_ReturnsCorrectText(AllocationStatus status, string expectedText)
    {
        Assert.Equal(expectedText, AllocationStatusColorService.GetStatusText(status));
    }

    [Fact]
    public void GetLockedRowStyle_NotLocked_ReturnsEmpty()
    {
        Assert.Empty(AllocationStatusColorService.GetLockedRowStyle(false, "", "user1"));
        Assert.Empty(AllocationStatusColorService.GetLockedRowStyle(false, "user2", "user1"));
    }

    [Fact]
    public void GetLockedRowStyle_LockedByCurrentUser_ReturnsLightBlue()
    {
        var style = AllocationStatusColorService.GetLockedRowStyle(true, "user1", "user1");
        Assert.Contains("LightBlue", style);
    }

    [Fact]
    public void GetLockedRowStyle_LockedByOther_ReturnsGray()
    {
        var style = AllocationStatusColorService.GetLockedRowStyle(true, "user2", "user1");
        Assert.Contains("LightGray", style);
        Assert.Contains("opacity", style);
    }

    [Fact]
    public void GetLockedRowStyle_CaseInsensitive()
    {
        // Should match case-insensitively
        var style = AllocationStatusColorService.GetLockedRowStyle(true, "User1", "user1");
        Assert.Contains("LightBlue", style);

        var style2 = AllocationStatusColorService.GetLockedRowStyle(true, "USER1", "user1");
        Assert.Contains("LightBlue", style2);
    }

    [Fact]
    public void GetColor_UnknownStatus_ReturnsWhite()
    {
        // Test default case
        Assert.Equal("White", AllocationStatusColorService.GetColor((AllocationStatus)999));
    }

    [Fact]
    public void GetStatusText_UnknownStatus_ReturnsUnknown()
    {
        Assert.Equal("Unknown", AllocationStatusColorService.GetStatusText((AllocationStatus)999));
    }

    // Edge cases
    [Fact]
    public void GetStatus_DecimalPrecision()
    {
        // Test decimal precision
        Assert.Equal(AllocationStatus.FullyAllocated, AllocationStatusColorService.GetStatus(100.00m, 100.00m));
        Assert.Equal(AllocationStatus.PartiallyAllocated, AllocationStatusColorService.GetStatus(100.00m, 99.99m));
        Assert.Equal(AllocationStatus.OverAllocated, AllocationStatusColorService.GetStatus(100.00m, 100.01m));
    }
}
