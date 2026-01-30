using AppsYamlGenerator;
using DotNetWebApp.Models.AppDictionary;
using Xunit;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace AppsYamlGenerator.Tests;

public class AppsYamlMergerTests
{
    private readonly AppsYamlMerger _merger = new();
    private readonly IDeserializer _deserializer = new DeserializerBuilder()
        .WithNamingConvention(CamelCaseNamingConvention.Instance)
        .Build();

    [Fact]
    public void MergeApplicationsWithDataModel_WithApplications_ProducesValidYaml()
    {
        // Arrange
        var applications = new List<ApplicationInfo>
        {
            new ApplicationInfo
            {
                Name = "admin",
                Title = "Admin Portal",
                Description = "Admin app",
                Icon = "admin_panel_settings",
                Schema = "acme",
                Entities = new List<string> { "acme:Product", "acme:Category" },
                Views = new List<string>(),
                Theme = new Theme { PrimaryColor = "#007bff", SecondaryColor = "#6c757d", BackgroundColor = "#fff", TextColor = "#000" },
                SpaSections = new SpaSectionConfiguration
                {
                    DashboardNav = "Admin Dashboard",
                    DashboardTitle = "Admin Dashboard Title",
                    SettingsNav = "Admin Settings",
                    SettingsTitle = "Admin Settings Title"
                }
            }
        };

        var dataModel = new DataModel
        {
            Entities = new List<Entity>
            {
                new Entity
                {
                    Name = "Product",
                    Schema = "acme",
                    Properties = new List<Property>
                    {
                        new Property { Name = "Id", Type = "int", IsPrimaryKey = true, IsIdentity = true, IsRequired = true }
                    },
                    Relationships = new List<Relationship>()
                }
            }
        };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel);

        // Assert
        Assert.NotEmpty(yaml);
        Assert.Contains("applications:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("admin", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("dataModel:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Product", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void MergeApplicationsWithDataModel_WithPerAppSpaSections_IncludesInOutput()
    {
        // Arrange
        var applications = new List<ApplicationInfo>
        {
            new ApplicationInfo
            {
                Name = "reporting",
                Title = "Reporting",
                Schema = "acme",
                Entities = new List<string>(),
                Views = new List<string>(),
                Theme = new Theme(),
                SpaSections = new SpaSectionConfiguration
                {
                    DashboardNav = "Reports",
                    DashboardTitle = "Reporting Dashboard",
                    SettingsNav = "Report Settings",
                    SettingsTitle = "Reporting Settings"
                }
            }
        };

        var dataModel = new DataModel { Entities = new List<Entity>() };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel);

        // Assert
        Assert.Contains("spaSections:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Reports", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Reporting Dashboard", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Report Settings", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Reporting Settings", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void MergeApplicationsWithDataModel_MultipleApplications_PreservesAllApplications()
    {
        // Arrange
        var applications = new List<ApplicationInfo>
        {
            new ApplicationInfo { Name = "app1", Title = "App 1", Schema = "schema1", Entities = new(), Views = new(), Theme = new() },
            new ApplicationInfo { Name = "app2", Title = "App 2", Schema = "schema2", Entities = new(), Views = new(), Theme = new() },
            new ApplicationInfo { Name = "app3", Title = "App 3", Schema = "schema3", Entities = new(), Views = new(), Theme = new() }
        };

        var dataModel = new DataModel { Entities = new List<Entity>() };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel);
        var deserialized = _deserializer.Deserialize<AppDefinition>(yaml);

        // Assert
        Assert.Equal(3, deserialized.Applications.Count);
        Assert.Contains(deserialized.Applications, a => a.Name == "app1");
        Assert.Contains(deserialized.Applications, a => a.Name == "app2");
        Assert.Contains(deserialized.Applications, a => a.Name == "app3");
    }

    [Fact]
    public void MergeApplicationsWithDataModel_EmptyApplicationsList_ProducesValidYaml()
    {
        // Arrange
        var applications = new List<ApplicationInfo>();
        var dataModel = new DataModel
        {
            Entities = new List<Entity>
            {
                new Entity
                {
                    Name = "TestEntity",
                    Schema = "dbo",
                    Properties = new List<Property>(),
                    Relationships = new List<Relationship>()
                }
            }
        };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel);
        var deserialized = _deserializer.Deserialize<AppDefinition>(yaml);

        // Assert
        Assert.NotNull(deserialized);
        Assert.Empty(deserialized.Applications);
        Assert.NotEmpty(deserialized.DataModel.Entities);
        Assert.Single(deserialized.DataModel.Entities);
    }

