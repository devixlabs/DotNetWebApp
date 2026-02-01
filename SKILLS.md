# Skills Needed

Comprehensive guides for developers at all skill levels. Status of each guide:

- ✅ **[Front-End (Blazor/Radzen)](#front-end-skillsguide-blazorradzen)** - COMPLETE
- ✅ **[Database & DDL](#database--ddl)** - COMPLETE
- ✅ **[SQL Operations](#sql-operations)** - COMPLETE
- ✅ **[App Configuration & YAML](#app-configuration--yaml)** - COMPLETE
- ✅ **[.NET/C# Data Layer](#netc-data-layer)** - COMPLETE - Entity Framework Core, models, and data access
- ✅ **[SQL Views & Complex Queries (Phase 2)](#sql-views--complex-queries-phase-2)** - COMPLETE - Dapper-based views, IViewService, and SQL-first read patterns
- ✅ **[.NET/C# API & Services](#netc-api--services)** - COMPLETE - Controllers, services, and API endpoints

---

# Database & DDL

This guide covers SQL Server schema design and how DDL (Data Definition Language) files drive the data model in this project.

## Overview

The application uses a **DDL-first approach**: you define your database schema in SQL, and the system automatically generates everything else (YAML config, C# models, API endpoints, UI).

### The Pipeline

```
schema.sql (YOUR DDL)
    ↓ (run: make run-ddl-pipeline)
app.yaml (generated YAML config)
    ↓ (automatic on startup)
Models/Generated/*.cs (C# entities)
    ↓ (EF Core)
Database Migration & Tables
```

## File Locations

| File | Purpose |
|------|---------|
| `schema.sql` | 📝 Your SQL DDL file - this is what you edit to define tables |
| `app.yaml` | 🔄 Auto-generated from `schema.sql` - never edit manually |
| `Models/Generated/` | 🔄 Auto-generated C# entity classes - never edit manually |
| `Migrations/` | 🔄 Auto-generated EF Core migrations - ignored in repo |

## Writing Schema (schema.sql)

### Basic Table Structure

```sql
CREATE TABLE Categories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);
```

**Key parts:**
- `CREATE TABLE TableName` - defines a table (will be pluralized to `Categories` in database)
- `Id INT PRIMARY KEY IDENTITY(1,1)` - unique identifier that auto-increments
- `NVARCHAR(50) NOT NULL` - text field up to 50 characters, required
- `NVARCHAR(500) NULL` - optional text field

### Column Types

Common SQL Server types and their C# equivalents:

| SQL Type | C# Type | Notes |
|----------|---------|-------|
| `INT` | `int` | Whole numbers |
| `BIGINT` | `long` | Very large whole numbers |
| `DECIMAL(18,2)` | `decimal` | Money, prices (18 digits total, 2 after decimal) |
| `NVARCHAR(50)` | `string` | Text, max 50 characters |
| `NVARCHAR(MAX)` | `string` | Unlimited text |
| `DATETIME2` | `DateTime` | Date and time |
| `BIT` | `bool` | True/False |

### NULL vs NOT NULL

- `NOT NULL` - field is **required** (no empty values allowed)
- `NULL` - field is **optional** (can be empty)

```sql
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,        -- Required
    Description NVARCHAR(500) NULL,     -- Optional
    Price DECIMAL(18,2) NULL            -- Optional
);
```

### Foreign Keys (Relationships)

Link one table to another:

```sql
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    CategoryId INT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);
```

This means: "Products.CategoryId must match a Categories.Id value (or be NULL)"

### IDENTITY (Auto-Increment)

```sql
Id INT PRIMARY KEY IDENTITY(1,1)
```

- `IDENTITY(1,1)` - start at 1, increment by 1 each time
- Automatically assigns unique IDs; you don't have to provide them

### DEFAULT Values

```sql
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE()
);
```

`DEFAULT GETDATE()` - automatically sets the current date/time when a row is inserted

## Running the DDL Pipeline

After editing `schema.sql`, regenerate everything:

```bash
make run-ddl-pipeline
```

This:
1. Parses your `schema.sql` file
2. Generates `app.yaml` with entity definitions
3. Creates C# entity classes in `Models/Generated/`
4. Rebuilds the project
5. Generates a new EF Core migration

Then apply the migration to your database:

```bash
make migrate
```

## Troubleshooting

**Q: My schema changes aren't showing up in the API**
- Run `make run-ddl-pipeline` - the pipeline must be re-run after editing schema.sql

**Q: I get a migration error**
- Ensure `make db-start` is running (SQL Server container must be up)
- Ensure the previous migration has been applied

**Q: Which tables are actually created in the database?**
- After running `make migrate`, query the database to verify tables exist

## Important Notes

- Always edit `schema.sql`, never edit `app.yaml` or `Models/Generated/`
- The DDL parser handles: tables, columns, types, nullability, primary keys, foreign keys, IDENTITY, DEFAULT
- Currently does NOT handle: composite primary keys, UNIQUE constraints, CHECK constraints, computed columns
- After major schema changes, you may need to drop and recreate the database: `make db-drop` then `make db-start`

---

# SQL Operations

This guide covers writing and debugging SQL queries in this project.

## File Locations

| File | Purpose |
|------|---------|
| `schema.sql` | DDL (table definitions) |
| `seed.sql` | DML (sample data to insert) |
| SQL Server (in Docker) | The actual running database |

## Sample Data (seed.sql)

The `seed.sql` file contains INSERT statements that populate the database with example data:

```sql
INSERT INTO Categories (Name) VALUES ('Electronics');
INSERT INTO Categories (Name) VALUES ('Books');

INSERT INTO Products (Name, Description, Price, CategoryId)
VALUES ('Laptop', 'High-performance laptop', 999.99, 1);
```

### Running Seed Data

```bash
make seed
```

This:
1. Applies any pending migrations
2. Executes `seed.sql` to insert sample rows
3. Prevents duplicate inserts (guards against re-running)

### Writing Good Seed Data

- Keep it simple and representative
- Use meaningful names and values
- Follow the same order as table creation (dependencies first)
- Add comments explaining what the data represents:

```sql
-- Sample Categories for testing
INSERT INTO Categories (Name) VALUES ('Electronics');
INSERT INTO Categories (Name) VALUES ('Books');

-- Sample Products
INSERT INTO Products (Name, Description, Price, CategoryId)
VALUES ('Laptop', 'High-performance computer', 999.99, 1);
```

## Querying the Database

### Using SQL Server Tools in Docker

Access the SQL Server container:

```bash
docker exec -it mssql bash
```

Then use `sqlcmd`:

```sql
sqlcmd -S localhost -U sa -P YourPassword

SELECT * FROM Categories;
SELECT * FROM Products WHERE Price > 100;
SELECT COUNT(*) FROM Products;
```

### Common Query Patterns

**Get all rows:**
```sql
SELECT * FROM Products;
```

**Get specific columns:**
```sql
SELECT Id, Name, Price FROM Products;
```

**Filter with WHERE:**
```sql
SELECT * FROM Products WHERE CategoryId = 1;
SELECT * FROM Products WHERE Price > 50;
SELECT * FROM Products WHERE Name LIKE 'Laptop%';
```

**Count rows:**
```sql
SELECT COUNT(*) FROM Products;
```

**Join related tables:**
```sql
SELECT p.Name, c.Name AS CategoryName
FROM Products p
JOIN Categories c ON p.CategoryId = c.Id;
```

**Order results:**
```sql
SELECT * FROM Products ORDER BY Price DESC;
```

## Troubleshooting

**Q: The database is empty after seeding**
- Run `make migrate` first to apply schema
- Then run `make seed` to insert data
- Check `seed.sql` has correct table names and columns

**Q: I'm getting "foreign key constraint" error**
- Ensure the referenced table exists
- Ensure the referenced ID actually exists in the parent table

**Q: How do I clear the database and start over?**
- `make db-drop` - removes the database
- `make db-start` - creates a fresh database
- `make run-ddl-pipeline` - regenerates schema
- `make seed` - inserts sample data

---

# App Configuration & YAML

This guide covers understanding and editing the `app.yaml` configuration file.

## Overview

`app.yaml` is the **central configuration file** that defines:
- Application metadata (name, title, description)
- Theme colors (primary, secondary, background)
- Data model entity definitions (all your tables and fields)

It is **automatically generated** from `schema.sql` by the DDL pipeline. **Do not edit it manually** - always regenerate it from your SQL schema.

## File Location

`app.yaml` - in the project root

## Structure

```yaml
app:
  name: ImportedApp
  title: Imported Application
  description: Generated from DDL file
  logoUrl: /images/logo.png

theme:
  primaryColor: '#007bff'
  secondaryColor: '#6c757d'
  backgroundColor: '#ffffff'
  textColor: '#212529'

dataModel:
  entities:
  - name: Category
    properties:
    - name: Id
      type: int
      isPrimaryKey: true
      isIdentity: true
      isRequired: false
    - name: Name
      type: string
      isPrimaryKey: false
      isIdentity: false
      maxLength: 50
      isRequired: true
    relationships: []
```

## Understanding Each Section

### `app` - Application Metadata

```yaml
app:
  name: ImportedApp           # Internal identifier (used in code)
  title: Imported Application # Display name for users
  description: ...            # What your app does
  logoUrl: /images/logo.png   # Logo path (relative to wwwroot)
```

### `theme` - UI Colors

```yaml
theme:
  primaryColor: '#007bff'     # Main button/link color (blue)
  secondaryColor: '#6c757d'   # Muted elements (gray)
  backgroundColor: '#ffffff'  # Page background (white)
  textColor: '#212529'        # Text color (dark)
```

These use standard hex color codes. Tools like [color-hex.com](https://www.color-hex.com) help you find colors.

### `dataModel.entities` - Your Tables

Each entity represents a database table:

```yaml
entities:
- name: Category              # Table name (will be Category in code, Categories in DB)
  properties:
  - name: Id                  # Column name
    type: int                 # C# type
    isPrimaryKey: true        # Is this the unique identifier?
    isIdentity: true          # Auto-increment?
    isRequired: false         # NOT NULL in SQL?
    maxLength: null           # Max length (for strings)
  relationships: []           # Foreign key relationships
```

### Property Types

| YAML type | C# Type | SQL Type |
|-----------|---------|----------|
| `int` | `int` | `INT` |
| `long` | `long` | `BIGINT` |
| `decimal` | `decimal` | `DECIMAL` |
| `string` | `string` | `NVARCHAR` |
| `DateTime` | `DateTime` | `DATETIME2` |
| `bool` | `bool` | `BIT` |

### Relationships (Foreign Keys)

```yaml
- name: Product
  properties: [...]
  relationships:
  - name: Category
    foreignKeyProperty: CategoryId
    principalEntityName: Category
```

This tells the system: "Product has a CategoryId that references Category"

## How It's Used

1. **Startup** - Application loads `app.yaml` and caches it in `AppDictionaryService`
2. **UI Navigation** - `NavMenu.razor` reads entity names to build navigation
3. **Data Grid** - `DynamicDataGrid.razor` reads property definitions to display columns
4. **API** - `EntitiesController` reads entity metadata to route requests
5. **Code Generation** - `ModelGenerator` reads this file to create C# entity classes

## Regenerating After Schema Changes

Never edit `app.yaml` manually. Instead:

1. Edit your `schema.sql`
2. Run `make run-ddl-pipeline`
3. The new `app.yaml` is generated automatically

## What Can Actually Be Customized

While `app.yaml` is auto-generated, you can modify these parts:

```yaml
app:
  title: My Custom Title      # Change the display name
  description: My Description # Change the description
  logoUrl: /images/custom.png # Point to your own logo

theme:
  primaryColor: '#FF5733'     # Change colors
  secondaryColor: '#33FF57'
```

For other changes (adding entities, columns, types), edit `schema.sql` instead.

## Troubleshooting

**Q: My schema changes aren't in app.yaml**
- Run `make run-ddl-pipeline` to regenerate

**Q: I accidentally edited app.yaml**
- Don't worry, run `make run-ddl-pipeline` to restore it from schema.sql

**Q: How do I add a new entity?**
- Add a `CREATE TABLE` statement to `schema.sql`
- Run `make run-ddl-pipeline`
- The entity will automatically appear in app.yaml, navigation, and API

---

# .NET/C# Data Layer

This guide covers Entity Framework Core, entity models, and the database access layer.

## Overview

The data layer uses **Entity Framework Core** with a dynamic model discovery system:

1. **YAML defines data structure** (`app.yaml` from SQL DDL)
2. **ModelGenerator creates C# entities** from `app.yaml`
3. **AppDbContext discovers entities via reflection**
4. **EF Core handles migrations and queries**

## File Locations

| File | Purpose |
|------|---------|
| `DotNetWebApp.Models/Generated/` | Auto-generated entity classes (Product.cs, Category.cs, etc.) |
| `Data/AppDbContext.cs` | EF Core DbContext with dynamic entity discovery |
| `Migrations/` | EF Core migrations (generated, not committed in detail) |

## Generated Entity Models

Entity classes are auto-generated from `app.yaml` by ModelGenerator:

```csharp
// Example: Generated Product.cs
public class Product
{
    public int Id { get; set; }  // IDENTITY PRIMARY KEY
    public string Name { get; set; }  // NOT NULL
    public string? Description { get; set; }  // NULL (nullable string)
    public decimal? Price { get; set; }  // NULL (nullable decimal)
    public int? CategoryId { get; set; }  // Foreign Key
}
```

**Key Characteristics:**
- `Id` is always auto-increment (IDENTITY)
- Required fields are non-nullable
- Optional fields use nullable types (`string?`, `decimal?`, `int?`)
- Foreign keys as simple scalar properties

## AppDbContext

**Location:** `Data/AppDbContext.cs`

The context uses **reflection-based entity discovery**:

```csharp
// Find all types in DotNetWebApp.Models.Generated
var generatedTypes = assembly
    .GetTypes()
    .Where(t => t.Namespace == "DotNetWebApp.Models.Generated");

foreach (var type in generatedTypes)
{
    modelBuilder.Entity(type).ToTable(ToPlural(type.Name));
}
```

**Dynamic Pluralization:**
- `Product` → `Products`
- `Category` → `Categories`
- `Company` → `Companies`

**Multi-tenant Support:**
- `X-Customer-Schema` HTTP header switches schemas
- Default schema: `dbo`
- Context uses `ITenantSchemaAccessor` to apply schema to all queries

## Regenerating After Schema Changes

```bash
# Update schema.sql, then:
make run-ddl-pipeline

# This:
# 1. Runs DdlParser on schema.sql
# 2. Generates app.yaml
# 3. Runs ModelGenerator
# 4. Creates/updates entity classes
# 5. Runs dotnet build

# Apply to database:
make migrate
```

## Working with Entities in Code

**Query with Entity Framework:**

```csharp
@inject AppDbContext DbContext

@code {
    private List<Product> products = new();

    protected override async Task OnInitializedAsync()
    {
        // Get all
        products = await DbContext.Set<Product>().ToListAsync();

        // Filter
        var expensive = await DbContext.Set<Product>()
            .Where(p => p.Price > 100)
            .ToListAsync();

        // Include relationships
        var withCategories = await DbContext.Set<Product>()
            .Include(p => p.Category)
            .ToListAsync();
    }
}
```

**Async Operations Are Required:**
- Always use `ToListAsync()`, `FirstOrDefaultAsync()`, `CountAsync()`
- Never use `.Result` or `.Wait()`
- Always `await`

## Troubleshooting

**Q: New entities don't appear in DbContext**
- Run `make run-ddl-pipeline` to regenerate
- Run `make build` to recompile
- Restart the application

**Q: "Unknown entity type" error**
- Ensure the entity exists in `DotNetWebApp.Models/Generated/`
- Check the type name matches your entity
- Run `make build` to ensure type discovery works

**Q: Foreign key navigation properties don't work**
- EF requires explicit `.Include()` to load related data
- E.g., `await DbContext.Products.Include(p => p.Category).ToListAsync()`
- Or use the scalar FK property directly

---

# SQL Views & Complex Queries (Phase 2)

This guide covers **SQL-first view pipeline** for complex read operations using Dapper. Use this for multi-table JOINs, aggregations, reports, and dashboards where EF Core queries would be inefficient or overly complex.

## Overview

Phase 2 introduces a **hybrid data access architecture**:

- **EF Core** for all write operations (CREATE, UPDATE, DELETE) on entities
- **Dapper** for complex read operations from SQL views (multi-table JOINs, aggregations)
- **SQL-first philosophy:** Write SQL queries, generate C# view models automatically

### Why SQL Views?

| Scenario | Use EF Core | Use SQL Views (Dapper) |
|----------|-------------|------------------------|
| Single entity CRUD | ✅ Yes | ❌ No |
| Simple queries (1-2 tables) | ✅ Yes | ❌ No |
| Multi-table JOINs (3+ tables) | ⚠️ Complex | ✅ Yes |
| Aggregations (SUM, AVG, GROUP BY) | ⚠️ Complex | ✅ Yes |
| Reports & dashboards | ❌ No | ✅ Yes |
| Legacy SQL queries | ❌ No | ✅ Yes |

### The View Pipeline

```
SQL View File (sql/views/ProductSalesView.sql)
    ↓ (manual: write your SELECT query)
views.yaml (define view metadata)
    ↓ (run: make run-view-pipeline)
ViewModels/ProductSalesView.generated.cs (auto-generated C# DTO)
    ↓ (inject in Blazor component)
IViewService.ExecuteViewAsync<ProductSalesView>()
    ↓ (Dapper executes SQL, maps to C# objects)
IEnumerable<ProductSalesView> results
```

## File Locations

| File | Purpose |
|------|---------|
| `sql/views/*.sql` | 📝 Your SQL SELECT queries - this is what you write |
| `views.yaml` | 📝 View definitions with metadata - you edit this |
| `DotNetWebApp.Models/ViewModels/*.generated.cs` | 🔄 Auto-generated C# view model classes - never edit manually |
| `Services/Views/` | 🔧 IViewService, ViewRegistry, DapperQueryService implementations |

## Creating SQL Views

### Step 1: Write the SQL Query

Create a new file in `sql/views/` with your SELECT query:

**File:** `sql/views/ProductSalesView.sql`

```sql
-- ProductSalesView: Product sales summary with category and order totals
-- Parameters: @TopN (int) - Number of top products to return

SELECT TOP (@TopN)
    p.Id,
    p.Name,
    p.Price,
    c.Name AS CategoryName,
    COUNT(od.Id) AS TotalSold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Products p
LEFT JOIN Categories c ON p.CategoryId = c.Id
LEFT JOIN OrderDetails od ON p.Id = od.ProductId
GROUP BY p.Id, p.Name, p.Price, c.Name
ORDER BY TotalRevenue DESC
```

**Key Points:**
- Use `@ParameterName` for parameters (will be mapped to C# parameters)
- Use column aliases (`AS CategoryName`) for clarity
- Aggregate functions (COUNT, SUM) are fully supported
- Multi-table JOINs work as expected

### Step 2: Define the View in views.yaml

**File:** `views.yaml` (project root)

```yaml
views:
  - name: ProductSalesView
    description: "Product sales summary with category and order totals"
    sql_file: "sql/views/ProductSalesView.sql"
    generate_partial: true

    # Parameters passed to SQL query
    parameters:
      - name: TopN
        type: int
        nullable: false
        default: "10"
        validation:
          required: true
          range: [1, 1000]

    # Properties returned from SQL (must match column names)
    properties:
      - name: Id
        type: int
        nullable: false
      - name: Name
        type: string
        nullable: false
        max_length: 100
      - name: Price
        type: decimal
        nullable: false
      - name: CategoryName
        type: string
        nullable: true
        max_length: 100
      - name: TotalSold
        type: int
        nullable: false
      - name: TotalRevenue
        type: decimal
        nullable: false
```

**Important:** Property names must match SQL column names exactly (case-sensitive).

### Step 3: Generate View Models

Run the view pipeline to generate C# view model classes:

```bash
make run-view-pipeline
```

This creates: `DotNetWebApp.Models/ViewModels/ProductSalesView.generated.cs`

**Generated output:**
```csharp
// Auto-generated - DO NOT EDIT
// Generated: 2026-01-27

using System;
using System.ComponentModel.DataAnnotations;

namespace DotNetWebApp.Models.ViewModels
{
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
}
```

### Step 4: (Optional) Extend with Partial Class

You can add custom properties/methods without modifying generated code:

**File:** `DotNetWebApp.Models/ViewModels/ProductSalesView.cs` (create manually)

```csharp
namespace DotNetWebApp.Models.ViewModels
{
    public partial class ProductSalesView
    {
        // Custom computed property for UI display
        public string FormattedRevenue => TotalRevenue.ToString("C");

        // Business logic
        public bool IsHighValue => TotalRevenue > 10000;

        // Validation helpers
        public bool HasSales => TotalSold > 0;
    }
}
```

This file is **never overwritten** by the pipeline.

## Using IViewService in Components

### Basic Example - Read-Only Grid

**File:** `Components/Pages/ProductDashboard.razor`

```razor
@page "/dashboard/products"
@inject IViewService ViewService
@inject ILogger<ProductDashboard> Logger

<PageTitle>Product Sales Dashboard</PageTitle>

<h3>Top Selling Products</h3>

@if (isLoading)
{
    <p><em>Loading...</em></p>
}
else if (!string.IsNullOrWhiteSpace(errorMessage))
{
    <div class="alert alert-danger">
        <strong>Error:</strong> @errorMessage
    </div>
}
else if (products != null && products.Any())
{
    <RadzenDataGrid Data="@products"
                    TItem="ProductSalesView"
                    AllowFiltering="true"
                    AllowSorting="true"
                    AllowPaging="true"
                    PageSize="20">
        <Columns>
            <RadzenDataGridColumn TItem="ProductSalesView"
                                 Property="Name"
                                 Title="Product Name" />

            <RadzenDataGridColumn TItem="ProductSalesView"
                                 Property="CategoryName"
                                 Title="Category" />

            <RadzenDataGridColumn TItem="ProductSalesView"
                                 Property="Price"
                                 Title="Price"
                                 FormatString="{0:C}" />

            <RadzenDataGridColumn TItem="ProductSalesView"
                                 Property="TotalSold"
                                 Title="Units Sold"
                                 FormatString="{0:N0}" />

            <RadzenDataGridColumn TItem="ProductSalesView"
                                 Property="TotalRevenue"
                                 Title="Total Revenue"
                                 FormatString="{0:C}" />
        </Columns>
    </RadzenDataGrid>
}

@code {
    private IEnumerable<ProductSalesView>? products;
    private bool isLoading = true;
    private string? errorMessage;

    protected override async Task OnInitializedAsync()
    {
        try
        {
            await LoadDataAsync();
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Failed to initialize component");
            errorMessage = "Failed to load component.";
        }
    }

    private async Task LoadDataAsync()
    {
        isLoading = true;
        errorMessage = null;

        try
        {
            Logger.LogInformation("Loading product sales data");

            // Execute view with parameters
            products = await ViewService.ExecuteViewAsync<ProductSalesView>(
                "ProductSalesView",
                new { TopN = 50 }
            );

            Logger.LogInformation("Loaded {Count} products", products?.Count() ?? 0);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Error loading data");
            errorMessage = $"Error: {ex.Message}";
        }
        finally
        {
            isLoading = false;
        }
    }
}
```

### With User Input Parameters

Add filter controls that pass parameters to the view:

```razor
@code {
    private int topN = 50;
    private string? searchTerm;

    private async Task OnApplyFilters()
    {
        products = await ViewService.ExecuteViewAsync<ProductSalesView>(
            "ProductSalesView",
            new {
                TopN = topN,
                SearchTerm = searchTerm ?? ""
            }
        );
    }
}

<!-- Add filter UI -->
<div class="filters">
    <RadzenNumeric @bind-Value="topN" Min="1" Max="1000" />
    <RadzenTextBox @bind-Value="searchTerm" Placeholder="Search..." />
    <RadzenButton Text="Apply Filters" Click="@OnApplyFilters" />
</div>
```

### Using the ViewSection Generic Component

For most view display scenarios, use the **reusable `ViewSection.razor` component** instead of building custom components. ViewSection handles:
- Automatic parameter binding
- Dynamic column discovery from view results
- Filtering, sorting, and paging
- Error handling and loading states
- Type-safe view model handling

**File:** `Components/Sections/ViewSection.razor` (built-in component)

```razor
<!-- Parent page that uses ViewSection -->
@page "/dashboard"

<ViewSection AppName="MyApp" ViewName="ProductSalesView" />
```

**What ViewSection provides automatically:**
- ✅ Parameter input fields for all view parameters
- ✅ Execute button to run the query
- ✅ Responsive data grid with filtering & sorting
- ✅ Paging support (20 rows per page)
- ✅ Dynamic column discovery (no need to define columns)
- ✅ Error alerts and loading indicators
- ✅ Row count display

**When to use ViewSection:**
- Displaying any SQL view with standard grid/parameter UI
- Dashboards and reports
- Data exploration tools

**When to use custom components:**
- Complex layouts (multi-section dashboards)
- Custom visualizations (charts, maps)
- Special interactions (tree views, nested data)

### Loading Single Record

Use `ExecuteViewSingleAsync` when expecting exactly one result:

```razor
@code {
    private ProductSalesView? product;

    protected override async Task OnInitializedAsync()
    {
        product = await ViewService.ExecuteViewSingleAsync<ProductSalesView>(
            "ProductSalesView",
            new { TopN = 1 }
        );

        if (product == null)
        {
            errorMessage = "Product not found.";
        }
    }
}
```

## IViewService API Reference

### ExecuteViewAsync<T>

Executes a view and returns multiple results:

```csharp
Task<IEnumerable<T>> ExecuteViewAsync<T>(
    string viewName,
    object? parameters = null
)
```

**Parameters:**
- `viewName` - Name of view from `views.yaml` (case-insensitive)
- `parameters` - Anonymous object with properties matching SQL parameter names

**Returns:** `IEnumerable<T>` (empty if no results)

**Example:**
```csharp
var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    new { TopN = 100, CategoryId = 5 }
);
```

### ExecuteViewSingleAsync<T>

Executes a view and returns a single result or null:

```csharp
Task<T?> ExecuteViewSingleAsync<T>(
    string viewName,
    object? parameters = null
)
```

**Returns:** Single result or `null` if no results

**Example:**
```csharp
var product = await ViewService.ExecuteViewSingleAsync<ProductSalesView>(
    "ProductSalesView",
    new { TopN = 1 }
);
```

## views.yaml Schema Reference

### Complete Example

```yaml
views:
  - name: ViewName                    # C# class name (PascalCase)
    description: "Human-readable description"
    sql_file: "sql/views/ViewName.sql"   # Relative to views.yaml
    generate_partial: true            # Generate partial class (optional)

    parameters:                       # Optional SQL parameters
      - name: ParameterName
        type: int|string|decimal|bool|DateTime
        nullable: true|false
        default: "10"                 # Default value as string
        validation:                   # Optional validation rules
          required: true
          range: [1, 1000]            # For numeric types
          max_length: 100             # For string types

    properties:                       # Must match SQL column names
      - name: PropertyName
        type: int|string|decimal|bool|DateTime
        nullable: true|false
        max_length: 100               # For string types (optional)
```

### Supported Types

| YAML Type | C# Type | SQL Type |
|-----------|---------|----------|
| `int` | `int` | `INT` |
| `long` | `long` | `BIGINT` |
| `decimal` | `decimal` | `DECIMAL`, `NUMERIC`, `MONEY` |
| `string` | `string` | `NVARCHAR`, `VARCHAR`, `CHAR` |
| `bool` | `bool` | `BIT` |
| `DateTime` | `DateTime` | `DATETIME2`, `DATETIME`, `DATE` |

**Nullable types:** Set `nullable: true` to generate `int?`, `decimal?`, etc.

## Multi-Tenant Support

SQL views automatically inherit the current tenant's schema via shared EF Core connection:

```sql
-- Your SQL view references tables without schema prefix
SELECT p.Id, p.Name
FROM Products p
LEFT JOIN Categories c ON p.CategoryId = c.Id
```

The `X-Customer-Schema` header is automatically applied:
- Request with `X-Customer-Schema: acme` queries `acme.Products`
- Request with `X-Customer-Schema: initech` queries `initech.Products`

**No code changes needed** - multi-tenancy is handled by `DapperQueryService`.

## Common Patterns

### Pattern: Dashboard with Multiple Views

Load multiple views in parallel:

```csharp
protected override async Task OnInitializedAsync()
{
    var tasksales = ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView", new { TopN = 10 });

    var taskCustomers = ViewService.ExecuteViewAsync<CustomerSummaryView>(
        "CustomerSummaryView", null);

    var taskRevenue = ViewService.ExecuteViewSingleAsync<RevenueSummaryView>(
        "RevenueSummaryView", null);

    await Task.WhenAll(taskSales, taskCustomers, taskRevenue);

    products = taskSales.Result;
    customers = taskCustomers.Result;
    revenue = taskRevenue.Result;
}
```

### Pattern: Auto-Refresh Dashboard

Refresh data on a timer:

```csharp
private System.Threading.Timer? refreshTimer;

protected override void OnInitialized()
{
    refreshTimer = new Timer(async _ => {
        await InvokeAsync(async () => {
            await LoadDataAsync();
            StateHasChanged();
        });
    }, null, TimeSpan.FromSeconds(5), TimeSpan.FromSeconds(5));
}

public void Dispose()
{
    refreshTimer?.Dispose();
}
```

### Pattern: Export to CSV

Use view results for reporting:

```csharp
private async Task ExportToCsv()
{
    var data = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView", new { TopN = 1000 });

    var csv = new StringBuilder();
    csv.AppendLine("Name,Category,Price,Total Sold,Total Revenue");

    foreach (var row in data)
    {
        csv.AppendLine($"{row.Name},{row.CategoryName},{row.Price},{row.TotalSold},{row.TotalRevenue}");
    }

    // Trigger browser download
    await JSRuntime.InvokeVoidAsync("downloadFile",
        "products.csv",
        csv.ToString());
}
```

## Architecture: Services Overview

Phase 2 consists of three service layers:

### IViewRegistry (Singleton)

Loads `views.yaml` once at startup, caches SQL file contents:

```csharp
public interface IViewRegistry
{
    Task<string> GetViewSqlAsync(string viewName);
    ViewDefinition GetViewDefinition(string viewName);
    IEnumerable<string> GetAllViewNames();
}
```

**Registered in Program.cs:**
```csharp
var viewRegistry = new ViewRegistry(
    Path.Combine(builder.Environment.ContentRootPath, "views.yaml"),
    loggerFactory.CreateLogger<ViewRegistry>()
);
builder.Services.AddSingleton<IViewRegistry>(viewRegistry);
```

### IDapperQueryService (Scoped)

Executes SQL queries via Dapper, shares EF Core connection for multi-tenancy:

```csharp
public interface IDapperQueryService
{
    Task<IEnumerable<T>> QueryAsync<T>(string sql, object? parameters = null);
    Task<T?> QuerySingleAsync<T>(string sql, object? parameters = null);
}
```

**Uses shared connection:**
```csharp
var connection = _dbContext.Database.GetDbConnection();
return await connection.QueryAsync<T>(sql, parameters);
```

### IViewService (Scoped)

Orchestrates ViewRegistry + DapperQueryService:

```csharp
public interface IViewService
{
    Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null);
    Task<T?> ExecuteViewSingleAsync<T>(string viewName, object? parameters = null);
}
```

**Workflow:**
1. Get SQL from `ViewRegistry.GetViewSqlAsync()`
2. Execute SQL via `DapperQueryService.QueryAsync<T>()`
3. Return results

## Troubleshooting

**Q: "View 'ViewName' not found in registry"**
- Check `views.yaml` has an entry with matching `name:` field
- View names are case-insensitive but must match exactly
- Restart the application to reload `views.yaml`

**Q: "SQL file not found"**
- Verify `sql_file:` path in `views.yaml` is correct
- Paths are relative to `views.yaml` location (project root)
- Check file exists: `ls sql/views/YourView.sql`

**Q: "Property 'X' does not exist on type 'Y'"**
- SQL column names must match `properties:` in `views.yaml` exactly (case-sensitive)
- Use column aliases in SQL: `SELECT c.Name AS CategoryName`
- Regenerate view models: `make run-view-pipeline`

**Q: "Type mismatch" or casting errors**
- Ensure `type:` in `views.yaml` matches SQL column type
- Check nullable settings match (`nullable: true` for `NULL` columns)
- SQL `INT` → `int`, `BIGINT` → `long`, `NVARCHAR` → `string`, etc.

**Q: Changes to SQL view don't reflect**
- Restart the application (SQL is cached by `ViewRegistry`)
- Or implement hot-reload by clearing the SQL cache

**Q: Parameters not working**
- Parameter names must match `@ParameterName` in SQL exactly (case-sensitive)
- Pass parameters as anonymous object: `new { ParameterName = value }`
- Dapper parameter matching is case-insensitive but consistent naming helps

**Q: Multi-tenant queries returning wrong data**
- Verify `X-Customer-Schema` header is set correctly
- Check `DapperQueryService` is using shared EF connection
- Test schema isolation with different header values

## Important Notes

- **Views are read-only:** Use `IEntityOperationService` for write operations (EF Core)
- **SQL is cached:** Restart application to reload SQL changes
- **Type safety:** View models are strongly typed with IntelliSense support
- **Performance:** Dapper is ~2x faster than EF for complex queries
- **No migrations:** SQL views don't create database views (just queries)
- **Partial classes:** Extend generated classes without modifying generated code
- **Multi-tenant:** Schema inheritance is automatic via shared connection

## Running the View Pipeline

```bash
# Generate view models from views.yaml
make run-view-pipeline

# Generate both entities (from schema.sql) and views (from views.yaml)
make run-all-pipelines

# Check generated files
ls DotNetWebApp.Models/ViewModels/
```

---

# .NET/C# API & Services

This guide covers the REST API, EntitiesController, and service layer.

## REST API Overview

The application provides a **dynamic CRUD API** for all entities via `EntitiesController`.

**Base URL:** `/api/entities/{entityName}`

Endpoints use **singular entity names**:
- `/api/entities/product` (not `/api/entities/products`)
- `/api/entities/category`
- `/api/entities/company`

Entity names are **case-insensitive** via `IEntityMetadataService` lookup.

## Available Endpoints

All endpoints support all entities dynamically:

### Get All Entities

```
GET /api/entities/{entityName}
```

**Example:**
```bash
curl https://localhost:5001/api/entities/product
```

**Response:** 200 OK with array of JSON objects
```json
[
  { "id": 1, "name": "Laptop", "price": 999.99, "categoryId": 1 },
  { "id": 2, "name": "Mouse", "price": 29.99, "categoryId": 1 }
]
```

### Get Entity Count

```
GET /api/entities/{entityName}/count
```

**Example:**
```bash
curl https://localhost:5001/api/entities/product/count
```

**Response:** 200 OK with count
```json
{ "count": 42 }
```

### Get Single Entity by ID

```
GET /api/entities/{entityName}/{id}
```

**Example:**
```bash
curl https://localhost:5001/api/entities/product/1
```

**Response:** 200 OK or 404 Not Found

### Create Entity

```
POST /api/entities/{entityName}
Content-Type: application/json

{...entity fields...}
```

**Example:**
```bash
curl -X POST https://localhost:5001/api/entities/product \
  -H "Content-Type: application/json" \
  -d '{"name":"Keyboard","price":79.99,"categoryId":1}'
```

**Response:** 201 Created with created entity in body

### Update Entity

```
PUT /api/entities/{entityName}/{id}
Content-Type: application/json

{...entity fields...}
```

**Example:**
```bash
curl -X PUT https://localhost:5001/api/entities/product/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"Gaming Laptop","price":1299.99,"categoryId":1}'
```

**Response:** 200 OK or 404 Not Found

### Delete Entity

```
DELETE /api/entities/{entityName}/{id}
```

**Example:**
```bash
curl -X DELETE https://localhost:5001/api/entities/product/1
```

**Response:** 204 No Content or 404 Not Found

## Key Services

**Location:** `Services/`

### IEntityApiService

Used by Blazor components to call the API:

```csharp
@inject IEntityApiService EntityApi

@code {
    private List<Product> products = new();

    protected override async Task OnInitializedAsync()
    {
        products = (await EntityApi.GetEntitiesAsync("product"))
            .Cast<Product>()
            .ToList();
    }

    private async Task CreateItem(Product p)
    {
        var created = await EntityApi.CreateEntityAsync("product", p);
    }

    private async Task DeleteItem(int id)
    {
        await EntityApi.DeleteEntityAsync("product", id.ToString());
    }
}
```

### IEntityMetadataService

Maps entity names to CLR types and provides metadata:

```csharp
@inject IEntityMetadataService EntityMetadata

@code {
    protected override void OnInitialized()
    {
        // Get all entities
        var entities = EntityMetadata.Entities;

        // Find by name
        var product = EntityMetadata.Find("product");
        if (product != null)
        {
            var type = product.Type;  // System.Type
            var properties = product.Properties;  // IReadOnlyList<PropertyMetadata>
        }
    }
}
```

### IAppDictionaryService

Loads and caches `app.yaml` entity definitions:

```csharp
@inject IAppDictionaryService AppDict

@code {
    protected override void OnInitialized()
    {
        var def = AppDict.AppDefinition;
        foreach (var entity in def.DataModel.Entities)
        {
            Console.WriteLine($"Entity: {entity.Name}");
            foreach (var prop in entity.Properties)
            {
                Console.WriteLine($"  - {prop.Name}: {prop.Type}");
            }
        }
    }
}
```

### ISpaSectionService

Manages SPA routing and section navigation:

```csharp
@inject ISpaSectionService SpaSections

@code {
    protected override void OnInitialized()
    {
        // Get all available sections (Dashboard, Settings, all entities)
        var sections = SpaSections.Sections;

        // Navigate to section
        var productSection = SpaSections.FromRouteSegment("product");
        if (productSection != null)
        {
            SpaSections.NavigateTo(productSection);
        }
    }
}
```

### IDashboardService

Fetches summary metrics for dashboard:

```csharp
@inject IDashboardService Dashboard

@code {
    private DashboardSummary? summary;

    protected override async Task OnInitializedAsync()
    {
        summary = await Dashboard.GetSummaryAsync();
        // summary.EntityCounts - IReadOnlyDictionary<string, int>
    }
}
```

## EntitiesController Implementation

**Location:** `Controllers/EntitiesController.cs`

The controller uses reflection to execute EF Core operations dynamically:

**Key Methods:**
- `GetAll(string entityName)` - DbSet query via reflection
- `GetCount(string entityName)` - COUNT query
- `GetById(string entityName, string id)` - FindAsync with type conversion
- `Create(string entityName, JsonElement data)` - Activator.CreateInstance + SaveChanges
- `Update(string entityName, string id, JsonElement data)` - Reflection property assignment
- `Delete(string entityName, string id)` - FindAsync + Remove + SaveChanges

**Important Notes:**
- Primary key type detection handles: `int`, `long`, `Guid`, `string`
- JSON deserialization to entity properties uses reflection
- All operations are async (uses Task/Task<T>)
- Errors return 400 Bad Request or 404 Not Found

## Troubleshooting

**Q: API returns 404 for my entity**
- Check entity name casing (case-insensitive, but must be valid)
- Verify entity exists in `app.yaml` and was generated
- Run `make run-ddl-pipeline` if you added new entities

**Q: "Unknown entity" error on Create/Update**
- Entity metadata not synced - run `make run-ddl-pipeline`
- Check JSON payload matches entity fields
- Verify non-nullable fields are provided

**Q: API changes take time to appear**
- Entity metadata is cached in `IAppDictionaryService`
- Restart application to refresh cache
- Or: Force regeneration with `make run-ddl-pipeline`

---

# Front-End Skills Guide (Blazor/Radzen)

This guide helps with front-end changes to Razor/Blazor components and JavaScript interop. Read this BEFORE making front-end changes.

---

## File Locations

| What | Where |
|------|-------|
| SPA main container | `Components/Pages/SpaApp.razor` (`/app` route) |
| Entity CRUD page | `Components/Pages/GenericEntityPage.razor` (`/{EntityName}` route) |
| Home page | `Components/Pages/Home.razor` (`/` route) |
| Dashboard section | `Components/Sections/DashboardSection.razor` |
| Entity section | `Components/Sections/EntitySection.razor` |
| Settings section | `Components/Sections/SettingsSection.razor` |
| Section header | `Components/Sections/SectionHeader.razor` (reusable) |
| Dynamic data grid | `Shared/DynamicDataGrid.razor` (renders columns from YAML) |
| Main layout | `Shared/MainLayout.razor` (RadzenLayout wrapper with branding) |
| Navigation menu | `Shared/NavMenu.razor` (RadzenPanelMenu) |
| Global imports | `_Imports.razor` |
| Custom CSS | `wwwroot/css/app.css` |
| HTML host | `Pages/_Layout.cshtml` (scripts/CSS), `Pages/_Host.cshtml` |

**No custom JavaScript files exist.** JS is only used via `IJSRuntime` interop.

---

## Radzen Components (v7.1.0)

Radzen is already configured. The `<RadzenComponents />` tag in `Shared/MainLayout.razor` enables all Radzen features.

### RadzenButton

```razor
<RadzenButton Text="Save"
              Icon="save"
              ButtonStyle="ButtonStyle.Primary"
              Click="@OnSave" />

<RadzenButton Text="@(isLoading ? "Loading..." : "Refresh")"
              Icon="refresh"
              IsBusy="@isLoading"
              Click="@OnRefresh" />
```

**Button styles:** `Primary`, `Secondary`, `Success`, `Danger`, `Warning`, `Info`, `Light`, `Dark`

**Common icons:** `add`, `edit`, `delete`, `save`, `refresh`, `close`, `check`, `search`

### RadzenDataGrid

```razor
<RadzenDataGrid Data="@items"
                TItem="MyModel"
                AllowFiltering="true"
                AllowSorting="true"
                AllowPaging="true"
                PageSize="10"
                AllowColumnResize="true"
                ShowPagingSummary="true">
    <Columns>
        <RadzenDataGridColumn TItem="MyModel" Property="Id" Title="ID" Width="80px" />
        <RadzenDataGridColumn TItem="MyModel" Property="Name" Title="Name" />
        <RadzenDataGridColumn TItem="MyModel" Property="Price" Title="Price" FormatString="{0:C}" />
        <RadzenDataGridColumn TItem="MyModel" Title="Actions" Width="120px">
            <Template Context="item">
                <RadzenButton Icon="edit" ButtonStyle="ButtonStyle.Light" Click="@(() => Edit(item))" />
                <RadzenButton Icon="delete" ButtonStyle="ButtonStyle.Danger" Click="@(() => Delete(item))" />
            </Template>
        </RadzenDataGridColumn>
    </Columns>
</RadzenDataGrid>
```

**Key points:**
- `TItem` must match your data type
- `Property` binds to model property names (case-sensitive)
- Use `<Template Context="item">` for custom column content
- `FormatString` uses C# format strings (`{0:C}` = currency, `{0:N2}` = number)

### DynamicDataGrid (Project Component)

The project includes a dynamic data grid that renders columns from YAML definitions:

```razor
<DynamicDataGrid EntityName="Product" Entities="@products" />
```

**How it works:**
- Reads entity columns from `app.yaml` via `IEntityMetadataService`
- Dynamically instantiates generic `RadzenDataGrid<object>` for any entity
- Renders columns based on property definitions
- Handles filtering, sorting, and paging automatically

**When to use:**
- Generic CRUD pages for any entity
- Rendering entities fetched from the API
- Building custom admin interfaces

### RadzenProgressBar (Loading Indicator)

```razor
<RadzenProgressBar ProgressBarStyle="ProgressBarStyle.Primary"
                   Value="100"
                   ShowValue="false"
                   Mode="ProgressBarMode.Indeterminate" />
```

### RadzenDialog (Modal)

```razor
@inject DialogService DialogService

@code {
    private async Task ShowConfirmDialog()
    {
        var result = await DialogService.Confirm(
            "Are you sure?",
            "Confirm Delete",
            new ConfirmOptions { OkButtonText = "Yes", CancelButtonText = "No" });

        if (result == true)
        {
            // User confirmed
        }
    }

    private async Task ShowCustomDialog()
    {
        await DialogService.OpenAsync<MyDialogComponent>("Dialog Title",
            new Dictionary<string, object> { { "ItemId", 123 } },
            new DialogOptions { Width = "500px", Height = "400px" });
    }
}
```

**Note:** Register `DialogService` in `Program.cs` if not already done:
```csharp
builder.Services.AddScoped<DialogService>();
```

### RadzenTextBox, RadzenNumeric, RadzenDropDown (Form Inputs)

```razor
<RadzenTextBox @bind-Value="@name" Placeholder="Enter name" />

<RadzenNumeric @bind-Value="@price" Min="0" Step="0.01" />

<RadzenDropDown @bind-Value="@selectedCategory"
                Data="@categories"
                TextProperty="Name"
                ValueProperty="Id"
                Placeholder="Select category" />

<RadzenCheckBox @bind-Value="@isActive" />

<RadzenDatePicker @bind-Value="@selectedDate" DateFormat="yyyy-MM-dd" />
```

### RadzenNotification (Toast Messages)

```razor
@inject NotificationService NotificationService

@code {
    private void ShowSuccess()
    {
        NotificationService.Notify(NotificationSeverity.Success, "Success", "Item saved!");
    }

    private void ShowError(string message)
    {
        NotificationService.Notify(NotificationSeverity.Error, "Error", message);
    }
}
```

**Severities:** `Success`, `Error`, `Warning`, `Info`

**Note:** Add `<RadzenNotification />` to `MainLayout.razor` if not present.

---

## JavaScript Interop (IJSRuntime)

### Setup

Inject at top of `.razor` file:
```razor
@inject IJSRuntime JSRuntime
```

### Common Patterns

**Call JS function (no return):**
```csharp
await JSRuntime.InvokeVoidAsync("functionName", arg1, arg2);
```

**Call JS function (with return):**
```csharp
var result = await JSRuntime.InvokeAsync<string>("functionName", arg1);
```

**Browser APIs:**
```csharp
// Update URL without reload
await JSRuntime.InvokeVoidAsync("history.replaceState", null, "", "/app#section");

// Scroll to element
await JSRuntime.InvokeVoidAsync("document.getElementById('myId').scrollIntoView");

// Alert
await JSRuntime.InvokeVoidAsync("alert", "Hello!");

// Confirm
var confirmed = await JSRuntime.InvokeAsync<bool>("confirm", "Are you sure?");

// LocalStorage
await JSRuntime.InvokeVoidAsync("localStorage.setItem", "key", "value");
var value = await JSRuntime.InvokeAsync<string>("localStorage.getItem", "key");
```

### Adding Custom JavaScript

If you need custom JS functions:

1. Create file: `wwwroot/js/app.js`
2. Add to `Pages/_Layout.cshtml` before `</body>`:
   ```html
   <script src="js/app.js"></script>
   ```
3. Define functions on window object:
   ```javascript
   window.myFunction = function(param) {
       // do something
       return result;
   };
   ```
4. Call from Blazor:
   ```csharp
   var result = await JSRuntime.InvokeAsync<string>("myFunction", param);
   ```

---

## SPA Structure

The application includes an optional **Single Page Application** (SPA) at `/app` with dynamic routing and sections.

### SPA Pages

**SpaApp.razor** (`/app` and `/app/{section}`):
- Main SPA container
- Routes to Dashboard, Settings, Entity sections, or dynamic entities
- Handles loading state via `AsyncUiState`

**GenericEntityPage.razor** (`/{entityName}`):
- Standalone CRUD page for any entity
- Renders `DynamicDataGrid` and entity count
- Alternative to SPA sections (non-SPA alternative)

### SPA Sections

Sections are dynamically loaded components managed by `ISpaSectionService`:

**Built-in Sections:**
1. **Dashboard** - Metrics and entity counts (`DashboardSection.razor`)
2. **Settings** - Application configuration (`SettingsSection.razor`)
3. **Entity** - CRUD for each entity (one per entity in `app.yaml`, routed via `EntitySection.razor`)

**How Routing Works:**
```
/app                          → Dashboard (default)
/app/dashboard                → Dashboard
/app/settings                 → Settings
/app/product                  → Entity section for Product
/app/category                 → Entity section for Category
```

Entity names are matched case-insensitively and support dynamic routes even if not pre-configured.

### Section Components

**DashboardSection.razor:**
- Displays entity count cards (reads from `IEntityMetadataService`)
- Shows hardcoded metrics: Revenue, Active Users, Growth, Recent Activity
- Injects: `IDashboardService`, `IEntityMetadataService`

**EntitySection.razor:**
- CRUD interface for a single entity
- Parameters: `EntityName`
- Renders: `SectionHeader` + `DynamicDataGrid`
- Injects: `IEntityApiService`, `IEntityMetadataService`

**SettingsSection.razor:**
- Application settings form (stub implementation)
- Theme selector, notification toggles, export/cache buttons
- Injects: application configuration services

**SectionHeader.razor:**
- Reusable header component for any section
- Parameters: `Title`, `IsLoading`
- Shows loading spinner if busy

### Enabling the SPA

The SPA is optional and can be toggled in `appsettings.json`:

```json
{
  "AppCustomization": {
    "EnableSpaExample": true,
    "SpaSectionLabels": {
      "DashboardNav": "Dashboard",
      "SettingsNav": "Settings"
    }
  }
}
```

When disabled, `/app` is unavailable but `GenericEntityPage.razor` still works.

---

## Component Patterns

### Basic Component Structure

```razor
@* At top: route, injections *@
@page "/mypage"
@inject HttpClient Http
@inject NavigationManager Navigation

@* HTML/Razor markup *@
<div class="container">
    @if (isLoading)
    {
        <p>Loading...</p>
    }
    else
    {
        <h1>@title</h1>
    }
</div>

@* C# code block at bottom *@
@code {
    private bool isLoading = true;
    private string title = "My Page";

    protected override async Task OnInitializedAsync()
    {
        await LoadData();
    }

    private async Task LoadData()
    {
        isLoading = true;
        StateHasChanged();

        try
        {
            // load data
        }
        finally
        {
            isLoading = false;
            StateHasChanged();
        }
    }
}
```

### Component Parameters (Child Components)

```razor
@* In child component (MySection.razor) *@
<div>
    <p>Count: @Count</p>
    <button @onclick="HandleClick">Click</button>
</div>

@code {
    [Parameter]
    public int Count { get; set; }

    [Parameter]
    public List<Item> Items { get; set; } = new();

    [Parameter]
    public EventCallback OnRefresh { get; set; }

    [Parameter]
    public EventCallback<Item> OnItemSelected { get; set; }

    private async Task HandleClick()
    {
        await OnRefresh.InvokeAsync();
    }

    private async Task SelectItem(Item item)
    {
        await OnItemSelected.InvokeAsync(item);
    }
}
```

```razor
@* In parent component *@
<MySection Count="@totalCount"
           Items="@items"
           OnRefresh="@LoadData"
           OnItemSelected="@HandleSelection" />

@code {
    private int totalCount = 0;
    private List<Item> items = new();

    private async Task HandleSelection(Item item)
    {
        // handle selected item
    }
}
```

### API Calls with HttpClient

<!-- FIXME: Endpoints are now singular (e.g., api/product) and dynamic (api/{EntityName}); update the sample URLs. BaseAddress is already set via DI in Program.cs. -->
```csharp
@inject HttpClient Http

@code {
    protected override async Task OnInitializedAsync()
    {
        // Set base URL (do this once)
        Http.BaseAddress = new Uri(Navigation.BaseUri);
    }

    // GET list
    private async Task<List<Product>> GetProducts()
    {
        return await Http.GetFromJsonAsync<List<Product>>("api/products") ?? new();
    }

    // GET single
    private async Task<Product?> GetProduct(int id)
    {
        return await Http.GetFromJsonAsync<Product>($"api/products/{id}");
    }

    // POST create
    private async Task<Product?> CreateProduct(Product product)
    {
        var response = await Http.PostAsJsonAsync("api/products", product);
        if (response.IsSuccessStatusCode)
        {
            return await response.Content.ReadFromJsonAsync<Product>();
        }
        return null;
    }

    // PUT update
    private async Task<bool> UpdateProduct(int id, Product product)
    {
        var response = await Http.PutAsJsonAsync($"api/products/{id}", product);
        return response.IsSuccessStatusCode;
    }

    // DELETE
    private async Task<bool> DeleteProduct(int id)
    {
        var response = await Http.DeleteAsync($"api/products/{id}");
        return response.IsSuccessStatusCode;
    }
}
```

---

## State Management

### When to Call StateHasChanged()

Call `StateHasChanged()` when:
- Updating state inside `try/finally` blocks
- After async operations that modify displayed data
- After receiving events from JS interop

**Do NOT call** after:
- `@onclick` handlers (automatic)
- Parameter changes (automatic)
- `OnInitializedAsync` completion (automatic)

### Loading State Pattern

```csharp
private bool isLoading = false;
private string? errorMessage = null;

private async Task LoadData()
{
    isLoading = true;
    errorMessage = null;
    StateHasChanged();

    try
    {
        data = await Http.GetFromJsonAsync<List<Item>>("api/items") ?? new();
    }
    catch (Exception ex)
    {
        errorMessage = "Failed to load data";
        Console.WriteLine($"Error: {ex.Message}");
    }
    finally
    {
        isLoading = false;
        StateHasChanged();
    }
}
```

---

## Common Mistakes to Avoid

1. **Forgetting `TItem` on Radzen components** - DataGrid columns need `TItem="YourModel"`

2. **Case-sensitive Property names** - `Property="Name"` must match model exactly

3. **Missing `@` for C# expressions** - Use `@variable` not `variable` in markup

4. **Forgetting `async`/`await`** - Event handlers with async code need `async Task`

5. **Not setting HttpClient.BaseAddress** - Required before relative URL calls

6. **Blocking with `.Result`** - Never use `.Result` or `.Wait()`, always `await`

7. **Modifying parameters directly** - Use EventCallback to notify parent instead

---

## Quick Reference: Current Project Structure

```
Components/
  Pages/
    SpaApp.razor               <- Main SPA container (route: /app, dynamic sections)
    GenericEntityPage.razor    <- Standalone CRUD page (route: /{EntityName})
    Home.razor                 <- Landing page (route: /)
  Sections/
    DashboardSection.razor     <- Dashboard with entity metrics
    EntitySection.razor        <- Entity CRUD section for SPA
    SettingsSection.razor      <- Application settings
    SectionHeader.razor        <- Reusable section header component
Shared/
  MainLayout.razor             <- Master layout (RadzenLayout, branding, MainLayout.razor)
  NavMenu.razor                <- Navigation menu (dynamic entity links)
  DynamicDataGrid.razor        <- Generic data grid (renders any entity via reflection)
Models/
  Generated/                   <- Auto-generated entity models from app.yaml
Services/
  AppDictionaryService.cs      <- Loads and caches app.yaml
  EntityMetadataService.cs     <- Maps YAML entities to CLR types
  EntityApiService.cs          <- HTTP client wrapper
  SpaSectionService.cs         <- SPA routing and section management
  DashboardService.cs          <- Dashboard metrics
```

### Adding a New Entity

1. Add `CREATE TABLE` to `schema.sql`
2. Run `make run-ddl-pipeline`
3. Entity auto-appears in:
   - API endpoints (`/api/entities/myentity`)
   - SPA sections (`/app/myentity`)
   - Navigation menu ("Data" section)
   - GenericEntityPage (`/myentity`)

### Adding a New SPA Section

Sections are coordinated by `ISpaSectionService`. The system currently supports:
- Dashboard (hardcoded, static)
- Settings (hardcoded, static)
- Entity (dynamic - one per entity from `app.yaml`)

To add custom static sections, modify `SpaSectionService.cs`:
1. Add entry to `SpaSection` enum
2. Register in `GetInfo()` method
3. Add route segment in `FromRouteSegment()` method
4. Create corresponding `.razor` component in `Components/Sections/`
5. Update navigation in `NavMenu.razor` if desired

### Adding a New Radzen Component

1. Check if component needs services (DialogService, NotificationService)
2. Register service in `Program.cs` if needed
3. Add component tag to `MainLayout.razor` if needed (like `<RadzenNotification />`)
4. Use component in your `.razor` file
