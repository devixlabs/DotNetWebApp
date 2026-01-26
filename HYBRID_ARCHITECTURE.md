# Hybrid EF Core + Dapper Architecture for DotNetWebApp

**Document Status:** SIMPLIFIED APPROACH (Updated 2026-01-26)
**Target Scale:** 200+ entities, multiple database schemas, small team
**Architecture Style:** Pragmatic hybrid (NOT full Clean Architecture layers)

---

## Executive Summary

This document defines the **simplified hybrid architecture** for DotNetWebApp, combining:
- **EF Core** for entity CRUD operations (200+ generated models)
- **Dapper** for complex SQL views (multi-table JOINs, reports, dashboards)
- **SQL-first philosophy** for both entities (DDL) and views (SELECT queries)

**Key Decision:** We do NOT implement full Clean Architecture with 4 separate projects. Instead, we use namespace-based organization within a single project to balance complexity and team size.

---

## Architecture Principles

### 1. **SQL as Source of Truth**

```
┌─────────────────────────────────────────────┐
│ SQL DDL (schema.sql)                        │
│ → app.yaml                                  │
│ → Models/Generated/*.cs (EF entities)       │
│ → IEntityOperationService (dynamic CRUD)    │
└─────────────────────────────────────────────┘

┌─────────────────────────────────────────────┐
│ SQL SELECT (sql/views/*.sql)                │
│ → views.yaml                                │
│ → Models/ViewModels/*.cs (Dapper DTOs)      │
│ → IViewService (typed queries)              │
└─────────────────────────────────────────────┘
```

### 2. **Clear Separation of Concerns**

| Layer | Technology | Purpose | Example |
|-------|------------|---------|---------|
| **Entity Models** | EF Core | Single-table CRUD for 200+ generated entities | `Product`, `Category`, `Order` |
| **View Models** | Dapper | Multi-table reads for UI components | `ProductSalesView`, `CustomerOrderHistoryView` |
| **Business Logic** | Blazor Server | C# event handlers (no JavaScript/AJAX) | `OnRestockAsync()`, `OnProcessOrderAsync()` |
| **Data Access** | `IEntityOperationService` (writes) + `IViewService` (reads) | Abstraction layer | Injected into Blazor components |

### 3. **Multi-Tenancy via Shared Connection**

```csharp
// Finbuckle.MultiTenant sets schema on EF Core connection
builder.Services.AddMultiTenant<TenantInfo>()
    .WithHeaderStrategy("X-Customer-Schema");

// Dapper shares the SAME connection → automatic schema inheritance
builder.Services.AddScoped<IDapperQueryService>(sp =>
{
    var dbContext = sp.GetRequiredService<AppDbContext>();
    return new DapperQueryService(dbContext);  // ✅ Uses EF's connection
});
```

**Result:** No manual schema injection needed. Tenant isolation is automatic for both ORMs.

---

## Project Structure

**Single-project organization with namespaces (NOT 4 separate projects):**

```
DotNetWebApp/
├── sql/
│   ├── schema.sql                      # DDL source (existing)
│   └── views/                          # NEW: Complex SQL views
│       ├── ProductSalesView.sql
│       ├── CustomerOrderHistoryView.sql
│       └── InventoryDashboardView.sql
├── app.yaml                            # Entity definitions (existing)
├── views.yaml                          # NEW: View definitions
├── DotNetWebApp.Models/
│   ├── Generated/                      # EF Core entities (existing)
│   │   ├── Product.cs
│   │   ├── Category.cs
│   │   └── Order.cs
│   ├── ViewModels/                     # NEW: Dapper DTOs
│   │   ├── ProductSalesView.cs
│   │   ├── CustomerOrderHistoryView.cs
│   │   └── InventoryDashboardView.cs
│   └── AppDictionary/                  # YAML models (existing)
├── Services/
│   ├── IEntityOperationService.cs      # EF CRUD (REFACTOR.md Phase 1)
│   ├── EntityOperationService.cs
│   └── Views/                          # NEW: Dapper view services
│       ├── IViewRegistry.cs
│       ├── ViewRegistry.cs
│       ├── IViewService.cs
│       └── ViewService.cs
├── Data/
│   ├── AppDbContext.cs                 # EF Core (existing)
│   └── Dapper/                         # NEW
│       ├── IDapperQueryService.cs
│       └── DapperQueryService.cs
├── Controllers/
│   └── EntitiesController.cs           # Dynamic CRUD API (existing)
├── Components/
│   ├── Pages/
│   │   ├── ProductDashboard.razor      # NEW: Uses IViewService
│   │   ├── GenericEntityPage.razor     # Existing: Uses IEntityOperationService
│   │   └── ...
│   └── Shared/
│       ├── DynamicDataGrid.razor       # Existing
│       └── ...
└── ModelGenerator/
    ├── EntityGenerator.cs              # Existing
    └── ViewModelGenerator.cs           # NEW
```

