# Database Connection Architecture

## Overview

This application uses **two SQL Server databases** with a hybrid EF Core (writes) + Dapper (reads) pattern:

- **GAI** (Primary Database) - Contains Deacom ERP tables (dmprod, dtfifo, dtjob, dttord, etc.)
- **GAIMisc** (Secondary Database) - Contains shared application tables (gai_scheduler, gai_allocate, etc.)

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
    "PrimaryDatabase": "Server=localhost,1433;Database=GAI;User Id=sa;Password=...;TrustServerCertificate=True;",
    "SecondaryDatabase": "Server=localhost,1433;Database=GAIMisc;User Id=sa;Password=...;TrustServerCertificate=True;"
  }
}
```

## Database Mappings

### GAI Database (Primary)

**EF Core**: `AppDbContext`
**Dapper**: `DapperQueryService` (keyed as "Primary")

**Tables**:
- **Products**: dmprod, dmunit
- **Inventory**: dtfifo, dtstaging
- **Sales Orders**: dttord, dtlord
- **Manufacturing**: dtjob, dtljob
- **Customers**: dmbill, dmship
- **Attributes**: dtd1, dtd2

**Used By**:
- DeacomService (product lookups, order enrichment)
- ICTService (product/inventory queries)

### GAIMisc Database (Secondary)

**EF Core**: `SecondaryDbContext`
**Dapper**: `SecondaryDapperQueryService` (keyed as "Secondary")

**Tables**:
- **Order Headers**: gai_scheduler (shared by all 5 apps)
- **Line Items**: gai_allocate (ICT, Allocation)
- **User Config**: gai_dmstech (shared by all 5 apps)
- **Acuity Data**: acuity_appointments, acuity_forms, acuity_form_values

**Used By**:
- AcuityImportService (Acuity CSV import)
- ICTService (ICT order management)

## Service Patterns

### Pattern 1: Single Database Service (DeacomService)

Queries only GAI tables - uses default `IDapperQueryService`.

```csharp
public class DeacomService : IDeacomService
{
    private readonly IDapperQueryService _dapper;  // Connects to GAI (Primary)

    public DeacomService(IDapperQueryService dapper, ILogger<DeacomService> logger)
    {
        _dapper = dapper;
        _logger = logger;
    }

    // Queries: dttord, dmbill, dmship (all in GAI)
}
```

### Pattern 2: Single Database Service (AcuityImportService)

Uses only GAIMisc tables - uses `SecondaryDbContext` for EF Core.

```csharp
public class AcuityImportService : IAcuityImportService
{
    private readonly SecondaryDbContext _context;  // Connects to GAIMisc

    public AcuityImportService(
        SecondaryDbContext context,
        IDeacomService deacomService,
        ILogger<AcuityImportService> logger)
    {
        _context = context;
        _deacomService = deacomService;
        _logger = logger;
    }

    // Writes to: gai_scheduler, acuity_appointments (all in GAIMisc)
}
```

### Pattern 3: Multi-Database Service (ICTService)

Queries BOTH databases - uses keyed Dapper services.

```csharp
public class ICTService : IICTService
{
    private readonly SecondaryDbContext _context;          // EF writes to GAIMisc
    private readonly IDapperQueryService _primaryDapper;   // Queries to GAI
    private readonly IDapperQueryService _secondaryDapper; // Queries to GAIMisc

