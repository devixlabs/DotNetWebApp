using System.Collections.Concurrent;
using Dapper;
using DotNetWebApp.Constants;
using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models.AppDictionary;
using DotNetWebApp.Models.ViewModels;
using DotNetWebApp.Services;
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
    /// Includes comprehensive error scenario coverage.
    /// </summary>
    public class ViewPipelineTests : IAsyncLifetime
    {
        private string _testDataDirectory = null!;
        private string _viewsYamlPath = null!;
        private string _sqlViewsDirectory = null!;
        private ILogger<ViewRegistry> _loggerViewRegistry = null!;
        private ILogger<DapperQueryService> _loggerDapperService = null!;
        private ILogger<ViewService> _loggerViewService = null!;
        private IAppDictionaryService _mockAppDictionary = null!;

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

            // Set up mock app dictionary with views loaded from app.yaml
            var mockAppDict = new Mock<IAppDictionaryService>();
            var testApp = new ApplicationInfo
            {
                Name = "test",
                Title = "Test App",
                Schema = "test",
                Entities = new List<string>(),
                Views = new List<string> { "TestView" }  // Test view is visible
            };

            // Create an AppDefinition with views (as if loaded from app.yaml)
            var appDef = new AppDefinition
            {
                Applications = new List<ApplicationInfo> { testApp },
                DataModel = new DataModel { Entities = new List<Entity>() },
                Views = new ViewsDefinition
                {
                    Views = new List<ViewDefinition>
                    {
                        new ViewDefinition
                        {
                            Name = "TestView",
                            Description = "Test view for unit testing",
                            SqlFile = "sql/views/TestView.sql",
                            GeneratePartial = true,
                            Parameters = new List<ViewParameter>
                            {
                                new ViewParameter
                                {
                                    Name = "TopN",
                                    Type = "int",
                                    Nullable = false,
                                    Default = "10"
                                }
                            },
                            Properties = new List<ViewProperty>
                            {
                                new ViewProperty { Name = "Id", Type = "int", Nullable = false },
                                new ViewProperty { Name = "Name", Type = "string", Nullable = false },
                                new ViewProperty { Name = "Value", Type = "decimal", Nullable = false }
                            }
                        }
                    }
                }
            };

            mockAppDict.Setup(x => x.AppDefinition).Returns(appDef);
            mockAppDict.Setup(x => x.GetApplication(It.IsAny<string>()))
                .Returns(testApp);
            _mockAppDictionary = mockAppDict.Object;
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

        #region IViewRegistry Tests - Happy Path

        [Fact]
        public void ViewRegistry_LoadsViewsFromYaml()
        {
            // Arrange & Act
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var viewNames = registry.GetAllViewNames().ToList();

            // Assert
            Assert.NotEmpty(viewNames);
            Assert.Contains("TestView", viewNames);
        }

        [Fact]
        public void ViewRegistry_GetViewDefinition_ReturnsCorrectMetadata()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

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
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            var ex = Assert.Throws<InvalidOperationException>(() => registry.GetViewDefinition("UnknownView"));
            Assert.Contains(ErrorIds.ViewNotFound, ex.Message);
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_LoadsSqlContent()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

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
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

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
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            var ex = await Assert.ThrowsAsync<InvalidOperationException>(
                () => registry.GetViewSqlAsync("UnknownView"));
            Assert.Contains(ErrorIds.ViewNotFound, ex.Message);
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_ThrowsForMissingSqlFile()
        {
            // Arrange: Create mock AppDictionary with a view that references a missing SQL file
            var mockAppDict = new Mock<IAppDictionaryService>();
            var appDef = new AppDefinition
            {
                Applications = new List<ApplicationInfo>(),
                DataModel = new DataModel { Entities = new List<Entity>() },
                Views = new ViewsDefinition
                {
                    Views = new List<ViewDefinition>
                    {
                        new ViewDefinition
                        {
                            Name = "BrokenView",
                            Description = "View with missing SQL file",
                            SqlFile = "sql/views/NonExistent.sql",  // This file doesn't exist
                            GeneratePartial = true,
                            Parameters = new List<ViewParameter>(),
                            Properties = new List<ViewProperty> { new ViewProperty { Name = "Id", Type = "int", Nullable = false } }
                        }
                    }
                }
            };

            mockAppDict.Setup(x => x.AppDefinition).Returns(appDef);
            var registry = new ViewRegistry(_loggerViewRegistry, mockAppDict.Object, _testDataDirectory);

            // Act & Assert
            var ex = await Assert.ThrowsAsync<FileNotFoundException>(
                () => registry.GetViewSqlAsync("BrokenView"));
            Assert.Contains(ErrorIds.SqlFileNotFound, ex.Message);
            Assert.Contains("BrokenView", ex.Message);
        }

        [Fact]
        public void ViewRegistry_GetAllViewNames_ReturnsAllRegisteredViews()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act
            var viewNames = registry.GetAllViewNames().ToList();

            // Assert
            Assert.NotEmpty(viewNames);
            Assert.Single(viewNames);
            Assert.Contains("TestView", viewNames);
        }

        #endregion

        #region IViewRegistry Tests - Error Scenarios

        [Fact]
        public void ViewRegistry_HandlesEmptyViews_Gracefully()
        {
            // Arrange: Create mock AppDictionary with no views
            var mockAppDict = new Mock<IAppDictionaryService>();
            var appDef = new AppDefinition
            {
                Applications = new List<ApplicationInfo>(),
                DataModel = new DataModel { Entities = new List<Entity>() },
                Views = new ViewsDefinition { Views = new List<ViewDefinition>() }  // Empty views
            };

            mockAppDict.Setup(x => x.AppDefinition).Returns(appDef);

            // Act: Create registry with empty views
            var registry = new ViewRegistry(_loggerViewRegistry, mockAppDict.Object, _testDataDirectory);

            // Assert: Should load successfully with no views
            var viewNames = registry.GetAllViewNames().ToList();
            Assert.Empty(viewNames);
        }

        [Fact]
        public void ViewRegistry_GetViewDefinition_ThrowsForNullViewName()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            Assert.Throws<ArgumentException>(() => registry.GetViewDefinition(null!));
        }

        [Fact]
        public void ViewRegistry_GetViewDefinition_ThrowsForEmptyViewName()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            Assert.Throws<ArgumentException>(() => registry.GetViewDefinition(""));
        }

        [Fact]
        public void ViewRegistry_GetViewDefinition_ThrowsForWhitespaceViewName()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            Assert.Throws<ArgumentException>(() => registry.GetViewDefinition("   "));
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_ThrowsForNullViewName()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(
                () => registry.GetViewSqlAsync(null!));
        }

        [Fact]
        public async Task ViewRegistry_GetViewSqlAsync_ThrowsForEmptyViewName()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(
                () => registry.GetViewSqlAsync(""));
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

        [Fact]
        public void DapperQueryService_ThrowsForNullDbContext()
        {
            // Act & Assert
            Assert.Throws<ArgumentNullException>(
                () => new DapperQueryService(null!, _loggerDapperService));
        }

        [Fact]
        public void DapperQueryService_ThrowsForNullLogger()
        {
            // Arrange
            var mockTenantAccessor = new Mock<ITenantSchemaAccessor>();
            mockTenantAccessor.Setup(x => x.Schema).Returns("dbo");
            var mockDbContext = new Mock<AppDbContext>(
                new DbContextOptions<AppDbContext>(),
                mockTenantAccessor.Object);

            // Act & Assert
            Assert.Throws<ArgumentNullException>(
                () => new DapperQueryService(mockDbContext.Object, null!));
        }

        #endregion

        #region IViewService Tests - Happy Path

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

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
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

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
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
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            // Use NullLogger to suppress log output for this exception test
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            var ex = await Assert.ThrowsAsync<InvalidOperationException>(
                () => service.ExecuteViewAsync<TestDataDto>("UnknownView"));
            Assert.Contains(ErrorIds.ViewNotFound, ex.Message);
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

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
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

        #region IViewService Tests - Error Scenarios

        [Fact]
        public async Task ViewService_ExecuteViewAsync_ThrowsForNullViewName()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(
                () => service.ExecuteViewAsync<TestDataDto>(null!));
        }

        [Fact]
        public async Task ViewService_ExecuteViewAsync_ThrowsForEmptyViewName()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(
                () => service.ExecuteViewAsync<TestDataDto>(""));
        }

        [Fact]
        public async Task ViewService_ExecuteViewSingleAsync_ThrowsForNullViewName()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            await Assert.ThrowsAsync<ArgumentException>(
                () => service.ExecuteViewSingleAsync<TestDataDto>(null!));
        }

        [Fact]
        public async Task ViewService_ExecuteViewAsync_PropagatesRegistryFileNotFoundException()
        {
            // Arrange: Create mock AppDictionary with a view that has a missing SQL file
            var mockAppDict = new Mock<IAppDictionaryService>();
            var appDef = new AppDefinition
            {
                Applications = new List<ApplicationInfo>(),
                DataModel = new DataModel { Entities = new List<Entity>() },
                Views = new ViewsDefinition
                {
                    Views = new List<ViewDefinition>
                    {
                        new ViewDefinition
                        {
                            Name = "MissingSqlView",
                            Description = "View with missing SQL file",
                            SqlFile = "sql/views/DoesNotExist.sql",
                            GeneratePartial = true,
                            Parameters = new List<ViewParameter>(),
                            Properties = new List<ViewProperty>
                            {
                                new ViewProperty { Name = "Id", Type = "int", Nullable = false }
                            }
                        }
                    }
                }
            };

            mockAppDict.Setup(x => x.AppDefinition).Returns(appDef);

            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_loggerViewRegistry, mockAppDict.Object, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert - FileNotFoundException should propagate directly from GetViewSqlAsync
            var ex = await Assert.ThrowsAsync<FileNotFoundException>(
                () => service.ExecuteViewAsync<TestDataDto>("MissingSqlView"));
            Assert.Contains(ErrorIds.SqlFileNotFound, ex.Message);
        }

        [Fact]
        public async Task ViewService_ExecuteViewAsync_PropagatesDapperSqlError()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var sqlError = new InvalidOperationException(
                $"[{ErrorIds.SqlError}] Database error: Invalid column name (Code: 207)");
            mockDapper
                .Setup(d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ThrowsAsync(sqlError);

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert - SQL error should propagate without double-wrapping
            var ex = await Assert.ThrowsAsync<InvalidOperationException>(
                () => service.ExecuteViewAsync<TestDataDto>("TestView"));
            Assert.Contains(ErrorIds.SqlError, ex.Message);
            Assert.Null(ex.InnerException); // Not double-wrapped
        }

        [Fact]
        public async Task ViewService_ExecuteViewAsync_PropagatesDapperTimeoutError()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var timeoutError = new InvalidOperationException(
                $"[{ErrorIds.QueryTimeout}] Query execution timed out. The database is responding slowly.");
            mockDapper
                .Setup(d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ThrowsAsync(timeoutError);

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert - Timeout error should propagate without double-wrapping
            var ex = await Assert.ThrowsAsync<InvalidOperationException>(
                () => service.ExecuteViewAsync<TestDataDto>("TestView"));
            Assert.Contains(ErrorIds.QueryTimeout, ex.Message);
        }

        [Fact]
        public async Task ViewService_ExecuteViewAsync_PropagatesArgumentException()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var argError = new ArgumentException("Invalid parameter name", "param");
            mockDapper
                .Setup(d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ThrowsAsync(argError);

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert - ArgumentException should propagate unchanged
            var ex = await Assert.ThrowsAsync<ArgumentException>(
                () => service.ExecuteViewAsync<TestDataDto>("TestView"));
            Assert.Equal("Invalid parameter name (Parameter 'param')", ex.Message);
        }

        [Fact]
        public async Task ViewService_ExecuteViewSingleAsync_PropagatesDapperError()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var sqlError = new InvalidOperationException(
                $"[{ErrorIds.SqlError}] Database error: Permission denied (Code: 229)");
            mockDapper
                .Setup(d => d.QuerySingleAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ThrowsAsync(sqlError);

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            var ex = await Assert.ThrowsAsync<InvalidOperationException>(
                () => service.ExecuteViewSingleAsync<TestDataDto>("TestView"));
            Assert.Contains(ErrorIds.SqlError, ex.Message);
        }

        #endregion

        #region ViewService Constructor Tests

        [Fact]
        public void ViewService_ThrowsForNullDapper()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            Assert.Throws<ArgumentNullException>(
                () => new ViewService(null!, registry, _loggerViewService));
        }

        [Fact]
        public void ViewService_ThrowsForNullRegistry()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();

            // Act & Assert
            Assert.Throws<ArgumentNullException>(
                () => new ViewService(mockDapper.Object, null!, _loggerViewService));
        }

        [Fact]
        public void ViewService_ThrowsForNullLogger()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);

            // Act & Assert
            Assert.Throws<ArgumentNullException>(
                () => new ViewService(mockDapper.Object, registry, null!));
        }

        #endregion

        #region ErrorIds Constants Tests

        [Fact]
        public void ErrorIds_ContainsAllRequiredConstants()
        {
            // Verify all error ID constants exist
            Assert.Equal("VIEW_NOT_FOUND", ErrorIds.ViewNotFound);
            Assert.Equal("VIEWS_YAML_MISSING", ErrorIds.ViewsYamlMissing);
            Assert.Equal("VIEWS_YAML_EMPTY", ErrorIds.ViewsYamlEmpty);
            Assert.Equal("VIEWS_YAML_PARSE_ERROR", ErrorIds.ViewsYamlParseError);
            Assert.Equal("SQL_FILE_NOT_FOUND", ErrorIds.SqlFileNotFound);
            Assert.Equal("SQL_FILE_PERMISSION_DENIED", ErrorIds.SqlFilePermissionDenied);
            Assert.Equal("QUERY_EXECUTION_FAILED", ErrorIds.QueryExecutionFailed);
            Assert.Equal("QUERY_TIMEOUT", ErrorIds.QueryTimeout);
            Assert.Equal("SQL_ERROR", ErrorIds.SqlError);
            Assert.Equal("VIEW_EXECUTION_FAILED", ErrorIds.ViewExecutionFailed);
        }

        [Fact]
        public void ErrorIds_GetFriendlySqlErrorMessage_ReturnsCorrectMessages()
        {
            // Test known error codes
            Assert.Contains("timeout", ErrorIds.GetFriendlySqlErrorMessage(-2, ""), StringComparison.OrdinalIgnoreCase);
            Assert.Contains("network", ErrorIds.GetFriendlySqlErrorMessage(-1, ""), StringComparison.OrdinalIgnoreCase);
            Assert.Contains("column", ErrorIds.GetFriendlySqlErrorMessage(207, ""), StringComparison.OrdinalIgnoreCase);
            Assert.Contains("table", ErrorIds.GetFriendlySqlErrorMessage(208, ""), StringComparison.OrdinalIgnoreCase);
            Assert.Contains("deadlock", ErrorIds.GetFriendlySqlErrorMessage(1205, ""), StringComparison.OrdinalIgnoreCase);
            Assert.Contains("Login failed", ErrorIds.GetFriendlySqlErrorMessage(18456, ""), StringComparison.OrdinalIgnoreCase);

            // Test unknown error code falls back to original message
            var unknownResult = ErrorIds.GetFriendlySqlErrorMessage(99999, "Original error message");
            Assert.Contains("Original error message", unknownResult);
        }

        #endregion

        #region Integration-Style Tests (Simulated)

        [Fact]
        public async Task FullPipeline_ViewService_LoadsAndExecutesView()
        {
            // Arrange: Set up a complete pipeline with mocked Dapper
            var mockDapper = new Mock<IDapperQueryService>();
            var testResults = new List<TestDataDto>
            {
                new() { Id = 1, Name = "Product A", Value = 99.99m },
                new() { Id = 2, Name = "Product B", Value = 149.99m },
                new() { Id = 3, Name = "Product C", Value = 199.99m }
            };
            mockDapper
                .Setup(d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ReturnsAsync(testResults);

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, _loggerViewService);

            // Act: Execute view through the full pipeline
            var results = await service.ExecuteViewAsync<TestDataDto>("TestView", new { TopN = 10 });

            // Assert
            var resultList = results.ToList();
            Assert.Equal(3, resultList.Count);
            Assert.Equal("Product A", resultList[0].Name);
            Assert.Equal(149.99m, resultList[1].Value);
        }

        [Fact]
        public async Task FullPipeline_ViewNotFound_ReturnsSpecificError()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            var ex = await Assert.ThrowsAsync<InvalidOperationException>(
                () => service.ExecuteViewAsync<TestDataDto>("NonExistentView"));

            // Verify error message is specific and actionable
            Assert.Contains("VIEW_NOT_FOUND", ex.Message);
            Assert.Contains("NonExistentView", ex.Message);
            Assert.Contains("Registered views:", ex.Message);
        }

        [Fact]
        public async Task FullPipeline_SqlFileNotFound_ReturnsSpecificError()
        {
            // Arrange: Create mock AppDictionary with a view that references missing SQL file
            var mockAppDict = new Mock<IAppDictionaryService>();
            var appDef = new AppDefinition
            {
                Applications = new List<ApplicationInfo>(),
                DataModel = new DataModel { Entities = new List<Entity>() },
                Views = new ViewsDefinition
                {
                    Views = new List<ViewDefinition>
                    {
                        new ViewDefinition
                        {
                            Name = "MissingFileView",
                            Description = "View with missing SQL file",
                            SqlFile = "sql/views/ThisFileDoesNotExist.sql",  // This file doesn't exist
                            GeneratePartial = true,
                            Parameters = new List<ViewParameter>(),
                            Properties = new List<ViewProperty>
                            {
                                new ViewProperty { Name = "Id", Type = "int", Nullable = false }
                            }
                        }
                    }
                }
            };

            mockAppDict.Setup(x => x.AppDefinition).Returns(appDef);

            var mockDapper = new Mock<IDapperQueryService>();
            var registry = new ViewRegistry(_loggerViewRegistry, mockAppDict.Object, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, NullLogger<ViewService>.Instance);

            // Act & Assert
            var ex = await Assert.ThrowsAsync<FileNotFoundException>(
                () => service.ExecuteViewAsync<TestDataDto>("MissingFileView"));

            // Verify error message is specific and actionable
            Assert.Contains("SQL_FILE_NOT_FOUND", ex.Message);
            Assert.Contains("MissingFileView", ex.Message);
            Assert.Contains("sql/views/", ex.Message);
        }

        #endregion

        #region Concurrent Access Tests

        [Fact]
        public async Task ViewRegistry_ConcurrentAccess_IsSafe()
        {
            // Arrange
            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var tasks = new List<Task<string>>();

            // Act: Multiple concurrent requests for same view
            for (int i = 0; i < 100; i++)
            {
                tasks.Add(registry.GetViewSqlAsync("TestView"));
            }

            var results = await Task.WhenAll(tasks);

            // Assert: All results should be identical (cached)
            Assert.All(results, sql => Assert.Equal(results[0], sql));
        }

        [Fact]
        public async Task ViewService_ConcurrentExecution_IsSafe()
        {
            // Arrange
            var mockDapper = new Mock<IDapperQueryService>();
            var testResults = new List<TestDataDto> { new() { Id = 1, Name = "Test", Value = 100 } };
            mockDapper
                .Setup(d => d.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
                .ReturnsAsync(testResults);

            var registry = new ViewRegistry(_loggerViewRegistry, _mockAppDictionary, _testDataDirectory);
            var service = new ViewService(mockDapper.Object, registry, _loggerViewService);

            var tasks = new List<Task<IEnumerable<TestDataDto>>>();

            // Act: Multiple concurrent view executions
            for (int i = 0; i < 50; i++)
            {
                tasks.Add(service.ExecuteViewAsync<TestDataDto>("TestView", new { TopN = i }));
            }

            var results = await Task.WhenAll(tasks);

            // Assert: All executions completed successfully
            Assert.All(results, r => Assert.Single(r));
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
