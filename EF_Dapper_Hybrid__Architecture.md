# This file follows **Microsoft Clean Architecture** standards:

### 1. **EF Core** is isolated in the Infrastructure layer (for migrations and state).  
### 2. **Dapper** is utilized in the Application layer (for fast reads and complex SQL writes).  
### 3. **Blazor/Radzen** stays in the Web layer, consuming the Dapper DTOs.

## **Implementation Blueprint: HybridArchitecture.md**

### TASK: Implement Hybrid .NET 8/9 Clean Architecture (EF Core \+ Dapper)

## **1. PRE-REQUISITES**  
- Create a new directory and execute all shell commands from the root.  
- Ensure .NET SDK 8.0 or higher is installed.

## **2. PROJECT INITIALIZATION (CLI)**  
Execute these commands to build the four-tier architecture:

```bash  
dotnet new sln -n HybridSystem  
dotnet new classlib -n HybridSystem.Domain  
dotnet new classlib -n HybridSystem.Application  
dotnet new classlib -n HybridSystem.Infrastructure  
dotnet new blazor -n HybridSystem.WebUI --interactivity Server  
dotnet sln add (ls **/*.csproj)
```

## **3. DEPENDENCY GRAPH**

Configure references to ensure the Domain remains pure:
* **Application** -> Domain  
* **Infrastructure** -> Application, Domain  
* **WebUI** -> Infrastructure, Application

## **4. MODULE ARCHITECTURE & STANDARDS**

### **A. DOMAIN LAYER (POCOs)**

* **Path**: HybridSystem.Domain/Entities/  
* **Rule**: Pure C\# classes only. No EF or Dapper references.  
* **Goal**: Database-agnostic business models.

### **B. INFRASTRUCTURE LAYER (EF/LINQ)**

* **Path**: HybridSystem.Infrastructure/Persistence/  
* **Technology**: EF Core (Microsoft.EntityFrameworkCore.SqlServer)  
* **Purpose**: Database schema management, Migrations, and Identity.  
* **Best Practice**: Use this layer for "Writes" where change-tracking is needed (e.g., Simple CRUD).

### **C. APPLICATION LAYER (DAPPER/SQL)**

* **Path**: HybridSystem.Application/Data/  
* **Technology**: Dapper  
* **Purpose**: High-performance Read models (DTOs) and Complex "Task-Writes."  
* **Standard**: All DTOs for Radzen components live here. Hand-written SQL only.

## **5. CODE IMPLEMENTATION: SHARED CONNECTION**

Create a service in HybridSystem.Infrastructure that registers a shared IDbConnection so EF and Dapper share the same underlying pipeline:

### 5.1 DbContext with Dynamic Entity Registration

**File:** `Data/EF/AppDbContext.cs`

```csharp
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using DotNetWebApp.Data.Tenancy;

namespace DotNetWebApp.Data.EF
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(
            DbContextOptions<AppDbContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor) : base(options)
        {
            Schema = tenantSchemaAccessor.Schema;
        }

        public string Schema { get; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Set default schema for multi-tenancy
            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            // Dynamically register ALL entities from Generated namespace via reflection
            var entityTypes = Assembly.GetExecutingAssembly().GetTypes()
                .Where(t => t.IsClass && t.Namespace == "DotNetWebApp.Models.Generated");

            foreach (var type in entityTypes)
            {
                modelBuilder.Entity(type)
                    .ToTable(ToPlural(type.Name));  // Product → Products
            }
        }

        // Pluralization logic: Category → Categories, Product → Products
        private static string ToPlural(string name)
        {
            if (name.EndsWith("y", StringComparison.OrdinalIgnoreCase) && name.Length > 1)
            {
                var beforeY = name[name.Length - 2];
                if (!"aeiou".Contains(char.ToLowerInvariant(beforeY)))
                {
                    return name[..^1] + "ies";
                }
            }
            return name.EndsWith("s", StringComparison.OrdinalIgnoreCase) ? name : $"{name}s";
        }
    }
}
```