    public ICTService(
        SecondaryDbContext context,
        [FromKeyedServices("Primary")] IDapperQueryService primaryDapper,
        [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper,
        IICTOrderNumberService orderNumberService,
        IDeacomService deacomService,
        ILogger<ICTService> logger)
    {
        _context = context;
        _primaryDapper = primaryDapper;
        _secondaryDapper = secondaryDapper;
        _orderNumberService = orderNumberService;
        _deacomService = deacomService;
        _logger = logger;
    }

    // PRIMARY Dapper (GAI) for:
    // - GetAvailableProductsAsync (dmprod, dtfifo, dtd2, dmunit)
    // - GetManufacturingJobsAsync (dtjob, dtljob, dmprod)
    // - ValidateQuantityAsync (dtfifo, dmprod)
    // - GetProductDetailsAsync (dmprod, dtfifo, dtd2, dmunit)

    // SECONDARY Dapper (GAIMisc) for:
    // - ListOrdersAsync (gai_scheduler, gai_allocate)

    // EF Core SecondaryDbContext for:
    // - CreateOrderAsync (gai_scheduler)
    // - AddLineItemAsync (gai_allocate)
    // - GetOrderAsync (gai_scheduler, gai_allocate)
    // - SubmitOrderAsync (gai_scheduler, gai_allocate)
    // - DeleteOrderAsync (gai_scheduler, gai_allocate)
}
```

### Pattern 4: Secondary Database Queries (ICTOrderNumberService)

Queries only GAIMisc tables - uses keyed "Secondary" Dapper service.

```csharp
public class ICTOrderNumberService : IICTOrderNumberService
{
    private readonly IDapperQueryService _dapperQuery;  // Connects to GAIMisc (Secondary)

    public ICTOrderNumberService(
        [FromKeyedServices("Secondary")] IDapperQueryService dapperQuery,
        ILogger<ICTOrderNumberService> logger)
    {
        _dapperQuery = dapperQuery;
        _logger = logger;
    }

    // Queries: gai_scheduler (in GAIMisc)
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

**Injecting Primary (GAI) database**:
```csharp
public MyService([FromKeyedServices("Primary")] IDapperQueryService dapper)
```

**Injecting Secondary (GAIMisc) database**:
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

### GAI Database (Primary)

| Schema Area | Tables | Used By |
|------------|--------|---------|
| Products | dmprod, dmunit | DeacomService, ICTService |
| Inventory | dtfifo, dtstaging | DeacomService, ICTService |
| Sales Orders | dttord, dtlord | DeacomService |
| Manufacturing | dtjob, dtljob | ICTService |
| Customers | dmbill, dmship | DeacomService |
| Attributes | dtd1, dtd2 | DeacomService, ICTService |

### GAIMisc Database (Secondary)

| Schema Area | Tables | Used By |
|------------|--------|---------|
| Scheduler | gai_scheduler | AcuityImportService, ICTService |
| Allocations | gai_allocate | ICTService |
| User Config | gai_dmstech | All 5 apps |
| Acuity Data | acuity_* | AcuityImportService |

## Troubleshooting

### Error: "Invalid object name 'gai_scheduler'"

**Cause**: Service is using PRIMARY Dapper (GAI database) but needs SECONDARY (GAIMisc).

**Fix**: Inject keyed "Secondary" service:
```csharp
public MyService([FromKeyedServices("Secondary")] IDapperQueryService dapper)
```

### Error: "Invalid object name 'dmprod'"

**Cause**: Service is using SECONDARY Dapper (GAIMisc database) but needs PRIMARY (GAI).

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
USE [GAI]
...
CREATE TABLE dmprod (...);  -- This is in GAI

USE [GAIMisc]
...
CREATE TABLE gai_scheduler (...);  -- This is in GAIMisc
```

## Migration from Single Database

If you have a service that was incorrectly using the default `IDapperQueryService` and getting table not found errors:

1. Identify which database contains your tables (check schema.sql)
2. If tables are in GAIMisc, inject keyed "Secondary" service
3. Update constructor to use `[FromKeyedServices("Secondary")]`
4. Add `using Microsoft.Extensions.DependencyInjection;` to imports

**Before**:
```csharp
public MyService(IDapperQueryService dapper)  // Connects to GAI
```

**After** (for GAIMisc tables):
```csharp
using Microsoft.Extensions.DependencyInjection;

public MyService([FromKeyedServices("Secondary")] IDapperQueryService dapper)  // Connects to GAIMisc
```
