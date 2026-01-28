using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;
using DotNetWebApp.Services;
using DotNetWebApp.Tests.TestEntities;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests;

public class EntityApiServiceTests
{
    private IApplicationContextAccessor CreateMockApplicationContext()
    {
        var mock = new Mock<IApplicationContextAccessor>();
        mock.Setup(x => x.ApplicationName).Returns("admin");
        return mock.Object;
    }

    [Fact]
    public async Task GetEntitiesAsync_ReturnsProducts_WhenEntityExists()
    {
        var product1 = new Product { Id = 1, Name = "Product 1", Price = 10.99m };
        var product2 = new Product { Id = 2, Name = "Product 2", Price = 20.99m };
        var json = JsonSerializer.Serialize(new[] { product1, product2 });

        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.OK, json))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        var result = await service.GetEntitiesAsync("Product");

        Assert.NotNull(result);
        var entities = result.Cast<Product>().ToList();
        Assert.Equal(2, entities.Count);
        Assert.Equal("Product 1", entities[0].Name);
        Assert.Equal("Product 2", entities[1].Name);
    }

    [Fact]
    public async Task GetEntitiesAsync_ThrowsException_WhenEntityNotFound()
    {
        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.OK, "[]"))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(null, null);
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.GetEntitiesAsync("Unknown"));
    }

    [Fact]
    public async Task GetEntitiesAsync_ThrowsException_WhenHttpRequestFails()
    {
        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.NotFound, ""))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.GetEntitiesAsync("Product"));
    }

    [Fact]
    public async Task GetCountAsync_ReturnsCount_WhenEntityExists()
    {
        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.OK, "42"))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        var result = await service.GetCountAsync("Product");

        Assert.Equal(42, result);
    }

    [Fact]
    public async Task GetCountAsync_ThrowsException_WhenEntityNotFound()
    {
        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.OK, "0"))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(null, null);
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.GetCountAsync("Unknown"));
    }

    [Fact]
    public async Task GetCountAsync_ThrowsException_WhenHttpRequestFails()
    {
        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.InternalServerError, ""))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.GetCountAsync("Product"));
    }

    [Fact]
    public async Task CreateEntityAsync_ReturnsCreatedEntity_WhenValid()
    {
        var createdProduct = new Product { Id = 1, Name = "New Product", Price = 15.99m };
        var responseJson = JsonSerializer.Serialize(createdProduct);

        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.Created, responseJson))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        var newProduct = new Product { Name = "New Product", Price = 15.99m };
        var result = await service.CreateEntityAsync("Product", newProduct);

        var createdProductResult = Assert.IsType<Product>(result);
        Assert.Equal(1, createdProductResult.Id);
        Assert.Equal("New Product", createdProductResult.Name);
    }

    [Fact]
    public async Task CreateEntityAsync_ThrowsException_WhenEntityNotFound()
    {
        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.Created, "{}"))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(null, null);
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        var newProduct = new Product { Name = "New Product", Price = 15.99m };

        await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.CreateEntityAsync("Unknown", newProduct));
    }

    [Fact]
    public async Task CreateEntityAsync_ThrowsException_WhenHttpRequestFails()
    {
        var httpClient = new HttpClient(new FakeHttpMessageHandler(HttpStatusCode.BadRequest, ""))
        {
            BaseAddress = new Uri("http://localhost/")
        };
        var metadataService = new TestEntityMetadataService(typeof(Product), "Product");
        var appContext = CreateMockApplicationContext();
        var service = new EntityApiService(httpClient, metadataService, appContext);

        var newProduct = new Product { Name = "New Product", Price = 15.99m };

        await Assert.ThrowsAsync<InvalidOperationException>(
            () => service.CreateEntityAsync("Product", newProduct));
    }

    private sealed class FakeHttpMessageHandler : HttpMessageHandler
    {
        private readonly HttpStatusCode _statusCode;
        private readonly string _content;

        public FakeHttpMessageHandler(HttpStatusCode statusCode, string content)
        {
            _statusCode = statusCode;
            _content = content;
        }

        protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            var response = new HttpResponseMessage(_statusCode)
            {
                Content = new StringContent(_content)
            };
            return Task.FromResult(response);
        }
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