---

## Data Access Patterns

### Pattern 1: Entity CRUD (EF Core)

**When to use:** Single-table operations, simple queries, writes

```csharp
// Service layer (REFACTOR.md Phase 1)
public interface IEntityOperationService
{
    Task<IList> GetAllAsync(Type entityType, CancellationToken ct = default);
    Task<object?> GetByIdAsync(Type entityType, object id, CancellationToken ct = default);
    Task<object> CreateAsync(Type entityType, object entity, CancellationToken ct = default);
    Task<object> UpdateAsync(Type entityType, object entity, CancellationToken ct = default);
    Task DeleteAsync(Type entityType, object id, CancellationToken ct = default);
}

// Usage in Blazor component
@inject IEntityOperationService EntityService

@code {
    private async Task OnRestockAsync(int productId)
    {
        var productType = typeof(Product);
        var product = await EntityService.GetByIdAsync(productType, productId);

        if (product is Product p)
        {
            p.Stock += 100;  // Business logic
            await EntityService.UpdateAsync(productType, p);
        }
    }
}
```

**Why EF Core:**
- Change tracking (simplified updates)
- Navigation properties (if needed)
- Reflection-friendly (works with dynamic types for 200+ entities)
- Migrations for schema management

---

### Pattern 2: Complex Views (Dapper)

**When to use:** Multi-table JOINs, aggregations, reports, dashboards

```csharp
// SQL file: sql/views/ProductSalesView.sql
SELECT
    p.Id,
    p.Name,
    p.Price,
    c.Name AS CategoryName,
    SUM(od.Quantity) AS TotalSold,
    SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Products p
LEFT JOIN Categories c ON p.CategoryId = c.Id
LEFT JOIN OrderDetails od ON p.Id = od.ProductId
GROUP BY p.Id, p.Name, p.Price, c.Name
ORDER BY TotalSold DESC;

// views.yaml definition
views:
  - name: ProductSalesView
    sql_file: "sql/views/ProductSalesView.sql"
    properties:
      - name: Id
        type: int
      - name: Name
        type: string
      - name: TotalSold
        type: int
      # ...

// Generated: Models/ViewModels/ProductSalesView.cs
public class ProductSalesView
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public int TotalSold { get; set; }
    // ...
}

// Service layer
public interface IViewService
{
    Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null);
}

// Usage in Blazor component
@inject IViewService ViewService

@code {
    private IEnumerable<ProductSalesView>? products;

    protected override async Task OnInitializedAsync()
    {
        products = await ViewService.ExecuteViewAsync<ProductSalesView>(
            "ProductSalesView",
            new { TopN = 50 });
    }
}
```

**Why Dapper:**
- 2-5x faster for complex JOINs
- Full SQL control (CTEs, window functions, etc.)
- No N+1 query problems
- Read-only (no change tracking overhead)

---

## Service Layer Architecture

### Core Services (Existing + New)

```csharp
// Existing services (KEEP AS-IS)
public interface IAppDictionaryService { /* loads app.yaml */ }
public interface IEntityMetadataService { /* maps entities to CLR types */ }

// NEW: Phase 1 (REFACTOR.md)
public interface IEntityOperationService { /* EF CRUD operations */ }

// NEW: Phase 2 (View Pipeline)
public interface IViewRegistry { /* loads views.yaml */ }
public interface IViewService { /* executes SQL views via Dapper */ }
public interface IDapperQueryService { /* low-level Dapper abstraction */ }
```

### Dependency Injection Registration

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

// Existing services (singletons for cached data)
builder.Services.AddSingleton<IAppDictionaryService>(/* ... */);
builder.Services.AddSingleton<IEntityMetadataService, EntityMetadataService>();
builder.Services.AddSingleton<IViewRegistry>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var viewsYamlPath = Path.Combine(env.ContentRootPath, "views.yaml");
    return new ViewRegistry(viewsYamlPath, sp.GetRequiredService<ILogger<ViewRegistry>>());
});

// Multi-tenancy (Finbuckle)
builder.Services.AddMultiTenant<TenantInfo>()
    .WithHeaderStrategy("X-Customer-Schema")
    .WithInMemoryStore(/* tenant config */);

// EF Core (scoped per request)
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(connectionString,
        sql => sql.CommandTimeout(30).EnableRetryOnFailure()));

