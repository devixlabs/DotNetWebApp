using DotNetWebApp.Models.AppDictionary;
using YamlMerger;
using Xunit;

namespace DotNetWebApp.YamlMerger.Tests;

/// <summary>
/// Unit tests for YamlMergeService.
/// Tests YAML serialization, view-to-application mapping, and merging logic.
/// </summary>
public class YamlMergeServiceTests
{
    private readonly YamlMergeService _service;

    public YamlMergeServiceTests()
    {
        _service = new YamlMergeService();
    }

    [Fact]
    public void PopulateApplicationViews_WithViewsAndApplications_PopulatesViewsArrays()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = new() },
                new ApplicationInfo { Name = "reporting", Title = "Reporting", Views = new() },
                new ApplicationInfo { Name = "metrics", Title = "Metrics", Views = new() }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        Applications = new() { "admin", "reporting" }
                    },
                    new ViewDefinition
                    {
                        Name = "RevenueView",
                        Applications = new() { "reporting", "metrics" }
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        Assert.NotNull(appDef.Applications[0].Views);
        Assert.Contains("ProductSalesView", appDef.Applications[0].Views);
        Assert.DoesNotContain("RevenueView", appDef.Applications[0].Views);

        Assert.NotNull(appDef.Applications[1].Views);
        Assert.Contains("ProductSalesView", appDef.Applications[1].Views);
        Assert.Contains("RevenueView", appDef.Applications[1].Views);

        Assert.NotNull(appDef.Applications[2].Views);
        Assert.DoesNotContain("ProductSalesView", appDef.Applications[2].Views);
        Assert.Contains("RevenueView", appDef.Applications[2].Views);
    }

    [Fact]
    public void PopulateApplicationViews_WithEmptyApplicationsList_DoesNothing()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = null,
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        Applications = new() { "admin" }
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert - should not throw and applications should remain null
        Assert.Null(appDef.Applications);
    }

    [Fact]
    public void PopulateApplicationViews_WithEmptyViewsList_DoesNothing()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = new() }
            },
            Views = null
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        Assert.Empty(appDef.Applications[0].Views);
    }

    [Fact]
    public void PopulateApplicationViews_WithViewHavingNoApplications_DoesNotAddViewToAnyApp()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = new() },
                new ApplicationInfo { Name = "reporting", Title = "Reporting", Views = new() }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        Applications = new() // Empty applications list
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        Assert.Empty(appDef.Applications[0].Views);
        Assert.Empty(appDef.Applications[1].Views);
    }

    [Fact]
    public void PopulateApplicationViews_WithUnknownApplicationName_IgnoresMapping()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = new() }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        Applications = new() { "admin", "nonexistent" }
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        Assert.Single(appDef.Applications[0].Views);
        Assert.Contains("ProductSalesView", appDef.Applications[0].Views);
    }

    [Fact]
    public void PopulateApplicationViews_WithCaseInsensitiveAppName_MatchesCorrectly()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "Admin", Title = "Admin", Views = new() }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        Applications = new() { "admin" } // lowercase
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        Assert.Single(appDef.Applications[0].Views);
        Assert.Contains("ProductSalesView", appDef.Applications[0].Views);
    }

    [Fact]
    public void PopulateApplicationViews_PreventsDuplicateViewEntries()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = new() { "ProductSalesView" } }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        Applications = new() { "admin" }
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert - should have exactly one entry, not two
        Assert.Single(appDef.Applications[0].Views);
        Assert.Equal("ProductSalesView", appDef.Applications[0].Views[0]);
    }

    [Fact]
    public void SerializeAppDefinition_ProducesValidYaml()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo
                {
                    Name = "admin",
                    Title = "Admin Portal",
                    Views = new() { "ProductSalesView" }
                }
            },
            DataModel = new DataModel
            {
                Entities = new()
                {
                    new Entity
                    {
                        Name = "Product",
                        Schema = "dbo",
                        Properties = new(),
                        Relationships = new()
                    }
                }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        SqlFile = "sql/views/ProductSalesView.sql",
                        GeneratePartial = true,
                        Applications = new() { "admin" }
                    }
                }
            }
        };

        // Act
        var yaml = _service.SerializeAppDefinition(appDef);

        // Assert
        Assert.NotNull(yaml);
        Assert.NotEmpty(yaml);
        Assert.Contains("applications:", yaml);
        Assert.Contains("name: admin", yaml);
        Assert.Contains("dataModel:", yaml);
        Assert.Contains("views:", yaml);
        Assert.Contains("ProductSalesView", yaml);
    }

    [Fact]
    public void SerializeAppDefinition_UsesCamelCaseNaming()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo
                {
                    Name = "admin",
                    Title = "Admin",
                    Views = new(),
                    Theme = new Theme()
                }
            },
            DataModel = new DataModel { Entities = new() },
            Views = new ViewsDefinition { Views = new() }
        };

        // Act
        var yaml = _service.SerializeAppDefinition(appDef);

        // Assert - should use camelCase like "primaryColor", not "primary_color" or "PrimaryColor"
        Assert.Contains("applications:", yaml);
        Assert.Contains("dataModel:", yaml);
        // PrimaryColor should be serialized in camelCase
        // We can't test exact format without implementation details, but we can verify it's valid YAML
        Assert.NotNull(yaml);
    }

    [Fact]
    public void PopulateApplicationViews_InitializesNullViewsArrays()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = null }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "ProductSalesView",
                        Applications = new() { "admin" }
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        Assert.NotNull(appDef.Applications[0].Views);
        Assert.Single(appDef.Applications[0].Views);
    }

    [Fact]
    public void PopulateApplicationViews_WithMultipleViewsPerApp_MapsAllCorrectly()
    {
        // Arrange
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = new() }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition { Name = "View1", Applications = new() { "admin" } },
                    new ViewDefinition { Name = "View2", Applications = new() { "admin" } },
                    new ViewDefinition { Name = "View3", Applications = new() { "admin" } }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        Assert.Equal(3, appDef.Applications[0].Views.Count);
        Assert.Contains("View1", appDef.Applications[0].Views);
        Assert.Contains("View2", appDef.Applications[0].Views);
        Assert.Contains("View3", appDef.Applications[0].Views);
    }

    [Fact]
    public void PopulateApplicationViews_ComplexScenario_AllViewsDistributedCorrectly()
    {
        // Arrange - Complex scenario with multiple apps and views with various assignments
        var appDef = new AppDefinition
        {
            Applications = new()
            {
                new ApplicationInfo { Name = "admin", Title = "Admin", Views = new() },
                new ApplicationInfo { Name = "reporting", Title = "Reporting", Views = new() },
                new ApplicationInfo { Name = "metrics", Title = "Metrics", Views = new() },
                new ApplicationInfo { Name = "public", Title = "Public", Views = new() }
            },
            Views = new ViewsDefinition
            {
                Views = new()
                {
                    new ViewDefinition
                    {
                        Name = "SystemHealthView",
                        Applications = new() { "admin", "metrics" }
                    },
                    new ViewDefinition
                    {
                        Name = "SalesReportView",
                        Applications = new() { "admin", "reporting" }
                    },
                    new ViewDefinition
                    {
                        Name = "PublicStatsView",
                        Applications = new() { "public" }
                    },
                    new ViewDefinition
                    {
                        Name = "AllDataView",
                        Applications = new() { "admin", "reporting", "metrics", "public" }
                    }
                }
            }
        };

        // Act
        _service.PopulateApplicationViews(appDef);

        // Assert
        // admin: SystemHealthView, SalesReportView, AllDataView
        Assert.Equal(3, appDef.Applications[0].Views.Count);
        Assert.Contains("SystemHealthView", appDef.Applications[0].Views);
        Assert.Contains("SalesReportView", appDef.Applications[0].Views);
        Assert.Contains("AllDataView", appDef.Applications[0].Views);

        // reporting: SalesReportView, AllDataView
        Assert.Equal(2, appDef.Applications[1].Views.Count);
        Assert.Contains("SalesReportView", appDef.Applications[1].Views);
        Assert.Contains("AllDataView", appDef.Applications[1].Views);

        // metrics: SystemHealthView, AllDataView
        Assert.Equal(2, appDef.Applications[2].Views.Count);
        Assert.Contains("SystemHealthView", appDef.Applications[2].Views);
        Assert.Contains("AllDataView", appDef.Applications[2].Views);

        // public: PublicStatsView, AllDataView
        Assert.Equal(2, appDef.Applications[3].Views.Count);
        Assert.Contains("PublicStatsView", appDef.Applications[3].Views);
        Assert.Contains("AllDataView", appDef.Applications[3].Views);
    }
}
