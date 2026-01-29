using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;
using DotNetWebApp.Services;
using DotNetWebApp.Tests.TestEntities;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace DotNetWebApp.Tests.UI;

/// <summary>
/// Integration tests for SmartDataGrid write operations via IEntityOperationService
/// Verifies that Update and Delete operations work correctly with entity data
/// </summary>
public class SmartDataGridIntegrationTests : IDisposable
{
    private readonly SqliteConnection _connection;
    private readonly DbContextOptions<TestAppDbContext> _options;

    public SmartDataGridIntegrationTests()
    {
        _connection = new SqliteConnection("DataSource=:memory:");
        _connection.Open();
        _options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(_connection)
            .Options;
    }

    [Fact]
    public async Task UpdateAsync_WithValidEntity_UpdatesDatabase()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "Original Category" };
        context.Categories.Add(category);
        await context.SaveChangesAsync();

        var categoryId = category.Id;
        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act - Update the category
        var updatedCategory = new Category { Id = categoryId, Name = "Updated Category" };
        var result = await service.UpdateAsync(typeof(Category), updatedCategory);

        // Assert
        Assert.NotNull(result);
        var dbCategory = await context.Categories.FirstOrDefaultAsync(c => c.Id == categoryId);
        Assert.NotNull(dbCategory);
        Assert.Equal("Updated Category", dbCategory.Name);
    }

    [Fact]
    public async Task DeleteAsync_WithValidId_DeletesFromDatabase()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "Category to Delete" };
        context.Categories.Add(category);
        await context.SaveChangesAsync();

        var categoryId = category.Id;
        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act - Delete the category
        await service.DeleteAsync(typeof(Category), categoryId);

        // Assert
        var dbCategory = await context.Categories.FirstOrDefaultAsync(c => c.Id == categoryId);
        Assert.Null(dbCategory);
    }

    [Fact]
    public async Task UpdateAsync_WithMultipleChanges_PersistsAllChanges()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var product = new Product
        {
            Name = "Original Product",
            Price = 10.00m
        };
        context.Products.Add(product);
        await context.SaveChangesAsync();

        var productId = product.Id;
        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act - Update multiple properties
        var updatedProduct = new Product
        {
            Id = productId,
            Name = "Updated Product",
            Price = 20.00m
        };
        await service.UpdateAsync(typeof(Product), updatedProduct);

        // Assert
        var dbProduct = await context.Products.FirstOrDefaultAsync(p => p.Id == productId);
        Assert.NotNull(dbProduct);
        Assert.Equal("Updated Product", dbProduct.Name);
        Assert.Equal(20.00m, dbProduct.Price);
    }

    [Fact]
    public async Task GetAllAsync_ReturnsAllEntities()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Categories.AddRange(
            new Category { Name = "Category 1" },
            new Category { Name = "Category 2" },
            new Category { Name = "Category 3" }
        );
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act
        var result = await service.GetAllAsync(typeof(Category));

        // Assert
        Assert.NotEmpty(result);
        Assert.Equal(3, result.Count);
    }

    [Fact]
    public async Task GetByIdAsync_WithValidId_ReturnsEntity()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "Test Category" };
        context.Categories.Add(category);
        await context.SaveChangesAsync();

        var categoryId = category.Id;
        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act
        var result = await service.GetByIdAsync(typeof(Category), categoryId);

        // Assert
        Assert.NotNull(result);
        Assert.IsType<Category>(result);
        var dbCategory = (Category)result;
        Assert.Equal("Test Category", dbCategory.Name);
    }

    [Fact]
    public async Task CreateAsync_WithNewEntity_AddsToDatabase()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "New Category" };
        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act
        var result = await service.CreateAsync(typeof(Category), category);

        // Assert
        Assert.NotNull(result);
        Assert.IsType<Category>(result);

        var dbCategory = await context.Categories.FirstOrDefaultAsync(c => c.Name == "New Category");
        Assert.NotNull(dbCategory);
    }

    [Fact]
    public async Task GetCountAsync_ReturnsCorrectCount()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Categories.AddRange(
            new Category { Name = "Category 1" },
            new Category { Name = "Category 2" }
        );
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act
        var count = await service.GetCountAsync(typeof(Category));

        // Assert
        Assert.Equal(2, count);
    }

    [Fact]
    public async Task DeleteAsync_WithInvalidId_ThrowsException()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);
        var invalidId = 99999;

        // Act & Assert
        await Assert.ThrowsAnyAsync<Exception>(
            () => service.DeleteAsync(typeof(Category), invalidId));
    }

    [Fact]
    public async Task UpdateAsync_WithNonExistentEntity_ThrowsException()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);
        var nonExistentCategory = new Category { Id = 99999, Name = "Non-existent" };

        // Act & Assert
        await Assert.ThrowsAnyAsync<Exception>(
            () => service.UpdateAsync(typeof(Category), nonExistentCategory));
    }

    /// <summary>
    /// Simulates SmartDataGrid workflow: Get all -> Update -> Get all (verify change)
    /// </summary>
    [Fact]
    public async Task SmartDataGrid_UpdateWorkflow_UpdatesAndRefreshesData()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "Beverages" };
        context.Categories.Add(category);
        await context.SaveChangesAsync();

        var categoryId = category.Id;
        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act - Simulate SmartDataGrid update workflow
        var all1 = await service.GetAllAsync(typeof(Category));
        var originalCount = all1.Count;

        var categoryToUpdate = new Category { Id = categoryId, Name = "Updated Beverages" };
        await service.UpdateAsync(typeof(Category), categoryToUpdate);

        var all2 = await service.GetAllAsync(typeof(Category));

        // Assert
        Assert.Equal(originalCount, all2.Count); // Count should stay same
        var updated = all2.Cast<Category>().FirstOrDefault(c => c.Id == categoryId);
        Assert.NotNull(updated);
        Assert.Equal("Updated Beverages", updated.Name);
    }

    /// <summary>
    /// Simulates SmartDataGrid workflow: Get all -> Delete -> Get all (verify removal)
    /// </summary>
    [Fact]
    public async Task SmartDataGrid_DeleteWorkflow_DeletesAndRefreshesData()
    {
        // Arrange
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var categories = new[]
        {
            new Category { Name = "Category 1" },
            new Category { Name = "Category 2" },
            new Category { Name = "Category 3" }
        };

        context.Categories.AddRange(categories);
        await context.SaveChangesAsync();

        var categoryId = categories.First().Id;
        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        // Act - Simulate SmartDataGrid delete workflow
        var all1 = await service.GetAllAsync(typeof(Category));
        var originalCount = all1.Count;

        await service.DeleteAsync(typeof(Category), categoryId);

        var all2 = await service.GetAllAsync(typeof(Category));

        // Assert
        Assert.Equal(originalCount - 1, all2.Count); // Count should decrease
        var deleted = all2.Cast<Category>().FirstOrDefault(c => c.Id == categoryId);
        Assert.Null(deleted);
    }

    private static IEntityMetadataService CreateMetadataService()
    {
        return new TestEntityMetadataService(
            new[] { typeof(Product), typeof(Category) },
            new[] { "Product", "Category" }
        );
    }

    private sealed class TestTenantSchemaAccessor : ITenantSchemaAccessor
    {
        public TestTenantSchemaAccessor(string schema) => Schema = schema;
        public string Schema { get; }
    }

    private sealed class TestEntityMetadataService : IEntityMetadataService
    {
        private readonly List<EntityMetadata> _entities;

        public TestEntityMetadataService(Type[] clrTypes, string[] entityNames)
        {
            _entities = new List<EntityMetadata>();
            for (int i = 0; i < clrTypes.Length; i++)
            {
                var entity = new Entity
                {
                    Name = entityNames[i],
                    Properties = new List<Property>
                    {
                        new Property { Name = "Id", Type = "int", IsPrimaryKey = true },
                        new Property { Name = "Name", Type = "string" }
                    }
                };
                _entities.Add(new EntityMetadata(entity, clrTypes[i]));
            }
        }

        public IReadOnlyList<EntityMetadata> Entities => _entities.AsReadOnly();
        public EntityMetadata? Find(string entityName)
        {
            return _entities.FirstOrDefault(e => e.Definition.Name == entityName);
        }

        public IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName)
        {
            return _entities.AsReadOnly();
        }

        public bool IsEntityVisibleInApplication(EntityMetadata entity, string appName)
        {
            return true;
        }
    }

    public void Dispose()
    {
        _connection?.Dispose();
    }
}
