# Phase 3: Radzen Component Patterns & Implementation Guide

**Status:** REFERENCE PATTERNS (Core patterns implemented via ProductDashboard.razor)
**Purpose:** Guide for building Radzen components with IViewService integration
**Prerequisite:** Phase 1 & Phase 2 must be completed first
**Last Updated:** 2026-01-28 (Updated for multi-app architecture)

> **⚠️ IMPORTANT - Multi-App Context (2026-01-28):**
> This project now uses **multi-app architecture** with `apps.yaml` (not `app.yaml`).
> - Views are **app-scoped**: each application defines which views it can access
> - Routes are **app-prefixed**: `/admin/dashboard`, `/reporting/dashboard`, etc.
> - See `MULTI_APP_IMPLEMENTATION_SUMMARY.md` for full architecture details

---

## Executive Summary

Phase 3 provides **reference patterns and implementation guidelines** for building Blazor components using Radzen UI library:

1. **Reference component patterns** - Copy these as starting points for grids, forms, and dashboards
2. **Complete working example** - ProductDashboard.razor showing IViewService integration
3. **Implementation guidelines** - File locations, naming conventions, state management patterns
4. **Testing strategies** - Unit and integration testing approaches

This guide helps developers build type-safe, data-bound Blazor components that leverage Phase 2's ViewModels and IViewService.

### Why Phase 3?

- Phase 1 provides: `IEntityOperationService` (CRUD writes via EF Core)
- Phase 2 provides: `IViewService` + ViewModels (complex reads via Dapper)
- **Phase 3 provides:** Systematic patterns for building UI components that consume both

**Approach:** Manual component development following proven patterns (NOT code generation)

---

## Architecture & Philosophy

### Key Principles

1. **Pattern-Based Development**
   - Each component type (grid, form, dashboard) has a reference pattern
   - Developers copy the pattern and customize for their needs
   - Variations are straightforward - change bindings, add/remove columns, adjust styling

2. **Strong Typing from Phase 2**
   - ViewModels have DataAnnotations ([Required], [MaxLength], [Range])
   - ViewModelParameters classes are validation-ready
   - Full IntelliSense and compile-time type checking

3. **Radzen Component Library**
   - Use Radzen's built-in components directly (RadzenDataGrid, RadzenCard, etc.)
   - No abstraction layers - full access to Radzen features
   - Leverage Radzen's validation, filtering, sorting, paging out-of-the-box

4. **Composability**
   - Components can be nested (dashboard contains grids + forms)
   - Each component is independent and testable
   - Reusable state management patterns (AsyncUiState, error handling)

5. **Multi-Tenant & Schema-Aware by Default**
   - SQL views use schema-qualified table names: `[acme].[TableName]`
   - ViewService inherits schema from EF Core context
   - No extra work needed – automatic schema isolation

### Component Types

| Type | Purpose | When to Use | Complexity |
|------|---------|-------------|-----------|
| **grid** | Read-only tabular display | Dashboards, reports, lists | Low |
| **grid-editable** | Grid with inline editing | CRUD lists, data entry | Moderate |
| **form** | Single record display/edit | Detail pages, settings | Low-Moderate |
| **detail** | Master-detail (grid + form) | Product catalog, orders | Moderate |
| **filter-panel** | Parameter input form | Dashboards with filters | Low |
| **dashboard** | Multiple components composed | Executive summaries | Moderate |
| **chart** | Data visualization | KPIs, trends | High |

---

## Reference Component Patterns

This section provides reference Razor component patterns for building Blazor UI components with Radzen. These are **complete working examples** that you can copy as starting points and customize for your specific needs.

Each pattern shows:
- Complete `.razor` component code
- IViewService integration for data loading
- State management (loading, error, empty states)
- Event handling and user interactions
- Radzen component configuration

### Grid Component Pattern

**Use this pattern for:** Dashboards, reports, data tables, any read-only or read-heavy data display

**Example: ProductDashboard.razor** (see `Components/Pages/ProductDashboard.razor` for working implementation)

> **Note:** ProductDashboard.razor is currently routed at `/dashboard/products` (standalone route outside multi-app routing). Future dashboards should follow the multi-app pattern: `/{AppName}/dashboard/{ViewName}`

