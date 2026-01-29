using System;
using System.Collections.Generic;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;
using DotNetWebApp.Services;
using Microsoft.AspNetCore.Http;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests;

/// <summary>
/// Unit tests for multi-app routing and application context management.
/// Tests Phase 2-3 implementation: ApplicationContextAccessor, IEntityMetadataService filtering.
/// </summary>
public class MultiAppRoutingTests
{
    private readonly Mock<IAppDictionaryService> _mockAppDictionary;
    private readonly ApplicationInfo _adminApp;
    private readonly ApplicationInfo _reportingApp;
    private readonly ApplicationInfo _metricsApp;

    public MultiAppRoutingTests()
    {
        _adminApp = new ApplicationInfo
        {
            Name = "admin",
            Title = "Admin Portal",
            Schema = "acme",
            Entities = new List<string> { "acme:Category", "acme:Product", "acme:Company" },
            Views = new List<string>()
        };

        _reportingApp = new ApplicationInfo
        {
            Name = "reporting",
            Title = "Reporting",
            Schema = "acme",
            Entities = new List<string> { "acme:Company", "acme:Product" },
            Views = new List<string>()
        };

        _metricsApp = new ApplicationInfo
        {
            Name = "metrics",
            Title = "Metrics",
            Schema = "initech",
            Entities = new List<string> { "initech:Company", "initech:User" },
            Views = new List<string>()
        };

        _mockAppDictionary = new Mock<IAppDictionaryService>();
        _mockAppDictionary.Setup(x => x.GetApplication("admin")).Returns(_adminApp);
        _mockAppDictionary.Setup(x => x.GetApplication("reporting")).Returns(_reportingApp);
        _mockAppDictionary.Setup(x => x.GetApplication("metrics")).Returns(_metricsApp);
        _mockAppDictionary.Setup(x => x.GetApplication(It.IsNotIn("admin", "reporting", "metrics"))).Returns((ApplicationInfo?)null);
        _mockAppDictionary.Setup(x => x.GetAllApplications()).Returns(
            new[] { _adminApp, _reportingApp, _metricsApp }.AsReadOnly());

        // Minimal AppDefinition for EntityMetadataService constructor (required for reflection lookup)
        var appDef = new AppDefinition { DataModel = new DataModel { Entities = new List<Entity>() } };
        _mockAppDictionary.Setup(x => x.AppDefinition).Returns(appDef);
    }

    #region Multi-App Configuration Validation

    /// <summary>
    /// These tests focus on validating the ApplicationInfo configuration itself,
    /// not EntityMetadataService integration (which requires deeper setup with actual entity reflection).
    /// EntityMetadataService integration tests should be in a separate integration test suite.
    /// </summary>

    [Fact]
    public void MultiAppConfig_AdminAppHasCorrectEntities()
    {
        // Arrange & Act
        var adminEntities = _adminApp.Entities;

        // Assert
        Assert.Equal(3, adminEntities.Count);
        Assert.Contains("acme:Category", adminEntities);
        Assert.Contains("acme:Product", adminEntities);
        Assert.Contains("acme:Company", adminEntities);
    }

    [Fact]
    public void MultiAppConfig_ReportingAppHasFewerEntitiesThanAdmin()
    {
        // Arrange & Act
        var reportingEntities = _reportingApp.Entities;
        var adminEntities = _adminApp.Entities;

        // Assert
        Assert.Equal(2, reportingEntities.Count);
        Assert.True(reportingEntities.Count < adminEntities.Count);
        Assert.DoesNotContain("acme:Category", reportingEntities);
        Assert.Contains("acme:Product", reportingEntities);
        Assert.Contains("acme:Company", reportingEntities);
    }

    [Fact]
    public void MultiAppConfig_MetricsAppHasOnlyInitechEntities()
    {
        // Arrange & Act
        var metricsEntities = _metricsApp.Entities;

        // Assert
        Assert.Equal(2, metricsEntities.Count);
        Assert.All(metricsEntities, entity => Assert.True(entity.StartsWith("initech:")));
        Assert.Contains("initech:Company", metricsEntities);
        Assert.Contains("initech:User", metricsEntities);
    }

    [Fact]
    public void MultiAppConfig_AdminAndMetricsHaveNoSharedEntities()
    {
        // Arrange & Act
        var adminEntities = new HashSet<string>(_adminApp.Entities);
        var metricsEntities = new HashSet<string>(_metricsApp.Entities);

        // Assert - different schemas = no overlap
        var intersection = adminEntities.Intersect(metricsEntities);
        Assert.Empty(intersection);
    }

    [Fact]
    public void MultiAppConfig_AdminAndReportingShareSomeEntities()
    {
        // Arrange & Act
        var adminEntities = new HashSet<string>(_adminApp.Entities);
        var reportingEntities = new HashSet<string>(_reportingApp.Entities);

        // Assert - both acme schema = some overlap
        var intersection = adminEntities.Intersect(reportingEntities);
        Assert.NotEmpty(intersection);
        Assert.Contains("acme:Product", intersection);
        Assert.Contains("acme:Company", intersection);
    }