    [Fact]
    public void MergeApplicationsWithDataModel_WithViews_PreservesViewsSection()
    {
        // Arrange
        var applications = new List<ApplicationInfo>();
        var dataModel = new DataModel { Entities = new List<Entity>() };
        var views = new ViewsDefinition
        {
            Views = new List<ViewDefinition>
            {
                new ViewDefinition { Name = "ProductSalesView", SqlFile = "sql/views/ProductSalesView.sql" }
            }
        };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel, views);

        // Assert
        Assert.Contains("views:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("ProductSalesView", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void MergeApplicationsWithDataModel_OutputIsDeserializable()
    {
        // Arrange
        var applications = new List<ApplicationInfo>
        {
            new ApplicationInfo
            {
                Name = "test",
                Title = "Test",
                Schema = "dbo",
                Entities = new List<string> { "dbo:TestEntity" },
                Views = new List<string>(),
                Theme = new Theme
                {
                    PrimaryColor = "#007bff",
                    SecondaryColor = "#6c757d",
                    BackgroundColor = "#ffffff",
                    TextColor = "#212529"
                }
            }
        };

        var dataModel = new DataModel
        {
            Entities = new List<Entity>
            {
                new Entity
                {
                    Name = "TestEntity",
                    Schema = "dbo",
                    Properties = new List<Property>
                    {
                        new Property { Name = "Id", Type = "int", IsPrimaryKey = true, IsIdentity = true, IsRequired = true }
                    },
                    Relationships = new List<Relationship>()
                }
            }
        };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel);
        var deserialized = _deserializer.Deserialize<AppDefinition>(yaml);

        // Assert
        Assert.NotNull(deserialized);
        Assert.NotNull(deserialized.Applications);
        Assert.NotNull(deserialized.DataModel);
        Assert.Single(deserialized.Applications);
        Assert.Single(deserialized.DataModel.Entities);
        Assert.Equal("test", deserialized.Applications[0].Name);
        Assert.Equal("TestEntity", deserialized.DataModel.Entities[0].Name);
    }

    [Fact]
    public void MergeApplicationsWithDataModel_ApplicationWithoutSpaSections_CreatesNullProperty()
    {
        // Arrange
        var applications = new List<ApplicationInfo>
        {
            new ApplicationInfo
            {
                Name = "minimal",
                Title = "Minimal App",
                Schema = "dbo",
                Entities = new List<string>(),
                Views = new List<string>(),
                Theme = new Theme(),
                SpaSections = null  // No SpaSections defined
            }
        };

        var dataModel = new DataModel { Entities = new List<Entity>() };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel);
        var deserialized = _deserializer.Deserialize<AppDefinition>(yaml);

        // Assert
        Assert.NotNull(deserialized);
        Assert.Single(deserialized.Applications);
        // SpaSections can be null for backward compatibility
        var app = deserialized.Applications[0];
        Assert.Null(app.SpaSections);
    }

    [Fact]
    public void MergeApplicationsWithDataModel_CamelCaseSerializationVerified()
    {
        // Arrange
        var applications = new List<ApplicationInfo>
        {
            new ApplicationInfo
            {
                Name = "test",
                Title = "Test",
                Schema = "dbo",
                Entities = new List<string>(),
                Views = new List<string>(),
                Theme = new Theme
                {
                    PrimaryColor = "#007bff",
                    SecondaryColor = "#6c757d",
                    BackgroundColor = "#fff",
                    TextColor = "#000"
                },
                SpaSections = new SpaSectionConfiguration
                {
                    DashboardNav = "Dashboard",
                    DashboardTitle = "Dashboard Title",
                    SettingsNav = "Settings",
                    SettingsTitle = "Settings Title"
                }
            }
        };

        var dataModel = new DataModel { Entities = new List<Entity>() };

        // Act
        var yaml = _merger.MergeApplicationsWithDataModel(applications, dataModel);

        // Assert
        // Verify camelCase naming convention in output
        Assert.Contains("primaryColor:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("secondaryColor:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("backgroundColor:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("textColor:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("dashboardNav:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("dashboardTitle:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("settingsNav:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("settingsTitle:", yaml, StringComparison.OrdinalIgnoreCase);
    }
}