```razor
@page "{Route}"
@using DotNetWebApp.Models.ViewModels
@using DotNetWebApp.Services.Views
@inject IViewService ViewService
@inject ILogger<{ComponentName}> Logger
@inject NavigationManager Navigation

<PageTitle>{Title}</PageTitle>

<RadzenStack Style="margin: 20px;">
    <!-- Filter Panel (Optional) -->
    @if (hasFilterPanel)
    {
        <RadzenCard>
            <RadzenStack Orientation="Orientation.Horizontal" AlignItems="AlignItems.Center" Gap="10px">
                @foreach (var param in filterParameters)
                {
                    <div>
                        <RadzenLabel Text="@param.Label" />
                        @if (param.Type == "int" && !param.IsDropdown)
                        {
                            <RadzenNumeric @bind-Value="@filterValues[param.Name]"
                                         Min="@param.Min" Max="@param.Max"
                                         Style="width: 100%;" />
                        }
                    </div>
                }
                <RadzenButton Text="Apply Filters" Click="@OnApplyFilters" />
            </RadzenStack>
        </RadzenCard>
    }

    <!-- Data Grid -->
    <RadzenDataGrid @ref="grid"
                    Data="@gridData"
                    TItem="{ViewModelType}"
                    AllowFiltering="@allowFiltering"
                    AllowSorting="@allowSorting"
                    AllowPaging="@allowPaging"
                    PageSize="@pageSize"
                    Style="height: {GridHeight};">

        <Columns>
            @foreach (var column in columns)
            {
                @if (column.Type == "string")
                {
                    <RadzenDataGridColumn TItem="{ViewModelType}"
                                         Property="@column.PropertyName"
                                         Title="@column.Title"
                                         Sortable="@column.Sortable"
                                         Filterable="@column.Filterable" />
                }
                else if (column.Type == "decimal" || column.Type == "int" || column.Type == "long")
                {
                    <RadzenDataGridColumn TItem="{ViewModelType}"
                                         Property="@column.PropertyName"
                                         Title="@column.Title"
                                         FormatString="@column.Format"
                                         TextAlign="@column.TextAlign"
                                         Sortable="@column.Sortable"
                                         Filterable="@column.Filterable" />
                }
            }

            @if (hasActions)
            {
                <RadzenDataGridColumn TItem="{ViewModelType}"
                                     Frozen="true" FrozenPosition="FrozenColumnPosition.Right"
                                     Width="100px" TextAlign="TextAlign.Center">
                    <Template Context="data">
                        @foreach (var action in actions)
                        {
                            @if (action.HasRoute)
                            {
                                <RadzenButton Icon="@action.Icon"
                                             Click="@(() => Navigation.NavigateTo(action.ResolveRoute(data)))"
                                             ButtonStyle="ButtonStyle.Light"
                                             Size="ButtonSize.Small" />
                            }
                            else if (action.HasClickHandler)
                            {
                                <RadzenButton Icon="@action.Icon"
                                             Click="@(() => OnAction(action.Name, data))"
                                             ButtonStyle="ButtonStyle.Light"
                                             Size="ButtonSize.Small" />
                            }
                        }
                    </Template>
                </RadzenDataGridColumn>
            }
        </Columns>
    </RadzenDataGrid>

    <!-- Loading State -->
    @if (isLoading)
    {
        <RadzenProgressBar Value="100" ShowValue="false" />
        <p><em>Loading data...</em></p>
    }

    <!-- Error State -->
    @if (!string.IsNullOrEmpty(errorMessage))
    {
        <RadzenAlert AlertStyle="AlertStyle.Danger" Title="Error">
            @errorMessage
        </RadzenAlert>
    }

    <!-- No Data State -->
    @if (!isLoading && (gridData == null || !gridData.Any()) && string.IsNullOrEmpty(errorMessage))
    {
        <RadzenAlert AlertStyle="AlertStyle.Info" Title="No Data">
            No records found. Try adjusting your filters.
        </RadzenAlert>
    }
</RadzenStack>

@code {
    [Parameter]
    public string Route { get; set; } = "/your-route";

    private IEnumerable<{ViewModelType}>? gridData;
    private bool isLoading = true;
    private string? errorMessage;
    private RadzenDataGrid<{ViewModelType}>? grid;

    // Grid configuration
    private bool allowFiltering = {AllowFiltering};
    private bool allowSorting = {AllowSorting};
    private bool allowPaging = {AllowPaging};
    private int pageSize = {PageSize};
    private string gridHeight = "{GridHeight}";

    // Filter parameters (if view has parameters)
    private Dictionary<string, object?> filterValues = new();
    private bool hasFilterPanel = {HasFilterPanel};

    // Action configuration
    private bool hasActions = {HasActions};
    private List<ActionConfig> actions = new();

    // Column configuration
    private List<ColumnConfig> columns = new();

    protected override async Task OnInitializedAsync()
    {
        try
        {
            await LoadDataAsync();
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Failed to initialize component");
            errorMessage = "Failed to load component. Please refresh and try again.";
        }
    }

    private async Task LoadDataAsync()
    {
        isLoading = true;
        errorMessage = null;

        try
        {
            Logger.LogInformation("Loading data for {ComponentName}", "{ComponentName}");

            // Build parameters object from defaults + filter values
            var parameters = new {ViewModelTypeParameters}
            {
                {ParameterBindings}
            };

            // Execute view
            gridData = await ViewService.ExecuteViewAsync<{ViewModelType}>(
                "{ViewName}",
                parameters);

            Logger.LogInformation("Loaded {Count} records", gridData?.Count() ?? 0);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Error loading data");
            errorMessage = $"Error loading data: {ex.Message}";
        }
        finally
        {
            isLoading = false;
        }
    }

    private async Task OnApplyFilters()
    {
        await LoadDataAsync();
        StateHasChanged();
    }

    private async Task OnAction(string actionName, {ViewModelType} record)
    {
        Logger.LogInformation("Action {Action} triggered for record", actionName);
        // Implement action handlers as needed
        await Task.CompletedTask;
    }

    // Configuration classes
    private class ColumnConfig
    {
        public string PropertyName { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Type { get; set; } = "string";
        public string? Format { get; set; }
        public TextAlign TextAlign { get; set; } = TextAlign.Left;
        public bool Sortable { get; set; }
        public bool Filterable { get; set; }
    }

    private class ActionConfig
    {
        public string Name { get; set; } = string.Empty;
        public string Icon { get; set; } = string.Empty;
        public string? Route { get; set; }
        public bool HasRoute => !string.IsNullOrEmpty(Route);
        public bool HasClickHandler => !HasRoute;

        public string ResolveRoute(object record)
        {
            if (Route == null) return string.Empty;
            var result = Route;
            foreach (var prop in record.GetType().GetProperties())
            {
                result = result.Replace($"{{{prop.Name}}}", prop.GetValue(record)?.ToString() ?? "");
            }
            return result;
        }
    }

    private class FilterParamConfig
    {
        public string Name { get; set; } = string.Empty;
        public string Label { get; set; } = string.Empty;
        public string Type { get; set; } = "string";
        public bool IsDropdown { get; set; }
        public object? Min { get; set; }
        public object? Max { get; set; }
    }
}

### Form Component Pattern

**Use this pattern for:** Detail pages, edit forms, settings pages, single-record display/edit

**Example: ProductForm.razor**


```razor
@page "{Route}"
@using DotNetWebApp.Models.ViewModels
@using DotNetWebApp.Services.Views
@inject IViewService ViewService
@inject ILogger<{ComponentName}> Logger
@inject NavigationManager Navigation

