using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DotNetWebApp.Models;
using DotNetWebApp.Services;
using DotNetWebApp.Tests.TestEntities;
using DotNetWebApp.Data.Tenancy;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace DotNetWebApp.Tests;

public class EntityOperationServiceTests
{
    private readonly SqliteConnection _connection;
    private readonly DbContextOptions<TestAppDbContext> _options;

    public EntityOperationServiceTests()
    {
        _connection = new SqliteConnection("DataSource=:memory:");
        _connection.Open();
        _options = new DbContextOptionsBuilder<TestAppDbContext>()
            .UseSqlite(_connection)
            .Options;
    }

    [Fact]
    public async Task GetAllAsync_WithProducts_ReturnsAllEntities()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Set<Product>().AddRange(
            new Product { Name = "Product 1", Price = 10.99m },
            new Product { Name = "Product 2", Price = 20.99m }
        );
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var result = await service.GetAllAsync(typeof(Product));

        Assert.NotNull(result);
        Assert.Equal(2, result.Count);
    }

    [Fact]
    public async Task GetAllAsync_WithEmptyTable_ReturnsEmptyList()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var result = await service.GetAllAsync(typeof(Product));

        Assert.NotNull(result);
        Assert.Empty(result);
    }

    [Fact]
    public async Task GetCountAsync_WithProducts_ReturnsCorrectCount()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Set<Product>().AddRange(
            new Product { Name = "Product 1", Price = 10.99m },
            new Product { Name = "Product 2", Price = 20.99m },
            new Product { Name = "Product 3", Price = 30.99m }
        );
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var count = await service.GetCountAsync(typeof(Product));

        Assert.Equal(3, count);
    }

    [Fact]
    public async Task GetCountAsync_WithEmptyTable_ReturnsZero()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var count = await service.GetCountAsync(typeof(Product));

        Assert.Equal(0, count);
    }

    [Fact]
    public async Task CreateAsync_WithValidEntity_CreatesAndReturnEntity()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var product = new Product { Name = "New Product", Price = 15.99m };

        var result = await service.CreateAsync(typeof(Product), product);

        Assert.NotNull(result);
        Assert.IsType<Product>(result);

        var savedCount = await context.Set<Product>().CountAsync();
        Assert.Equal(1, savedCount);

        var savedProduct = await context.Set<Product>().FirstAsync();
        Assert.Equal("New Product", savedProduct.Name);
        Assert.Equal(15.99m, savedProduct.Price);
    }

    [Fact]
    public async Task CreateAsync_MultipleCalls_CreatesMultipleEntities()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var product1 = new Product { Name = "Product 1", Price = 10.99m };
        var product2 = new Product { Name = "Product 2", Price = 20.99m };

        await service.CreateAsync(typeof(Product), product1);
        await service.CreateAsync(typeof(Product), product2);

        var count = await context.Set<Product>().CountAsync();
        Assert.Equal(2, count);
    }

    [Fact]
    public async Task GetByIdAsync_WithExistingId_ReturnsEntity()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var product = new Product { Name = "Test Product", Price = 10.99m };
        context.Set<Product>().Add(product);
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var result = await service.GetByIdAsync(typeof(Product), product.Id);

        Assert.NotNull(result);
        Assert.IsType<Product>(result);
        var retrievedProduct = (Product)result;
        Assert.Equal(product.Id, retrievedProduct.Id);
        Assert.Equal("Test Product", retrievedProduct.Name);
    }

    [Fact]
    public async Task GetByIdAsync_WithNonExistentId_ReturnsNull()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var result = await service.GetByIdAsync(typeof(Product), 999);

        Assert.Null(result);
    }

    [Fact]
    public async Task UpdateAsync_WithExistingEntity_UpdatesAndReturnEntity()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var product = new Product { Name = "Original Product", Price = 10.99m };
        context.Set<Product>().Add(product);
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var updatedProduct = new Product { Id = product.Id, Name = "Updated Product", Price = 20.99m };

        var result = await service.UpdateAsync(typeof(Product), updatedProduct);

        Assert.NotNull(result);
        Assert.IsType<Product>(result);

        var savedProduct = await context.Set<Product>().FindAsync(product.Id);
        Assert.Equal("Updated Product", savedProduct!.Name);
        Assert.Equal(20.99m, savedProduct.Price);
    }

    [Fact]
    public async Task UpdateAsync_WithNonExistentId_ThrowsException()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var product = new Product { Id = 999, Name = "Non-existent", Price = 10.99m };

        var ex = await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.UpdateAsync(typeof(Product), product));
        Assert.Contains("not found", ex.Message);
    }

    [Fact]
    public async Task DeleteAsync_WithExistingId_RemovesEntity()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var product = new Product { Name = "Product to Delete", Price = 10.99m };
        context.Set<Product>().Add(product);
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        await service.DeleteAsync(typeof(Product), product.Id);

        var count = await context.Set<Product>().CountAsync();
        Assert.Equal(0, count);
    }

    [Fact]
    public async Task DeleteAsync_WithNonExistentId_ThrowsException()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var ex = await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.DeleteAsync(typeof(Product), 999));
        Assert.Contains("not found", ex.Message);
    }

    [Fact]
    public async Task GetAllAsync_WithCategories_ReturnsAllCategories()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        context.Set<Category>().AddRange(
            new Category { Name = "Category 1" },
            new Category { Name = "Category 2" },
            new Category { Name = "Category 3" }
        );
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var result = await service.GetAllAsync(typeof(Category));

        Assert.NotNull(result);
        Assert.Equal(3, result.Count);
    }

    [Fact]
    public async Task CreateAsync_WithCategories_CreatesCategory()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var category = new Category { Name = "New Category" };

        var result = await service.CreateAsync(typeof(Category), category);

        Assert.NotNull(result);
        Assert.IsType<Category>(result);

        var savedCount = await context.Set<Category>().CountAsync();
        Assert.Equal(1, savedCount);
    }

    [Fact]
    public async Task GetByIdAsync_WithCategories_ReturnsCategory()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "Test Category" };
        context.Set<Category>().Add(category);
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var result = await service.GetByIdAsync(typeof(Category), category.Id);

        Assert.NotNull(result);
        Assert.IsType<Category>(result);
        var retrievedCategory = (Category)result;
        Assert.Equal(category.Id, retrievedCategory.Id);
        Assert.Equal("Test Category", retrievedCategory.Name);
    }

    [Fact]
    public async Task UpdateAsync_WithCategories_UpdatesCategory()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "Original Category" };
        context.Set<Category>().Add(category);
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        var updatedCategory = new Category { Id = category.Id, Name = "Updated Category" };

        var result = await service.UpdateAsync(typeof(Category), updatedCategory);

        Assert.NotNull(result);

        var savedCategory = await context.Set<Category>().FindAsync(category.Id);
        Assert.Equal("Updated Category", savedCategory!.Name);
    }

    [Fact]
    public async Task DeleteAsync_WithCategories_DeletesCategory()
    {
        await using var context = new TestAppDbContext(_options, new TestTenantSchemaAccessor("dbo"));
        await context.Database.EnsureCreatedAsync();

        var category = new Category { Name = "Category to Delete" };
        context.Set<Category>().Add(category);
        await context.SaveChangesAsync();

        var metadataService = CreateMetadataService();
        var service = new EntityOperationService(context, metadataService);

        await service.DeleteAsync(typeof(Category), category.Id);

        var count = await context.Set<Category>().CountAsync();
        Assert.Equal(0, count);
    }

    private sealed class TestTenantSchemaAccessor : ITenantSchemaAccessor
    {
        public TestTenantSchemaAccessor(string schema) => Schema = schema;
        public string Schema { get; }
    }

    private static IEntityMetadataService CreateMetadataService()
    {
        return new TestEntityMetadataService(
            new[] { typeof(Product), typeof(Category) },
            new[] { "Product", "Category" }
        );
    }

    private sealed class TestEntityMetadataService : IEntityMetadataService
    {
        private readonly List<EntityMetadata> _entities;

        public TestEntityMetadataService(Type[] clrTypes, string[] entityNames)
        {
            _entities = new List<EntityMetadata>();
            for (int i = 0; i < clrTypes.Length; i++)
            {
                var entity = new Models.AppDictionary.Entity
                {
                    Name = entityNames[i],
                    Properties = new List<Models.AppDictionary.Property>
                    {
                        new Models.AppDictionary.Property
                        {
                            Name = "Id",
                            Type = "int",
                            IsPrimaryKey = true
                        }
                    }
                };
                _entities.Add(new EntityMetadata(entity, clrTypes[i]));
            }
        }

        public IReadOnlyList<EntityMetadata> Entities => _entities.AsReadOnly();

        public EntityMetadata? Find(string entityName)
        {
            return _entities.FirstOrDefault(e =>
                e.Definition.Name.Equals(entityName, StringComparison.OrdinalIgnoreCase));
        }

        public IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName) =>
            _entities.AsReadOnly();

        public bool IsEntityVisibleInApplication(EntityMetadata entity, string appName) => true;
    }
}