// Data access services (scoped)
builder.Services.AddScoped<IEntityOperationService, EntityOperationService>();
builder.Services.AddScoped<IDapperQueryService, DapperQueryService>();  // Shares EF connection
builder.Services.AddScoped<IViewService, ViewService>();
```

---

## Transaction Coordination

### Scenario: EF Write + Dapper Audit Log

```csharp
public async Task ProcessOrderWithAuditAsync(int orderId)
{
    // Both operations share the same connection → same transaction
    using var transaction = await _dbContext.Database.BeginTransactionAsync();

    try
    {
        // EF Core write (change tracking)
        var order = await _dbContext.Set<Order>().FindAsync(orderId);
        order.Status = "Processed";
        order.ProcessedDate = DateTime.UtcNow;

        // Dapper write (fast batch operation)
        const string auditSql = @"
            INSERT INTO AuditLog (EntityType, EntityId, Action, Timestamp)
            VALUES ('Order', @OrderId, 'Processed', GETUTCDATE())";

        await _dapperQueryService.ExecuteAsync(auditSql, new { OrderId = orderId });

        // Commit both atomically
        await _dbContext.SaveChangesAsync();
        await transaction.CommitAsync();
    }
    catch
    {
        await transaction.RollbackAsync();
        throw;
    }
}
```

**Key:** `DapperQueryService` uses `_dbContext.Database.GetDbConnection()` → same connection, same transaction.

---

## Code Generation Pipelines

### Pipeline 1: Entity Generation (Existing)

```bash
# Makefile target
make run-ddl-pipeline

# Steps:
# 1. DdlParser reads schema.sql
# 2. Generates app.yaml
# 3. ModelGenerator reads app.yaml
# 4. Generates Models/Generated/*.cs
# 5. Run: dotnet ef migrations add <Name>
# 6. Run: dotnet ef database update
```

### Pipeline 2: View Generation (NEW - Phase 2)

```bash
# Makefile target
make run-view-pipeline

# Steps:
# 1. Create SQL file in sql/views/
# 2. Add entry to views.yaml (or use auto-discovery tool)
# 3. Run: make run-view-pipeline
# 4. Generates Models/ViewModels/*.cs
# 5. Use IViewService in Blazor components
```

---

## Decision Matrix: EF vs. Dapper

| Scenario | Use EF Core | Use Dapper | Rationale |
|----------|-------------|------------|-----------|
| Get single entity by ID | ✅ | ❌ | Simple, fast enough |
| Update single entity | ✅ | ❌ | Change tracking simplifies logic |
| Delete entity | ✅ | ❌ | Cascade deletes handled by EF |
| List all entities (no JOINs) | ✅ | ❌ | Dynamic via IEntityOperationService |
| Complex JOIN (3+ tables) | ❌ | ✅ | 2-5x faster, full SQL control |
| Aggregations (SUM, AVG, GROUP BY) | ❌ | ✅ | More efficient SQL |
| Reports/Dashboards | ❌ | ✅ | Read-only, optimized queries |
| Bulk operations (1000+ rows) | ❌ | ✅ | No change tracking overhead |
| Dynamic queries (user filters) | ✅ | ❌ | LINQ is safer than string concat |

---

## Multi-Tenancy Strategy

### Finbuckle Configuration

```csharp
public class TenantInfo : ITenantInfo
{
    public string Id { get; set; } = null!;
    public string Identifier { get; set; } = null!;
    public string Name { get; set; } = null!;
    public string Schema { get; set; } = "dbo";  // ⭐ Schema per tenant
}

// Program.cs
builder.Services.AddMultiTenant<TenantInfo>()
    .WithHeaderStrategy("X-Customer-Schema")  // Existing header
    .WithInMemoryStore(options =>
    {
        options.Tenants.Add(new TenantInfo
        {
            Id = "1",
            Identifier = "customer1",
            Schema = "customer1"
        });
        options.Tenants.Add(new TenantInfo
        {
            Id = "2",
            Identifier = "customer2",
            Schema = "customer2"
        });
    });
```

### AppDbContext Integration

```csharp
public class AppDbContext : MultiTenantDbContext<AppDbContext, TenantInfo>
{
    private readonly TenantInfo _tenant;

    public AppDbContext(
        DbContextOptions<AppDbContext> options,
        TenantInfo tenant) : base(options)
    {
        _tenant = tenant;
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Set default schema from tenant context
        if (!string.IsNullOrWhiteSpace(_tenant?.Schema))
        {
            modelBuilder.HasDefaultSchema(_tenant.Schema);
        }

        // Dynamic entity registration (existing code)
        var entityTypes = Assembly.GetExecutingAssembly().GetTypes()
            .Where(t => t.IsClass && t.Namespace == "DotNetWebApp.Models.Generated");

        foreach (var type in entityTypes)
        {
            modelBuilder.Entity(type).ToTable(ToPlural(type.Name));
        }
    }
}
```

### Dapper Automatic Schema Inheritance

```csharp
public class DapperQueryService : IDapperQueryService
{
    private readonly AppDbContext _dbContext;  // ⭐ Receives tenant-aware context