### 5.2 Shared Connection Setup in Program.cs

**File:** `Program.cs`

```csharp
using System.Data;
using System.Data.SqlClient;

// EF Core with connection pooling
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        sqlServerOptions => sqlServerOptions
            .CommandTimeout(30)
            .EnableRetryOnFailure(maxRetryCount: 3, maxRetryDelaySeconds: 5)));

builder.Services.AddScoped<DbContext>(sp => sp.GetRequiredService<AppDbContext>());

// Dapper: Share the same connection pool
builder.Services.AddScoped<IDbConnection>(sp =>
{
    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
        ?? throw new InvalidOperationException("Connection string not found");
    return new SqlConnection(connectionString);
});

// Data access abstraction
builder.Services.AddScoped<IDapperRepository, DapperRepository>();
```

### 5.3 Dapper Repository Interface

**File:** `Data/Dapper/IDapperRepository.cs`

```csharp
using System.Data;

namespace DotNetWebApp.Data.Dapper
{
    public interface IDapperRepository
    {
        Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null);
        Task<T?> QuerySingleAsync<T>(string sql, object? param = null);
        Task<int> ExecuteAsync(string sql, object? param = null);
        Task<IMultipleQuery> QueryMultipleAsync(string sql, object? param = null);
    }

    public interface IMultipleQuery : IDisposable
    {
        IEnumerable<T> Read<T>();
    }
}
```

### 5.4 Dapper Repository Implementation

**File:** `Data/Dapper/DapperRepository.cs`

```csharp
using System.Data;
using Dapper;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Data.Dapper
{
    public class DapperRepository : IDapperRepository
    {
        private readonly IDbConnection _connection;
        private readonly ILogger<DapperRepository> _logger;

        public DapperRepository(IDbConnection connection, ILogger<DapperRepository> logger)
        {
            _connection = connection;
            _logger = logger;
        }

        public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
        {
            try
            {
                _logger.LogDebug("Executing query: {Sql}", sql);
                return await _connection.QueryAsync<T>(sql, param);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Query failed: {Sql}", sql);
                throw new InvalidOperationException($"Query execution failed: {ex.Message}", ex);
            }
        }

        public async Task<T?> QuerySingleAsync<T>(string sql, object? param = null)
        {
            try
            {
                _logger.LogDebug("Executing single query: {Sql}", sql);
                return await _connection.QuerySingleOrDefaultAsync<T>(sql, param);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Query failed: {Sql}", sql);
                throw new InvalidOperationException($"Query execution failed: {ex.Message}", ex);
            }
        }

        public async Task<int> ExecuteAsync(string sql, object? param = null)
        {
            try
            {
                _logger.LogDebug("Executing command: {Sql}", sql);
                return await _connection.ExecuteAsync(sql, param);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Command failed: {Sql}", sql);
                throw new InvalidOperationException($"Command execution failed: {ex.Message}", ex);
            }
        }

        public async Task<IMultipleQuery> QueryMultipleAsync(string sql, object? param = null)
        {
            try
            {
                _logger.LogDebug("Executing multiple query: {Sql}", sql);
                var grid = await _connection.QueryMultipleAsync(sql, param);
                return new DapperMultipleQuery(grid);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Multiple query failed: {Sql}", sql);
                throw new InvalidOperationException($"Multiple query failed: {ex.Message}", ex);
            }
        }
    }

    public class DapperMultipleQuery : IMultipleQuery
    {
        private readonly SqlMapper.GridReader _grid;

        public DapperMultipleQuery(SqlMapper.GridReader grid)
        {
            _grid = grid;
        }

        public IEnumerable<T> Read<T>()
        {
            return _grid.Read<T>();
        }

        public void Dispose()
        {
            _grid?.Dispose();
        }
    }
}
```

