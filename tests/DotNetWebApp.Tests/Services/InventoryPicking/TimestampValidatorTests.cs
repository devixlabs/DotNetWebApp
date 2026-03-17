using DotNetWebApp.Services.InventoryPicking.Validators;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests.Services.InventoryPicking;

public class TimestampValidatorTests
{
    private readonly TimestampValidator _validator;

    public TimestampValidatorTests()
    {
        var logger = new Mock<ILogger<TimestampValidator>>();
        _validator = new TimestampValidator(logger.Object);
    }

    [Fact]
    public void ValidateClockTimes_IdenticalTimes_ReturnsInvalid()
    {
        // Arrange
        var time = DateTime.Now;

        // Act
        var result = _validator.ValidateClockTimes(time, time);

        // Assert
        Assert.False(result.IsValid);
        Assert.Equal("Paul says that there is no way you are that fast!", result.Message);
    }

    [Fact]
    public void ValidateClockTimes_ClockOutBeforeClockIn_ReturnsInvalid()
    {
        // Arrange
        var clockIn = DateTime.Now;
        var clockOut = clockIn.AddMinutes(-30);

        // Act
        var result = _validator.ValidateClockTimes(clockIn, clockOut);

        // Assert
        Assert.False(result.IsValid);
        Assert.Equal("Clock out cannot be before clock in", result.Message);
    }

    [Fact]
    public void ValidateClockTimes_ValidTimes_ReturnsValid()
    {
        // Arrange
        var clockIn = DateTime.Now.AddHours(-1);
        var clockOut = DateTime.Now;

        // Act
        var result = _validator.ValidateClockTimes(clockIn, clockOut);

        // Assert
        Assert.True(result.IsValid);
    }

    [Fact]
    public void ValidateClockTimes_OneMinuteDifference_ReturnsValid()
    {
        // Arrange
        var clockIn = DateTime.Now;
        var clockOut = clockIn.AddMinutes(1);

        // Act
        var result = _validator.ValidateClockTimes(clockIn, clockOut);

        // Assert
        Assert.True(result.IsValid);
    }

    [Fact]
    public void ValidateClockTimes_OneSecondDifference_ReturnsValid()
    {
        // Arrange
        var clockIn = DateTime.Now;
        var clockOut = clockIn.AddSeconds(1);

        // Act
        var result = _validator.ValidateClockTimes(clockIn, clockOut);

        // Assert
        Assert.True(result.IsValid);
    }

    [Fact]
    public void ValidateClockIn_TooFarInFuture_ReturnsInvalid()
    {
        // Arrange
        var clockIn = DateTime.Now.AddHours(2);

        // Act
        var result = _validator.ValidateClockIn(clockIn);

        // Assert
        Assert.False(result.IsValid);
        Assert.Contains("future", result.Message);
    }

    [Fact]
    public void ValidateClockIn_TooFarInPast_ReturnsInvalid()
    {
        // Arrange
        var clockIn = DateTime.Now.AddHours(-25);

        // Act
        var result = _validator.ValidateClockIn(clockIn);

        // Assert
        Assert.False(result.IsValid);
        Assert.Contains("past", result.Message);
    }

    [Fact]
    public void ValidateClockIn_CurrentTime_ReturnsValid()
    {
        // Arrange
        var clockIn = DateTime.Now;

        // Act
        var result = _validator.ValidateClockIn(clockIn);

        // Assert
        Assert.True(result.IsValid);
    }

    [Fact]
    public void ValidateClockIn_30MinutesAgo_ReturnsValid()
    {
        // Arrange
        var clockIn = DateTime.Now.AddMinutes(-30);

        // Act
        var result = _validator.ValidateClockIn(clockIn);

        // Assert
        Assert.True(result.IsValid);
    }

    [Fact]
    public void ValidateClockIn_30MinutesInFuture_ReturnsValid()
    {
        // Arrange
        var clockIn = DateTime.Now.AddMinutes(30);

        // Act
        var result = _validator.ValidateClockIn(clockIn);

        // Assert
        Assert.True(result.IsValid);
    }
}