<PageTitle>{Title}</PageTitle>

<RadzenStack Style="margin: 20px; max-width: 800px;">
    <RadzenCard>
        <RadzenText TextStyle="TextStyle.H4">@Title</RadzenText>

        @if (isLoading)
        {
            <RadzenProgressBar Value="100" ShowValue="false" />
            <p><em>Loading...</em></p>
        }
        else if (!string.IsNullOrEmpty(errorMessage))
        {
            <RadzenAlert AlertStyle="AlertStyle.Danger" Title="Error">
                @errorMessage
            </RadzenAlert>
        }
        else if (formData != null)
        {
            <EditForm Model="@formData" OnValidSubmit="@OnSubmit">
                <DataAnnotationsValidator />

                @foreach (var fieldGroup in fieldGroups)
                {
                    <RadzenFieldset Text="@fieldGroup.Title" Style="margin-top: 20px;">
                        <RadzenStack Gap="15px">
                            @foreach (var field in fieldGroup.Fields)
                            {
                                @if (field.Type == "string")
                                {
                                    <div>
                                        <RadzenLabel Text="@field.Label" />
                                        <RadzenTextBox @bind-Value="@GetPropertyValue(field.PropertyName)"
                                                      ReadOnly="@field.ReadOnly"
                                                      Style="width: 100%;" />
                                        <ValidationMessage For="@(() => GetPropertyValue(field.PropertyName))" />
                                    </div>
                                }
                                else if (field.Type == "decimal" || field.Type == "int")
                                {
                                    <div>
                                        <RadzenLabel Text="@field.Label" />
                                        <RadzenNumeric @bind-Value="@GetNumericValue(field.PropertyName)"
                                                      ReadOnly="@field.ReadOnly"
                                                      Style="width: 100%;" />
                                        <ValidationMessage For="@(() => GetNumericValue(field.PropertyName))" />
                                    </div>
                                }
                            }
                        </RadzenStack>
                    </RadzenFieldset>
                }

                <RadzenStack Orientation="Orientation.Horizontal" Gap="10px" Style="margin-top: 20px;">
                    <RadzenButton ButtonType="ButtonType.Submit" Text="@submitButtonText" />
                    <RadzenButton Text="@cancelButtonText" Click="@OnCancel" ButtonStyle="ButtonStyle.Light" />
                </RadzenStack>
            </EditForm>
        }
    </RadzenCard>