## **6. APPLICATION LAYER: DAPPER SERVICES**

### 6.1 Dapper Service for Complex Reads

When you need high-performance reads with JOINs and complex queries, create a Dapper service in the Application layer:

**File:** `Data/Dapper/ProductDapperService.cs`

```csharp
namespace DotNetWebApp.Data.Dapper
{
    public interface IProductDapperService
    {
        Task<IEnumerable<ProductReadDto>> GetProductsWithCategoriesAsync();
        Task<ProductSalesReportDto> GetSalesReportAsync(int productId);
    }

    public class ProductDapperService : IProductDapperService
    {
        private readonly IDapperRepository _repository;
        private readonly ILogger<ProductDapperService> _logger;

        public ProductDapperService(IDapperRepository repository, ILogger<ProductDapperService> logger)
        {
            _repository = repository;
            _logger = logger;
        }

        // Simple join query
        public async Task<IEnumerable<ProductReadDto>> GetProductsWithCategoriesAsync()
        {
            const string sql = @"
                SELECT
                    p.Id,
                    p.Name,
                    p.Price,
                    c.Name AS CategoryName
                FROM Products p
                LEFT JOIN Categories c ON p.CategoryId = c.Id
                ORDER BY c.Name, p.Name";

            return await _repository.QueryAsync<ProductReadDto>(sql);
        }

        // Complex report with CTE and aggregation
        public async Task<ProductSalesReportDto> GetSalesReportAsync(int productId)
        {
            const string sql = @"
                -- Summary stats
                SELECT
                    p.Id,
                    p.Name,
                    COUNT(*) AS TotalOrders,
                    ISNULL(SUM(Quantity), 0) AS TotalQuantitySold,
                    ISNULL(SUM(Quantity * p.Price), 0) AS TotalRevenue
                FROM Products p
                LEFT JOIN OrderDetails od ON p.Id = od.ProductId
                WHERE p.Id = @ProductId
                GROUP BY p.Id, p.Name;

                -- Recent orders
                SELECT TOP 10
                    od.Id,
                    o.OrderDate,
                    od.Quantity,
                    CAST(od.Quantity * p.Price AS DECIMAL(18,2)) AS LineTotal
                FROM OrderDetails od
                JOIN Orders o ON od.OrderId = o.Id
                JOIN Products p ON od.ProductId = p.Id
                WHERE p.Id = @ProductId
                ORDER BY o.OrderDate DESC";

            using var multi = await _repository.QueryMultipleAsync(sql, new { ProductId = productId });

            var summary = multi.Read<ProductSalesReportDto>().FirstOrDefault()
                ?? throw new InvalidOperationException($"Product {productId} not found");

            summary.RecentOrders = multi.Read<OrderLineDto>().ToList();
            return summary;
        }
    }

    public class ProductReadDto
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public decimal? Price { get; set; }
        public string? CategoryName { get; set; }
    }

    public class ProductSalesReportDto
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public int TotalOrders { get; set; }
        public int TotalQuantitySold { get; set; }
        public decimal TotalRevenue { get; set; }
        public List<OrderLineDto> RecentOrders { get; set; } = new();
    }

    public class OrderLineDto
    {
        public int Id { get; set; }
        public DateTime OrderDate { get; set; }
        public int Quantity { get; set; }
        public decimal LineTotal { get; set; }
    }
}
```

### 6.2 Dapper Write Operations

When a user clicks "Process" in the UI, use Dapper in the Application Layer to execute complex write operations:

**File:** `Data/Dapper/OrderProcessingService.cs`

