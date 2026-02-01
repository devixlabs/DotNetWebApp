# API Reference: Complete Service Documentation

Complete API documentation for IViewService, IViewRegistry, IDapperQueryService, and data classes.

---

## IViewService Interface

Location: `/Services/Views/IViewService.cs`

Executes SQL views and returns results. Scoped lifetime (one per HTTP request).

### ExecuteViewAsync<T>

```csharp
Task<IEnumerable<T>> ExecuteViewAsync<T>(
    string viewName,
    object? parameters = null)
```

**Parameters:**
- `viewName` (string) - View name from app.yaml (case-insensitive)
- `parameters` (object, optional) - Anonymous object with SQL parameter values

**Returns:** `Task<IEnumerable<T>>` - Enumerable collection of results

**Exceptions:**
- `InvalidOperationException` - View not found in registry
- `FileNotFoundException` - SQL file not found on disk
- `SqlException` - SQL Server error (deadlock, constraint violation, etc.)
- `OperationCanceledException` - Query timeout

**Examples:**

```csharp
// No parameters
var results = await viewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");

// With parameters
var results = await viewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    new { TopN = 50, CategoryId = 3 });

// IEnumerable is lazy-evaluated (avoid ToList() unless needed)
var firstPage = results.Take(20);
```

---

### ExecuteViewSingleAsync<T>

```csharp
Task<T?> ExecuteViewSingleAsync<T>(
    string viewName,
    object? parameters = null)
```

**Parameters:**
- `viewName` (string) - View name from app.yaml (case-insensitive)
- `parameters` (object, optional) - Anonymous object with SQL parameter values

**Returns:** `Task<T?>` - Single result or null if no rows found

**Exceptions:**
- Same as `ExecuteViewAsync<T>`
- Additionally throws `InvalidOperationException` if multiple rows returned (expects exactly 0 or 1)

**Examples:**

```csharp
// Get dashboard summary for today
var dashboard = await viewService.ExecuteViewSingleAsync<DashboardSummaryView>(
    "DashboardSummaryView",
    new { Date = DateTime.Today });

if (dashboard != null)
{
    Console.WriteLine($"Total sales: {dashboard.TotalRevenue}");
}
else
{
    Console.WriteLine("No data for today");
}
```

---

## IViewRegistry Interface

Location: `/Services/Views/IViewRegistry.cs`

Manages view metadata and SQL file loading. Singleton lifetime (loaded once at startup).

### GetViewSqlAsync

```csharp
Task<string> GetViewSqlAsync(string viewName)
```

**Parameters:**
- `viewName` (string) - View name from app.yaml (case-insensitive)

**Returns:** `Task<string>` - SQL query text

**Exceptions:**
- `InvalidOperationException` - View not found in registry
- `FileNotFoundException` - SQL file missing on disk
- `UnauthorizedAccessException` - Permission denied reading SQL file

**Behavior:**
- First call: Reads SQL file from disk, caches result in `ConcurrentDictionary`
- Subsequent calls: Returns cached SQL (sub-millisecond)

**Examples:**

```csharp
// Direct usage (uncommon, IViewService uses this internally)
var sql = await viewRegistry.GetViewSqlAsync("ProductSalesView");
Console.WriteLine($"SQL:\n{sql}");
```

---

### GetViewDefinition

```csharp
ViewDefinition GetViewDefinition(string viewName)
```

**Parameters:**
- `viewName` (string) - View name from app.yaml (case-insensitive)

**Returns:** `ViewDefinition` - View metadata

**Exceptions:**
- `InvalidOperationException` - View not found in registry

**Returns `ViewDefinition` with properties:**
- `Name` (string) - View name
- `Description` (string) - View description
- `SqlFile` (string) - Path to SQL file
- `GeneratePartial` (bool) - Whether view model is partial class
- `Applications` (List<string>) - Which apps can access this view
- `Parameters` (List<ViewParameter>) - SQL parameters with types and validation
- `Properties` (List<ViewProperty>) - Result columns with types and validation

**Examples:**

