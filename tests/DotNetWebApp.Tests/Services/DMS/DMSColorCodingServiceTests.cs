using DotNetWebApp.Services.DMS;
using DotNetWebApp.Services.DMS.Models;
using Xunit;

namespace DotNetWebApp.Tests.Services.DMS;

public class DMSColorCodingServiceTests
{
    #region Order Type Colors

    [Fact]
    public void GetOrderTypeColor_SO_ReturnsSeaShell()
    {
        // Act
        var color = DMSColorCodingService.GetOrderTypeColor(OrderType.SO);

        // Assert
        Assert.Equal("SeaShell", color);
    }

    [Fact]
    public void GetOrderTypeColor_PO_ReturnsLightSkyBlue()
    {
        // Act
        var color = DMSColorCodingService.GetOrderTypeColor(OrderType.PO);

        // Assert
        Assert.Equal("LightSkyBlue", color);
    }

    [Fact]
    public void GetOrderTypeColor_ICT_NL_ReturnsLightSalmon()
    {
        // Act
        var color = DMSColorCodingService.GetOrderTypeColor(OrderType.ICT_NL);

        // Assert
        Assert.Equal("LightSalmon", color);
    }

    [Fact]
    public void GetOrderTypeColor_ICT_CPFG_ReturnsLightSlateGray()
    {
        // Act
        var color = DMSColorCodingService.GetOrderTypeColor(OrderType.ICT_CPFG);

        // Assert
        Assert.Equal("LightSlateGray", color);
    }

    [Fact]
    public void GetOrderTypeColor_DeletedSO_ReturnsLightGray()
    {
        // Act
        var color = DMSColorCodingService.GetOrderTypeColor(OrderType.Deleted_SO);

        // Assert
        Assert.Equal("LightGray", color);
    }

    [Fact]
    public void GetOrderTypeColor_DeletedPO_ReturnsLightGray()
    {
        // Act
        var color = DMSColorCodingService.GetOrderTypeColor(OrderType.Deleted_PO);

        // Assert
        Assert.Equal("LightGray", color);
    }

    #endregion

    #region Status Colors

    [Fact]
    public void GetStatusColor_NA_ReturnsWhite()
    {
        // Act
        var color = DMSColorCodingService.GetStatusColor(DockStatus.NA);

        // Assert
        Assert.Equal("White", color);
    }

    [Fact]
    public void GetStatusColor_CheckIn_ReturnsOrange()
    {
        // Act
        var color = DMSColorCodingService.GetStatusColor(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Orange", color);
    }

    [Fact]
    public void GetStatusColor_Loading_ReturnsYellow()
    {
        // Act
        var color = DMSColorCodingService.GetStatusColor(DockStatus.Loading);

        // Assert
        Assert.Equal("Yellow", color);
    }

    [Fact]
    public void GetStatusColor_Unloading_ReturnsLemonChiffon()
    {
        // Act
        var color = DMSColorCodingService.GetStatusColor(DockStatus.Unloading);

        // Assert
        Assert.Equal("LemonChiffon", color);
    }

    [Fact]
    public void GetStatusColor_Shipped_ReturnsPaleGreen()
    {
        // Act
        var color = DMSColorCodingService.GetStatusColor(DockStatus.Shipped);

        // Assert
        Assert.Equal("PaleGreen", color);
    }

    [Fact]
    public void GetStatusColor_Received_ReturnsMediumAquamarine()
    {
        // Act
        var color = DMSColorCodingService.GetStatusColor(DockStatus.Received);

        // Assert
        Assert.Equal("MediumAquamarine", color);
    }

    #endregion

    #region Row and Cell Styles

    [Fact]
    public void GetRowStyle_StatusNA_ReturnsWhiteBackground()
    {
        // Arrange
        var order = new DMSOrder { StatusEnum = DockStatus.NA };

        // Act
        var style = DMSColorCodingService.GetRowStyle(order);

        // Assert
        Assert.Contains("background-color: White", style);
    }

    [Fact]
    public void GetRowStyle_StatusCheckIn_ReturnsOrangeBackground()
    {
        // Arrange
        var order = new DMSOrder { StatusEnum = DockStatus.CheckIn };

        // Act
        var style = DMSColorCodingService.GetRowStyle(order);

        // Assert
        Assert.Contains("background-color: Orange", style);
    }

    [Fact]
    public void GetRowStyle_StatusShipped_ReturnsPaleGreenBackground()
    {
        // Arrange
        var order = new DMSOrder { StatusEnum = DockStatus.Shipped };

        // Act
        var style = DMSColorCodingService.GetRowStyle(order);

        // Assert
        Assert.Contains("background-color: PaleGreen", style);
    }

    [Fact]
    public void GetOrderNumberCellStyle_SO_ReturnsSeaShellBold()
    {
        // Act
        var style = DMSColorCodingService.GetOrderNumberCellStyle(OrderType.SO);

        // Assert
        Assert.Contains("background-color: SeaShell", style);
        Assert.Contains("font-weight: bold", style);
    }

    [Fact]
    public void GetOrderNumberCellStyle_PO_ReturnsLightSkyBlueBold()
    {
        // Act
        var style = DMSColorCodingService.GetOrderNumberCellStyle(OrderType.PO);

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
        var style = DMSColorCodingService.GetDockCellStyle(checkInDate);

        // Assert
        Assert.Contains("background-color: Orange", style);
    }

    [Fact]
    public void GetDockCellStyle_NotCheckedIn_ReturnsEmpty()
    {
        // Arrange
        DateTime? checkInDate = null;

        // Act
        var style = DMSColorCodingService.GetDockCellStyle(checkInDate);

        // Assert
        Assert.Equal("", style);
    }

    #endregion

    #region Badge Styles

    [Fact]
    public void GetStatusBadgeStyle_NA_ReturnsLight()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetStatusBadgeStyle(DockStatus.NA);

        // Assert
        Assert.Equal("Light", badgeStyle);
    }

