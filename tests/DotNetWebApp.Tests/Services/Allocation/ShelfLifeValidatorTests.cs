using DotNetWebApp.Services.Allocation.Models;
using DotNetWebApp.Services.Allocation.Validators;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests.Services.Allocation;

/// <summary>
/// Tests for ShelfLifeValidator.
/// Business Rule: Minimum 30 days shelf life required (or customer-specific).
/// </summary>
public class ShelfLifeValidatorTests
{
    private readonly ShelfLifeValidator _validator;
    private readonly DateTime _testDate = new DateTime(2026, 2, 1);

    public ShelfLifeValidatorTests()
    {
        var logger = new Mock<ILogger<ShelfLifeValidator>>();
        _validator = new ShelfLifeValidator(logger.Object);
    }

    [Fact]
    public void MeetsShelfLifeRequirements_NoExpirationDate_ReturnsTrue()
    {
        var lot = new InventoryLot { ExpirationDate = null };
        Assert.True(_validator.MeetsShelfLifeRequirements(lot, _testDate));
    }

    [Fact]
    public void MeetsShelfLifeRequirements_Exactly30Days_ReturnsTrue()
    {
        var lot = new InventoryLot { ExpirationDate = _testDate.AddDays(30) };
        Assert.True(_validator.MeetsShelfLifeRequirements(lot, _testDate));
    }

    [Fact]
    public void MeetsShelfLifeRequirements_MoreThan30Days_ReturnsTrue()
    {
        var lot = new InventoryLot { ExpirationDate = _testDate.AddDays(60) };
        Assert.True(_validator.MeetsShelfLifeRequirements(lot, _testDate));
    }

    [Fact]
    public void MeetsShelfLifeRequirements_LessThan30Days_ReturnsFalse()
    {
        var lot = new InventoryLot { ExpirationDate = _testDate.AddDays(29) };
        Assert.False(_validator.MeetsShelfLifeRequirements(lot, _testDate));
    }

    [Fact]
    public void MeetsShelfLifeRequirements_ExpiredLot_ReturnsFalse()
    {
        var lot = new InventoryLot { ExpirationDate = _testDate.AddDays(-1) };
        Assert.False(_validator.MeetsShelfLifeRequirements(lot, _testDate));
    }

    [Fact]
    public void MeetsShelfLifeRequirements_CustomerMinDays_RespectsCustomValue()
    {
        // Customer requires 60 days
        var lot = new InventoryLot { ExpirationDate = _testDate.AddDays(45) };

        // Fails with 60-day requirement
        Assert.False(_validator.MeetsShelfLifeRequirements(lot, _testDate, customerMinDays: 60));

        // Passes with default 30-day requirement
        Assert.True(_validator.MeetsShelfLifeRequirements(lot, _testDate, customerMinDays: null));
    }

    [Theory]
    [InlineData(30, true)]  // Exactly 30 days
    [InlineData(31, true)]  // 31 days
    [InlineData(29, false)] // 29 days
    [InlineData(0, false)]  // Expires today
    [InlineData(-1, false)] // Already expired
    [InlineData(100, true)] // Far in future
    public void MeetsShelfLifeRequirements_DaysRemainingTheory(int daysFromNow, bool expected)
    {
        var lot = new InventoryLot { ExpirationDate = _testDate.AddDays(daysFromNow) };
        Assert.Equal(expected, _validator.MeetsShelfLifeRequirements(lot, _testDate));
    }

    [Fact]
    public void MeetsShelfLifeRequirements_ByDateDirectly_Works()
    {
        // With expiration date
        Assert.True(_validator.MeetsShelfLifeRequirements(_testDate.AddDays(30), _testDate));
        Assert.False(_validator.MeetsShelfLifeRequirements(_testDate.AddDays(29), _testDate));

        // Without expiration date
        Assert.True(_validator.MeetsShelfLifeRequirements((DateTime?)null, _testDate));
    }

    [Fact]
    public void GetDaysUntilExpiration_CalculatesCorrectly()
    {
        Assert.Equal(30, _validator.GetDaysUntilExpiration(_testDate.AddDays(30), _testDate));
        Assert.Equal(0, _validator.GetDaysUntilExpiration(_testDate, _testDate));
        Assert.Equal(-5, _validator.GetDaysUntilExpiration(_testDate.AddDays(-5), _testDate));
        Assert.Equal(int.MaxValue, _validator.GetDaysUntilExpiration(null, _testDate));
    }

    [Fact]
    public void GetMinimumExpirationDate_CalculatesCorrectly()
    {
        // Default 30 days
        Assert.Equal(_testDate.AddDays(30), _validator.GetMinimumExpirationDate(_testDate));

        // Custom 60 days
        Assert.Equal(_testDate.AddDays(60), _validator.GetMinimumExpirationDate(_testDate, 60));
    }

    [Fact]
    public void FilterByShelfLife_FiltersCorrectly()
    {
        var lots = new List<InventoryLot>
        {
            new InventoryLot { LotNumber = "LOT1", ExpirationDate = _testDate.AddDays(40) },  // Pass
            new InventoryLot { LotNumber = "LOT2", ExpirationDate = _testDate.AddDays(25) },  // Fail
            new InventoryLot { LotNumber = "LOT3", ExpirationDate = null },                    // Pass (no exp)
            new InventoryLot { LotNumber = "LOT4", ExpirationDate = _testDate.AddDays(30) },  // Pass (exactly 30)
            new InventoryLot { LotNumber = "LOT5", ExpirationDate = _testDate.AddDays(-1) },  // Fail (expired)
        };

        var filtered = _validator.FilterByShelfLife(lots, _testDate).ToList();

        Assert.Equal(3, filtered.Count);
        Assert.Contains(filtered, l => l.LotNumber == "LOT1");
        Assert.Contains(filtered, l => l.LotNumber == "LOT3");
        Assert.Contains(filtered, l => l.LotNumber == "LOT4");
        Assert.DoesNotContain(filtered, l => l.LotNumber == "LOT2");
        Assert.DoesNotContain(filtered, l => l.LotNumber == "LOT5");
    }

    [Fact]
    public void FilterByShelfLife_WithCustomMinDays_FiltersCorrectly()
    {
        var lots = new List<InventoryLot>
        {
            new InventoryLot { LotNumber = "LOT1", ExpirationDate = _testDate.AddDays(45) },  // Fail (needs 60)
            new InventoryLot { LotNumber = "LOT2", ExpirationDate = _testDate.AddDays(60) },  // Pass
            new InventoryLot { LotNumber = "LOT3", ExpirationDate = _testDate.AddDays(90) },  // Pass
        };

        var filtered = _validator.FilterByShelfLife(lots, _testDate, customerMinDays: 60).ToList();

        Assert.Equal(2, filtered.Count);
        Assert.Contains(filtered, l => l.LotNumber == "LOT2");
        Assert.Contains(filtered, l => l.LotNumber == "LOT3");
    }

    [Fact]
    public void DefaultMinShelfLifeDays_Is30()
    {
        Assert.Equal(30, ShelfLifeValidator.DEFAULT_MIN_SHELF_LIFE_DAYS);
    }
}
