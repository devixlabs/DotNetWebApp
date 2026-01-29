using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;
using DotNetWebApp.Services;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests
{
    public class DashboardServiceTests
    {
        private readonly Mock<IEntityApiService> _mockEntityApiService;
        private readonly Mock<IEntityMetadataService> _mockEntityMetadataService;
        private readonly Mock<ILogger<DashboardService>> _mockLogger;
        private readonly DashboardService _dashboardService;

        public DashboardServiceTests()
        {
            _mockEntityApiService = new Mock<IEntityApiService>();
            _mockEntityMetadataService = new Mock<IEntityMetadataService>();
            _mockLogger = new Mock<ILogger<DashboardService>>();
            _dashboardService = new DashboardService(
                _mockEntityApiService.Object,
                _mockEntityMetadataService.Object,
                _mockLogger.Object
            );
        }

        [Fact]
        public async Task GetSummaryAsync_ReturnsCounts_WhenApiSucceeds()
        {
            // Arrange
            var companyEntity = new Entity { Name = "Company", Schema = "acme", Properties = new List<Property>() };
            var productEntity = new Entity { Name = "Product", Schema = "acme", Properties = new List<Property>() };

            var mockEntities = new List<EntityMetadata>
            {
                new(companyEntity, typeof(object)),
                new(productEntity, typeof(object))
            };

            _mockEntityMetadataService.Setup(x => x.GetEntitiesForApplication("admin"))
                .Returns(mockEntities);
            _mockEntityApiService.Setup(x => x.GetCountAsync("admin", "acme:Company"))
                .ReturnsAsync(5);
            _mockEntityApiService.Setup(x => x.GetCountAsync("admin", "acme:Product"))
                .ReturnsAsync(10);

            // Act
            var result = await _dashboardService.GetSummaryAsync("admin");

            // Assert
            Assert.NotNull(result);
            Assert.Equal(2, result.EntityCounts.Count);
            Assert.False(result.EntityCounts[0].HasError);
            Assert.Equal(5, result.EntityCounts[0].Count);
            Assert.False(result.EntityCounts[1].HasError);
            Assert.Equal(10, result.EntityCounts[1].Count);
        }

        [Fact]
        public async Task GetSummaryAsync_ReturnsErrorState_WhenApiThrows()
        {
            // Arrange
            var companyEntity = new Entity { Name = "Company", Schema = "acme", Properties = new List<Property>() };
            var mockEntities = new List<EntityMetadata>
            {
                new(companyEntity, typeof(object))
            };

            _mockEntityMetadataService.Setup(x => x.GetEntitiesForApplication("admin"))
                .Returns(mockEntities);
            _mockEntityApiService.Setup(x => x.GetCountAsync("admin", "acme:Company"))
                .ThrowsAsync(new HttpRequestException("Connection timeout"));

            // Act
            var result = await _dashboardService.GetSummaryAsync("admin");

            // Assert
            Assert.NotNull(result);
            Assert.Single(result.EntityCounts);
            var countInfo = result.EntityCounts[0];
            Assert.True(countInfo.HasError);
            Assert.NotNull(countInfo.ErrorMessage);
            Assert.Contains("Failed to load count", countInfo.ErrorMessage);
            Assert.Equal(0, countInfo.Count);
        }

        [Fact]
        public async Task GetSummaryAsync_HandlesPartialFailure_WithMixedResults()
        {
            // Arrange
            var companyEntity = new Entity { Name = "Company", Schema = "acme", Properties = new List<Property>() };
            var productEntity = new Entity { Name = "Product", Schema = "acme", Properties = new List<Property>() };

            var mockEntities = new List<EntityMetadata>
            {
                new(companyEntity, typeof(object)),
                new(productEntity, typeof(object))
            };

            _mockEntityMetadataService.Setup(x => x.GetEntitiesForApplication("admin"))
                .Returns(mockEntities);
            _mockEntityApiService.Setup(x => x.GetCountAsync("admin", "acme:Company"))
                .ReturnsAsync(5);
            _mockEntityApiService.Setup(x => x.GetCountAsync("admin", "acme:Product"))
                .ThrowsAsync(new InvalidOperationException("Entity not found"));

            // Act
            var result = await _dashboardService.GetSummaryAsync("admin");

            // Assert
            Assert.NotNull(result);
            Assert.Equal(2, result.EntityCounts.Count);

            // First entity should succeed
            Assert.False(result.EntityCounts[0].HasError);
            Assert.Equal(5, result.EntityCounts[0].Count);

            // Second entity should have error
            Assert.True(result.EntityCounts[1].HasError);
            Assert.NotNull(result.EntityCounts[1].ErrorMessage);
            Assert.Equal(0, result.EntityCounts[1].Count);
        }

        [Fact]
        public async Task GetSummaryForApplicationAsync_ReturnsCorrectAppData()
        {
            // Arrange
            var appName = "reporting";
            var reportEntity = new Entity { Name = "Report", Schema = "analytics", Properties = new List<Property>() };

            var mockEntities = new List<EntityMetadata>
            {
                new(reportEntity, typeof(object))
            };

            _mockEntityMetadataService.Setup(x => x.GetEntitiesForApplication(appName))
                .Returns(mockEntities);
            _mockEntityApiService.Setup(x => x.GetCountAsync(appName, "analytics:Report"))
                .ReturnsAsync(42);

            // Act
            var result = await _dashboardService.GetSummaryForApplicationAsync(appName);

            // Assert
            Assert.NotNull(result);
            Assert.Single(result.EntityCounts);
            Assert.Equal(42, result.EntityCounts[0].Count);
            Assert.False(result.EntityCounts[0].HasError);
        }

        [Fact]
        public async Task GetSummaryAsync_ReturnsStaticMetrics()
        {
            // Arrange
            _mockEntityMetadataService.Setup(x => x.GetEntitiesForApplication(It.IsAny<string>()))
                .Returns(new List<EntityMetadata>());

            // Act
            var result = await _dashboardService.GetSummaryAsync("admin");

            // Assert
            Assert.NotNull(result);
            Assert.Equal(45789.50m, result.Revenue);
            Assert.Equal(1250, result.ActiveUsers);
            Assert.Equal(15, result.GrowthPercent);
            Assert.Equal(3, result.RecentActivities.Count);
        }
    }
}