```csharp
var definition = viewRegistry.GetViewDefinition("ProductSalesView");
Console.WriteLine($"View: {definition.Name}");
Console.WriteLine($"Description: {definition.Description}");
Console.WriteLine($"Accessible in: {string.Join(", ", definition.Applications)}");

foreach (var param in definition.Parameters)
{
    Console.WriteLine($"  Parameter: {param.Name} ({param.Type}) = {param.Default}");
}
```

---

### GetAllViewNames

```csharp
IEnumerable<string> GetAllViewNames()
```

**Parameters:** None

**Returns:** `IEnumerable<string>` - All view names in registry

**Exceptions:** None

**Examples:**

```csharp
var allViews = viewRegistry.GetAllViewNames();
Console.WriteLine($"Available views: {string.Join(", ", allViews)}");
```

---

### GetViewsForApplication

```csharp
IReadOnlyList<ViewDefinition> GetViewsForApplication(string appName)
```

**Parameters:**
- `appName` (string) - Application name (case-sensitive, matches ApplicationInfo.Name in app.yaml)

**Returns:** `IReadOnlyList<ViewDefinition>` - Views visible to the application

**Exceptions:** None (returns empty list if app not found or has no views)

**Examples:**

```csharp
var adminViews = viewRegistry.GetViewsForApplication("admin");
Console.WriteLine($"Admin can access {adminViews.Count} views:");
foreach (var view in adminViews)
{
    Console.WriteLine($"  - {view.Name}: {view.Description}");
}
```

---

## IDapperQueryService Interface

Location: `/Data/Dapper/IDapperQueryService.cs`

Executes SQL queries using Dapper. Scoped lifetime (one per HTTP request).

### QueryAsync<T>

```csharp
Task<IEnumerable<T>> QueryAsync<T>(
    string sql,
    object? parameters = null)
```

**Parameters:**
- `sql` (string) - SQL query text (supports @ParameterName syntax)
- `parameters` (object, optional) - Anonymous object or DynamicParameters with parameter values

**Returns:** `Task<IEnumerable<T>>` - Enumerable collection of mapped results

**Exceptions:**
- `SqlException` - SQL Server error
- `OperationCanceledException` - Query timeout
- `InvalidOperationException` - Type mapping error

**Behavior:**
- Dapper maps SQL result columns to T properties by name (case-insensitive)
- IEnumerable is lazy-evaluated; data not fetched until enumerated

**Examples:**

```csharp
// Simple query
var products = await dapper.QueryAsync<Product>(
    "SELECT * FROM Products WHERE CategoryId = @CategoryId",
    new { CategoryId = 3 });

// Complex query with multiple parameters
var sales = await dapper.QueryAsync<SalesResult>(
    @"SELECT TOP (@TopN) p.Id, p.Name, SUM(od.Quantity) AS TotalSold
      FROM Products p
      LEFT JOIN OrderDetails od ON p.Id = od.ProductId
      WHERE p.CategoryId = @CategoryId
      GROUP BY p.Id, p.Name
      ORDER BY TotalSold DESC",
    new { TopN = 50, CategoryId = 3 });
```

---

### QuerySingleAsync<T>

```csharp
Task<T?> QuerySingleAsync<T>(
    string sql,
    object? parameters = null)
```

**Parameters:**
- `sql` (string) - SQL query text (supports @ParameterName syntax)
- `parameters` (object, optional) - Anonymous object with parameter values

**Returns:** `Task<T?>` - Single result or null if no rows found

**Exceptions:**
- Same as `QueryAsync<T>`
- Additionally throws `InvalidOperationException` if multiple rows returned

**Examples:**

```csharp
var product = await dapper.QuerySingleAsync<Product>(
    "SELECT * FROM Products WHERE Id = @Id",
    new { Id = 42 });

if (product != null)
{
    Console.WriteLine($"Product: {product.Name}");
}
```

---

## Data Classes: ViewDefinition

Location: `/DotNetWebApp.Models/AppDictionary/ViewDefinition.cs`

