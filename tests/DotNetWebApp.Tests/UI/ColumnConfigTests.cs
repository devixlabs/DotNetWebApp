using DotNetWebApp.Models.UI;
using Xunit;

namespace DotNetWebApp.Tests.UI;

/// <summary>
/// Tests for ColumnConfig model - validates configuration for data grid columns
/// </summary>
public class ColumnConfigTests
{
    [Fact]
    public void Constructor_SetsDefaultValues()
    {
        // Arrange & Act
        var config = new ColumnConfig();

        // Assert
        Assert.NotNull(config.Property);
        Assert.Equal(string.Empty, config.Property);
        Assert.NotNull(config.DisplayName);
        Assert.Equal(string.Empty, config.DisplayName);
        Assert.True(config.Sortable);
        Assert.True(config.Filterable);
        Assert.False(config.Editable);
        Assert.False(config.Hidden);
        Assert.Null(config.FormatString);
        Assert.Null(config.Width);
    }

    [Fact]
    public void ColumnConfig_AllPropertiesCanBeSet()
    {
        // Arrange
        var config = new ColumnConfig();

        // Act
        config.Property = "ProductName";
        config.DisplayName = "Product Name";
        config.Sortable = true;
        config.Filterable = false;
        config.Editable = true;
        config.Hidden = false;
        config.FormatString = "{0:C2}";
        config.Width = 150;

        // Assert
        Assert.Equal("ProductName", config.Property);
        Assert.Equal("Product Name", config.DisplayName);
        Assert.True(config.Sortable);
        Assert.False(config.Filterable);
        Assert.True(config.Editable);
        Assert.False(config.Hidden);
        Assert.Equal("{0:C2}", config.FormatString);
        Assert.Equal(150, config.Width);
    }

    [Fact]
    public void ColumnConfig_SupportsPropertyInitializer()
    {
        // Arrange & Act
        var config = new ColumnConfig
        {
            Property = "Price",
            DisplayName = "Unit Price",
            Sortable = true,
            Filterable = false,
            Editable = true,
            Hidden = false,
            FormatString = "{0:C}",
            Width = 120
        };

        // Assert
        Assert.Equal("Price", config.Property);
        Assert.Equal("Unit Price", config.DisplayName);
        Assert.Equal("{0:C}", config.FormatString);
        Assert.Equal(120, config.Width);
    }

    [Fact]
    public void ColumnConfig_WithHidden_IsNotVisible()
    {
        // Arrange
        var config = new ColumnConfig { Property = "Id", Hidden = true };

        // Act & Assert
        Assert.True(config.Hidden);
        Assert.Equal("Id", config.Property);
    }

    [Fact]
    public void ColumnConfig_WithEditable_AllowsUserInput()
    {
        // Arrange
        var config = new ColumnConfig { Property = "Name", Editable = true };

        // Act & Assert
        Assert.True(config.Editable);
    }

    [Fact]
    public void ColumnConfig_WithFormatString_SupportsNumberFormatting()
    {
        // Arrange
        var config = new ColumnConfig
        {
            Property = "Amount",
            FormatString = "{0:N2}"
        };

        // Act & Assert
        Assert.Equal("{0:N2}", config.FormatString);
    }

    [Fact]
    public void ColumnConfig_CreateFromReflection_DefaultBehavior()
    {
        // Arrange - simulate reflection-based creation
        var configs = new[]
        {
            new ColumnConfig
            {
                Property = "Id",
                DisplayName = "ID",
                Sortable = true,
                Filterable = false,
                Editable = false,
                Hidden = false
            },
            new ColumnConfig
            {
                Property = "Name",
                DisplayName = "Name",
                Sortable = true,
                Filterable = true,
                Editable = true,
                Hidden = false
            }
        };

        // Act & Assert
        Assert.Equal(2, configs.Length);
        Assert.False(configs[0].Editable);
        Assert.True(configs[1].Editable);
    }
}
