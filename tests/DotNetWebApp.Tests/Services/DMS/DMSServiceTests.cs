using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Services.DMS;
using DotNetWebApp.Services.DMS.Models;
using DotNetWebApp.Services.DMS.Validators;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests.Services.DMS;

/// <summary>
/// Tests for DMSService focusing on testable logic
/// Full integration tests with database will be in separate integration test suite
/// </summary>
public class DMSServiceTests
{
    private readonly Mock<IDapperQueryService> _mockDapperQuery;
    private readonly StatusTransitionValidator _statusValidator;
    private readonly DeleteValidator _deleteValidator;
    private readonly Mock<ILogger<DMSService>> _mockLogger;

    public DMSServiceTests()
    {
        _mockDapperQuery = new Mock<IDapperQueryService>();
        _statusValidator = new StatusTransitionValidator();
        _deleteValidator = new DeleteValidator();
        _mockLogger = new Mock<ILogger<DMSService>>();
    }

    #region ListOrdersAsync Tests

    [Fact]
    public async Task ListOrdersAsync_CallsDapperWithCorrectSQL()
    {
        // Arrange
        var service = CreateService();
        var warehouseId = 3;
        var date = new DateTime(2025, 1, 15);
        var expectedOrders = new List<DMSOrder>
        {
            new DMSOrder { OrderNumber = 123, WarehouseId = 3, Status = "N/A", OrderTypeValue = 1 }
        };

        _mockDapperQuery.Setup(d => d.QueryAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(expectedOrders);

        // Act
        var result = await service.ListOrdersAsync(warehouseId, date);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result);
        _mockDapperQuery.Verify(d => d.QueryAsync<DMSOrder>(
            It.Is<string>(sql => sql.Contains("gs_id = @WarehouseId") &&
                                sql.Contains("gs_num1 <= 9") &&
                                sql.Contains("gai_scheduler")),
            It.IsAny<object>()), Times.Once);
    }