YAML model class representing a view definition.

### Properties

| Property | Type | YAML Key | Purpose |
|----------|------|----------|---------|
| `Name` | string | `name` | View identifier (PascalCase) |
| `Description` | string | `description` | Documentation string |
| `SqlFile` | string | `sql_file` | Relative path to SQL file |
| `GeneratePartial` | bool | `generate_partial` | Generate as partial class (default: true) |
| `Applications` | List<string> | `applications` | App names that can access this view |
| `Parameters` | List<ViewParameter> | `parameters` | SQL parameter definitions |
| `Properties` | List<ViewProperty> | `properties` | Result column definitions |

### Complete YAML Example

```yaml
views:
  - name: ProductSalesView
    description: "Product sales summary"
    sql_file: "sql/views/ProductSalesView.sql"
    generate_partial: true
    applications: [admin, reporting]
    parameters:
      - name: TopN
        type: int
        nullable: false
        default: "10"
    properties:
      - name: Id
        type: int
        nullable: false
      - name: Name
        type: string
        nullable: false
        max_length: 100
```

---

## ViewParameter Class

Location: `/DotNetWebApp.Models/AppDictionary/ViewDefinition.cs`

Represents a SQL parameter (@TopN, @CategoryId, etc.).

### Properties

| Property | Type | YAML Key | Purpose |
|----------|------|----------|---------|
| `Name` | string | `name` | Parameter name (no @ prefix) |
| `Type` | string | `type` | C# type: int, string, decimal, datetime, bool, guid, double, float |
| `Nullable` | bool | `nullable` | Whether parameter can be null |
| `Default` | string | `default` | Default value as string (parsed to type) |
| `Validation` | ValidationConfig | `validation` | Optional validation rules |

### Supported Types

```
int, long, short, byte
string, char
decimal, double, float
datetime, datetimeoffset, timespan
bool
guid
```

### Complete Parameter Example

```yaml
parameters:
  - name: TopN
    type: int
    nullable: false
    default: "10"
    validation:
      required: true
      range: [1, 1000]

  - name: CategoryId
    type: int
    nullable: true
    default: null

  - name: SearchText
    type: string
    nullable: false
    default: ""
    validation:
      required: true
      max_length: 100
```

---

## ViewProperty Class

Location: `/DotNetWebApp.Models/AppDictionary/ViewDefinition.cs`

Represents a SQL result column (SELECT projection).

### Properties

| Property | Type | YAML Key | Purpose |
|----------|------|----------|---------|
| `Name` | string | `name` | Property name (matches SQL alias) |
| `Type` | string | `type` | C# type |
| `Nullable` | bool | `nullable` | Whether can be NULL |
| `MaxLength` | int? | `max_length` | Max length for string properties |
| `Validation` | ValidationConfig | `validation` | Optional validation rules |

### Complete Property Example

```yaml
properties:
  - name: Id
    type: int
    nullable: false

  - name: Name
    type: string
    nullable: false
    max_length: 100
    validation:
      required: true

  - name: CategoryName
    type: string
    nullable: true
    max_length: 100

  - name: Price
    type: decimal
    nullable: false

  - name: TotalRevenue
    type: decimal
    nullable: false
```

---

## Generated View Model Class

Location: `/DotNetWebApp.Models/ViewModels/*.generated.cs`

Auto-generated C# class representing a view's result shape.

### Example Generated Class

**Source:** `appsettings.json` + `ProductSalesView.sql`

**Generated:** `ProductSalesView.generated.cs`

```csharp
using System.ComponentModel.DataAnnotations;

namespace DotNetWebApp.Models.ViewModels
{
    /// <summary>
    /// Product sales summary with category and order totals
    /// </summary>
    /// <remarks>
    /// SQL Source: sql/views/ProductSalesView.sql
    /// Parameters:
    ///   - @TopN (int) = 10
    /// </remarks>
    public partial class ProductSalesView
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = null!;

        public decimal Price { get; set; }

        [MaxLength(100)]
        public string? CategoryName { get; set; }

        public int TotalSold { get; set; }

        public decimal TotalRevenue { get; set; }
    }

    /// <summary>
    /// Parameters for ProductSalesView view query.
    /// </summary>
    public partial class ProductSalesViewParameters
    {
        [Required]
        [Range(1, 1000)]
        public int TopN { get; set; } = 10;
    }
}
```