</RadzenStack>

@code {
    [Parameter]
    public string Route { get; set; } = "/your-route";

    private {ViewModelType}? formData;
    private bool isLoading = true;
    private string? errorMessage;
    private string submitButtonText = "{SubmitButtonText}";
    private string cancelButtonText = "{CancelButtonText}";

    private List<FieldGroup> fieldGroups = new();

    protected override async Task OnInitializedAsync()
    {
        await LoadDataAsync();
    }

    private async Task LoadDataAsync()
    {
        isLoading = true;
        errorMessage = null;

        try
        {
            // For single record forms, use ExecuteViewSingleAsync
            var parameters = new {ViewModelTypeParameters}
            {
                {ParameterBindings}
            };

            formData = await ViewService.ExecuteViewSingleAsync<{ViewModelType}>(
                "{ViewName}",
                parameters);

            if (formData == null)
            {
                errorMessage = "Record not found.";
            }
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Error loading form data");
            errorMessage = $"Error loading data: {ex.Message}";
        }
        finally
        {
            isLoading = false;
        }
    }

    private async Task OnSubmit()
    {
        try
        {
            Logger.LogInformation("Form submitted");
            // Implement submit logic (save, etc.)
            // Example: await EntityService.UpdateAsync(formData);
            Navigation.NavigateTo("{ReturnRoute}");
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Error submitting form");
            errorMessage = $"Error: {ex.Message}";
        }
    }

    private void OnCancel()
    {
        Navigation.NavigateTo("{ReturnRoute}");
    }

    private object? GetPropertyValue(string propertyName)
    {
        if (formData == null) return null;
        return formData.GetType().GetProperty(propertyName)?.GetValue(formData);
    }

    private object? GetNumericValue(string propertyName)
    {
        return GetPropertyValue(propertyName);
    }

    private class FieldGroup
    {
        public string Title { get; set; } = string.Empty;
        public List<FieldConfig> Fields { get; set; } = new();
    }

    private class FieldConfig
    {
        public string PropertyName { get; set; } = string.Empty;
        public string Label { get; set; } = string.Empty;
        public string Type { get; set; } = "string";
        public bool ReadOnly { get; set; }
        public bool Required { get; set; }
        public int? MaxLength { get; set; }
    }

### Dashboard Component Pattern

**Use this pattern for:** Composite pages with multiple data sources, executive dashboards

**Example: ExecutiveDashboard.razor**

```razor
@page "{Route}"
@inject ILogger<{ComponentName}> Logger

<PageTitle>{Title}</PageTitle>

<RadzenStack Style="margin: 20px;">
    <RadzenText TextStyle="TextStyle.H3">@Title</RadzenText>

    <div style="display: grid; grid-template-columns: {GridLayout}; gap: 20px;">
        @foreach (var section in sections)
        {
            <div style="grid-column: span {@section.Span}; min-height: {@section.Height};">
                <RadzenCard>
                    <RadzenText TextStyle="TextStyle.H5">@section.Title</RadzenText>
                    @* Load component dynamically or use @if branches *@
                    @if (section.ComponentType == typeof(ProductDashboard))
                    {
                        <ProductDashboard />
                    }
                </RadzenCard>
            </div>
        }
    </div>
</RadzenStack>

@code {
    [Parameter]
    public string Route { get; set; } = "/your-route";

    private List<DashboardSection> sections = new();

    protected override void OnInitialized()
    {
        Logger.LogInformation("Dashboard initialized");
        // Initialize sections
    }

    private class DashboardSection
    {
        public string Title { get; set; } = string.Empty;
        public string ComponentName { get; set; } = string.Empty;
        public Type ComponentType { get; set; } = typeof(object);
        public int Span { get; set; } = 1;
        public string Height { get; set; } = "400px";
    }

---

## Building Radzen Components (SKILLS.md Integration)

This section provides guidance for implementing Blazor components using Radzen UI library with IViewService integration. These patterns should be documented in your project's `SKILLS.md` file.

FIRST: Understand radzen-skill-creation-guide.md and make sure it aligns with this section. If not, reconcile with the human developer.

### Overview

Building Blazor components with Radzen follows a consistent pattern:

1. **Create the `.razor` component file** in appropriate location
2. **Inject required services** (IViewService, ILogger, NavigationManager)
3. **Define state variables** (data, isLoading, errorMessage)
4. **Implement OnInitializedAsync** to load data via IViewService
5. **Add Radzen components** (RadzenDataGrid, RadzenCard, etc.) with data binding
6. **Handle loading/error/empty states** with conditional rendering

### Component File Locations

| Component Type | Location | Routable? |
|---|---|---|
| Page (grid, form, dashboard) | `Components/Pages/{Name}.razor` | Yes (@page directive) |
| Reusable Section | `Components/Sections/{Name}.razor` | No |
| Shared Sub-component | `Shared/{Name}.razor` | No |

> **Note (2026-01-28):** The shared components are in `Shared/` (at project root), NOT `Components/Shared/`. This includes `NavMenu.razor`, `DynamicDataGrid.razor`, and `SectionHeader.razor`.

### Required Service Injections

Every data-driven component needs:

```csharp
@inject IViewService ViewService
@inject ILogger<ComponentName> Logger
@inject NavigationManager Navigation    // If component has navigation
```

### State Management Pattern

Always use this pattern for consistency:

```csharp
private IEnumerable<ViewModelType>? data;    // The data
private bool isLoading = true;               // Loading state
private string? errorMessage;                // Error state
```

### Data Loading Pattern

Standard async data loading with error handling:

```csharp
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
        Logger.LogInformation("Loading data");

        // Execute view with parameters
        data = await ViewService.ExecuteViewAsync<ViewModelType>(
            "ViewName",
            new { Parameter1 = value1, Parameter2 = value2 }
        );

        Logger.LogInformation("Loaded {Count} records", data?.Count() ?? 0);
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
```

### Common Patterns

#### Pattern: Grid with No Parameters

```csharp
var gridData = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    null);
```

#### Pattern: Grid with View Parameters

```csharp
var parameters = new { TopN = 50, CategoryId = categoryId };
var gridData = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    parameters);
```

#### Pattern: Single Record Load

```csharp
var formData = await ViewService.ExecuteViewSingleAsync<ProductSalesView>(
    "ProductSalesView",
    new { ProductId = id });
