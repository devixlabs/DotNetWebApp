using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DotNetWebApp.Controllers;
using DotNetWebApp.Data;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;
using DotNetWebApp.Services;
using DotNetWebApp.Tests.TestEntities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests;

public class EntitiesControllerTests
{
    private IAppDictionaryService CreateMockAppDictionary()
    {
        var mock = new Mock<IAppDictionaryService>();
        var appDef = new AppDefinition { Applications = new List<ApplicationInfo>() };
        var adminApp = new ApplicationInfo
        {
            Name = "admin",
            Entities = new List<string> { "Product", "Category" }
        };
        appDef.Applications.Add(adminApp);
        mock.Setup(x => x.AppDefinition).Returns(appDef);
        mock.Setup(x => x.GetApplication("admin")).Returns(adminApp);
        return mock.Object;
    }

    [Fact]
    public async Task GetEntities_ReturnsProducts_WhenEntityExists()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Set<Product>().Add(new Product { Name = "Test Product", Price = 10.99m });
        await context.SaveChangesAsync();

        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var result = await controller.GetEntities("admin", "dbo", "Product");

        var okResult = Assert.IsType<OkObjectResult>(result);
        var products = Assert.IsAssignableFrom<IEnumerable<Product>>(okResult.Value);
        Assert.Single(products);
        Assert.Equal("Test Product", products.First().Name);
    }

    [Fact]
    public async Task GetEntities_ReturnsCategories_WhenEntityExists()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Set<Category>().Add(new Category { Name = "Test Category" });
        await context.SaveChangesAsync();

        var metadataService = new TestEntityMetadataService(typeof(Category), "Category");
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var result = await controller.GetEntities("admin", "dbo", "Category");

        var okResult = Assert.IsType<OkObjectResult>(result);
        var categories = Assert.IsAssignableFrom<IEnumerable<Category>>(okResult.Value);
        Assert.Single(categories);
        Assert.Equal("Test Category", categories.First().Name);
    }

    [Fact]
    public async Task GetEntities_Returns404_WhenEntityNotFound()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        var metadataService = new TestEntityMetadataService(null, null);
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var result = await controller.GetEntities("admin", "dbo", "invalid");

        var notFoundResult = Assert.IsType<NotFoundObjectResult>(result);
        Assert.NotNull(notFoundResult.Value);
    }

    [Fact]
    public async Task GetEntityCount_ReturnsCount_WhenEntityExists()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Set<Product>().AddRange(
            new Product { Name = "Product 1", Price = 10.99m },
            new Product { Name = "Product 2", Price = 20.99m },
            new Product { Name = "Product 3", Price = 30.99m }
        );
        await context.SaveChangesAsync();

        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var result = await controller.GetEntityCount("admin", "dbo", "Product");

        var okResult = Assert.IsType<OkObjectResult>(result.Result);
        Assert.Equal(3, okResult.Value);
    }

    [Fact]
    public async Task GetEntityCount_Returns404_WhenEntityNotFound()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        var metadataService = new TestEntityMetadataService(null, null);
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var result = await controller.GetEntityCount("admin", "dbo", "invalid");

        var notFoundResult = Assert.IsType<NotFoundObjectResult>(result.Result);
        Assert.NotNull(notFoundResult.Value);
    }

    [Fact]
    public async Task CreateEntity_CreatesAndReturnsEntity_WhenValidJson()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = new TestEntityMetadataService(typeof(Category), "Category");
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var httpContext = new Microsoft.AspNetCore.Http.DefaultHttpContext();
        var jsonBody = "{\"Name\":\"New Category\"}";
        httpContext.Request.Body = new System.IO.MemoryStream(System.Text.Encoding.UTF8.GetBytes(jsonBody));
        controller.ControllerContext = new ControllerContext
        {
            HttpContext = httpContext
        };

        var result = await controller.CreateEntity("admin", "dbo", "Category");

        var createdResult = Assert.IsType<CreatedAtActionResult>(result);
        var category = Assert.IsType<Category>(createdResult.Value);
        Assert.Equal("New Category", category.Name);

        var savedCount = await context.Set<Category>().CountAsync();
        Assert.Equal(1, savedCount);
    }

    [Fact]
    public async Task CreateEntity_Returns404_WhenEntityNotFound()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        var metadataService = new TestEntityMetadataService(null, null);
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var httpContext = new Microsoft.AspNetCore.Http.DefaultHttpContext();
        httpContext.Request.Body = new System.IO.MemoryStream(System.Text.Encoding.UTF8.GetBytes("{}"));
        controller.ControllerContext = new ControllerContext
        {
            HttpContext = httpContext
        };

        var result = await controller.CreateEntity("admin", "dbo", "invalid");

        Assert.IsType<NotFoundObjectResult>(result);
    }

    [Fact]
    public async Task CreateEntity_ReturnsBadRequest_WhenEmptyBody()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        var metadataService = new TestEntityMetadataService(typeof(Category), "Category");
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var httpContext = new Microsoft.AspNetCore.Http.DefaultHttpContext();
        httpContext.Request.Body = new System.IO.MemoryStream(System.Text.Encoding.UTF8.GetBytes(""));
        controller.ControllerContext = new ControllerContext
        {
            HttpContext = httpContext
        };

        var result = await controller.CreateEntity("admin", "dbo", "Category");

        var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
        Assert.NotNull(badRequestResult.Value);
    }

    [Fact]
    public async Task CreateEntity_ReturnsBadRequest_WhenInvalidJson()
    {
        await using var connection = new SqliteConnection("DataSource=:memory:");
        await connection.OpenAsync();
        var options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(connection)
            .Options;

        await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
        var metadataService = new TestEntityMetadataService(typeof(Category), "Category");
        var operationService = new EntityOperationService(context, metadataService);
        var appDictionary = CreateMockAppDictionary();
        var controller = new EntitiesController(operationService, metadataService, appDictionary);

        var httpContext = new Microsoft.AspNetCore.Http.DefaultHttpContext();
        httpContext.Request.Body = new System.IO.MemoryStream(System.Text.Encoding.UTF8.GetBytes("{invalid json}"));
        controller.ControllerContext = new ControllerContext
        {
            HttpContext = httpContext
        };

        var result = await controller.CreateEntity("admin", "dbo", "Category");

        var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
        Assert.NotNull(badRequestResult.Value);
    }

    private sealed class TestTenantSchemaAccessor : ITenantSchemaAccessor
    {
        public TestTenantSchemaAccessor(string schema) => Schema = schema;
        public string Schema { get; }
    }

    private sealed class TestEntityMetadataService : IEntityMetadataService
    {
        private readonly EntityMetadata? _metadata;

        public TestEntityMetadataService(System.Type? clrType, string? entityName)
        {
            if (clrType != null && entityName != null)
            {
                var entity = new Entity { Name = entityName, Properties = new List<Property>() };
                _metadata = new EntityMetadata(entity, clrType);
            }
        }

        public IReadOnlyList<EntityMetadata> Entities =>
            _metadata != null ? new[] { _metadata } : System.Array.Empty<EntityMetadata>();

        public EntityMetadata? Find(string entityName) => _metadata;

        public IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName) =>
            _metadata != null ? new[] { _metadata } : System.Array.Empty<EntityMetadata>();

        public bool IsEntityVisibleInApplication(EntityMetadata entity, string appName) => true;
    }
}