```csharp
namespace DotNetWebApp.Data.Dapper
{
    public interface IOrderProcessingService
    {
        Task ProcessOrderAsync(int orderId);
        Task UpdateBulkInventoryAsync(List<(int productId, int quantityAdjustment)> adjustments);
    }

    public class OrderProcessingService : IOrderProcessingService
    {
        private readonly IDapperRepository _repository;
        private readonly ILogger<OrderProcessingService> _logger;

        public OrderProcessingService(IDapperRepository repository, ILogger<OrderProcessingService> logger)
        {
            _repository = repository;
            _logger = logger;
        }

        // Complex write with multiple operations in single batch
        public async Task ProcessOrderAsync(int orderId)
        {
            const string sql = @"
                -- Update order status
                UPDATE Orders SET Status = 'Processed', ProcessedDate = GETUTC()
                WHERE Id = @OrderId;

                -- Log the event
                INSERT INTO AuditLog (EntityType, EntityId, Action, Timestamp)
                VALUES ('Order', @OrderId, 'Processed', GETUTC());

                -- Update inventory from order details
                UPDATE Products
                SET Stock = Stock - od.Quantity
                FROM Products p
                JOIN OrderDetails od ON p.Id = od.ProductId
                WHERE od.OrderId = @OrderId;";

            try
            {
                var rowsAffected = await _repository.ExecuteAsync(sql, new { OrderId = orderId });
                _logger.LogInformation("Processed order {OrderId}. Rows affected: {RowsAffected}",
                    orderId, rowsAffected);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to process order {OrderId}", orderId);
                throw;
            }
        }

        // Batch update operation
        public async Task UpdateBulkInventoryAsync(List<(int productId, int quantityAdjustment)> adjustments)
        {
            if (!adjustments.Any())
                return;

            var sql = @"
                UPDATE Products
                SET Stock = Stock + @QuantityAdjustment
                WHERE Id = @ProductId";

            foreach (var (productId, adjustment) in adjustments)
            {
                await _repository.ExecuteAsync(sql, new { ProductId = productId, QuantityAdjustment = adjustment });
            }

            _logger.LogInformation("Updated inventory for {Count} products", adjustments.Count);
        }
    }
}
```

### 6.3 Using Dapper Services in Blazor Components

**File:** `Components/Sections/OrderProcessingSection.razor`

```razor
@page "/order-processing"
@inject IOrderProcessingService OrderService
@inject ILogger<OrderProcessingSection> Logger

<div class="order-processing">
    <h3>Order Processing</h3>

    @if (isProcessing)
    {
        <p><em>Processing order...</em></p>
    }
    else if (!string.IsNullOrWhiteSpace(statusMessage))
    {
        <div class="alert alert-info">@statusMessage</div>
    }

    <button class="btn btn-primary" @onclick="ProcessOrderAsync" disabled="@isProcessing">
        Process Order
    </button>
</div>

@code {
    private bool isProcessing = false;
    private string? statusMessage;

    private async Task ProcessOrderAsync()
    {
        isProcessing = true;
        statusMessage = null;

        try
        {
            // This calls Dapper under the hood for high-performance processing
            await OrderService.ProcessOrderAsync(123);
            statusMessage = "Order processed successfully";
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Order processing failed");
            statusMessage = $"Error: {ex.Message}";
        }
        finally
        {
            isProcessing = false;
        }
    }
}
```

## **7. TRANSACTION COORDINATION & ERROR HANDLING**

### 7.1 Explicit Transactions with EF + Dapper

When you need to coordinate operations across both ORMs:

```csharp
public async Task ComplexBusinessOperationAsync(int productId, int quantity)
{
    using var transaction = await _dbContext.Database.BeginTransactionAsync();

    try
    {
        // EF Core operation
        var product = await _dbContext.Set<Product>()
            .FirstOrDefaultAsync(p => p.Id == productId);

        if (product == null)
            throw new InvalidOperationException($"Product {productId} not found");

        product.Stock -= quantity;

        // Dapper operation in same transaction
        const string logSql = @"
            INSERT INTO ProductActivityLog (ProductId, Action, Timestamp)
            VALUES (@ProductId, 'StockDecremented', GETUTC())";

        await _dapperRepository.ExecuteAsync(logSql, new { ProductId = productId });

        // Save both operations atomically
        await _dbContext.SaveChangesAsync();
        await transaction.CommitAsync();

        _logger.LogInformation("Operation completed for product {ProductId}", productId);
    }
    catch (Exception ex)
    {
        await transaction.RollbackAsync();
        _logger.LogError(ex, "Operation failed for product {ProductId}", productId);
        throw new DataAccessException("Failed to complete operation", ex);
    }
    finally
    {
        await transaction.DisposeAsync();
    }
}
```

