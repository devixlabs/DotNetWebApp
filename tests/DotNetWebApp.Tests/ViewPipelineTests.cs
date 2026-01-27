using System.Collections.Concurrent;
using Dapper;
using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models.AppDictionary;
using DotNetWebApp.Models.ViewModels;
using DotNetWebApp.Services.Views;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests
{
    /// <summary>
    /// Unit tests for the SQL view pipeline (Phase 2B implementation).
    /// Tests IViewRegistry, IDapperQueryService, and IViewService.
    /// </summary>
    public class ViewPipelineTests : IAsyncLifetime
    {
        private string _testDataDirectory = null!;
        private string _viewsYamlPath = null!;
        private string _sqlViewsDirectory = null!;
        private ILogger<ViewRegistry> _loggerViewRegistry = null!;
        private ILogger<DapperQueryService> _loggerDapperService = null!;
        private ILogger<ViewService> _loggerViewService = null!;

        public async Task InitializeAsync()
        {
            // Set up temporary test directory
            _testDataDirectory = Path.Combine(Path.GetTempPath(), $"view-tests-{Guid.NewGuid()}");
            Directory.CreateDirectory(_testDataDirectory);

            _sqlViewsDirectory = Path.Combine(_testDataDirectory, "sql", "views");
            Directory.CreateDirectory(_sqlViewsDirectory);

            _viewsYamlPath = Path.Combine(_testDataDirectory, "views.yaml");

            // Create test views.yaml
            var viewsYaml = @"
views:
  - name: TestView
    description: ""Test view for unit testing""
    sql_file: ""sql/views/TestView.sql""
    generate_partial: true
    parameters:
      - name: TopN
        type: int
        nullable: false
        default: ""10""
    properties:
      - name: Id
        type: int
        nullable: false
      - name: Name
        type: string
        nullable: false
      - name: Value
        type: decimal
        nullable: false
";
            await File.WriteAllTextAsync(_viewsYamlPath, viewsYaml);

            // Create test SQL file
            var sqlContent = @"
SELECT
    1 AS Id,
    'Test' AS Name,
    100.00 AS Value
UNION ALL
SELECT
    2 AS Id,
    'Test2' AS Name,
    200.00 AS Value
";
            var sqlFilePath = Path.Combine(_sqlViewsDirectory, "TestView.sql");
            await File.WriteAllTextAsync(sqlFilePath, sqlContent);

            // Set up loggers
            var loggerFactory = LoggerFactory.Create(builder => builder.AddConsole());
            _loggerViewRegistry = loggerFactory.CreateLogger<ViewRegistry>();
            _loggerDapperService = loggerFactory.CreateLogger<DapperQueryService>();
            _loggerViewService = loggerFactory.CreateLogger<ViewService>();
        }

        public async Task DisposeAsync()
        {
            // Clean up test directory
            if (Directory.Exists(_testDataDirectory))
            {
                Directory.Delete(_testDataDirectory, recursive: true);
            }

            await Task.CompletedTask;
        }

        #region IViewRegistry Tests

        [Fact]
        public void ViewRegistry_LoadsViewsFromYaml()
        {
            // Arrange & Act
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);
            var viewNames = registry.GetAllViewNames().ToList();

            // Assert
            Assert.NotEmpty(viewNames);
            Assert.Contains("TestView", viewNames);
        }

        [Fact]
        public void ViewRegistry_GetViewDefinition_ReturnsCorrectMetadata()
        {
            // Arrange
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);

            // Act
            var definition = registry.GetViewDefinition("TestView");

            // Assert
            Assert.NotNull(definition);
            Assert.Equal("TestView", definition.Name);
            Assert.Equal("Test view for unit testing", definition.Description);
            Assert.Equal("sql/views/TestView.sql", definition.SqlFile);
            Assert.True(definition.GeneratePartial);
            Assert.NotEmpty(definition.Parameters!);
            Assert.NotEmpty(definition.Properties!);
        }

        [Fact]
        public void ViewRegistry_GetViewDefinition_ThrowsForUnknownView()
        {
            // Arrange
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);

            // Act & Assert
            Assert.Throws<InvalidOperationException>(() => registry.GetViewDefinition("UnknownView"));
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_LoadsSqlContent()
        {
            // Arrange
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);

            // Act
            var sql = await registry.GetViewSqlAsync("TestView");

            // Assert
            Assert.NotNull(sql);
            Assert.Contains("SELECT", sql, StringComparison.OrdinalIgnoreCase);
            Assert.Contains("Id", sql);
            Assert.Contains("UNION", sql, StringComparison.OrdinalIgnoreCase);
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_CachesSqlForSubsequentCalls()
        {
            // Arrange
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);

            // Act
            var sql1 = await registry.GetViewSqlAsync("TestView");
            var sql2 = await registry.GetViewSqlAsync("TestView");

            // Assert
            Assert.Equal(sql1, sql2);
            Assert.Same(sql1, sql2); // Should be same cached instance
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_ThrowsForUnknownView()
        {
            // Arrange
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);

            // Act & Assert
            await Assert.ThrowsAsync<InvalidOperationException>(
                () => registry.GetViewSqlAsync("UnknownView"));
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_ThrowsForMissingSqlFile()
        {
            // Arrange: Create a views.yaml that references non-existent SQL file
            var brokenYamlPath = Path.Combine(_testDataDirectory, "broken.yaml");
            var brokenYaml = @"
views:
  - name: BrokenView
    description: ""View with missing SQL file""
    sql_file: ""sql/views/NonExistent.sql""
    generate_partial: true
    properties:
      - name: Id
        type: int
        nullable: false
";
            await File.WriteAllTextAsync(brokenYamlPath, brokenYaml);
            var registry = new ViewRegistry(brokenYamlPath, _loggerViewRegistry);

            // Act & Assert
            await Assert.ThrowsAsync<FileNotFoundException>(
                () => registry.GetViewSqlAsync("BrokenView"));
        }

        [Fact]
        public void ViewRegistry_GetAllViewNames_ReturnsAllRegisteredViews()
        {
            // Arrange
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);

            // Act
            var viewNames = registry.GetAllViewNames().ToList();

            // Assert
            Assert.NotEmpty(viewNames);
            Assert.Single(viewNames);
            Assert.Contains("TestView", viewNames);
        }

        [Fact]
        public void ViewRegistry_HandlesMissingYamlFile_Gracefully()
        {
            // Arrange
            var nonExistentPath = Path.Combine(_testDataDirectory, "nonexistent.yaml");

            // Act
            var registry = new ViewRegistry(nonExistentPath, _loggerViewRegistry);

            // Assert
            Assert.Empty(registry.GetAllViewNames());
        }

        #endregion

        #region IDapperQueryService Tests

        [Fact]
        public void DapperQueryService_HasRequiredMethods()
        {
            // Verify DapperQueryService class structure
            // Full testing of Dapper execution requires a real database context
            // and is covered by integration tests with the app running

            // Verify QueryAsync method exists
            var queryMethod = typeof(DapperQueryService).GetMethod("QueryAsync");
            Assert.NotNull(queryMethod);
            Assert.True(queryMethod.IsGenericMethodDefinition);
            Assert.Single(queryMethod.GetGenericArguments());

            // Verify QuerySingleAsync method exists
            var querySingleMethod = typeof(DapperQueryService).GetMethod("QuerySingleAsync");
            Assert.NotNull(querySingleMethod);
            Assert.True(querySingleMethod.IsGenericMethodDefinition);
            Assert.Single(querySingleMethod.GetGenericArguments());
        }

        #endregion

        #region IViewService Tests

        [Fact]
        public async Task ViewService_ExecuteViewAsync_ReturnsViewResults()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var testResults = new List<TestDataDto>
            {
                new() { Id = 1, Name = "Test1", Value = 100 },
                new() { Id = 2, Name = "Test2", Value = 200 }
            };
            mockDapper
                .Setup(d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ReturnsAsync(testResults);

            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);
            var service = new ViewService(mockDapper.Object, registry, _loggerViewService);

            // Act
            var results = await service.ExecuteViewAsync<TestDataDto>("TestView", new { TopN = 10 });

            // Assert
            Assert.NotNull(results);
            var resultList = results.ToList();
            Assert.Equal(2, resultList.Count);
            mockDapper.Verify(
                d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()),
                Times.Once);
        }

        [Fact]
        public async Task ViewService_ExecuteViewSingleAsync_ReturnsSingleResult()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var testResult = new TestDataDto { Id = 1, Name = "Test1", Value = 100 };
            mockDapper
                .Setup(d => d.QuerySingleAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ReturnsAsync(testResult);

            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);
            var service = new ViewService(mockDapper.Object, registry, _loggerViewService);

            // Act
            var result = await service.ExecuteViewSingleAsync<TestDataDto>("TestView");

            // Assert
            Assert.NotNull(result);
            Assert.Equal(1, result.Id);
            mockDapper.Verify(
                d => d.QuerySingleAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()),
                Times.Once);
        }

        [Fact]
        public async Task ViewService_ExecuteViewAsync_ThrowsForUnknownView()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);
            // Use NullLogger to suppress log output for this exception test
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            await Assert.ThrowsAsync<InvalidOperationException>(
                () => service.ExecuteViewAsync<TestDataDto>("UnknownView"));
        }

        [Fact]
        public async Task ViewService_ExecuteViewAsync_PassesParametersCorrectly()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var testResults = new List<TestDataDto>
            {
                new() { Id = 1, Name = "Test1", Value = 100 }
            };
            mockDapper
                .Setup(d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ReturnsAsync(testResults);

            var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);
            var service = new ViewService(mockDapper.Object, registry, _loggerViewService);

            var parameters = new { TopN = 50 };

            // Act
            await service.ExecuteViewAsync<TestDataDto>("TestView", parameters);

            // Assert
            mockDapper.Verify(
                d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), parameters),
                Times.Once);
        }

        #endregion

        /// <summary>
        /// Simple DTO for testing Dapper query results.
        /// </summary>
        private class TestDataDto
        {
            public int Id { get; set; }
            public string Name { get; set; } = null!;
            public decimal Value { get; set; }
        }
    }
}
