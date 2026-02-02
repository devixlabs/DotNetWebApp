using DotNetWebApp.Services.DMS.Models;
using DotNetWebApp.Services.DMS.Validators;
using Xunit;

namespace DotNetWebApp.Tests.Services.DMS;

public class StatusTransitionValidatorTests
{
    private readonly StatusTransitionValidator _validator;

    public StatusTransitionValidatorTests()
    {
        _validator = new StatusTransitionValidator();
    }

    #region Valid Forward Transitions

    [Fact]
    public void ValidateTransition_NAToCheckIn_ReturnsValid()
    {
        // Arrange
        var current = DockStatus.NA;
        var next = DockStatus.CheckIn;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void ValidateTransition_CheckInToLoading_ReturnsValid()
    {
        // Arrange
        var current = DockStatus.CheckIn;
        var next = DockStatus.Loading;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void ValidateTransition_LoadingToUnloading_ReturnsValid()
    {
        // Arrange
        var current = DockStatus.Loading;
        var next = DockStatus.Unloading;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void ValidateTransition_LoadingToShipped_ReturnsValid()
    {
        // Arrange - Skip Unloading for outbound orders
        var current = DockStatus.Loading;
        var next = DockStatus.Shipped;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void ValidateTransition_UnloadingToShipped_ReturnsValid()
    {
        // Arrange
        var current = DockStatus.Unloading;
        var next = DockStatus.Shipped;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void ValidateTransition_UnloadingToReceived_ReturnsValid()
    {
        // Arrange - Inbound orders go to Received
        var current = DockStatus.Unloading;
        var next = DockStatus.Received;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void ValidateTransition_ShippedToReceived_ReturnsValid()
    {
        // Arrange
        var current = DockStatus.Shipped;
        var next = DockStatus.Received;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    #endregion

    #region Special Case: CheckIn to NA (Only Allowed Backward Transition)

    [Fact]
    public void ValidateTransition_CheckInToNA_ReturnsValid()
    {
        // Arrange - Special case: can revert from CheckIn to NA to clear check-in time
        var current = DockStatus.CheckIn;
        var next = DockStatus.NA;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    #endregion

    #region Invalid Backward Transitions (Except CheckIn → NA)

    [Fact]
    public void ValidateTransition_LoadingToNA_ReturnsInvalid()
    {
        // Arrange
        var current = DockStatus.Loading;
        var next = DockStatus.NA;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("forward", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void ValidateTransition_LoadingToCheckIn_ReturnsInvalid()
    {
        // Arrange
        var current = DockStatus.Loading;
        var next = DockStatus.CheckIn;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("forward", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void ValidateTransition_ShippedToLoading_ReturnsInvalid()
    {
        // Arrange
        var current = DockStatus.Shipped;
        var next = DockStatus.Loading;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("forward", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void ValidateTransition_ReceivedToShipped_ReturnsInvalid()
    {
        // Arrange - Received is terminal state
        var current = DockStatus.Received;
        var next = DockStatus.Shipped;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("forward", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    #endregion

    #region Invalid Forward Transitions (Skipping Required Steps)

    [Fact]
    public void ValidateTransition_NAToLoading_ReturnsInvalid()
    {
        // Arrange - Must go through CheckIn first
        var current = DockStatus.NA;
        var next = DockStatus.Loading;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("Invalid transition", errorMessage);
        Assert.Contains("CheckIn", errorMessage);
    }

    [Fact]
    public void ValidateTransition_CheckInToShipped_ReturnsInvalid()
    {
        // Arrange - Must go through Loading first
        var current = DockStatus.CheckIn;
        var next = DockStatus.Shipped;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("Invalid transition", errorMessage);
    }

    [Fact]
    public void ValidateTransition_CheckInToReceived_ReturnsInvalid()
    {
        // Arrange - Cannot skip directly to Received
        var current = DockStatus.CheckIn;
        var next = DockStatus.Received;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("Invalid transition", errorMessage);
    }

    #endregion

    #region Same Status (No-Op)

    [Fact]
    public void ValidateTransition_SameStatus_ReturnsInvalid()
    {
        // Arrange
        var current = DockStatus.Loading;
        var next = DockStatus.Loading;

        // Act
        var (isValid, errorMessage) = _validator.ValidateTransition(current, next);

        // Assert
        Assert.False(isValid);
        Assert.Contains("already", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    #endregion

    #region Terminal Status

    [Fact]
    public void IsTerminalStatus_Received_ReturnsTrue()
    {
        // Act
        var isTerminal = _validator.IsTerminalStatus(DockStatus.Received);

        // Assert
        Assert.True(isTerminal);
    }

    [Fact]
    public void IsTerminalStatus_Shipped_ReturnsFalse()
    {
        // Act
        var isTerminal = _validator.IsTerminalStatus(DockStatus.Shipped);

        // Assert
        Assert.False(isTerminal);
    }

    [Fact]
    public void IsTerminalStatus_NA_ReturnsFalse()
    {
        // Act
        var isTerminal = _validator.IsTerminalStatus(DockStatus.NA);

        // Assert
        Assert.False(isTerminal);
    }

    #endregion

    #region Reachable Statuses

    [Fact]
    public void GetReachableStatuses_FromNA_ReturnsAllStatuses()
    {
        // Act
        var reachable = _validator.GetReachableStatuses(DockStatus.NA);

        // Assert
        Assert.Contains(DockStatus.CheckIn, reachable);
        Assert.Contains(DockStatus.Loading, reachable);
        Assert.Contains(DockStatus.Unloading, reachable);
        Assert.Contains(DockStatus.Shipped, reachable);
        Assert.Contains(DockStatus.Received, reachable);
    }

    [Fact]
    public void GetReachableStatuses_FromCheckIn_ReturnsDownstreamStatuses()
    {
        // Act
        var reachable = _validator.GetReachableStatuses(DockStatus.CheckIn);

        // Assert
        Assert.Contains(DockStatus.Loading, reachable);
        Assert.Contains(DockStatus.Shipped, reachable);
        Assert.Contains(DockStatus.Received, reachable);
        Assert.Contains(DockStatus.NA, reachable); // Special case: can revert to NA
    }

    [Fact]
    public void GetReachableStatuses_FromReceived_ReturnsEmpty()
    {
        // Act
        var reachable = _validator.GetReachableStatuses(DockStatus.Received);

        // Assert
        Assert.Empty(reachable);
    }

    #endregion
}
