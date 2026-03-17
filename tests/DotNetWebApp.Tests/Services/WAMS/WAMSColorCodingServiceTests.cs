using DotNetWebApp.Services.WAMS;
using DotNetWebApp.Services.WAMS.Models;
using Xunit;

namespace DotNetWebApp.Tests.Services.WAMS;

public class WAMSColorCodingServiceTests
{
    #region Order Type Colors

    [Fact]
    public void GetOrderTypeColor_SO_ReturnsSeaShell()
    {
        // Act
        var color = WAMSColorCodingService.GetOrderTypeColor(OrderType.SO);

        // Assert
        Assert.Equal("SeaShell", color);
    }

    [Fact]
    public void GetOrderTypeColor_PO_ReturnsLightSkyBlue()
    {
        // Act
        var color = WAMSColorCodingService.GetOrderTypeColor(OrderType.PO);

        // Assert
        Assert.Equal("LightSkyBlue", color);
    }

    [Fact]
    public void GetOrderTypeColor_ICT_NYC_ReturnsLightSalmon()
    {
        // Act
        var color = WAMSColorCodingService.GetOrderTypeColor(OrderType.ICT_NYC);

        // Assert
        Assert.Equal("LightSalmon", color);
    }

    [Fact]
    public void GetOrderTypeColor_ICT_Chicago_ReturnsLightSlateGray()
    {
        // Act
        var color = WAMSColorCodingService.GetOrderTypeColor(OrderType.ICT_Chicago);

        // Assert
        Assert.Equal("LightSlateGray", color);
    }

    [Fact]
    public void GetOrderTypeColor_DeletedSO_ReturnsLightGray()
    {
        // Act
        var color = WAMSColorCodingService.GetOrderTypeColor(OrderType.Deleted_SO);

        // Assert
        Assert.Equal("LightGray", color);
    }

    [Fact]
    public void GetOrderTypeColor_DeletedPO_ReturnsLightGray()
    {
        // Act
        var color = WAMSColorCodingService.GetOrderTypeColor(OrderType.Deleted_PO);

        // Assert
        Assert.Equal("LightGray", color);
    }

    #endregion

    #region Status Colors

    [Fact]
    public void GetStatusColor_NA_ReturnsWhite()
    {
        // Act
        var color = WAMSColorCodingService.GetStatusColor(DockStatus.NA);

        // Assert
        Assert.Equal("White", color);
    }

    [Fact]
    public void GetStatusColor_CheckIn_ReturnsOrange()
    {
        // Act
        var color = WAMSColorCodingService.GetStatusColor(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Orange", color);
    }

    [Fact]
    public void GetStatusColor_Loading_ReturnsYellow()
    {
        // Act
        var color = WAMSColorCodingService.GetStatusColor(DockStatus.Loading);

        // Assert
        Assert.Equal("Yellow", color);
    }

    [Fact]
    public void GetStatusColor_Unloading_ReturnsLemonChiffon()
    {
        // Act
        var color = WAMSColorCodingService.GetStatusColor(DockStatus.Unloading);

        // Assert
        Assert.Equal("LemonChiffon", color);
    }

    [Fact]
    public void GetStatusColor_Shipped_ReturnsPaleGreen()
    {
        // Act
        var color = WAMSColorCodingService.GetStatusColor(DockStatus.Shipped);

        // Assert
        Assert.Equal("PaleGreen", color);
    }

    [Fact]
    public void GetStatusColor_Received_ReturnsMediumAquamarine()
    {
        // Act
        var color = WAMSColorCodingService.GetStatusColor(DockStatus.Received);

        // Assert
        Assert.Equal("MediumAquamarine", color);
    }

    #endregion

    #region Row and Cell Styles

    [Fact]
    public void GetRowStyle_StatusNA_ReturnsWhiteBackground()
    {
        // Arrange
        var order = new WAMSOrder { StatusEnum = DockStatus.NA };

        // Act
        var style = WAMSColorCodingService.GetRowStyle(order);

        // Assert
        Assert.Contains("background-color: White", style);
    }

    [Fact]
    public void GetRowStyle_StatusCheckIn_ReturnsOrangeBackground()
    {
        // Arrange
        var order = new WAMSOrder { StatusEnum = DockStatus.CheckIn };

        // Act
        var style = WAMSColorCodingService.GetRowStyle(order);

        // Assert
        Assert.Contains("background-color: Orange", style);
    }

    [Fact]
    public void GetRowStyle_StatusShipped_ReturnsPaleGreenBackground()
    {
        // Arrange
        var order = new WAMSOrder { StatusEnum = DockStatus.Shipped };

        // Act
        var style = WAMSColorCodingService.GetRowStyle(order);

        // Assert
        Assert.Contains("background-color: PaleGreen", style);
    }

    [Fact]
    public void GetOrderNumberCellStyle_SO_ReturnsSeaShellBold()
    {
        // Act
        var style = WAMSColorCodingService.GetOrderNumberCellStyle(OrderType.SO);

        // Assert
        Assert.Contains("background-color: SeaShell", style);
        Assert.Contains("font-weight: bold", style);
    }

    [Fact]
    public void GetOrderNumberCellStyle_PO_ReturnsLightSkyBlueBold()
    {
        // Act
        var style = WAMSColorCodingService.GetOrderNumberCellStyle(OrderType.PO);

        // Assert
        Assert.Contains("background-color: LightSkyBlue", style);
        Assert.Contains("font-weight: bold", style);
    }

    [Fact]
    public void GetDockCellStyle_CheckedIn_ReturnsOrange()
    {
        // Arrange
        var checkInDate = DateTime.Now;

        // Act
        var style = WAMSColorCodingService.GetDockCellStyle(checkInDate);

        // Assert
        Assert.Contains("background-color: Orange", style);
    }

    [Fact]
    public void GetDockCellStyle_NotCheckedIn_ReturnsEmpty()
    {
        // Arrange
        DateTime? checkInDate = null;

        // Act
        var style = WAMSColorCodingService.GetDockCellStyle(checkInDate);

        // Assert
        Assert.Equal("", style);
    }

    #endregion

    #region Badge Styles

    [Fact]
    public void GetStatusBadgeStyle_NA_ReturnsLight()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetStatusBadgeStyle(DockStatus.NA);

        // Assert
        Assert.Equal("Light", badgeStyle);
    }

