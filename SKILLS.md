# Skills Needed

Comprehensive guides for developers at all skill levels. Status of each guide:

- ✅ **[Front-End (Blazor/Radzen)](#front-end-skillsguide-blazorradzen)** - COMPLETE
- ✅ **[Database & DDL](#database--ddl)** - COMPLETE
- ✅ **[SQL Operations](#sql-operations)** - COMPLETE
- ✅ **[App Configuration & YAML](#app-configuration--yaml)** - COMPLETE
- 📋 **.NET/C# Data Layer** *(pending)* - Entity Framework Core, models, and data access
- 📋 **.NET/C# API & Services** *(pending)* - Controllers, services, and API endpoints

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

# Front-End Skills Guide (Blazor/Radzen)

This guide helps with front-end changes to Razor/Blazor components and JavaScript interop. Read this BEFORE making front-end changes.

---

## File Locations

| What | Where |
|------|-------|
| SPA main container | `Components/Pages/SpaApp.razor` |
| Section components | `Components/Sections/*.razor` |
| Shared layouts | `Shared/MainLayout.razor`, `Shared/NavMenu.razor` |
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

<!-- FIXME: Outdated structure: include GenericEntityPage.razor, DynamicDataGrid.razor, Models/Generated, and ModelGenerator; remove Models/Product.cs. -->
```
Components/
  Pages/
    SpaApp.razor       <- Main SPA container (route: /app)
    Home.razor         <- Landing page (route: /)
  Sections/
    DashboardSection.razor   <- Metrics cards
    EntitySection.razor      <- Dynamic entity section
    SettingsSection.razor    <- Config forms
Shared/
  MainLayout.razor     <- Master layout (contains RadzenComponents)
  NavMenu.razor        <- Navigation bar
Models/
  Generated/           <- Auto-generated entity models from app.yaml
```

### Adding a New Section

<!-- FIXME: SPA sections are coordinated via SpaSection enum + SpaSectionService/ISpaSectionService; update steps to include those files. -->
1. Add a new entity to `app.yaml` (SPA sections are data-driven)
2. Regenerate models with `ModelGenerator` if needed
3. Verify the entity appears in `/app/{EntityName}` and the "Data" nav group

### Adding a New Radzen Component

1. Check if component needs services (DialogService, NotificationService)
2. Register service in `Program.cs` if needed
3. Add component tag to `MainLayout.razor` if needed (like `<RadzenNotification />`)
4. Use component in your `.razor` file
