# Database Connection Architecture

## Overview

This application uses **two SQL Server databases** with a hybrid EF Core (writes) + Dapper (reads) pattern:

- **WEBAPP** (Primary Database) - Contains ERP tables (products, customers, orders, inventory, etc.)
- **WEBAPPMisc** (Secondary Database) - Contains shared application tables (webapp_scheduler, webapp_allocate, etc.)

## Connection Configuration

### Program.cs Registration

```csharp
// EF Core DbContexts
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(primaryConnectionString));
builder.Services.AddDbContext<SecondaryDbContext>(options =>
    options.UseSqlServer(secondaryConnectionString));

// Dapper Query Services (read-only)
builder.Services.AddKeyedScoped<IDapperQueryService, DapperQueryService>("Primary");
builder.Services.AddKeyedScoped<IDapperQueryService>(
    "Secondary",
    (sp, key) => new SecondaryDapperQueryService(
        sp.GetRequiredService<SecondaryDbContext>(),
        sp.GetRequiredService<ILogger<SecondaryDapperQueryService>>()));

// Default (non-keyed) uses Primary for backwards compatibility
builder.Services.AddScoped<IDapperQueryService, DapperQueryService>();
```

### Connection Strings (appsettings.Local.json)

```json
{
  "ConnectionStrings": {
    "PrimaryDatabase": "Server=localhost,1433;Database=WEBAPP;User Id=sa;Password=...;TrustServerCertificate=True;",
    "SecondaryDatabase": "Server=localhost,1433;Database=WEBAPPMisc;User Id=sa;Password=...;TrustServerCertificate=True;"
  }
}
```

## Database Mappings

### WEBAPP Database (Primary)

**EF Core**: `AppDbContext`
**Dapper**: `DapperQueryService` (keyed as "Primary")

**Tables**: products, customers, orders, order_lines, inventory, warehouses, vendors, units_of_measure

**Used By**:
- InventoryPickingService (product lookups, order enrichment)
- InventoryAllocationService (product availability queries)

### WEBAPPMisc Database (Secondary)

**EF Core**: `SecondaryDbContext`
**Dapper**: `SecondaryDapperQueryService` (keyed as "Secondary")

**Tables**:
- **Order Headers**: webapp_scheduler (shared by all apps)
- **Line Items**: webapp_allocate (Inventory Allocation)
- **User Config**: webapp_dmstech (shared by all apps)
- **Locks**: webapp_lock (pessimistic locking)

**Used By**:
- InventoryPickingService (scheduler queries)
- InventoryAllocationService (allocation records)
- WAMSService (dock management)

## Service Patterns

### Pattern 1: Single Database Service (Primary)

Queries only WEBAPP tables - uses default `IDapperQueryService`.

```csharp
public class MyPrimaryService : IMyPrimaryService
{
    private readonly IDapperQueryService _dapper;  // Connects to WEBAPP (Primary)

    public MyPrimaryService(IDapperQueryService dapper, ILogger<MyPrimaryService> logger)
    {
        _dapper = dapper;
        _logger = logger;
    }

    // Queries: products, orders, inventory (all in WEBAPP)
}
```

### Pattern 2: Multi-Database Service

Queries BOTH databases - uses keyed Dapper services.

```csharp
public class MultiDbService : IMultiDbService
{
    private readonly SecondaryDbContext _context;          // EF writes to WEBAPPMisc
    private readonly IDapperQueryService _primaryDapper;   // Queries to WEBAPP
    private readonly IDapperQueryService _secondaryDapper; // Queries to WEBAPPMisc

    public MultiDbService(
        SecondaryDbContext context,
        [FromKeyedServices("Primary")] IDapperQueryService primaryDapper,
        [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper,
        ILogger<MultiDbService> logger)
    {
        _context = context;
        _primaryDapper = primaryDapper;
        _secondaryDapper = secondaryDapper;
        _logger = logger;
    }

    // PRIMARY Dapper (WEBAPP) for:
    // - Product lookups, order details, inventory queries

    // SECONDARY Dapper (WEBAPPMisc) for:
    // - ListOrdersAsync (webapp_scheduler, webapp_allocate)

    // EF Core SecondaryDbContext for:
    // - CreateOrderAsync (webapp_scheduler)
    // - AddLineItemAsync (webapp_allocate)
}
```