### 7.2 Error Handling Strategy

**File:** `Exceptions/DataAccessException.cs`

```csharp
namespace DotNetWebApp.Exceptions
{
    public class EntityNotFoundException : Exception
    {
        public EntityNotFoundException(string entityName, int id)
            : base($"Entity '{entityName}' with ID {id} not found") { }
    }

    public class InvalidEntityDataException : Exception
    {
        public InvalidEntityDataException(string entityName, string details)
            : base($"Invalid data for entity '{entityName}': {details}") { }
    }

    public class DataAccessException : Exception
    {
        public DataAccessException(string message, Exception innerException)
            : base(message, innerException) { }
    }
}
```

### 7.3 Dependency Injection Setup

**File:** `Program.cs` (Complete DI configuration)

```csharp
// Services registration in order
var builder = WebApplication.CreateBuilder(args);

// Configuration
builder.Services.Configure<AppCustomizationOptions>(
    builder.Configuration.GetSection("AppCustomization"));
builder.Services.Configure<TenantSchemaOptions>(
    builder.Configuration.GetSection("TenantSchema"));

// Web services
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddControllers();
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddRadzenComponents();

// HTTP context and client
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<HttpClient>(sp =>
{
    var navigationManager = sp.GetRequiredService<NavigationManager>();
    var handler = new HttpClientHandler();
    if (builder.Environment.IsDevelopment())
    {
        handler.ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true;
    }
    return new HttpClient(handler) { BaseAddress = new Uri(navigationManager.BaseUri) };
});

// Infrastructure services (singletons for cached data)
builder.Services.AddSingleton<IAppDictionaryService>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var yamlPath = Path.Combine(env.ContentRootPath, "app.yaml");
    return new AppDictionaryService(yamlPath);
});
builder.Services.AddSingleton<IEntityMetadataService, EntityMetadataService>();
builder.Services.AddSingleton<IModelCacheKeyFactory, AppModelCacheKeyFactory>();

// Database layer
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        sqlServerOptions => sqlServerOptions
            .CommandTimeout(30)
            .EnableRetryOnFailure(maxRetryCount: 3, maxRetryDelaySeconds: 5)));

builder.Services.AddScoped<DbContext>(sp => sp.GetRequiredService<AppDbContext>());

// Data access layer
builder.Services.AddScoped<IDbConnection>(sp =>
{
    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
        ?? throw new InvalidOperationException("Connection string not found");
    return new SqlConnection(connectionString);
});
builder.Services.AddScoped<IDapperRepository, DapperRepository>();

// Business logic services
builder.Services.AddScoped<IDashboardService, DashboardService>();
builder.Services.AddScoped<ISpaSectionService, SpaSectionService>();
builder.Services.AddScoped<IEntityApiService, EntityApiService>();
builder.Services.AddScoped<DataSeeder>();
builder.Services.AddScoped<IProductDapperService, ProductDapperService>();
builder.Services.AddScoped<IOrderProcessingService, OrderProcessingService>();

// Tenancy
builder.Services.AddScoped<ITenantSchemaAccessor, HeaderTenantSchemaAccessor>();

// Build app
var app = builder.Build();

// Seed mode
var seedMode = args.Any(arg =>
    string.Equals(arg, "--seed", StringComparison.OrdinalIgnoreCase));

if (seedMode)
{
    using var scope = app.Services.CreateScope();
    var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    await dbContext.Database.MigrateAsync();
    await scope.ServiceProvider.GetRequiredService<DataSeeder>().SeedAsync();
    return;
}

// Middleware
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.MapControllers();
app.MapBlazorHub();
app.MapFallbackToPage("/_Host");
app.Run();
```

