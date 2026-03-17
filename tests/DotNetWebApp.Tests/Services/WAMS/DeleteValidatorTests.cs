using DotNetWebApp.Services.WAMS.Models;
using DotNetWebApp.Services.WAMS.Validators;
using Xunit;

namespace DotNetWebApp.Tests.Services.WAMS;

public class DeleteValidatorTests
{
    private readonly DeleteValidator _validator;

    public DeleteValidatorTests()
    {
        _validator = new DeleteValidator();
    }

    #region CanDelete - Valid Cases

    [Fact]
    public void CanDelete_StatusNA_SecurityLevel1_ReturnsValid()
    {
        // Arrange - Admin user, status NA, SO
        var status = DockStatus.NA;
        var securityLevel = 1; // Admin
        var orderType = OrderType.SO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void CanDelete_StatusNA_SecurityLevel2_ReturnsValid()
    {
        // Arrange - User role, status NA, PO
        var status = DockStatus.NA;
        var securityLevel = 2; // User
        var orderType = OrderType.PO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void CanDelete_StatusNA_Admin_ICT_ReturnsValid()
    {
        // Arrange - Admin, status NA, ICT order
        var status = DockStatus.NA;
        var securityLevel = 1;
        var orderType = OrderType.ICT_NYC;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    #endregion

    #region CanDelete - Invalid: Already Deleted

    [Fact]
    public void CanDelete_AlreadyDeleted_ReturnsInvalid()
    {
        // Arrange - Order is already deleted (type 11)
        var status = DockStatus.NA;
        var securityLevel = 1;
        var orderType = OrderType.Deleted_SO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("already deleted", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void CanDelete_AlreadyDeleted_Type12_ReturnsInvalid()
    {
        // Arrange
        var status = DockStatus.NA;
        var securityLevel = 1;
        var orderType = OrderType.Deleted_PO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("already deleted", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    #endregion

    #region CanDelete - Invalid: Insufficient Security Level

    [Fact]
    public void CanDelete_SecurityLevel3_ReturnsInvalid()
    {
        // Arrange - Security level 3 is not authorized
        var status = DockStatus.NA;
        var securityLevel = 3;
        var orderType = OrderType.SO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("security level", errorMessage, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("2", errorMessage); // Must be <= 2
    }

    [Fact]
    public void CanDelete_SecurityLevel5_ReturnsInvalid()
    {
        // Arrange - Security level 5 (view only) is not authorized
        var status = DockStatus.NA;
        var securityLevel = 5;
        var orderType = OrderType.PO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("security level", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    #endregion

    #region CanDelete - Invalid: Status Not NA

    [Fact]
    public void CanDelete_StatusCheckIn_ReturnsInvalid()
    {
        // Arrange - Cannot delete after check-in
        var status = DockStatus.CheckIn;
        var securityLevel = 1;
        var orderType = OrderType.SO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("N/A", errorMessage);
    }

    [Fact]
    public void CanDelete_StatusLoading_ReturnsInvalid()
    {
        // Arrange - Cannot delete while loading
        var status = DockStatus.Loading;
        var securityLevel = 1;
        var orderType = OrderType.SO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("N/A", errorMessage);
    }

    [Fact]
    public void CanDelete_StatusShipped_ReturnsInvalid()
    {
        // Arrange - Cannot delete after shipped
        var status = DockStatus.Shipped;
        var securityLevel = 1;
        var orderType = OrderType.SO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("N/A", errorMessage);
    }

    [Fact]
    public void CanDelete_StatusReceived_ReturnsInvalid()
    {
        // Arrange - Cannot delete after received
        var status = DockStatus.Received;
        var securityLevel = 1;
        var orderType = OrderType.PO;

        // Act
        var (isValid, errorMessage) = _validator.CanDelete(status, securityLevel, orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("N/A", errorMessage);
    }

    #endregion

    #region CanUndelete - Valid Cases

    [Fact]
    public void CanUndelete_DeletedSO_ReturnsValid()
    {
        // Arrange - Order is deleted, can be undeleted
        var orderType = OrderType.Deleted_SO;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void CanUndelete_DeletedPO_ReturnsValid()
    {
        // Arrange
        var orderType = OrderType.Deleted_PO;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void CanUndelete_DeletedICT_ReturnsValid()
    {
        // Arrange
        var orderType = OrderType.Deleted_ICT_NYC;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void CanUndelete_WithSecurityLevel_Admin_ReturnsValid()
    {
        // Arrange - Admin user can undelete
        var orderType = OrderType.Deleted_SO;
        var securityLevel = 1;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType, securityLevel);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    [Fact]
    public void CanUndelete_WithSecurityLevel_User_ReturnsValid()
    {
        // Arrange - User role can undelete
        var orderType = OrderType.Deleted_PO;
        var securityLevel = 2;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType, securityLevel);

        // Assert
        Assert.True(isValid);
        Assert.Equal("", errorMessage);
    }

    #endregion

    #region CanUndelete - Invalid Cases

    [Fact]
    public void CanUndelete_NotDeleted_ReturnsInvalid()
    {
        // Arrange - Order is not deleted
        var orderType = OrderType.SO;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("not deleted", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void CanUndelete_NotDeleted_PO_ReturnsInvalid()
    {
        // Arrange
        var orderType = OrderType.PO;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType);

        // Assert
        Assert.False(isValid);
        Assert.Contains("not deleted", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void CanUndelete_WithSecurityLevel_Insufficient_ReturnsInvalid()
    {
        // Arrange - Security level 3 cannot undelete
        var orderType = OrderType.Deleted_SO;
        var securityLevel = 3;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType, securityLevel);

        // Assert
        Assert.False(isValid);
        Assert.Contains("security level", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void CanUndelete_WithSecurityLevel5_ReturnsInvalid()
    {
        // Arrange - View only user cannot undelete
        var orderType = OrderType.Deleted_PO;
        var securityLevel = 5;

        // Act
        var (isValid, errorMessage) = _validator.CanUndelete(orderType, securityLevel);

        // Assert
        Assert.False(isValid);
        Assert.Contains("security level", errorMessage, StringComparison.OrdinalIgnoreCase);
    }

    #endregion

    #region User-Friendly Messages

    [Fact]
    public void GetDeleteReasonMessage_AlreadyDeleted_ReturnsMessage()
    {
        // Arrange
        var status = DockStatus.NA;
        var securityLevel = 1;
        var orderType = OrderType.Deleted_SO;

        // Act
        var message = _validator.GetDeleteReasonMessage(status, securityLevel, orderType);

        // Assert
        Assert.Contains("already been deleted", message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void GetDeleteReasonMessage_InsufficientSecurity_ReturnsMessage()
    {
        // Arrange
        var status = DockStatus.NA;
        var securityLevel = 5;
        var orderType = OrderType.SO;

        // Act
        var message = _validator.GetDeleteReasonMessage(status, securityLevel, orderType);

        // Assert
        Assert.Contains("security level", message, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("5", message);
    }

    [Fact]
    public void GetDeleteReasonMessage_WrongStatus_ReturnsMessage()
    {
        // Arrange
        var status = DockStatus.Loading;
        var securityLevel = 1;
        var orderType = OrderType.SO;

        // Act
        var message = _validator.GetDeleteReasonMessage(status, securityLevel, orderType);

        // Assert
        Assert.Contains("N/A", message);
        Assert.Contains("Loading", message);
    }

    [Fact]
    public void GetUndeleteReasonMessage_NotDeleted_ReturnsMessage()
    {
        // Arrange
        var orderType = OrderType.SO;
        var securityLevel = 1;

        // Act
        var message = _validator.GetUndeleteReasonMessage(orderType, securityLevel);

        // Assert
        Assert.Contains("not deleted", message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void GetUndeleteReasonMessage_InsufficientSecurity_ReturnsMessage()
    {
        // Arrange
        var orderType = OrderType.Deleted_SO;
        var securityLevel = 5;

        // Act
        var message = _validator.GetUndeleteReasonMessage(orderType, securityLevel);

        // Assert
        Assert.Contains("security level", message, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("5", message);
    }

    #endregion
}