    [Fact]
    public void GetStatusBadgeStyle_CheckIn_ReturnsWarning()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetStatusBadgeStyle(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Warning", badgeStyle);
    }

    [Fact]
    public void GetStatusBadgeStyle_Loading_ReturnsInfo()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetStatusBadgeStyle(DockStatus.Loading);

        // Assert
        Assert.Equal("Info", badgeStyle);
    }

    [Fact]
    public void GetStatusBadgeStyle_Shipped_ReturnsSuccess()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetStatusBadgeStyle(DockStatus.Shipped);

        // Assert
        Assert.Equal("Success", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_SO_ReturnsInfo()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.SO);

        // Assert
        Assert.Equal("Info", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_PO_ReturnsPrimary()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.PO);

        // Assert
        Assert.Equal("Primary", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_ICT_ReturnsWarning()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.ICT_NYC);

        // Assert
        Assert.Equal("Warning", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_Deleted_ReturnsLight()
    {
        // Act
        var badgeStyle = WAMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.Deleted_SO);

        // Assert
        Assert.Equal("Light", badgeStyle);
    }

    #endregion

    #region Display Names

    [Fact]
    public void GetStatusDisplayName_NA_ReturnsNA()
    {
        // Act
        var displayName = WAMSColorCodingService.GetStatusDisplayName(DockStatus.NA);

        // Assert
        Assert.Equal("N/A", displayName);
    }

    [Fact]
    public void GetStatusDisplayName_CheckIn_ReturnsCheckIn()
    {
        // Act
        var displayName = WAMSColorCodingService.GetStatusDisplayName(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Check In", displayName);
    }

    [Fact]
    public void GetStatusDisplayName_Loading_ReturnsLoading()
    {
        // Act
        var displayName = WAMSColorCodingService.GetStatusDisplayName(DockStatus.Loading);

        // Assert
        Assert.Equal("Loading", displayName);
    }

    [Fact]
    public void GetStatusDisplayName_Shipped_ReturnsShipped()
    {
        // Act
        var displayName = WAMSColorCodingService.GetStatusDisplayName(DockStatus.Shipped);

        // Assert
        Assert.Equal("Shipped", displayName);
    }

    #endregion

    #region Status Parsing

    [Fact]
    public void ParseStatus_NA_ReturnsNA()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus("N/A");

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    [Fact]
    public void ParseStatus_CheckIn_ReturnsCheckIn()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus("Check In");

        // Assert
        Assert.Equal(DockStatus.CheckIn, status);
    }

    [Fact]
    public void ParseStatus_CheckInNoSpace_ReturnsCheckIn()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus("CheckIn");

        // Assert
        Assert.Equal(DockStatus.CheckIn, status);
    }

    [Fact]
    public void ParseStatus_Loading_ReturnsLoading()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus("Loading");

        // Assert
        Assert.Equal(DockStatus.Loading, status);
    }

    [Fact]
    public void ParseStatus_CaseInsensitive_ReturnsCorrect()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus("SHIPPED");

        // Assert
        Assert.Equal(DockStatus.Shipped, status);
    }

    [Fact]
    public void ParseStatus_Null_ReturnsNA()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus(null);

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    [Fact]
    public void ParseStatus_Empty_ReturnsNA()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus("");

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    [Fact]
    public void ParseStatus_Unknown_ReturnsNA()
    {
        // Act
        var status = WAMSColorCodingService.ParseStatus("InvalidStatus");

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    #endregion

    #region Status String Conversion

    [Fact]
    public void ToStatusString_NA_ReturnsNA()
    {
        // Act
        var statusString = WAMSColorCodingService.ToStatusString(DockStatus.NA);

        // Assert
        Assert.Equal("N/A", statusString);
    }

    [Fact]
    public void ToStatusString_CheckIn_ReturnsCheckIn()
    {
        // Act
        var statusString = WAMSColorCodingService.ToStatusString(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Check In", statusString);
    }

    [Fact]
    public void ToStatusString_Shipped_ReturnsShipped()
    {
        // Act
        var statusString = WAMSColorCodingService.ToStatusString(DockStatus.Shipped);

        // Assert
        Assert.Equal("Shipped", statusString);
    }

    [Fact]
    public void ToStatusString_Received_ReturnsReceived()
    {
        // Act
        var statusString = WAMSColorCodingService.ToStatusString(DockStatus.Received);

        // Assert
        Assert.Equal("Received", statusString);
    }

    #endregion
}