    public DapperQueryService(AppDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
    {
        // Uses EF's connection → automatic tenant schema
        var connection = _dbContext.Database.GetDbConnection();
        return await connection.QueryAsync<T>(sql, param);
    }
}
```

**No manual schema injection needed!** SQL queries like `SELECT * FROM Products` automatically resolve to the correct tenant schema.

---

## Performance Optimization Guidelines

### 1. Use Compiled Queries for Hot Paths

```csharp
private static readonly Func<AppDbContext, int, Task<Product?>> GetProductById =
    EF.CompileAsyncQuery((AppDbContext ctx, int id) =>
        ctx.Set<Product>().FirstOrDefault(p => p.Id == id));
```

### 2. Add Caching for Metadata Services

```csharp
public class EntityMetadataService : IEntityMetadataService
{
    private readonly IMemoryCache _cache;

    public EntityMetadata? Find(string entityName)
    {
        return _cache.GetOrCreate($"meta:{entityName}", entry =>
        {
            entry.SlidingExpiration = TimeSpan.FromHours(1);
            return /* lookup logic */;
        });
    }
}
```

### 3. Use Dapper for Read-Heavy Endpoints

After profiling with Application Insights or MiniProfiler, convert slow EF queries to Dapper.

### 4. Enable Query Splitting for Collections

```csharp
modelBuilder.Entity<Product>()
    .HasMany(p => p.OrderDetails)
    .WithOne()
    .AsSplitQuery();  // Prevents cartesian explosion
```

---

## Testing Strategy

### Unit Tests

```csharp
// EntityOperationService (EF Core)
[Fact]
public async Task GetAllAsync_ReturnsAllEntities()
{
    // Arrange: In-memory DbContext
    var options = new DbContextOptionsBuilder<AppDbContext>()
        .UseInMemoryDatabase(databaseName: "TestDb")
        .Options;

    // Act & Assert
    // ...
}

// ViewRegistry (Dapper)
[Fact]
public async Task GetViewSqlAsync_LoadsFromFile()
{
    // Arrange: Mock file system or real views.yaml
    var registry = new ViewRegistry("views.yaml", logger);

    // Act
    var sql = await registry.GetViewSqlAsync("ProductSalesView");

    // Assert
    Assert.Contains("SELECT", sql);
}
```

### Integration Tests

```csharp
[Fact]
public async Task ViewService_ExecutesViewWithTenantIsolation()
{
    // Arrange: Real SQL Server with multiple schemas
    using var connection = new SqlConnection(connectionString);

    // Act: Execute view for tenant1
    SetTenantHeader("customer1");
    var results1 = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");

    // Act: Execute view for tenant2
    SetTenantHeader("customer2");
    var results2 = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");

    // Assert: Different results per tenant
    Assert.NotEqual(results1.Count(), results2.Count());
}
```

---

## Migration Path from Current Architecture

### Phase 1: Foundation (REFACTOR.md Phases 1, 3, 5)
- Extract `IEntityOperationService` (EF CRUD)
- Migrate to Finbuckle.MultiTenant
- Configuration consolidation

**Duration:** 2 weeks

### Phase 2: View Pipeline (PHASE2_VIEW_PIPELINE.md)
- Create `views.yaml` and SQL view files
- Implement `ViewRegistry`, `ViewService`, `DapperQueryService`
- Generate view models
- Update Blazor components

**Duration:** 1-2 weeks

### Phase 3: Validation + Polish
- Add validation pipeline
- YAML immutability
- Performance testing

**Duration:** 1 week

**Total:** 4-5 weeks

---

## What We DELIBERATELY Did NOT Implement

### ❌ Full Clean Architecture (4 Separate Projects)

**Why:** Overkill for small team. Namespace organization provides 80% of benefits.

### ❌ Repository Pattern

**Why:** `IEntityOperationService` + `IViewService` provide sufficient abstraction.

### ❌ CQRS/Mediator Pattern

**Why:** Adds complexity without benefits at this scale. Services are clear enough.

### ❌ Domain-Driven Design (Aggregates, Value Objects)

**Why:** This is a data-driven app, not a complex business domain.

### ❌ OData for Dynamic Queries

**Why:** Our reflection-based `IEntityOperationService` is simpler and sufficient.

---

## References

- **REFACTOR.md** - Complete refactoring plan (all phases)
- **PHASE2_VIEW_PIPELINE.md** - Detailed implementation guide for SQL-first views
- **CLAUDE.md** - Project context for future Claude sessions
- **SESSION_SUMMARY.md** - Development log

---

**Document Version:** 2.0 (Simplified Approach)
**Last Updated:** 2026-01-26
**Next Review:** After Phase 2 implementation