### Property Attributes Generated

**From ViewProperty:**
- `[Required]` - if Nullable = false
- `[MaxLength(N)]` - if MaxLength specified
- `[Range(min, max)]` - if Validation.Range specified

**From ViewParameter:**
- Parameters class generated as optional extension (for parameter validation UI)
- Can be used with FluentValidation if needed

---

## Error ID Constants

Location: `/Constants/ErrorIds.cs`

Standardized error IDs for monitoring and debugging.

### Error ID Reference

```csharp
public static class ErrorIds
{
    // View-related errors
    public const string ViewNotFound = "VIEW_NOT_FOUND";
    public const string SqlFileNotFound = "SQL_FILE_NOT_FOUND";
    public const string SqlFilePermissionDenied = "SQL_FILE_PERMISSION_DENIED";

    // Execution errors
    public const string QueryTimeout = "QUERY_TIMEOUT";
    public const string QueryOutOfMemory = "QUERY_OUT_OF_MEMORY";
    public const string SqlError = "SQL_ERROR";
    public const string InvalidParameter = "QUERY_INVALID_PARAMETER";
    public const string ViewExecutionFailed = "VIEW_EXECUTION_FAILED";
}
```

### Logging Usage

Always include error ID in log message:

```csharp
try
{
    results = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");
}
catch (FileNotFoundException ex)
{
    Logger.LogError(ex, "[{ErrorId}] SQL file not found", ErrorIds.SqlFileNotFound);
    throw;
}
catch (InvalidOperationException ex) when (ex.Message.Contains("DEADLOCK"))
{
    Logger.LogWarning(ex, "[{ErrorId}] Database deadlock", ErrorIds.SqlError);
    throw;
}
```

---

## Dependency Injection Registration

Location: `/Program.cs`

### Complete DI Setup

```csharp
// Line 47-52: AppDictionaryService (Singleton)
builder.Services.AddSingleton<IAppDictionaryService>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var yamlPath = Path.Combine(env.ContentRootPath, "app.yaml");
    return new AppDictionaryService(yamlPath);
});

// Line 62: DapperQueryService (Scoped)
builder.Services.AddScoped<IDapperQueryService, DapperQueryService>();

// Line 65-71: ViewRegistry (Singleton, depends on AppDictionaryService)
builder.Services.AddSingleton<IViewRegistry>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var logger = sp.GetRequiredService<ILogger<ViewRegistry>>();
    var appDictionary = sp.GetRequiredService<IAppDictionaryService>();
    return new ViewRegistry(logger, appDictionary, env.ContentRootPath);
});

// Line 74: ViewService (Scoped, depends on IViewRegistry + IDapperQueryService)
builder.Services.AddScoped<IViewService, ViewService>();
```

### Key Points

1. **Order matters:** AppDictionaryService must be registered before ViewRegistry
2. **IViewRegistry is singleton:** Views loaded once at startup
3. **IViewService is scoped:** Can add per-request state in future
4. **IDapperQueryService must use factory pattern:** To share DbContext connection

---

## Usage Summary Quick Table

| Task | Interface | Method |
|------|-----------|--------|
| Execute view with parameters | IViewService | ExecuteViewAsync<T> |
| Execute view return single | IViewService | ExecuteViewSingleAsync<T> |
| Get view definition | IViewRegistry | GetViewDefinition |
| Get SQL for debugging | IViewRegistry | GetViewSqlAsync |
| List all views | IViewRegistry | GetAllViewNames |
| List views for app | IViewRegistry | GetViewsForApplication |
| Execute raw SQL | IDapperQueryService | QueryAsync<T> |
| Execute raw SQL single | IDapperQueryService | QuerySingleAsync<T> |