```

#### Pattern: Multi-View Dashboard

Load multiple views in parallel:

```csharp
var taskProducts = ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView", null);
var taskCustomers = ViewService.ExecuteViewAsync<CustomerSummaryView>("CustomerSummaryView", null);

await Task.WhenAll(taskProducts, taskCustomers);

products = taskProducts.Result;
customers = taskCustomers.Result;
```

### Validation from ViewModels

Phase 2 generates ViewModels with DataAnnotations. Use these in forms:

```csharp
// Generated ProductSalesView.cs includes:
[Required]
[MaxLength(100)]
public string Name { get; set; } = null!;

[Range(1, 1000)]
public int TopN { get; set; } = 10;
```

The form's `<EditForm>` with `<DataAnnotationsValidator>` automatically enforces these rules.

### Multi-Tenant & Schema Considerations

ViewService automatically inherits schema from EF Core context. No extra work needed:

- SQL views should use schema-qualified table names: `[acme].[TableName]`
- User's `X-Customer-Schema` header is applied automatically
- Dapper queries execute against correct schema
- No component code changes required

**Example SQL view with schema qualification:**

```sql
SELECT
    p.Id,
    p.Name,
    p.Price
FROM [acme].[Products] p
LEFT JOIN [acme].[Categories] c ON p.CategoryId = c.Id
```

### Navigation & Routing

For action buttons with routes, use route parameters:

```csharp
@foreach (var item in data)
{
    <RadzenButton Text="Edit" 
                  Click="@(() => Navigation.NavigateTo($"/products/{item.Id}"))" />
}
```

### Error Handling Checklist

- [ ] Wrap LoadDataAsync in try-catch
- [ ] Log errors with Logger.LogError(ex, ...)
- [ ] Display user-friendly error message in RadzenAlert
- [ ] Show different states: loading, error, empty, success
- [ ] Test with invalid view names
- [ ] Test with invalid parameters

### Testing Checklist

- [ ] Component renders without errors
- [ ] Data loads from ViewService correctly
- [ ] Grid columns display with correct formatting
- [ ] Form fields bind to view data correctly
- [ ] Filters apply correctly (OnApplyFilters)
- [ ] Actions/buttons work (navigation, etc.)
- [ ] Error states display properly
- [ ] Empty result sets handled
- [ ] Multi-tenant schema isolation works

### SQL View Best Practices

When creating or reviewing SQL view files in `sql/views/`:

- **Use schema-qualified table names:** Always use `[acme].[TableName]` format, not just `TableName`
- **Never assume default schema:** Explicit schema qualification ensures views work correctly
- **Example:**
  ```sql
  SELECT p.Id, p.Name
  FROM [acme].[Products] p
  LEFT JOIN [acme].[Categories] c ON p.CategoryId = c.Id
  WHERE p.Price > @MinPrice
  ```
- **Schema context is automatic:** IViewService and Dapper inherit schema from EF Core context, so no code changes needed

## Phase 3E: Step-by-Step Implementation Plan

### Step 1: Build Reference Component Examples (Days 1-3)

**Deliverable:** Working Blazor components demonstrating patterns

Build example components following the reference patterns:

- [x] Create `Components/Pages/ProductDashboard.razor` (grid pattern) ✅ DONE
- [ ] Create `Components/Pages/ProductForm.razor` (form pattern)
- [ ] Create `Components/Pages/ExecutiveDashboard.razor` (dashboard pattern)
- [x] Verify all components compile and load data correctly ✅ ProductDashboard working
- [ ] Test data binding, navigation, and state management
- [ ] Document any customizations from base patterns

**Files created:**
- `Components/Pages/ProductDashboard.razor` ✅ (reference implementation)

**Approach:**
1. Copy the appropriate reference pattern from this document
2. Customize for your specific ViewModels and views
3. Adjust columns, fields, styling as needed
4. Test with actual data

---

### Step 2: Update SKILLS.md (Day 4)

**Deliverable:** Documentation for building Radzen components

- [ ] Add "Building Radzen Components" section to SKILLS.md
- [ ] Document service injection patterns
- [ ] Provide state management examples
- [ ] Include common data loading patterns
- [ ] Add validation/error handling guide
- [ ] Document multi-tenant considerations

**Files to update:**
- `SKILLS.md` - Add new major section

**Content to include:**
- Component file locations and naming
- Required service injections (IViewService, ILogger, NavigationManager)
- Standard state management pattern
- Data loading with error handling
- Common patterns (grid with params, single record, multi-view)
- SQL view best practices

---

### Step 3: Update NavMenu Navigation (Day 5)

**Deliverable:** Navigation links to new components

**STATUS: ✅ MOSTLY COMPLETE (Multi-app navigation implemented)**

The NavMenu has been completely rewritten for multi-app architecture. It now:
- Shows all applications from `apps.yaml`
- Dynamically generates entity sections per app
- Highlights the active application

**Files:**
- `Shared/NavMenu.razor` (note: NOT in `Components/Shared/`)

**Current Implementation:**
```razor
<RadzenPanelMenu class="app-nav-menu" DisplayStyle="@MenuItemDisplayStyle.IconAndText" Multiple="false">
    <RadzenPanelMenuItem Text="Home" Icon="home" Path="@GetHomePath()" />

    @foreach (var app in AppDictionary.GetAllApplications())
    {
        <RadzenPanelMenuItem Text="@app.Title" Icon="@(app.Icon ?? "apps")" Expanded="@IsActiveApp(app.Name)">
            @foreach (var sectionItem in SpaSections.GetSectionsForApplication(app.Name))
            {
                var sectionPath = GetSectionPath(app.Name, sectionItem);
                var sectionIcon = GetSectionIcon(sectionItem.Section);
                <RadzenPanelMenuItem Text="@sectionItem.NavLabel" Icon="@sectionIcon" Path="@sectionPath" />
            }
        </RadzenPanelMenuItem>
    }
