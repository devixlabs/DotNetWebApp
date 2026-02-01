---
name: views-architecture
description: >
  SQL-first view pipeline architecture for complex read queries with Dapper.
  Use when working with SQL views, IViewService, IViewRegistry, IDapperQueryService,
  adding new views, debugging view execution, or understanding the EF Core + Dapper
  hybrid architecture. Covers view definitions, code generation, Blazor integration,
  error handling, and multi-tenant view isolation.
---

# Views Architecture Skill

SQL-First View Pipeline for Complex Read Queries (Phase 2B Complete)

---

## 🚨 CRITICAL: Schema-Qualified Type Resolution

**This is the #1 error when working with views in multi-schema environments.**

When multiple schemas have the same view name (e.g., `acme.ProductSalesView` and `initech.ProductSalesView`), type resolution fails if you don't use fully-qualified namespace paths.

**Example Error:**
```
InvalidOperationException: Could not load type 'DotNetWebApp.Models.ViewModels.ProductSalesView'
```

**Root Cause:** The reflection call in ViewSection.razor doesn't include the schema namespace:
```csharp
// ❌ WRONG - Missing schema namespace
var typeName = $"DotNetWebApp.Models.ViewModels.{ViewName}";
var type = Type.GetType(typeName);  // Returns null for schema-qualified views
```

**Solution:** Always include schema namespace when views exist in multiple schemas:
```csharp
// ✅ CORRECT - Include schema namespace
var typeName = $"DotNetWebApp.Models.ViewModels.{SchemaName}.{ViewName}";
var type = Type.GetType(typeName);  // Works for multi-schema scenarios
```

**Prevention:** For single-schema projects, no issue. For multi-tenant/multi-schema, use schema-qualified type resolution.

---

## Architecture Overview

The project implements a **three-service pattern** for SQL views:

### The Three Services

**IViewRegistry (Singleton)**
- Loads view metadata from `app.yaml` during startup
- Caches SQL file contents in `ConcurrentDictionary<string, string>`
- Provides view definitions, SQL paths, and visibility control
- Application-level visibility: controls which apps can access which views

**IViewService (Scoped)**
- Orchestrates view execution
- Coordinates between IViewRegistry (metadata) and IDapperQueryService (execution)
- Two methods: `ExecuteViewAsync<T>()` and `ExecuteViewSingleAsync<T>()`

**IDapperQueryService (Scoped)**
- Executes raw SQL using Dapper ORM
- Shares EF Core's database connection (no separate connection pool)
- Automatically inherits tenant schema from AppDbContext
- Maps SQL result rows to strongly-typed C# objects

### Data Flow

```
appsettings.json ViewDefinitions
    ↓ [Build: ViewModelGenerator]
    ↓ [Build: AppsYamlGenerator merges]
app.yaml (runtime config)
    ↓ [Runtime: IViewRegistry singleton loads]
IViewService.ExecuteViewAsync<T>(viewName, parameters)
    ↓ [Calls: IViewRegistry.GetViewSqlAsync()]
    ↓ [Calls: IDapperQueryService.QueryAsync<T>()]
Database (SQL Server)
    ↓ [Dapper maps rows to C# objects]
ViewSection.razor (Radzen DataGrid displays results)
```

### Why This Architecture

- **EF Core for writes:** Change tracking, migrations, CRUD on entities
- **Dapper for reads:** 2-5x faster for complex queries, full SQL control
- **SQL-first:** Legacy SQL as source of truth
- **Type-safe:** Generated C# view models with DataAnnotations
- **Multi-tenant:** Automatic schema inheritance from EF Core connection

---

## Quick Start: Adding a New View

**Complete end-to-end workflow:**

### Step 1: Create SQL File

Create `sql/views/CustomerOrderHistoryView.sql`:

```sql
-- CustomerOrderHistoryView.sql
-- Customer order history with totals
-- Parameters: @TopN (default: 10)

SELECT TOP (@TopN)
    c.Id AS CustomerId,
    c.Name AS CustomerName,
    COUNT(DISTINCT o.Id) AS TotalOrders,
    COALESCE(SUM(o.Amount), 0) AS TotalRevenue
FROM acme.Customers c
LEFT JOIN acme.Orders o ON c.Id = o.CustomerId
GROUP BY c.Id, c.Name
ORDER BY TotalRevenue DESC;
```

### Step 2: Add ViewDefinition to appsettings.json