    [Fact]
    public void GetStatusBadgeStyle_CheckIn_ReturnsWarning()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetStatusBadgeStyle(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Warning", badgeStyle);
    }

    [Fact]
    public void GetStatusBadgeStyle_Loading_ReturnsInfo()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetStatusBadgeStyle(DockStatus.Loading);

        // Assert
        Assert.Equal("Info", badgeStyle);
    }

    [Fact]
    public void GetStatusBadgeStyle_Shipped_ReturnsSuccess()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetStatusBadgeStyle(DockStatus.Shipped);

        // Assert
        Assert.Equal("Success", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_SO_ReturnsInfo()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.SO);

        // Assert
        Assert.Equal("Info", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_PO_ReturnsPrimary()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.PO);

        // Assert
        Assert.Equal("Primary", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_ICT_ReturnsWarning()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.ICT_NL);

        // Assert
        Assert.Equal("Warning", badgeStyle);
    }

    [Fact]
    public void GetOrderTypeBadgeStyle_Deleted_ReturnsLight()
    {
        // Act
        var badgeStyle = DMSColorCodingService.GetOrderTypeBadgeStyle(OrderType.Deleted_SO);

        // Assert
        Assert.Equal("Light", badgeStyle);
    }

    #endregion

    #region Display Names

    [Fact]
    public void GetStatusDisplayName_NA_ReturnsNA()
    {
        // Act
        var displayName = DMSColorCodingService.GetStatusDisplayName(DockStatus.NA);

        // Assert
        Assert.Equal("N/A", displayName);
    }

    [Fact]
    public void GetStatusDisplayName_CheckIn_ReturnsCheckIn()
    {
        // Act
        var displayName = DMSColorCodingService.GetStatusDisplayName(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Check In", displayName);
    }

    [Fact]
    public void GetStatusDisplayName_Loading_ReturnsLoading()
    {
        // Act
        var displayName = DMSColorCodingService.GetStatusDisplayName(DockStatus.Loading);

        // Assert
        Assert.Equal("Loading", displayName);
    }

    [Fact]
    public void GetStatusDisplayName_Shipped_ReturnsShipped()
    {
        // Act
        var displayName = DMSColorCodingService.GetStatusDisplayName(DockStatus.Shipped);

        // Assert
        Assert.Equal("Shipped", displayName);
    }

    #endregion

    #region Status Parsing

    [Fact]
    public void ParseStatus_NA_ReturnsNA()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus("N/A");

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    [Fact]
    public void ParseStatus_CheckIn_ReturnsCheckIn()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus("Check In");

        // Assert
        Assert.Equal(DockStatus.CheckIn, status);
    }

    [Fact]
    public void ParseStatus_CheckInNoSpace_ReturnsCheckIn()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus("CheckIn");

        // Assert
        Assert.Equal(DockStatus.CheckIn, status);
    }

    [Fact]
    public void ParseStatus_Loading_ReturnsLoading()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus("Loading");

        // Assert
        Assert.Equal(DockStatus.Loading, status);
    }

    [Fact]
    public void ParseStatus_CaseInsensitive_ReturnsCorrect()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus("SHIPPED");

        // Assert
        Assert.Equal(DockStatus.Shipped, status);
    }

    [Fact]
    public void ParseStatus_Null_ReturnsNA()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus(null);

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    [Fact]
    public void ParseStatus_Empty_ReturnsNA()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus("");

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    [Fact]
    public void ParseStatus_Unknown_ReturnsNA()
    {
        // Act
        var status = DMSColorCodingService.ParseStatus("InvalidStatus");

        // Assert
        Assert.Equal(DockStatus.NA, status);
    }

    #endregion

    #region Status String Conversion

    [Fact]
    public void ToStatusString_NA_ReturnsNA()
    {
        // Act
        var statusString = DMSColorCodingService.ToStatusString(DockStatus.NA);

        // Assert
        Assert.Equal("N/A", statusString);
    }

    [Fact]
    public void ToStatusString_CheckIn_ReturnsCheckIn()
    {
        // Act
        var statusString = DMSColorCodingService.ToStatusString(DockStatus.CheckIn);

        // Assert
        Assert.Equal("Check In", statusString);
    }

    [Fact]
    public void ToStatusString_Shipped_ReturnsShipped()
    {
        // Act
        var statusString = DMSColorCodingService.ToStatusString(DockStatus.Shipped);

        // Assert
        Assert.Equal("Shipped", statusString);
    }

    [Fact]
    public void ToStatusString_Received_ReturnsReceived()
    {
        // Act
        var statusString = DMSColorCodingService.ToStatusString(DockStatus.Received);

        // Assert
        Assert.Equal("Received", statusString);
    }

    #endregion
}