---

## **8. PROJECT STRUCTURE**

```
DotNetWebApp/
├── Controllers/
│   ├── EntitiesController.cs          # Generic REST API (reflection-based)
│   └── ...
├── Components/
│   ├── Pages/
│   │   ├── GenericEntityPage.razor    # Dynamic entity pages
│   │   ├── SpaApp.razor               # SPA root
│   │   └── ...
│   ├── Sections/
│   │   ├── DashboardSection.razor
│   │   ├── OrderProcessingSection.razor
│   │   └── ...
│   └── Shared/
│       ├── DynamicDataGrid.razor      # Radzen grid with reflection
│       ├── MainLayout.razor
│       └── ...
├── Data/
│   ├── EF/
│   │   ├── AppDbContext.cs            # EF Core with dynamic entities
│   │   └── AppDbContextFactory.cs     # Design-time factory
│   ├── Dapper/
│   │   ├── IDapperRepository.cs       # Dapper abstraction
│   │   ├── DapperRepository.cs
│   │   ├── IProductDapperService.cs
│   │   ├── ProductDapperService.cs
│   │   ├── IOrderProcessingService.cs
│   │   └── OrderProcessingService.cs
│   ├── Tenancy/
│   │   ├── ITenantSchemaAccessor.cs
│   │   └── HeaderTenantSchemaAccessor.cs
│   └── ...
├── Models/
│   ├── Generated/                     # Auto-generated entities
│   │   ├── Product.cs
│   │   ├── Category.cs
│   │   └── ...
│   ├── AppDictionary/
│   │   ├── AppDefinition.cs
│   │   └── ...
│   └── DTOs/
│       ├── ProductReadDto.cs
│       ├── ProductSalesReportDto.cs
│       └── ...
├── Services/
│   ├── AppDictionaryService.cs        # YAML loading (singleton)
│   ├── EntityMetadataService.cs       # Entity mapping (singleton)
│   ├── EntityApiService.cs            # HTTP CRUD calls (scoped)
│   ├── DashboardService.cs
│   ├── DataSeeder.cs
│   ├── SpaSectionService.cs
│   ├── AsyncUiState.cs
│   └── ...
├── Exceptions/
│   ├── EntityNotFoundException.cs
│   ├── InvalidEntityDataException.cs
│   └── DataAccessException.cs
├── Migrations/
│   ├── 20260125174732_InitialCreate.cs
│   └── AppDbContextModelSnapshot.cs
├── wwwroot/
│   └── css/
│       └── app.css
├── app.yaml                           # Generated from schema.sql
├── schema.sql                         # DDL source
├── seed.sql                           # Seed data
├── appsettings.json
├── Program.cs
└── DotNetWebApp.csproj
```

---

## **9. MIGRATION WORKFLOW**

### Creating & Applying Migrations

```bash
# After modifying app.yaml or Models/Generated/
dotnet ef migrations add DescriptiveNameHere
dotnet ef database update

# View pending migrations
dotnet ef migrations list

# Revert to previous state
dotnet ef database update PreviousMigrationName
```

### Hybrid Guideline

- **EF Core**: Handle schema migrations (`dotnet ef migrations add`)
- **Dapper**: Execute raw SQL for complex operations, read models, aggregations

---

## **7. SUMMARY OF ARCHITECTURAL INTENT**

This hybrid approach is designed for teams of **SQL experts**.

* **EF Core** is used as a "Database Management Tool" (Migrations).  
* **Dapper** is used as the "Application Engine" (Fast UI Data).  
* **Radzen** components bind to "Flat DTOs" in the Application layer, keeping the WebUI decoupled from the physical database schema.