Edit `appsettings.json` and add to `"ViewDefinitions"` array:

```json
{
  "Name": "CustomerOrderHistoryView",
  "Description": "Customer order history with totals",
  "SqlFile": "sql/views/CustomerOrderHistoryView.sql",
  "GeneratePartial": true,
  "Applications": ["admin", "reporting"],
  "Parameters": [
    {
      "Name": "TopN",
      "Type": "int",
      "Nullable": false,
      "Default": "10",
      "Validation": {
        "Required": true,
        "Range": [1, 1000]
      }
    }
  ],
  "Properties": [
    { "Name": "CustomerId", "Type": "int", "Nullable": false },
    { "Name": "CustomerName", "Type": "string", "Nullable": false, "MaxLength": 100 },
    { "Name": "TotalOrders", "Type": "int", "Nullable": false },
    { "Name": "TotalRevenue", "Type": "decimal", "Nullable": false }
  ]
}
```

### Step 3: Run Pipeline

```bash
make run-ddl-pipeline
```

This generates:
- `DotNetWebApp.Models/ViewModels/CustomerOrderHistoryView.generated.cs` (C# DTO)
- Updates `app.yaml` with view metadata
- IViewRegistry loads on next application start

### Step 4: Use in Blazor Component

```razor
@page "/orders/customer-history"
@inject IViewService ViewService

<ViewSection AppName="admin" ViewName="CustomerOrderHistoryView" />

@code {
    private IEnumerable<CustomerOrderHistoryView>? results;

    protected override async Task OnInitializedAsync()
    {
        results = await ViewService.ExecuteViewAsync<CustomerOrderHistoryView>(
            "CustomerOrderHistoryView",
            new { TopN = 50 });
    }
}
```

---

## View Definitions (appsettings.json)

View definitions are stored in `appsettings.json` under `"ViewDefinitions"` array. The build pipeline merges these into `app.yaml`.

### Complete ViewDefinition Structure

```json
{
  "ViewDefinitions": [
    {
      "Name": "ProductSalesView",
      "Description": "Product sales summary with category",
      "SqlFile": "sql/views/ProductSalesView.sql",
      "GeneratePartial": true,
      "Applications": ["admin", "reporting"],
      "Parameters": [
        {
          "Name": "TopN",
          "Type": "int",
          "Nullable": false,
          "Default": "10",
          "Validation": {
            "Required": true,
            "Range": [1, 1000]
          }
        }
      ],
      "Properties": [
        {
          "Name": "Id",
          "Type": "int",
          "Nullable": false
        },
        {
          "Name": "Name",
          "Type": "string",
          "Nullable": false,
          "MaxLength": 100
        },
        {
          "Name": "Price",
          "Type": "decimal",
          "Nullable": false
        }
      ]
    }
  ]
}
```

### Key Fields

| Field | Purpose | Example |
|-------|---------|---------|
| `Name` | C# class name (PascalCase) | `ProductSalesView` |
| `Description` | Documentation | `"Product sales summary"` |
| `SqlFile` | Relative path from project root | `"sql/views/ProductSalesView.sql"` |
| `GeneratePartial` | Generate as partial class (false = sealed) | `true` |
| `Applications` | Which apps can access this view | `["admin", "reporting"]` |
| `Parameters` | SQL parameters (@TopN, @CategoryId) | Array of ViewParameter objects |
| `Properties` | SQL result columns | Array of ViewProperty objects |

### ViewParameter Structure

```json
{
  "Name": "TopN",
  "Type": "int",
  "Nullable": false,
  "Default": "10",
  "Validation": {
    "Required": true,
    "Range": [1, 1000]
  }
}
```

Supported types: `int`, `string`, `decimal`, `datetime`, `bool`, `guid`, `double`, `float`

### ViewProperty Structure

```json
{
  "Name": "TotalRevenue",
  "Type": "decimal",
  "Nullable": false,
  "MaxLength": 100
}
```

Property names must exactly match SQL column aliases (case-insensitive).

---

## SQL View Files

SQL view files go in `sql/views/` and contain SELECT queries with parameters.

### Best Practices

**File:** `sql/views/ProductSalesView.sql`

```sql
-- ProductSalesView.sql
-- Product sales summary with category and order totals
-- Parameters: @TopN (default: 10), @CategoryId (optional filter)
--
-- Usage from IViewService:
--   await ViewService.ExecuteViewAsync<ProductSalesView>(
--       "ProductSalesView",
--       new { TopN = 50, CategoryId = 3 });

SELECT TOP (@TopN)
    p.Id,
    p.Name,
    p.Price,
    c.Name AS CategoryName,
    SUM(od.Quantity) AS TotalSold,
    SUM(od.Quantity * p.Price) AS TotalRevenue
FROM acme.Products p
LEFT JOIN acme.Categories c ON p.CategoryId = c.Id
LEFT JOIN acme.OrderDetails od ON p.Id = od.ProductId
WHERE (@CategoryId IS NULL OR p.CategoryId = @CategoryId)
GROUP BY p.Id, p.Name, p.Price, c.Name
ORDER BY TotalRevenue DESC;
```

### SQL Guidelines

- Use column aliases matching ViewDefinition properties: `COUNT(*) AS TotalCount`
- Use parameterized queries: `@TopN`, not hardcoded values like `TOP 10`
- Include header comments explaining parameters and usage
- Avoid schema prefixes in multi-tenant scenarios (let Dapper handle it)
- Test SQL in SSMS before adding to project
- Parameters use `@ParameterName` in SQL; no @ in ViewDefinition or C#

---

## Service Layer: IViewService, IViewRegistry, IDapperQueryService

### IViewService Interface

```csharp
public interface IViewService
{
    /// Execute a view and return multiple results
    Task<IEnumerable<T>> ExecuteViewAsync<T>(
        string viewName,
        object? parameters = null);

    /// Execute a view and return single result (null if not found)
    Task<T?> ExecuteViewSingleAsync<T>(
        string viewName,
        object? parameters = null);
}
```

### IViewService Usage Patterns

**Pattern 1: Simple View (No Parameters)**

```csharp
@inject IViewService ViewService

protected override async Task OnInitializedAsync()
{
    var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView");
}
```

**Pattern 2: Parameterized View**

```csharp
var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    new { TopN = 50, CategoryId = 3 });
```

**Pattern 3: Single Result**

```csharp
var dashboard = await ViewService.ExecuteViewSingleAsync<DashboardSummaryView>(
    "DashboardSummaryView",
    new { Date = DateTime.Today });

if (dashboard != null)
{
    // Use result
}
```

### IViewRegistry Interface

```csharp
public interface IViewRegistry
{
    /// Get SQL query text for a view
    Task<string> GetViewSqlAsync(string viewName);

    /// Get view metadata definition
    ViewDefinition GetViewDefinition(string viewName);

    /// Get all view names
    IEnumerable<string> GetAllViewNames();

    /// Get views visible to specific application
    IReadOnlyList<ViewDefinition> GetViewsForApplication(string appName);
}
```

### When to Use IViewRegistry Directly

- Building dynamic UI (listing available views)
- Validating view access permissions
- Debugging SQL queries
- Custom view execution logic
- Building API endpoints that need view metadata

---

## Blazor Integration: ViewSection.razor

### Using the Generic ViewSection Component

```razor
<ViewSection AppName="admin" ViewName="ProductSalesView" />
```

**Parameters:**
- `AppName` (string) - Current application name
- `ViewName` (string) - View to display

**Features:**
- Automatic column discovery from view model properties
- Parameter UI for views with @Parameters
- Radzen DataGrid with filtering, sorting, paging
- Error handling with user-friendly messages
- Loading states with progress indicator

### Custom View Component Pattern

```razor
@page "/dashboard/products"
@inject IViewService ViewService
@inject ILogger<ProductDashboard> Logger

<RadzenCard>
    <RadzenStack Gap="16px">
        <RadzenText Text="Top Products" TextStyle="@TextStyle.H5" />

        @if (isLoading)
        {
            <RadzenProgressBarCircular ShowValue="false"
                                      Mode="@ProgressBarMode.Indeterminate" />
        }
        else if (errorMessage != null)
        {
            <RadzenAlert AlertStyle="@AlertStyle.Danger">
                @errorMessage
            </RadzenAlert>
        }
        else if (products?.Any() == true)
        {
            <RadzenDataGrid Data="@products"
                           TItem="ProductSalesView"
                           AllowSorting="true"
                           AllowPaging="true"
                           AllowFiltering="true"
                           PageSize="20"
                           Style="width: 100%;">
                <Columns>
                    <RadzenDataGridColumn TItem="ProductSalesView"
                                         Property="Name"
                                         Title="Product" />
                    <RadzenDataGridColumn TItem="ProductSalesView"
                                         Property="CategoryName"
                                         Title="Category" />
                    <RadzenDataGridColumn TItem="ProductSalesView"
                                         Property="TotalSold"
                                         Title="Units Sold" />
                    <RadzenDataGridColumn TItem="ProductSalesView"
                                         Property="TotalRevenue"
                                         Title="Revenue">
                        <Template Context="product">
                            @product.TotalRevenue.ToString("C")
                        </Template>
                    </RadzenDataGridColumn>
                </Columns>
            </RadzenDataGrid>
        }
    </RadzenStack>
</RadzenCard>

@code {
    private IEnumerable<ProductSalesView>? products;
    private bool isLoading = true;
    private string? errorMessage;

    protected override async Task OnInitializedAsync()
    {
        try
        {
            products = await ViewService.ExecuteViewAsync<ProductSalesView>(
                "ProductSalesView",
                new { TopN = 50 });
        }
        catch (FileNotFoundException ex)
        {
            Logger.LogError(ex, "View SQL file not found");
            errorMessage = "View is not configured correctly. Please contact your administrator.";
        }
        catch (InvalidOperationException ex) when (ex.Message.Contains("VIEW_NOT_FOUND"))
        {
            Logger.LogError(ex, "View not registered");
            errorMessage = "View is not available. Please contact your administrator.";
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Error loading view");
            errorMessage = $"Error loading view: {ex.Message}";
        }
        finally
        {
            isLoading = false;
        }
    }
}
```

---

## Error Handling

View pipeline errors use standardized error IDs from `Constants/ErrorIds.cs`.

### Error ID Catalog

| Error ID | HTTP | Meaning | User Message |
|----------|------|---------|--------------|
| `VIEW_NOT_FOUND` | 404 | View not in app.yaml | "View is not available" |
| `SQL_FILE_NOT_FOUND` | 500 | .sql file missing | "View is not configured" |
| `SQL_FILE_PERMISSION_DENIED` | 403 | Cannot read .sql file | "Cannot access view files" |
| `QUERY_TIMEOUT` | 504 | SQL query timeout | "View is loading slowly" |
| `SQL_ERROR` | 500 | SQL Server error | "Database error" |
| `QUERY_INVALID_PARAMETER` | 400 | Invalid parameters | "Invalid parameters" |

### Error Handling Pattern

```csharp
try
{
    results = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = topN });
}
catch (FileNotFoundException ex)
{
    Logger.LogError(ex, "View SQL file not found");
    errorMessage = "View is not configured correctly.";
}
catch (InvalidOperationException ex) when (ex.Message.Contains("VIEW_NOT_FOUND"))
{
    Logger.LogError(ex, "View not registered");
    errorMessage = "View is not available.";
}
catch (InvalidOperationException ex) when (ex.Message.Contains("QUERY_TIMEOUT"))
{
    Logger.LogWarning(ex, "View query timeout");
    errorMessage = "The view is loading slowly. Please try again.";
}
catch (Exception ex)
{
    Logger.LogError(ex, "Unexpected error executing view");
    errorMessage = $"Error: {ex.Message}";
}
```

---

## Multi-Tenancy: Automatic Schema Isolation

Dapper automatically inherits the tenant schema from EF Core's connection. No manual schema injection needed.

### How It Works

**DI Registration in Program.cs:**

```csharp
builder.Services.AddScoped<IDapperQueryService>(sp =>
{
    var dbContext = sp.GetRequiredService<AppDbContext>();
    return new DapperQueryService(dbContext);  // ✅ Shares EF's connection
});
```

**Result:** SQL queries automatically use the correct schema:
- Request with `X-Customer-Schema: customer1` → Dapper uses `customer1` schema
- Request with `X-Customer-Schema: customer2` → Dapper uses `customer2` schema

### Key Point

The Finbuckle.MultiTenant middleware sets the schema before the request reaches your code. DapperQueryService gets the connection from AppDbContext, which already has the correct schema. Result: automatic multi-tenant isolation with zero additional work.

---

## Code Generation Pipeline

**Unified Pipeline (make run-ddl-pipeline):**

```
1. DdlParser: sql/schema.sql → entities.yaml
2. ViewModelGenerator: appsettings.json ViewDefinitions → validated
3. YamlMerger: entities.yaml + ViewDefinitions → data.yaml
4. AppsYamlGenerator: data.yaml + Applications → app.yaml
5. ModelGenerator:
   - EntityGenerator: app.yaml entities → DotNetWebApp.Models/Generated/*.cs
   - ViewModelGenerator: app.yaml views → DotNetWebApp.Models/ViewModels/*.generated.cs
```

### Generated Files

```
DotNetWebApp.Models/
├── Generated/
│   ├── Product.cs              # EF Core entities (from sql/schema.sql)
│   └── Category.cs
└── ViewModels/
    ├── ProductSalesView.generated.cs    # Dapper DTOs (from appsettings.json)
    └── ProductSalesView.cs              # Optional user extensions (never overwritten)
```

### Partial Class Pattern

- `.generated.cs` - Machine-generated, overwritten on each pipeline run
- `.cs` - User-maintained, never overwritten

**Example:** Add custom methods to view model without risking pipeline overwrite:

**File:** `DotNetWebApp.Models/ViewModels/ProductSalesView.generated.cs` (auto-generated)
```csharp
namespace DotNetWebApp.Models.ViewModels
{
    public partial class ProductSalesView
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public decimal Price { get; set; }
    }
}
```

**File:** `DotNetWebApp.Models/ViewModels/ProductSalesView.cs` (user-created, preserved)
```csharp
namespace DotNetWebApp.Models.ViewModels
{
    public partial class ProductSalesView
    {
        public decimal Margin => Price * 0.20m;  // Custom property, never overwritten
    }
}
```

---

## Best Practices

### 1. Use Views for Complex Reads

✅ **Use views for:**
- 3+ table JOINs
- Aggregations (SUM, AVG, GROUP BY)
- Reports and dashboards
- Read-only queries

❌ **Don't use views for:**
- Single entity CRUD
- Simple 1-2 table queries (use EF Core)
- Writes/updates (use EF Core)

### 2. Use EF Core for Writes

All INSERT, UPDATE, DELETE operations go through EF Core (EntitiesController), not views.

### 3. Validate Parameters

Always validate parameters before passing to view:

```csharp
if (topN < 1 || topN > 1000)
    throw new ArgumentException("TopN must be between 1 and 1000");

var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    new { TopN = topN });
```

### 4. Log with Error IDs

Always include error IDs for monitoring:

```csharp
Logger.LogError(ex, "View execution failed");  // ❌ Bad
Logger.LogError(ex, "[{ErrorId}] View execution failed", ErrorIds.ViewExecutionFailed);  // ✅ Good
```

### 5. Use Type-Safe View Models

```csharp
// ✅ CORRECT - Type-safe
var results = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");

// ❌ WRONG - Dynamic loses compile-time safety
var results = await ViewService.ExecuteViewAsync<dynamic>("ProductSalesView");
```

### 6. Run Pipeline After ViewDefinition Changes

Every time you modify `appsettings.json` ViewDefinitions:

```bash
make run-ddl-pipeline
# Then restart application to reload IViewRegistry singleton
```

---

## Business Logic & Controllers: Where Views Execute

### Why No ViewController?

**Don't create** a `ViewController` or REST endpoints for views like `/api/views/{viewName}`.

Views are read-only aggregations best served **directly from Blazor components**, not via HTTP:

```csharp
// ❌ DON'T DO THIS - Unnecessary HTTP layer
[ApiController]
[Route("api/views")]
public class ViewController : ControllerBase
{
    [HttpGet("{viewName}")]
    public async Task<ActionResult> GetView(string viewName, [FromQuery] int topN = 10)
    {
        var results = await _viewService.ExecuteViewAsync<dynamic>(viewName);
        return Ok(results);
    }
}
```

**Why:**
- Blazor is **same-process** as the API (no network benefit from HTTP)
- Extra HTTP round-trip adds 50-200ms latency per view load
- Typed view models (ProductSalesView, etc.) require complex dynamic JSON serialization
- View caching would be HTTP cache headers, not in-process memory
- Creates authentication/authorization complexity

**✅ DO THIS instead - Direct service injection:**

```csharp
// ✅ CORRECT - Direct service call from Blazor component
@inject IViewService ViewService

protected override async Task OnInitializedAsync()
{
    var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = 50 });
}
```

### Where Does Business Logic Live?

**Business logic for views belongs in service layer, not controllers:**

| Scenario | Where | Pattern |
|----------|-------|---------|
| **Simple view display** | Blazor component | Inject IViewService, call ExecuteViewAsync |
| **Complex parameter building** | Custom service (IViewParameterBuilder) | Extract parameter logic from component |
| **Publishing to message queue** | Custom wrapper service (IPublishingViewService) | Wrap IViewService, publish after execute |
| **Calling external API** | Custom wrapper service (IEnrichedViewService) | Execute view, enrich with API data |
| **Logging/auditing execution** | Decorator pattern or middleware | Wrap IViewService with logging |
| **Multi-step orchestration** | Dedicated service (IViewOrchestrationService) | Coordinate multiple view executions |

### Example: Custom View Service with Business Logic

**Scenario:** After loading ProductSalesView, publish top-selling products to a message queue.

**Implementation:**

```csharp
// Custom service wrapping IViewService
public interface IPublishingViewService
{
    Task<IEnumerable<T>> ExecuteAndPublishAsync<T>(
        string viewName,
        object? parameters = null,
        string publishTopic = null);
}

public class PublishingViewService : IPublishingViewService
{
    private readonly IViewService _viewService;
    private readonly IMessageQueue _queue;
    private readonly ILogger<PublishingViewService> _logger;

    public PublishingViewService(
        IViewService viewService,
        IMessageQueue queue,
        ILogger<PublishingViewService> logger)
    {
        _viewService = viewService;
        _queue = queue;
        _logger = logger;
    }

    public async Task<IEnumerable<T>> ExecuteAndPublishAsync<T>(
        string viewName,
        object? parameters = null,
        string publishTopic = null)
    {
        // Execute view normally
        var results = await _viewService.ExecuteViewAsync<T>(viewName, parameters);

        // Add business logic: publish to queue if topic specified
        if (publishTopic != null && results?.Any() == true)
        {
            var message = new ViewResultsMessage
            {
                ViewName = viewName,
                ResultCount = results.Count(),
                Timestamp = DateTime.UtcNow
            };

            await _queue.PublishAsync(publishTopic, message);
            _logger.LogInformation(
                "Published {Count} results from {ViewName} to {Topic}",
                results.Count(), viewName, publishTopic);
        }

        return results;
    }
}
```

**DI Registration:**

```csharp
builder.Services.AddScoped<IPublishingViewService, PublishingViewService>();
```

**Usage in Blazor Component:**

```csharp
@inject IPublishingViewService PublishingViewService

protected override async Task OnInitializedAsync()
{
    // Execute view AND publish to queue in one call
    results = await PublishingViewService.ExecuteAndPublishAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = 50 },
        publishTopic: "product-sales-events");
}
```

### Antipattern: Business Logic in Controllers

Don't do this:

```csharp
// ❌ WRONG - Business logic in controller
[ApiController]
[Route("api/products")]
public class ProductController : ControllerBase
{
    [HttpGet("sales")]
    public async Task<ActionResult> GetProductSales(int topN = 10)
    {
        // Execute view
        var results = await _viewService.ExecuteViewAsync<ProductSalesView>(
            "ProductSalesView",
            new { TopN = topN });

        // Business logic mixed in controller
        foreach (var product in results)
        {
            // Publish to queue
            await _queue.PublishAsync("product-sales", product);

            // Call external API
            await _externalService.LogSale(product.Id, product.TotalRevenue);

            // Update cache
            await _cache.SetAsync($"product_{product.Id}", product);
        }

        return Ok(results);
    }
}
```

**Why it's wrong:**
- Controller becomes god object (view execution + queue + API + cache)
- Can't test business logic without HTTP context
- Can't reuse logic in other contexts (background job, scheduled task)
- Violates single responsibility principle

---

## References

For deeper learning:

- [references/architecture-patterns.md](references/architecture-patterns.md) - Design decisions, why hybrid EF+Dapper, service layer patterns
- [references/api-reference.md](references/api-reference.md) - Complete API documentation for all three services
- [references/troubleshooting.md](references/troubleshooting.md) - Error catalog with step-by-step solutions
- [references/advanced-patterns.md](references/advanced-patterns.md) - Caching, performance, testing, streaming

**Project Documentation:**
- `/home/jrade/code/devixlabs/DotNetWebApp/ARCHITECTURE_SUMMARY.md` - Architecture overview
- `/home/jrade/code/devixlabs/DotNetWebApp/HYBRID_ARCHITECTURE.md` - EF Core + Dapper patterns
- `/home/jrade/code/devixlabs/DotNetWebApp/tests/DotNetWebApp.Tests/ViewPipelineTests.cs` - 18 unit tests covering view pipeline