### Pattern 3: Secondary Database Queries

Queries only WEBAPPMisc tables - uses keyed "Secondary" Dapper service.

```csharp
public class OrderNumberService : IOrderNumberService
{
    private readonly IDapperQueryService _dapperQuery;  // Connects to WEBAPPMisc (Secondary)

    public OrderNumberService(
        [FromKeyedServices("Secondary")] IDapperQueryService dapperQuery,
        ILogger<OrderNumberService> logger)
    {
        _dapperQuery = dapperQuery;
        _logger = logger;
    }

    // Queries: webapp_scheduler (in WEBAPPMisc)
}
```

## Keyed Services (.NET 8)

The project uses .NET 8's **keyed services** feature to support multiple instances of `IDapperQueryService`.

### Benefits

- **Same interface**: Both services implement `IDapperQueryService`
- **Explicit injection**: Services declare which database they need
- **Type safety**: Compile-time verification via `[FromKeyedServices]` attribute
- **Clear intent**: Code self-documents which database is being used

### Usage

**Injecting Primary (WEBAPP) database**:
```csharp
public MyService([FromKeyedServices("Primary")] IDapperQueryService dapper)
```

**Injecting Secondary (WEBAPPMisc) database**:
```csharp
public MyService([FromKeyedServices("Secondary")] IDapperQueryService dapper)
```

**Injecting both**:
```csharp
public MyService(
    [FromKeyedServices("Primary")] IDapperQueryService primaryDapper,
    [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper)
```

## Table Location Reference

### WEBAPP Database (Primary)

| Schema Area | Tables | Used By |
|------------|--------|---------|
| Products | products | InventoryPickingService |
| Inventory | inventory, warehouses | InventoryAllocationService |
| Orders | orders, order_lines | InventoryPickingService |
| Customers | customers | InventoryPickingService |
| Vendors | vendors | InventoryPickingService |

### WEBAPPMisc Database (Secondary)

| Schema Area | Tables | Used By |
|------------|--------|---------|
| Scheduler | webapp_scheduler | InventoryPickingService, WAMSService |
| Allocations | webapp_allocate | InventoryAllocationService |
| User Config | webapp_dmstech | All apps |
| Locks | webapp_lock | LockService |

## Troubleshooting

### Error: "Invalid object name 'webapp_scheduler'"

**Cause**: Service is using PRIMARY Dapper (WEBAPP database) but needs SECONDARY (WEBAPPMisc).

**Fix**: Inject keyed "Secondary" service:
```csharp
public MyService([FromKeyedServices("Secondary")] IDapperQueryService dapper)
```

### Error: "Invalid object name 'products'"

**Cause**: Service is using SECONDARY Dapper (WEBAPPMisc database) but needs PRIMARY (WEBAPP).

**Fix**: Inject keyed "Primary" service:
```csharp
public MyService([FromKeyedServices("Primary")] IDapperQueryService dapper)
```

### How to Determine Which Database

1. Check `sql/schema.sql` for `USE [DatabaseName]` statements
2. Find the `CREATE TABLE` statement for your table
3. The database is determined by the most recent `USE` statement before the `CREATE TABLE`

**Example**:
```sql
USE [WEBAPP]
...
CREATE TABLE products (...);  -- This is in WEBAPP

USE [WEBAPPMisc]
...
CREATE TABLE webapp_scheduler (...);  -- This is in WEBAPPMisc
```

## Migration from Single Database

If you have a service that was incorrectly using the default `IDapperQueryService` and getting table not found errors:

1. Identify which database contains your tables (check schema.sql)
2. If tables are in WEBAPPMisc, inject keyed "Secondary" service
3. Update constructor to use `[FromKeyedServices("Secondary")]`
4. Add `using Microsoft.Extensions.DependencyInjection;` to imports

**Before**:
```csharp
public MyService(IDapperQueryService dapper)  // Connects to WEBAPP
```

**After** (for WEBAPPMisc tables):
```csharp
using Microsoft.Extensions.DependencyInjection;

public MyService([FromKeyedServices("Secondary")] IDapperQueryService dapper)  // Connects to WEBAPPMisc
```
