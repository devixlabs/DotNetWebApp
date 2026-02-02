using DotNetWebApp.Services.PrePick;
using DotNetWebApp.Services.PrePick.Models;
using Xunit;

namespace DotNetWebApp.Tests.Services.PrePick;

public class ColorCodingServiceTests
{
    [Theory]
    [InlineData(1, "LightYellow")]
    [InlineData(2, "Tan")]
    [InlineData(3, "LightSalmon")]
    [InlineData(4, "DarkGray")]
    [InlineData(0, "White")]
    [InlineData(5, "White")]
    [InlineData(-1, "White")]
    public void GetStatusColor_ReturnsCorrectColor(int statusCode, string expectedColor)
    {
        // Act
        string result = ColorCodingService.GetStatusColor(statusCode);

        // Assert
        Assert.Equal(expectedColor, result);
    }

    [Theory]
    [InlineData(0, "Aquamarine")]   // No dock booking
    [InlineData(1, "Thistle")]      // Has dock booking
    [InlineData(99, "Thistle")]     // Any non-zero is dock booked
    public void GetDockColor_ReturnsCorrectColor(int crossDock, string expectedColor)
    {
        // Act
        string result = ColorCodingService.GetDockColor(crossDock);

        // Assert
        Assert.Equal(expectedColor, result);
    }

    [Fact]
    public void GetOperationColor_NoOperator_ReturnsWhite()
    {
        // Act
        string result = ColorCodingService.GetOperationColor(null, null, null);

        // Assert
        Assert.Equal("White", result);
    }

    [Fact]
    public void GetOperationColor_EmptyOperator_ReturnsWhite()
    {
        // Act
        string result = ColorCodingService.GetOperationColor("", DateTime.Now, null);

        // Assert
        Assert.Equal("White", result);
    }

    [Fact]
    public void GetOperationColor_OperatorWithClockIn_InProgress_ReturnsYellow()
    {
        // Arrange
        string operatorName = "TestUser";
        DateTime? clockIn = DateTime.Now.AddHours(-1);
        DateTime? clockOut = null;

        // Act
        string result = ColorCodingService.GetOperationColor(operatorName, clockIn, clockOut);

        // Assert
        Assert.Equal("Yellow", result);
    }

    [Fact]
    public void GetOperationColor_OperatorWithBothTimes_Completed_ReturnsLightGreen()
    {
        // Arrange
        string operatorName = "TestUser";
        DateTime? clockIn = DateTime.Now.AddHours(-2);
        DateTime? clockOut = DateTime.Now.AddHours(-1);

        // Act
        string result = ColorCodingService.GetOperationColor(operatorName, clockIn, clockOut);

        // Assert
        Assert.Equal("LightGreen", result);
    }

    [Fact]
    public void GetOperationColor_OperatorWithoutClockIn_ReturnsWhite()
    {
        // Arrange - Operator assigned but no clock times
        string operatorName = "TestUser";
        DateTime? clockIn = null;
        DateTime? clockOut = null;

        // Act
        string result = ColorCodingService.GetOperationColor(operatorName, clockIn, clockOut);

        // Assert
        Assert.Equal("White", result);
    }

    [Fact]
    public void GetRowCssClass_ReturnsCorrectClass()
    {
        // Arrange
        var order = new PrePickOrder { StatusCode = 2 };

        // Act
        string result = ColorCodingService.GetRowCssClass(order);

        // Assert
        Assert.Equal("prepick-status-2", result);
    }

    [Fact]
    public void GetOperationCssClass_InProgress_ReturnsCorrectClass()
    {
        // Act
        string result = ColorCodingService.GetOperationCssClass("TestUser", DateTime.Now, null);

        // Assert
        Assert.Equal("prepick-in-progress", result);
    }

    [Fact]
    public void GetOperationCssClass_Completed_ReturnsCorrectClass()
    {
        // Act
        string result = ColorCodingService.GetOperationCssClass("TestUser", DateTime.Now.AddHours(-1), DateTime.Now);

        // Assert
        Assert.Equal("prepick-completed", result);
    }

    [Fact]
    public void GetOperationCssClass_NoOperator_ReturnsEmpty()
    {
        // Act
        string result = ColorCodingService.GetOperationCssClass(null, null, null);

        // Assert
        Assert.Equal("", result);
    }

    [Fact]
    public void GetRowStyle_IncludesBackgroundColor()
    {
        // Arrange
        var colorCodingService = new ColorCodingService();
        var order = new PrePickOrder { StatusCode = 1 };

        // Act
        string result = colorCodingService.GetRowStyle(order);

        // Assert
        Assert.Contains("background-color:", result);
        Assert.Contains("LightYellow", result);
    }

    [Fact]
    public void GetPickerCellStyle_ReturnsCorrectStyle()
    {
        // Arrange
        var colorCodingService = new ColorCodingService();
        var order = new PrePickOrder
        {
            PickerUsername = "TestPicker",
            PickerClockIn = DateTime.Now.AddHours(-1),
            PickerClockOut = null
        };

        // Act
        string result = colorCodingService.GetPickerCellStyle(order);

        // Assert
        Assert.Contains("Yellow", result);
    }

    [Fact]
    public void GetAuditorCellStyle_Printed_ReturnsLemonChiffon()
    {
        // Arrange
        var colorCodingService = new ColorCodingService();
        var order = new PrePickOrder
        {
            AuditorUsername = "TestAuditor",
            AuditorClockIn = DateTime.Now,
            PrintStatus = 10  // Printed from Deacom
        };

        // Act
        string result = colorCodingService.GetAuditorCellStyle(order);

        // Assert
        Assert.Contains("LemonChiffon", result);
    }

    [Fact]
    public void GetAuditorCellStyle_PrintStatus11_ReturnsLemonChiffon()
    {
        // Arrange
        var colorCodingService = new ColorCodingService();
        var order = new PrePickOrder
        {
            AuditorUsername = "TestAuditor",
            AuditorClockIn = DateTime.Now,
            PrintStatus = 11  // Printed from allocation
        };

        // Act
        string result = colorCodingService.GetAuditorCellStyle(order);

        // Assert
        Assert.Contains("LemonChiffon", result);
    }

    [Fact]
    public void GetAuditorCellStyle_NotPrinted_ReturnsOperationColor()
    {
        // Arrange
        var colorCodingService = new ColorCodingService();
        var order = new PrePickOrder
        {
            AuditorUsername = "TestAuditor",
            AuditorClockIn = DateTime.Now.AddHours(-1),
            AuditorClockOut = null,
            PrintStatus = 0  // Not printed
        };

        // Act
        string result = colorCodingService.GetAuditorCellStyle(order);

        // Assert
        Assert.Contains("Yellow", result);  // In progress
    }
}