</RadzenPanelMenu>
```

**Remaining TODO (for view dashboards):**
- [ ] Add ProductDashboard to the navigation (currently at standalone `/dashboard/products` route)
- [ ] Determine if dashboards should be standalone or app-scoped routes

---

### Step 4: Create Unit Tests (Days 6-7)

**Deliverable:** Test suite for component behavior

Create test project at `tests/DotNetWebApp.Tests/Components/`

**Unit Tests:**

```csharp
// ComponentTests.cs
[Fact]
public async Task ProductDashboard_LoadsDataFromViewService()
{
    // Arrange
    var mockViewService = new Mock<IViewService>();
    mockViewService.Setup(x => x.ExecuteViewAsync<ProductSalesView>(
        It.IsAny<string>(), It.IsAny<object>()))
        .ReturnsAsync(new List<ProductSalesView> { /* test data */ });

    // Act
    var component = RenderComponent<ProductDashboard>(parameters =>
        parameters.Add(p => p.ViewService, mockViewService.Object));

    // Assert
    Assert.NotNull(component.Instance.Products);
    mockViewService.Verify(x => x.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView", It.IsAny<object>()), Times.Once);
}
```

**Files to create:**
- `tests/DotNetWebApp.Tests/Components/ProductDashboardTests.cs`
- `tests/DotNetWebApp.Tests/Components/ProductFormTests.cs`

**Run:** `make test`

---

### Step 5: Create Documentation & Guides (Day 8)

**Deliverable:** README and guides for using Phase 3

- [ ] Update project `README.md` with Phase 3 section
- [ ] Document component patterns in project wiki/docs
- [ ] Create troubleshooting guide
- [ ] Add examples of common customizations

**Files to create/update:**
- `README.md` (add Phase 3 section)
- `docs/COMPONENT_PATTERNS.md` (optional detailed guide)

---

## Phase 3F: Detailed Implementation Guidelines

### Component File Locations

| Component Type | Location | Routable? |
|---|---|---|
| Page (grid, form, dashboard) | `Components/Pages/{Name}.razor` | Yes (@page directive) |
| Reusable Section | `Components/Sections/{Name}.razor` | No |
| Shared Sub-component | `Shared/{Name}.razor` | No |

> **Actual file locations (2026-01-28):**
> - `Components/Pages/ProductDashboard.razor` - Reference grid component
> - `Components/Pages/SpaApp.razor` - Multi-app router
> - `Components/Sections/EntitySection.razor` - Entity CRUD section
> - `Components/Sections/DashboardSection.razor` - App dashboard
> - `Shared/NavMenu.razor` - Multi-app navigation
> - `Shared/DynamicDataGrid.razor` - Reflection-based grid

### Naming Conventions

- **Component class name:** PascalCase matching metadata.name
- **File name:** `{ComponentName}.razor`
- **ViewModel property access:** Exact match to ViewModel property (case-sensitive)
- **Method names:** OnInitializedAsync, LoadDataAsync, OnApplyFilters, OnSubmit, OnCancel

### Code Organization

Always follow this structure in .razor files:

```razor
@page "{routing.page}"
@using statements
@inject statements

<PageTitle>{routing.title}</PageTitle>

<!-- HTML/Component markup -->

@code {
    // [Parameter] properties
    // State variables (isLoading, errorMessage, data)
    // Lifecycle methods (OnInitializedAsync)
    // Event handlers (LoadDataAsync, OnApplyFilters)
    // Helper classes
}
```

### Required Injections

Every component needs:
```csharp
@inject IViewService ViewService
@inject ILogger<{ComponentName}> Logger
@inject NavigationManager Navigation    // If component has navigation
```

### State Management Pattern

Always use this pattern:
```csharp
private {ViewModelType}? data;           // The data
private bool isLoading = true;           // Loading state
private string? errorMessage;            // Error state
private Dictionary<string, object?> filterValues = new();  // Filter values
```

### Data Loading Pattern

```csharp
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
        Logger.LogInformation("Loading data");

        var parameters = new {ViewParameterType}
        {
            // Bind your view parameters here
        };

        data = await ViewService.ExecuteViewAsync<{ViewModelType}>(
            "{ViewName}",
            parameters);
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
```

### Grid Column Mapping

For each ViewModel property, add a column:
```razor
<RadzenDataGridColumn TItem="{ViewModelType}"
                     Property="@column.PropertyName"
                     Title="@column.Title"
                     FormatString="@column.Format"
                     TextAlign="@column.TextAlign"
                     Sortable="@column.Sortable"
                     Filterable="@column.Filterable" />
```

### Handling View Parameters

If your view has parameters:
1. Create filter panel UI (RadzenNumeric, RadzenDropdown, etc.)
2. Bind inputs to filterValues dictionary
3. In OnApplyFilters, rebuild parameters object
4. Call LoadDataAsync again

### Action Button Resolution

For action buttons with `{Id}` route placeholders:
```csharp
private class ActionConfig
{
    public string ResolveRoute(object record)
    {
        var result = Route ?? "";
        foreach (var prop in record.GetType().GetProperties())
        {
            var value = prop.GetValue(record)?.ToString() ?? "";
            result = result.Replace($"{{{prop.Name}}}", value);
        }
        return result;
    }
}
```

Then in button click:
```csharp
Navigation.NavigateTo(action.ResolveRoute(record));
```

---

## Phase 3G: Testing & Validation

### Test Categories

#### 1. View Pipeline Tests (Phase 2)
- Ensure views.yaml deserializes correctly
- Validate view names exist in registry
- Validate SQL files load correctly
- Validate ViewModels map to SQL columns

#### 2. Component Rendering Tests
- Component renders without errors
- Title displays correctly
- Loading state shows while loading
- Error state shows on failure
- Empty result state shows when no data

#### 3. Data Binding Tests
- Grid data populates correctly
- Form fields bind to view data
- Column values format correctly (currency, dates, etc.)
- Action buttons render with correct routes

#### 4. Interaction Tests
- Filter buttons apply filters
- Submit buttons work
- Cancel buttons navigate back
- Sorting/pagination work in grid

#### 5. Error Handling Tests
- Invalid view name throws appropriate error
- Missing view data handled gracefully
- Network errors display error message
- Validation errors prevent submission

### Manual Testing Checklist

For each new component:
- [ ] Component page loads without errors
- [ ] Data displays correctly
- [ ] Columns/fields show correct formatting
- [ ] Sorting works (if grid)
- [ ] Filtering works (if filters present)
- [ ] Navigation works (if action buttons)
- [ ] Error messages display properly
- [ ] Multi-tenant schema isolation works

### Test Execution

```bash
# Run all tests
make test

# Run specific test project
./dotnet-build.sh test tests/DotNetWebApp.Tests/DotNetWebApp.Tests.csproj

# Run with coverage
dotnet test /p:CollectCoverage=true
```

---

## Phase 3H: Completion Checklist

### Reference Components
- [x] `Components/Pages/ProductDashboard.razor` created ✅
- [ ] `Components/Pages/ProductForm.razor` created
- [ ] `Components/Pages/ExecutiveDashboard.razor` created
- [x] All components render and load data correctly ✅ (ProductDashboard)
- [x] Navigation links work ✅ (multi-app navigation implemented)

### SKILLS.md
- [ ] "Building Radzen Components" section added
- [ ] IViewService integration patterns documented
- [ ] State management patterns documented
- [ ] Common patterns documented (grid, form, dashboard)
- [ ] Error handling checklist provided

### Tests
- [ ] `tests/DotNetWebApp.Tests/Components/ProductDashboardTests.cs` created
- [x] All tests pass: `make test` ✅ (192 tests passing on multi_app branch)
- [ ] Test coverage for component rendering

### Navigation
- [x] `Shared/NavMenu.razor` updated ✅ (multi-app navigation complete)
- [x] Dashboard section added to menu ✅ (per-app entity sections)
- [ ] ProductDashboard linked in menu (standalone route, needs integration)
- [x] All navigation links work ✅

### Code Quality
- [x] No compiler warnings or errors ✅
- [x] Consistent code style (indentation, naming) ✅
- [x] Proper error handling in all components ✅ (ProductDashboard has comprehensive error handling)
- [x] Logging in all async operations ✅
- [x] Comments on complex logic ✅ (ProductDashboard heavily documented)

---

## Phase 3 Success Criteria

After Phase 3 completion:

✅ Developers can build Radzen components using reference patterns
✅ LLMs can follow patterns to implement consistent components
✅ Components are type-safe (use generated ViewModels from Phase 2)
✅ Data binding is automatic (IViewService + parameter binding)
✅ Multi-tenant support works automatically (schema inheritance)
✅ All components follow consistent patterns (state management, error handling)
✅ New components can be built quickly by copying reference patterns

---

## Next Steps After Phase 3

1. **Build additional reference components** (forms, dashboards) as needed
2. **Create more SQL views** in Phase 2 as UI requirements emerge
3. **Proceed to Phase 4** for editable components (SmartDataGrid<T>, inline editing)
4. **Extend SKILLS.md** with additional component patterns (charts, drilldown, etc.)

---

## Key Dependencies

**Phase 3 requires:**
- ✅ Phase 1: IEntityOperationService (CRUD operations)
- ✅ Phase 2: IViewService + ViewModels (data access)
- ✅ Existing: Radzen components (UI library)
- ✅ Existing: Blazor Server (runtime)

**Phase 3 provides for Phase 4:**
- Reference patterns for read-only components
- State management patterns (isLoading, errorMessage, data)
- IViewService integration examples
- Foundation for adding write capabilities (SmartDataGrid<T>)

---

**End of Phase 3 Reference Patterns Document**