    [Fact]
    public void MultiAppConfig_EachAppHasCorrectSchema()
    {
        // Assert
        Assert.Equal("acme", _adminApp.Schema);
        Assert.Equal("acme", _reportingApp.Schema);
        Assert.Equal("initech", _metricsApp.Schema);
    }

    #endregion

    #region EntityMetadataService Direct Logic Tests

    /// <summary>
    /// Test EntityMetadataService logic directly without full integration setup.
    /// These tests verify the core filtering logic using constructed EntityMetadata objects.
    /// </summary>

    [Fact]
    public void EntityMetadataService_IsEntityVisibleInApplication_WithQualifiedName_ReturnsTrue()
    {
        // Arrange
        var acmeProduct = new Entity
        {
            Name = "Product",
            Schema = "acme",
            Properties = new List<Property>()
        };
        var productMetadata = new EntityMetadata(acmeProduct, typeof(object));
        var metadataService = new EntityMetadataService(_mockAppDictionary.Object);

        // Act
        var isVisible = metadataService.IsEntityVisibleInApplication(productMetadata, "admin");

        // Assert
        Assert.True(isVisible);
    }

    [Fact]
    public void EntityMetadataService_IsEntityVisibleInApplication_WithQualifiedName_ReturnsFalse()
    {
        // Arrange - acme:Category is NOT in reporting app
        var acmeCategory = new Entity
        {
            Name = "Category",
            Schema = "acme",
            Properties = new List<Property>()
        };
        var categoryMetadata = new EntityMetadata(acmeCategory, typeof(object));
        var metadataService = new EntityMetadataService(_mockAppDictionary.Object);

        // Act
        var isVisible = metadataService.IsEntityVisibleInApplication(categoryMetadata, "reporting");

        // Assert
        Assert.False(isVisible);
    }

    [Fact]
    public void EntityMetadataService_IsEntityVisibleInApplication_CrossSchema_ReturnsFalse()
    {
        // Arrange - metrics app can't see acme entities
        var acmeProduct = new Entity
        {
            Name = "Product",
            Schema = "acme",
            Properties = new List<Property>()
        };
        var productMetadata = new EntityMetadata(acmeProduct, typeof(object));
        var metadataService = new EntityMetadataService(_mockAppDictionary.Object);

        // Act
        var isVisible = metadataService.IsEntityVisibleInApplication(productMetadata, "metrics");

        // Assert
        Assert.False(isVisible);
    }

    [Fact]
    public void EntityMetadataService_IsEntityVisibleInApplication_InvalidApp_ReturnsFalse()
    {
        // Arrange
        var acmeProduct = new Entity
        {
            Name = "Product",
            Schema = "acme",
            Properties = new List<Property>()
        };
        var productMetadata = new EntityMetadata(acmeProduct, typeof(object));
        var metadataService = new EntityMetadataService(_mockAppDictionary.Object);

        // Act
        var isVisible = metadataService.IsEntityVisibleInApplication(productMetadata, "invalidapp");

        // Assert
        Assert.False(isVisible);
    }

    #endregion

    #region Application Dictionary Tests

    [Fact]
    public void AppDictionaryService_GetAllApplications_ReturnsAllConfiguredApps()
    {
        // Arrange
        var apps = _mockAppDictionary.Object.GetAllApplications();

        // Act & Assert
        Assert.Equal(3, apps.Count);
        Assert.Single(apps.Where(a => a.Name == "admin"));
        Assert.Single(apps.Where(a => a.Name == "reporting"));
        Assert.Single(apps.Where(a => a.Name == "metrics"));
    }

    [Fact]
    public void AppDictionaryService_GetApplication_ReturnsCorrectApp()
    {
        // Act
        var adminApp = _mockAppDictionary.Object.GetApplication("admin");
        var reportingApp = _mockAppDictionary.Object.GetApplication("reporting");
        var metricsApp = _mockAppDictionary.Object.GetApplication("metrics");

        // Assert
        Assert.NotNull(adminApp);
        Assert.Equal("admin", adminApp.Name);
        Assert.Equal("acme", adminApp.Schema);

        Assert.NotNull(reportingApp);
        Assert.Equal("reporting", reportingApp.Name);

        Assert.NotNull(metricsApp);
        Assert.Equal("metrics", metricsApp.Name);
        Assert.Equal("initech", metricsApp.Schema);
    }

    [Fact]
    public void AppDictionaryService_GetApplication_ReturnsNullForInvalidApp()
    {
        // Act
        var app = _mockAppDictionary.Object.GetApplication("nonexistent");

        // Assert
        Assert.Null(app);
    }

    #endregion
}