    [Fact]
    public async Task ListOrdersAsync_WithStatusFilter_IncludesFilterInSQL()
    {
        // Arrange
        var service = CreateService();
        var warehouseId = 92;
        var date = DateTime.Today;
        var statusFilter = "Check In";
        var expectedOrders = new List<DMSOrder>
        {
            new DMSOrder { OrderNumber = 789, WarehouseId = 92, Status = "Check In", OrderTypeValue = 1 }
        };

        _mockDapperQuery.Setup(d => d.QueryAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(expectedOrders);

        // Act
        var result = await service.ListOrdersAsync(warehouseId, date, statusFilter);

        // Assert
        Assert.Single(result);
        _mockDapperQuery.Verify(d => d.QueryAsync<DMSOrder>(
            It.Is<string>(sql => sql.Contains("gs_status = @StatusFilter")),
            It.IsAny<object>()), Times.Once);
    }

    [Fact]
    public async Task ListOrdersAsync_ParsesEnumsCorrectly()
    {
        // Arrange
        var service = CreateService();
        var warehouseId = 3;
        var date = DateTime.Today;
        var ordersFromDb = new List<DMSOrder>
        {
            new DMSOrder { OrderNumber = 123, Status = "Check In", OrderTypeValue = 1 },
            new DMSOrder { OrderNumber = 456, Status = "Loading", OrderTypeValue = 2 },
            new DMSOrder { OrderNumber = 789, Status = "N/A", OrderTypeValue = 3 }
        };

        _mockDapperQuery.Setup(d => d.QueryAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(ordersFromDb);

        // Act
        var result = await service.ListOrdersAsync(warehouseId, date);
        var orders = result.ToList();

        // Assert
        Assert.Equal(3, orders.Count);
        Assert.Equal(DockStatus.CheckIn, orders[0].StatusEnum);
        Assert.Equal(OrderType.SO, orders[0].OrderTypeEnum);
        Assert.Equal(DockStatus.Loading, orders[1].StatusEnum);
        Assert.Equal(OrderType.PO, orders[1].OrderTypeEnum);
        Assert.Equal(DockStatus.NA, orders[2].StatusEnum);
        Assert.Equal(OrderType.ICT_NL, orders[2].OrderTypeEnum);
    }

    #endregion

    #region GetOrderAsync Tests

    [Fact]
    public async Task GetOrderAsync_OrderExists_ParsesAndReturnsOrder()
    {
        // Arrange
        var service = CreateService();
        var orderNumber = 123L;
        var warehouseId = 3;
        var expectedOrder = new DMSOrder
        {
            OrderNumber = orderNumber,
            WarehouseId = warehouseId,
            Status = "Check In",
            OrderTypeValue = 1
        };

        _mockDapperQuery.Setup(d => d.QuerySingleAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(expectedOrder);

        // Act
        var result = await service.GetOrderAsync(orderNumber, warehouseId);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(orderNumber, result.OrderNumber);
        Assert.Equal(DockStatus.CheckIn, result.StatusEnum);
        Assert.Equal(OrderType.SO, result.OrderTypeEnum);
    }

    [Fact]
    public async Task GetOrderAsync_OrderNotFound_ReturnsNull()
    {
        // Arrange
        var service = CreateService();
        var orderNumber = 999L;
        var warehouseId = 3;

        _mockDapperQuery.Setup(d => d.QuerySingleAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync((DMSOrder?)null);

        // Act
        var result = await service.GetOrderAsync(orderNumber, warehouseId);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task GetOrderAsync_CallsDapperWithCorrectParameters()
    {
        // Arrange
        var service = CreateService();
        var orderNumber = 123L;
        var warehouseId = 3;

        _mockDapperQuery.Setup(d => d.QuerySingleAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync((DMSOrder?)null);

        // Act
        await service.GetOrderAsync(orderNumber, warehouseId);

        // Assert
        _mockDapperQuery.Verify(d => d.QuerySingleAsync<DMSOrder>(
            It.Is<string>(sql => sql.Contains("gs_ordnum = @OrderNumber") &&
                                sql.Contains("gs_id = @WarehouseId")),
            It.Is<object>(p => HasProperty(p, "OrderNumber", orderNumber) &&
                              HasProperty(p, "WarehouseId", warehouseId))),
            Times.Once);
    }

    #endregion

    #region ChangeStatusAsync Tests - Logic Tests Only

    [Fact]
    public async Task ChangeStatusAsync_OrderNotFound_ReturnsFailure()
    {
        // Arrange
        var service = CreateService();
        var orderNumber = 999L;
        var warehouseId = 3;

        _mockDapperQuery.Setup(d => d.QuerySingleAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync((DMSOrder?)null);

        // Act
        var result = await service.ChangeStatusAsync(orderNumber, DockStatus.CheckIn, warehouseId);

        // Assert
        Assert.False(result.Success);
        Assert.Contains("not found", result.Message, StringComparison.OrdinalIgnoreCase);
        Assert.Equal(0, result.UpdatedOrderCount);
    }

    [Fact]
    public async Task ChangeStatusAsync_InvalidTransition_ReturnsFailure()
    {
        // Arrange
        var service = CreateService();
        var orderNumber = 123L;
        var warehouseId = 3;
        var currentOrder = new DMSOrder
        {
            OrderNumber = orderNumber,
            WarehouseId = warehouseId,
            Status = "N/A",
            OrderTypeValue = 1,
            StatusEnum = DockStatus.NA
        };

        _mockDapperQuery.Setup(d => d.QuerySingleAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(currentOrder);

        // Act - Try to skip CheckIn and go directly to Loading (invalid)
        var result = await service.ChangeStatusAsync(orderNumber, DockStatus.Loading, warehouseId);

        // Assert
        Assert.False(result.Success);
        Assert.Contains("Invalid transition", result.Message);
        Assert.Equal(0, result.UpdatedOrderCount);
    }

    [Fact]
    public async Task ChangeStatusAsync_SameStatus_ReturnsFailure()
    {
        // Arrange
        var service = CreateService();
        var orderNumber = 123L;
        var warehouseId = 3;
        var currentOrder = new DMSOrder
        {
            OrderNumber = orderNumber,
            WarehouseId = warehouseId,
            Status = "Check In",
            OrderTypeValue = 1,
            StatusEnum = DockStatus.CheckIn
        };

        _mockDapperQuery.Setup(d => d.QuerySingleAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(currentOrder);

        // Act - Try to set to CheckIn when already at CheckIn
        var result = await service.ChangeStatusAsync(orderNumber, DockStatus.CheckIn, warehouseId);

        // Assert
        Assert.False(result.Success);
        Assert.Contains("already", result.Message, StringComparison.OrdinalIgnoreCase);
    }

    #endregion

    #region BatchChangeStatusByAppIDAsync Tests - Logic Tests Only

    [Fact]
    public async Task BatchChangeStatusByAppIDAsync_EmptyAppID_ReturnsFailure()
    {
        // Arrange
        var service = CreateService();

        // Act
        var result = await service.BatchChangeStatusByAppIDAsync("", DockStatus.CheckIn, 3);

        // Assert
        Assert.False(result.Success);
        Assert.Contains("cannot be empty", result.Message, StringComparison.OrdinalIgnoreCase);
        Assert.Equal(0, result.UpdatedOrderCount);
    }

    [Fact]
    public async Task BatchChangeStatusByAppIDAsync_NoOrdersFound_ReturnsFailure()
    {
        // Arrange
        var service = CreateService();
        var appId = "APP-999";
        var warehouseId = 3;

        _mockDapperQuery.Setup(d => d.QueryAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(new List<DMSOrder>());

        // Act
        var result = await service.BatchChangeStatusByAppIDAsync(appId, DockStatus.CheckIn, warehouseId);

        // Assert
        Assert.False(result.Success);
        Assert.Contains("No orders found", result.Message);
        Assert.Equal(0, result.UpdatedOrderCount);
    }

    [Fact]
    public async Task BatchChangeStatusByAppIDAsync_MixedInvalidTransitions_ReturnsFailure()
    {
        // Arrange
        var service = CreateService();
        var appId = "APP-001";
        var warehouseId = 3;
        var orders = new List<DMSOrder>
        {
            new DMSOrder { OrderNumber = 123, Status = "N/A", StatusEnum = DockStatus.NA, AppId = appId, OrderTypeValue = 1 },
            new DMSOrder { OrderNumber = 456, Status = "Check In", StatusEnum = DockStatus.CheckIn, AppId = appId, OrderTypeValue = 1 }
        };

        _mockDapperQuery.Setup(d => d.QueryAsync<DMSOrder>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(orders);

        // Act - Try to move both to CheckIn, but second is already at CheckIn
        var result = await service.BatchChangeStatusByAppIDAsync(appId, DockStatus.CheckIn, warehouseId);

        // Assert
        Assert.False(result.Success);
        Assert.Contains("invalid", result.Message, StringComparison.OrdinalIgnoreCase);
        Assert.Equal(0, result.UpdatedOrderCount);
    }

    #endregion

    #region UpdateForkliftOperatorAsync Tests - Logic Tests Only

    [Fact]
    public async Task BatchUpdateForkliftByAppIDAsync_EmptyAppID_ReturnsFalse()
    {
        // Arrange
        var service = CreateService();

        // Act
        var result = await service.BatchUpdateForkliftByAppIDAsync("", "jdoe", 3);

        // Assert
        Assert.False(result);
    }

    #endregion

    #region GetAvailableOperatorsAsync Tests

    [Fact(Skip = "BLOCKER: GAISystem schema not integrated - see BLOCKERS.md")]
    public async Task GetAvailableOperatorsAsync_CallsDapperWithCorrectSQL()
    {
        // Arrange
        var service = CreateService();
        var warehouseId = 3;
        var expectedOperators = new List<OperatorInfo>
        {
            new OperatorInfo { Username = "jdoe", FullName = "John Doe", IsCPFGUser = true },
            new OperatorInfo { Username = "jsmith", FullName = "Jane Smith", IsCPFGUser = true }
        };

        _mockDapperQuery.Setup(d => d.QueryAsync<OperatorInfo>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(expectedOperators);

        // Act
        var result = await service.GetAvailableOperatorsAsync(warehouseId);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(2, result.Count());
        Assert.All(result, op => Assert.True(op.IsCPFGUser));
        _mockDapperQuery.Verify(d => d.QueryAsync<OperatorInfo>(
            It.Is<string>(sql => sql.Contains("d2_d1id = 687") &&
                                sql.Contains("gai_dat2")),
            It.IsAny<object>()), Times.Once);
    }

    [Fact(Skip = "BLOCKER: GAISystem schema not integrated - see BLOCKERS.md")]
    public async Task GetAvailableOperatorsAsync_ReturnsAllOperators()
    {
        // Arrange
        var service = CreateService();
        var warehouseId = 3;
        var expectedOperators = new List<OperatorInfo>
        {
            new OperatorInfo { Username = "user1", FullName = "User One", IsCPFGUser = true },
            new OperatorInfo { Username = "user2", FullName = "User Two", IsCPFGUser = true },
            new OperatorInfo { Username = "user3", FullName = "User Three", IsCPFGUser = true }
        };

        _mockDapperQuery.Setup(d => d.QueryAsync<OperatorInfo>(
            It.IsAny<string>(),
            It.IsAny<object>()))
            .ReturnsAsync(expectedOperators);

        // Act
        var result = await service.GetAvailableOperatorsAsync(warehouseId);

        // Assert
        var operators = result.ToList();
        Assert.Equal(3, operators.Count);
        Assert.Contains(operators, o => o.Username == "user1");
        Assert.Contains(operators, o => o.Username == "user2");
        Assert.Contains(operators, o => o.Username == "user3");
    }

    #endregion

    #region Helper Methods

    private DMSService CreateService()
    {
        // Create mock context - actual database operations are integration tests
        var mockContext = new Mock<SecondaryDbContext>(
            new DbContextOptions<SecondaryDbContext>(),
            Microsoft.Extensions.Options.Options.Create(new DatabaseMappingOptions()));

        return new DMSService(
            mockContext.Object,
            _mockDapperQuery.Object,
            _statusValidator,
            _deleteValidator,
            _mockLogger.Object);
    }

    private bool HasProperty(object obj, string propertyName, object expectedValue)
    {
        var prop = obj.GetType().GetProperty(propertyName);
        if (prop == null) return false;
        var value = prop.GetValue(obj);
        return Equals(value, expectedValue);
    }

    #endregion
}
