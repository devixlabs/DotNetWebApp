using DotNetWebApp.Services.PrePick;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests.Services.PrePick;

public class ShipValidationServiceTests
{
    private readonly ShipValidationService _service;

    public ShipValidationServiceTests()
    {
        var logger = new Mock<ILogger<ShipValidationService>>();
        _service = new ShipValidationService(logger.Object);
    }

    [Fact]
    public void CanShip_NonCreditHoldTerms_ReturnsTrue()
    {
        // Arrange - Terms ID 50 (not 51)
        int termsId = 50;
        decimal balance = 1000m;
        decimal totalDue = 500m;

        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void CanShip_CreditHoldWithinTolerance_ReturnsTrue()
    {
        // Arrange - Terms ID 51, balance within 3% tolerance
        int termsId = 51;
        decimal totalDue = 1000m;
        decimal balance = 30m;  // 3% of 1000 = 30

        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void CanShip_CreditHoldExactlyAtTolerance_ReturnsTrue()
    {
        // Arrange - Balance exactly at 3% tolerance
        int termsId = 51;
        decimal totalDue = 1000m;
        decimal balance = 30m;  // Exactly 3%

        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void CanShip_CreditHoldExceedsTolerance_ReturnsFalse()
    {
        // Arrange - Balance exceeds 3% tolerance
        int termsId = 51;
        decimal totalDue = 1000m;
        decimal balance = 31m;  // > 3%

        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.False(result);
    }

    [Fact]
    public void CanShip_CreditHoldZeroBalance_ReturnsTrue()
    {
        // Arrange
        int termsId = 51;
        decimal totalDue = 1000m;
        decimal balance = 0m;

        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void CanShip_CreditHoldZeroTotalDue_ReturnsTrueOnlyIfZeroBalance()
    {
        // Arrange - Edge case: total due is 0, so tolerance is 0
        int termsId = 51;
        decimal totalDue = 0m;
        decimal balance = 0m;

        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void CanShip_CreditHoldZeroTotalDueWithBalance_ReturnsFalse()
    {
        // Arrange - Total due is 0, any balance exceeds 0 tolerance
        int termsId = 51;
        decimal totalDue = 0m;
        decimal balance = 0.01m;

        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.False(result);
    }

    [Fact]
    public void CalculateOkToShip_Static_MatchesInstanceMethod()
    {
        // Arrange
        int termsId = 51;
        decimal totalDue = 1000m;
        decimal balance = 25m;  // Within tolerance

        // Act
        bool staticResult = ShipValidationService.CalculateOkToShip(termsId, balance, totalDue);
        bool instanceResult = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.Equal(staticResult, instanceResult);
    }

    [Theory]
    [InlineData(51, 0, 1000, true)]      // Zero balance
    [InlineData(51, 30, 1000, true)]     // At tolerance
    [InlineData(51, 31, 1000, false)]    // Above tolerance
    [InlineData(51, 100, 1000, false)]   // Well above tolerance
    [InlineData(50, 100, 1000, true)]    // Non-credit hold terms
    [InlineData(1, 500, 100, true)]      // Different terms
    [InlineData(51, 3, 100, true)]       // Small amounts, at tolerance
    [InlineData(51, 4, 100, false)]      // Small amounts, above tolerance
    public void CanShip_VariousScenarios(int termsId, decimal balance, decimal totalDue, bool expected)
    {
        // Act
        bool result = _service.CanShip(termsId, balance, totalDue);

        // Assert
        Assert.Equal(expected, result);
    }
}
