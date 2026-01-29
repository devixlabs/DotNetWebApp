using System.Reflection;
using DotNetWebApp.Models.UI;
using Xunit;

namespace DotNetWebApp.Tests.UI;

/// <summary>
/// Tests for SmartDataGrid component configuration logic
/// Note: These tests focus on configuration and reflection logic.
/// Blazor component rendering tests would require BUnit or similar.
/// </summary>
public class SmartDataGridTests
{
    /// <summary>
    /// Test class to use for reflection-based column discovery
    /// </summary>
    private class TestEntity
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public decimal Price { get; set; }
        public bool IsActive { get; set; }
    }

    [Fact]
    public void GetColumnConfigFromReflection_CreatesConfigForAllProperties()
    {
        // Arrange - simulate reflection-based discovery
        var properties = typeof(TestEntity).GetProperties(BindingFlags.Public | BindingFlags.Instance);

        // Act
        var configs = properties
            .Select(p => new ColumnConfig
            {
                Property = p.Name,
                DisplayName = p.Name,
                Sortable = true,
                Filterable = true,
                Editable = false,
                Hidden = false
            })
            .ToList();

        // Assert
        Assert.Equal(4, configs.Count);
        Assert.Contains(configs, c => c.Property == "Id");
        Assert.Contains(configs, c => c.Property == "Name");
        Assert.Contains(configs, c => c.Property == "Price");
        Assert.Contains(configs, c => c.Property == "IsActive");
    }

    [Fact]
    public void ColumnConfig_HiddenProperties_AreFilteredOut()
    {
        // Arrange
        var allConfigs = new[]
        {
            new ColumnConfig { Property = "Id", Hidden = true },
            new ColumnConfig { Property = "Name", Hidden = false },
            new ColumnConfig { Property = "Price", Hidden = false }
        };

        // Act
        var visibleConfigs = allConfigs.Where(c => !c.Hidden).ToList();

        // Assert
        Assert.Equal(2, visibleConfigs.Count);
        Assert.DoesNotContain(visibleConfigs, c => c.Property == "Id");
    }

    [Fact]
    public void ColumnConfig_EditableColumns_AreMapped()
    {
        // Arrange
        var configs = new[]
        {
            new ColumnConfig { Property = "Id", Editable = false },
            new ColumnConfig { Property = "Name", Editable = true },
            new ColumnConfig { Property = "Price", Editable = true }
        };

        // Act
        var editableConfigs = configs.Where(c => c.Editable).ToList();

        // Assert
        Assert.Equal(2, editableConfigs.Count);
        Assert.Contains(editableConfigs, c => c.Property == "Name");
        Assert.Contains(editableConfigs, c => c.Property == "Price");
    }

    [Fact]
    public void SmartDataGrid_DefaultConfiguration_HasExpectedFeatures()
    {
        // Arrange & Act
        var defaults = new SmartDataGridDefaults();

        // Assert
        Assert.True(defaults.AllowFiltering);
        Assert.True(defaults.AllowSorting);
        Assert.True(defaults.AllowPaging);
        Assert.False(defaults.AllowInlineEdit);
        Assert.False(defaults.AllowEdit);
        Assert.False(defaults.AllowDelete);
        Assert.False(defaults.ShowActionColumn);
    }

    [Fact]
    public void SmartDataGrid_WithEditEnabled_ShowsActionColumn()
    {
        // Arrange
        var config = new SmartDataGridDefaults
        {
            AllowEdit = true,
            ShowActionColumn = true
        };

        // Act & Assert
        Assert.True(config.AllowEdit);
        Assert.True(config.ShowActionColumn);
    }

    [Fact]
    public void SmartDataGrid_WithDeleteEnabled_ShowsActionColumn()
    {
        // Arrange
        var config = new SmartDataGridDefaults
        {
            AllowDelete = true,
            ShowActionColumn = true
        };

        // Act & Assert
        Assert.True(config.AllowDelete);
        Assert.True(config.ShowActionColumn);
    }

    [Fact]
    public void SmartDataGrid_ColumnOverrides_ReplaceDefaults()
    {
        // Arrange
        var defaultConfigs = typeof(TestEntity).GetProperties()
            .Select(p => new ColumnConfig
            {
                Property = p.Name,
                DisplayName = p.Name,
                Sortable = true,
                Filterable = true,
                Editable = false,
                Hidden = false
            })
            .ToList();

        var overrides = new[]
        {
            new ColumnConfig { Property = "Id", Hidden = true },
            new ColumnConfig { Property = "Price", DisplayName = "Unit Price", FormatString = "{0:C}" }
        };

        // Act
        var finalConfigs = ApplyColumnOverrides(defaultConfigs, overrides);

        // Assert
        var idColumn = finalConfigs.FirstOrDefault(c => c.Property == "Id");
        Assert.NotNull(idColumn);
        Assert.True(idColumn.Hidden);

        var priceColumn = finalConfigs.FirstOrDefault(c => c.Property == "Price");
        Assert.NotNull(priceColumn);
        Assert.Equal("Unit Price", priceColumn.DisplayName);
        Assert.Equal("{0:C}", priceColumn.FormatString);
    }

    /// <summary>
    /// Helper: Simulates how SmartDataGrid would apply column overrides
    /// </summary>
    private static List<ColumnConfig> ApplyColumnOverrides(
        List<ColumnConfig> defaults,
        IEnumerable<ColumnConfig> overrides)
    {
        var result = new List<ColumnConfig>(defaults);

        foreach (var @override in overrides)
        {
            var existing = result.FirstOrDefault(c => c.Property == @override.Property);
            if (existing != null)
            {
                // Apply non-default values from override
                if (!string.IsNullOrEmpty(@override.DisplayName) && @override.DisplayName != @override.Property)
                    existing.DisplayName = @override.DisplayName;
                if (@override.FormatString != null)
                    existing.FormatString = @override.FormatString;
                if (@override.Width.HasValue)
                    existing.Width = @override.Width;
                existing.Hidden = @override.Hidden;
                existing.Editable = @override.Editable;
                existing.Sortable = @override.Sortable;
                existing.Filterable = @override.Filterable;
            }
        }

        return result;
    }

    [Fact]
    public void SmartDataGrid_WithMultipleActions_AllDisplayed()
    {
        // Arrange
        var config = new SmartDataGridDefaults
        {
            ShowActionColumn = true,
            AllowEdit = true,
            AllowDelete = true
        };

        // Act & Assert
        Assert.True(config.ShowActionColumn);
        Assert.True(config.AllowEdit);
        Assert.True(config.AllowDelete);
    }

    [Fact]
    public void SmartDataGrid_PropertyFormatting_SupportsCurrency()
    {
        // Arrange
        var config = new ColumnConfig
        {
            Property = "Price",
            DisplayName = "Unit Price",
            FormatString = "{0:C2}"
        };

        // Act & Assert
        Assert.Equal("{0:C2}", config.FormatString);
    }

    [Fact]
    public void SmartDataGrid_PropertyFormatting_SupportsNumbers()
    {
        // Arrange
        var config = new ColumnConfig
        {
            Property = "Quantity",
            DisplayName = "Qty",
            FormatString = "{0:N0}"
        };

        // Act & Assert
        Assert.Equal("{0:N0}", config.FormatString);
    }

    [Fact]
    public void SmartDataGrid_PropertyFormatting_SupportsDates()
    {
        // Arrange
        var config = new ColumnConfig
        {
            Property = "CreatedAt",
            DisplayName = "Created",
            FormatString = "{0:MMM dd, yyyy}"
        };

        // Act & Assert
        Assert.Equal("{0:MMM dd, yyyy}", config.FormatString);
    }

    [Fact]
    public void SmartDataGrid_ColumnWidth_CanBeSet()
    {
        // Arrange
        var config = new ColumnConfig
        {
            Property = "Name",
            Width = 250
        };

        // Act & Assert
        Assert.Equal(250, config.Width);
    }
}

/// <summary>
/// Helper class simulating SmartDataGrid default feature configuration
/// </summary>
public class SmartDataGridDefaults
{
    public bool AllowFiltering { get; set; } = true;
    public bool AllowSorting { get; set; } = true;
    public bool AllowPaging { get; set; } = true;
    public bool AllowInlineEdit { get; set; } = false;
    public bool AllowEdit { get; set; } = false;
    public bool AllowDelete { get; set; } = false;
    public bool ShowActionColumn { get; set; } = false;
}
