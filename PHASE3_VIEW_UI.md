# Phase 3: Spec-Driven View UI Component Generation

**Status:** PLANNED (post Phase 2)
**Duration:** 2-3 weeks
**Priority:** MEDIUM (enables rapid UI development via LLM + human spec collaboration)
**Prerequisite:** Phase 1 & Phase 2 must be completed first

---

## Executive Summary

Phase 3 implements a **spec-driven UI component builder** that allows humans and LLMs to collaborate:

1. **Human developer** writes a component spec (YAML) describing what to build
2. **LLM reads** spec file and understands requirements
3. **LLM implements** `.razor` component following templated patterns
4. **Result:** Type-safe, data-bound Blazor components with no guessing

This is **NOT auto-generation** – it's **guided, explicit specification** that leverages Phase 2's generated ViewModels and services.

### Why Phase 3?

- Phase 1 provides: `IEntityOperationService` (CRUD writes)
- Phase 2 provides: `IViewService` + ViewModels (complex reads)
- **Phase 3 provides:** Systematic way to build UIs that consume both

---

## Architecture & Philosophy

### Key Principles

1. **Specs Are Configuration, Not Code**
   - YAML files describe *what* to build (structure, layout, bindings)
   - `.razor` implementation is consistent (data binding + event handlers)
   - Humans control the spec; LLM implements the pattern

2. **Strong Typing from Phase 2**
   - ViewModels have DataAnnotations ([Required], [MaxLength], [Range])
   - ViewModelParameters classes are validation-ready
   - No guessing about nullable types or field constraints

3. **Template-Based Implementation**
   - Each component type (grid, form, dashboard) has a proven pattern
   - Variations are CSS/layout changes, not structural changes
   - LLM applies template to spec properties

4. **Composability**
   - Components can be nested (dashboard contains grids + forms)
   - Each component is independent and testable
   - Reusable state management patterns

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

## Phase 3A: Spec Format & Documentation

### 3A.1 Spec Format Schema

**File:** `specs/SPEC_FORMAT.md`

Complete YAML schema for component specs:

```markdown
# Component Spec Format v1

All component specs are YAML files describing UI structure and data bindings.

## File Location
`specs/{component-name}.yaml` or `specs/examples/{category}/{name}.yaml`

## Root Properties

### metadata (required)
```yaml
metadata:
  name: ProductSalesGrid              # C# class name (PascalCase)
  description: "Display top selling products"
  type: grid|form|detail|filter-panel|dashboard|chart
  version: "1.0"
```

### routing (required for page components)
```yaml
routing:
  page: /dashboard/products           # Route (must start with /)
  layout: MainLayout                  # Blazor layout (optional, default: MainLayout)
  title: "Product Sales Dashboard"    # Page title
  requiresAuth: false                 # Auth required (optional, default: false)
```

### view (required for data components - grid, form, detail, chart)
```yaml
view:
  name: ProductSalesView              # From views.yaml
  parameters:
    TopN: 50                          # Parameter values (optional)
    CategoryId: 5
  singleRecord: false                 # Use ExecuteViewSingleAsync (optional, default: false)
```

### parameters (optional - for components with filter inputs)
```yaml
parameters:
  - name: TopN
    type: int
    label: "Number of Results"
    default: 50
    control: number-input
    gridColumn: 2
  - name: CategoryId
    type: int?
    label: "Category"
    default: null
    control: dropdown
    gridColumn: 2
    dataSource: Categories              # Entity name or view name
    valueProperty: Id
    textProperty: Name
```

### grid (required for type: grid)
```yaml
grid:
  allowFiltering: true
  allowSorting: true
  allowPaging: true
  pageSize: 20
  height: "600px"                     # Optional CSS height
  striped: true
  border: true
  responsive: true                    # Stack on mobile

  columns:
    - property: Name                  # ViewModel property name
      title: "Product Name"
      type: string                    # Expected type
      width: 200                      # Optional pixel width
      sortable: true
      filterable: true
      format: null                    # No format

    - property: Price
      title: "Unit Price"
      type: decimal
      sortable: true
      filterable: false
      format: "{0:C}"                 # Currency format
      textAlign: right

    - property: TotalRevenue
      title: "Total Revenue"
      type: decimal
      format: "{0:C}"
      textAlign: right
      width: 150

    - property: CategoryName
      title: "Category"
      type: string
      sortable: true
      filterable: true

actions:                              # Optional action columns
  - name: Edit
    icon: edit
    route: /products/{Id}
    enabled: true

  - name: View Details
    icon: info
    onClick: ViewDetails              # C# method name
    enabled: true
```

### form (required for type: form | detail)
```yaml
form:
  layout: vertical                    # vertical | horizontal | 2-column
  submitButtonText: "Save"
  cancelButtonText: "Cancel"
  readOnly: false                     # Entire form read-only

  fieldGroups:                        # Group fields visually
    - title: "Basic Information"
      fields:
        - property: Id
          label: "ID"
          type: int
          readOnly: true              # Disable individual fields
          visible: true               # Hide field conditionally (optional)

        - property: Name
          label: "Product Name"
          type: string
          required: true              # From ViewModel [Required]
          maxLength: 100              # From ViewModel [MaxLength]

    - title: "Pricing"
      fields:
        - property: Price
          label: "Unit Price"
          type: decimal
          required: true
          min: 0.01
          step: 0.01
```

### dashboard (required for type: dashboard)
```yaml
dashboard:
  layout: auto                        # auto | 1-column | 2-column | 3-column
  spacing: normal                     # compact | normal | spacious

  sections:
    - title: "Top Products"
      component: ProductSalesGrid     # Reference another spec (without .yaml)
      span: 2                         # Column span for 3-column layout
      height: 400

    - title: "Filters"
      component: ProductFilters
      span: 1
      height: auto

    - title: "Revenue Chart"
      component: RevenueChart
      span: 2
      height: 350
```

### filter-panel (required for type: filter-panel)
```yaml
filter-panel:
  layout: horizontal                  # horizontal | vertical | grid
  gridColumns: 3
  submitButtonText: "Apply Filters"
  resetButtonText: "Reset"
  liveUpdate: false                   # Apply filters on change

  fields:
    - name: TopN
      label: "Show Top"
      control: number-input
      default: 50
      gridColumn: 1

    - name: CategoryId
      label: "Category"
      control: dropdown
      default: null
      gridColumn: 1
      dataSource: Categories

    - name: PriceRange
      label: "Price Range"
      control: range-slider
      min: 0
      max: 10000
      gridColumn: 2
```

### chart (required for type: chart)
```yaml
chart:
  chartType: column                   # column | bar | line | pie | area
  xAxis:
    property: Name                    # Property to use for X-axis
    label: "Product"

  yAxis:
    property: TotalRevenue            # Property to use for Y-axis
    label: "Revenue"

  height: 400
  legend: true
  tooltip: true
  interactive: true                   # Allow drill-down
```

### styling (optional)
```yaml
styling:
  containerClass: ""                  # Custom CSS classes
  theme: default                      # light | dark | default
  customCss: |
    .product-grid { margin: 20px; }
```

## Example: Complete Grid Spec

```yaml
metadata:
  name: ProductSalesGrid
  description: "Display top selling products by category"
  type: grid
  version: "1.0"

routing:
  page: /dashboard/products
  title: "Product Sales"
  requiresAuth: false

view:
  name: ProductSalesView
  parameters:
    TopN: 50

grid:
  allowFiltering: true
  allowSorting: true
  allowPaging: true
  pageSize: 20

  columns:
    - property: Name
      title: "Product"
      sortable: true
      filterable: true

    - property: Price
      title: "Price"
      format: "{0:C}"
      sortable: true

    - property: CategoryName
      title: "Category"
      sortable: true

    - property: TotalSold
      title: "Units Sold"
      sortable: true
      textAlign: right

    - property: TotalRevenue
      title: "Total Revenue"
      format: "{0:C}"
      textAlign: right

  actions:
    - name: Edit
      icon: edit
      route: /products/{Id}
```

## Complete Schema Reference

See detailed property descriptions above for all supported options.
```

---

## Phase 3B: Implementation Patterns & Templates

### 3B.1 Template: Grid Component

**File:** `specs/templates/grid-template.razor`

This is the reference implementation that all grid specs should follow:

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
    public string Route { get; set; } = "{RouteFromSpec}";

    private IEnumerable<{ViewModelType}>? gridData;
    private bool isLoading = true;
    private string? errorMessage;
    private RadzenDataGrid<{ViewModelType}>? grid;

    // Grid configuration from spec
    private bool allowFiltering = {AllowFiltering};
    private bool allowSorting = {AllowSorting};
    private bool allowPaging = {AllowPaging};
    private int pageSize = {PageSize};
    private string gridHeight = "{GridHeight}";

    // Filter parameters (if spec includes parameters)
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

            // Build parameters object from spec defaults + filter values
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
```

**How LLM Uses This Template:**

1. Replace `{ComponentName}` with metadata.name
2. Replace `{Route}` with routing.page
3. Replace `{Title}` with routing.title
4. Replace `{ViewModelType}` with the generated class name from views.yaml
5. Generate `<RadzenDataGridColumn>` entries for each column in spec
6. Generate parameter binding code for each parameter
7. Replace placeholders with spec values

### 3B.2 Template: Form Component

**File:** `specs/templates/form-template.razor`

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
    public string Route { get; set; } = "{RouteFromSpec}";

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
}
```

### 3B.3 Template: Dashboard Component

**File:** `specs/templates/dashboard-template.razor`

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
                    @if (section.ComponentType == typeof(ProductSalesGrid))
                    {
                        <ProductSalesGrid />
                    }
                </RadzenCard>
            </div>
        }
    </div>
</RadzenStack>

@code {
    [Parameter]
    public string Route { get; set; } = "{RouteFromSpec}";

    private List<DashboardSection> sections = new();

    protected override void OnInitialized()
    {
        Logger.LogInformation("Dashboard initialized");
        // Initialize sections based on spec
    }

    private class DashboardSection
    {
        public string Title { get; set; } = string.Empty;
        public string ComponentName { get; set; } = string.Empty;
        public Type ComponentType { get; set; } = typeof(object);
        public int Span { get; set; } = 1;
        public string Height { get; set; } = "400px";
    }
}
```

---

## Phase 3C: Reference Specs & Examples

### 3C.1 Example 1: Simple Grid

**File:** `specs/examples/ProductSalesGrid.yaml`

```yaml
metadata:
  name: ProductSalesGrid
  description: "Display top selling products by category"
  type: grid
  version: "1.0"

routing:
  page: /dashboard/products
  title: "Product Sales Dashboard"
  requiresAuth: false

view:
  name: ProductSalesView
  parameters:
    TopN: 50

grid:
  allowFiltering: true
  allowSorting: true
  allowPaging: true
  pageSize: 20
  height: "600px"
  striped: true
  border: true

  columns:
    - property: Name
      title: "Product"
      type: string
      sortable: true
      filterable: true
      width: 200

    - property: Price
      title: "Unit Price"
      type: decimal
      format: "{0:C}"
      sortable: true
      textAlign: right
      width: 120

    - property: CategoryName
      title: "Category"
      type: string
      sortable: true
      filterable: true

    - property: TotalSold
      title: "Units Sold"
      type: int
      sortable: true
      textAlign: right
      width: 100

    - property: TotalRevenue
      title: "Total Revenue"
      type: decimal
      format: "{0:C}"
      sortable: true
      textAlign: right
      width: 150

  actions:
    - name: Edit
      icon: edit
      route: /products/{Id}
      enabled: true
```

### 3C.2 Example 2: Grid with Filter Panel

**File:** `specs/examples/FilteredProductGrid.yaml`

```yaml
metadata:
  name: FilteredProductGrid
  description: "Products with category filter"
  type: grid
  version: "1.0"

routing:
  page: /products
  title: "Products"

view:
  name: ProductSalesView
  parameters:
    TopN: 50
    CategoryId: null

parameters:
  - name: TopN
    type: int
    label: "Show Top N"
    default: 50
    control: number-input
    gridColumn: 1

  - name: CategoryId
    type: int?
    label: "Category Filter"
    default: null
    control: dropdown
    gridColumn: 1
    dataSource: Categories
    valueProperty: Id
    textProperty: Name

grid:
  allowFiltering: true
  allowSorting: true
  allowPaging: true
  pageSize: 20

  columns:
    - property: Name
      title: "Product"
      sortable: true

    - property: CategoryName
      title: "Category"
      sortable: true

    - property: Price
      title: "Price"
      format: "{0:C}"

    - property: TotalRevenue
      title: "Revenue"
      format: "{0:C}"
```

### 3C.3 Example 3: Dashboard with Multiple Components

**File:** `specs/examples/ExecutiveDashboard.yaml`

```yaml
metadata:
  name: ExecutiveDashboard
  description: "Executive summary dashboard"
  type: dashboard
  version: "1.0"

routing:
  page: /dashboard
  title: "Executive Dashboard"
  requiresAuth: true

dashboard:
  layout: 3-column
  spacing: normal

  sections:
    - title: "Top Products"
      component: ProductSalesGrid
      span: 2
      height: 400

    - title: "Filters"
      component: ProductFilters
      span: 1
      height: auto

    - title: "Revenue Chart"
      component: RevenueChart
      span: 2
      height: 350

    - title: "Key Metrics"
      component: MetricsSummary
      span: 1
      height: 350
```

---

## Phase 3D: SKILLS.md Integration

### 3D.1 New Skill: Build Component from Spec

**File:** `SKILLS.md` - Add new section

```markdown
## Building Blazor Components from Specs

This skill enables you to implement `.razor` components from YAML specifications, leveraging Phase 2's view models and services. This is not auto-generation—it's guided, templated implementation where humans write specs and LLMs implement consistent patterns.

### Overview

1. Human developer writes a `.yaml` spec file in `specs/` directory
2. Spec describes structure (grid, form, dashboard, etc.) and data bindings
3. You implement a `.razor` component following the corresponding template pattern
4. Result is type-safe, data-bound, reusable UI component

### Spec Format

See `specs/SPEC_FORMAT.md` for complete schema. Key concepts:

- **metadata**: Component name, type, description
- **routing**: Page route, title, auth requirements
- **view**: Which view model to load data from (from Phase 2)
- **parameters**: Filter/input parameters passed to view
- **grid/form/dashboard**: Component-specific configuration
- **columns/fields**: Data display configuration

### Implementation Process

**Step 1: Read the Spec**
- Open the provided `.yaml` file from `specs/` directory
- Note: metadata.type (grid, form, dashboard, etc.)
- Note: view.name (the view model to consume)
- Note: view.parameters (what data to pass to IViewService)

**Step 2: Determine Component Type**
- `type: grid` → Use `specs/templates/grid-template.razor`
- `type: form` → Use `specs/templates/form-template.razor`
- `type: dashboard` → Use `specs/templates/dashboard-template.razor`
- `type: filter-panel` → Custom form-based component
- `type: chart` → Radzen chart component

**Step 3: Create Component File**
- Location: `Components/Pages/{ComponentName}.razor` (for page components)
- Location: `Components/Sections/{ComponentName}.razor` (for reusable sections)
- PascalCase filename matching metadata.name

**Step 4: Implement Using Template**
- Copy corresponding template from `specs/templates/`
- Replace placeholders:
  - `{ComponentName}` → metadata.name
  - `{Route}` → routing.page
  - `{Title}` → routing.title
  - `{ViewName}` → view.name
  - `{ViewModelType}` → Generated class name (e.g., ProductSalesView)
  - `{ViewModelTypeParameters}` → Generated parameters class (e.g., ProductSalesViewParameters)

**Step 5: Generate Column/Field Configuration**
For each column/field in spec:
- Create `<RadzenDataGridColumn>` or form field
- Set property bindings from spec
- Apply formatting/validation from spec
- Use data types from spec

**Step 6: Bind View Parameters**
In the `LoadDataAsync()` method:
- Create new instance of {ViewModelTypeParameters}
- Bind each property from spec.view.parameters or filter values
- Pass to ViewService.ExecuteViewAsync<T>()

**Step 7: Handle Loading/Error/Empty States**
- Show `<RadzenProgressBar>` while isLoading
- Show `<RadzenAlert AlertStyle.Danger>` if errorMessage
- Show "No data" message if empty result set

### Common Patterns

#### Pattern: Grid with No Parameters
```csharp
var gridData = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    null);
```

#### Pattern: Grid with View Parameters
```csharp
var parameters = new ProductSalesViewParameters
{
    TopN = 50
};
var gridData = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    parameters);
```

#### Pattern: Grid with User Input Parameters
```csharp
var parameters = new ProductSalesViewParameters
{
    TopN = (int)(filterValues["TopN"] ?? 50)
};
var gridData = await ViewService.ExecuteViewAsync<ProductSalesView>(
    "ProductSalesView",
    parameters);
```

#### Pattern: Single Record Load
```csharp
var formData = await ViewService.ExecuteViewSingleAsync<ProductSalesView>(
    "ProductSalesView",
    new { TopN = 1 });
```

#### Pattern: Data Grid Column Configuration
Each spec column generates code like:
```razor
<RadzenDataGridColumn TItem="ProductSalesView"
                     Property="Name"
                     Title="Product"
                     Sortable="true"
                     Filterable="true" />
```

With formatting:
```razor
<RadzenDataGridColumn TItem="ProductSalesView"
                     Property="Price"
                     Title="Unit Price"
                     FormatString="{0:C}"
                     TextAlign="TextAlign.Right" />
```

#### Pattern: Form EditForm
```razor
<EditForm Model="@formData" OnValidSubmit="@OnSubmit">
    <DataAnnotationsValidator />

    <!-- Fields here -->

    <RadzenButton ButtonType="ButtonType.Submit" Text="Save" />
</EditForm>
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
- User's X-Customer-Schema header is applied
- Dapper queries execute against correct schema
- No component code changes required

**Example SQL view with acme schema:**
```sql
SELECT
    p.Id,
    p.Name,
    p.Price
FROM [acme].[Products] p
LEFT JOIN [acme].[Categories] c ON p.CategoryId = c.Id
```

### Navigation & Routing

For action buttons with routes:
```yaml
actions:
  - name: Edit
    icon: edit
    route: /products/{Id}
```

Generates code:
```csharp
public string ResolveRoute(object record)
{
    var result = "/products/{Id}";
    foreach (var prop in record.GetType().GetProperties())
    {
        result = result.Replace($"{{{prop.Name}}}",
                               prop.GetValue(record)?.ToString() ?? "");
    }
    return result;
}
```

Then call: `Navigation.NavigateTo(action.ResolveRoute(record))`

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

### Tips for LLM Implementation

1. **Always read the spec file first** - It's your source of truth
2. **Match property names exactly** - PropertyName in spec must match ViewModel property
3. **Use spec values for all configuration** - Don't add features not in spec
4. **Copy the template, then customize** - Don't build from scratch
5. **Validate data types** - Ensure format strings match property types (e.g., "{0:C}" for decimal)
6. **Handle null/empty explicitly** - Check for null results before binding
7. **Use consistent naming** - Class names, property names, method names follow C# conventions
8. **Log meaningfully** - Include component name and operation being performed

### Example: Full Implementation

Given this spec:
```yaml
metadata:
  name: ProductSalesGrid
  type: grid

routing:
  page: /dashboard/products
  title: "Product Sales"

view:
  name: ProductSalesView
  parameters:
    TopN: 50

grid:
  allowPaging: true
  pageSize: 20
  columns:
    - property: Name
      title: "Product"
    - property: Price
      title: "Price"
      format: "{0:C}"
```

Implementation steps:
1. Create `Components/Pages/ProductSalesGrid.razor`
2. Copy grid-template.razor content
3. Replace {ComponentName} with ProductSalesGrid
4. Replace {Title} with "Product Sales"
5. Replace {ViewName} with "ProductSalesView"
6. Replace {ViewModelType} with ProductSalesView
7. Generate columns based on spec
8. Set pageSize = 20, allowPaging = true
9. Build view parameters: `TopN = 50`
10. Test component loads and displays data

That's it. The template handles all the boilerplate.
```

---

## Phase 3E: Step-by-Step Implementation Plan

### Step 1: Create Spec Format Documentation (Day 1)

**Deliverable:** `specs/SPEC_FORMAT.md`

- [ ] Write complete YAML schema
- [ ] Include all component types
- [ ] Provide full property documentation
- [ ] Add constraint/validation descriptions
- [ ] Create example specs in SPEC_FORMAT.md

**Files to create:**
- `specs/SPEC_FORMAT.md`

---

### Step 2: Create Component Templates (Days 2-3)

**Deliverable:** Razor templates for grid, form, dashboard

- [ ] Create `specs/templates/` directory
- [ ] Implement grid-template.razor
- [ ] Implement form-template.razor
- [ ] Implement dashboard-template.razor
- [ ] Document placeholder names
- [ ] Test templates compile

**Files to create:**
- `specs/templates/grid-template.razor`
- `specs/templates/form-template.razor`
- `specs/templates/dashboard-template.razor`
- `specs/templates/README.md` (template usage guide)

---

### Step 3: Create Reference Spec Examples (Day 4)

**Deliverable:** Example YAML specs showing different patterns

- [ ] Create `specs/examples/` directory
- [ ] ProductSalesGrid.yaml (simple grid)
- [ ] FilteredProductGrid.yaml (grid with parameters)
- [ ] ProductForm.yaml (single record form)
- [ ] ExecutiveDashboard.yaml (multi-component dashboard)
- [ ] Validate specs against schema

**Files to create:**
- `specs/examples/ProductSalesGrid.yaml`
- `specs/examples/FilteredProductGrid.yaml`
- `specs/examples/ProductForm.yaml`
- `specs/examples/ExecutiveDashboard.yaml`

---

### Step 4: Update SKILLS.md (Day 5)

**Deliverable:** New skill section for building components from specs

- [ ] Add "Building Blazor Components from Specs" section
- [ ] Document spec format overview
- [ ] Provide implementation checklist
- [ ] Include common patterns
- [ ] Add validation/error handling guide
- [ ] Create examples showing full implementations

**Files to update:**
- `SKILLS.md` - Add new major section

---

### Step 5: Create Reference Component Implementations (Days 6-7)

**Deliverable:** Working example components built from specs

Using the examples from Step 3, create actual working components:

- [ ] Create ProductSalesGrid.razor from ProductSalesGrid.yaml
- [ ] Create FilteredProductGrid.razor from FilteredProductGrid.yaml
- [ ] Create ProductForm.razor from ProductForm.yaml
- [ ] Create ExecutiveDashboard.razor from ExecutiveDashboard.yaml
- [ ] Verify all components load without errors
- [ ] Test data binding and navigation

**Files to create:**
- `Components/Pages/ProductSalesGrid.razor`
- `Components/Pages/FilteredProductGrid.razor`
- `Components/Pages/ProductForm.razor`
- `Components/Pages/ExecutiveDashboard.razor`

---

### Step 6: Update NavMenu Navigation (Day 8)

**Deliverable:** Navigation links to new example components

- [ ] Add example components to NavMenu.razor
- [ ] Create "Dashboard" menu section
- [ ] Create "Examples" submenu
- [ ] Test navigation links work
- [ ] Verify pages are routable

**Files to update:**
- `Components/Shared/NavMenu.razor`

---

### Step 7: Create Unit Tests (Days 9-10)

**Deliverable:** Test suite for spec validation and component behavior

Create test project at `tests/DotNetWebApp.Tests/Specs/`

**Unit Tests:**

```csharp
// SpecValidationTests.cs
[Fact]
public void SpecSchema_ValidatesProductSalesGrid()
{
    // Load ProductSalesGrid.yaml
    // Deserialize as ViewsDefinition or SpecDefinition
    // Assert: metadata.name == "ProductSalesGrid"
    // Assert: view.name == "ProductSalesView"
    // Assert: grid.columns.Count > 0
}

[Fact]
public void SpecSchema_AllColumnsMapToViewModelProperties()
{
    // Load spec
    // Get ViewModel type reflection
    // Assert each column.property exists on ViewModel
    // Assert column.type matches property type
}

// ComponentIntegrationTests.cs
[Fact]
public async Task ProductSalesGrid_LoadsDataFromViewService()
{
    // Create component with mocked IViewService
    // Mock ViewService.ExecuteViewAsync to return test data
    // Render component
    // Assert data appears in grid
}
```

**Files to create:**
- `tests/DotNetWebApp.Tests/Specs/SpecValidationTests.cs`
- `tests/DotNetWebApp.Tests/Specs/ComponentIntegrationTests.cs`

**Run:** `make test`

---

### Step 8: Create Documentation & Guides (Day 10)

**Deliverable:** README and guides for using Phase 3

- [ ] Create `specs/README.md` - Overview and quick start
- [ ] Create `specs/IMPLEMENTATION_GUIDE.md` - Step-by-step for new specs
- [ ] Update project `README.md` with Phase 3 section
- [ ] Create `PHASE3_COMPLETE.md` - Summary of Phase 3

**Files to create/update:**
- `specs/README.md`
- `specs/IMPLEMENTATION_GUIDE.md`
- `README.md` (add Phase 3 section)

---

## Phase 3F: Detailed Implementation Guidelines

### Component File Locations

| Component Type | Location | Routable? |
|---|---|---|
| Page (grid, form, dashboard) | `Components/Pages/{Name}.razor` | Yes (@page directive) |
| Reusable Section | `Components/Sections/{Name}.razor` | No |
| Shared Sub-component | `Components/Shared/{Name}.razor` | No |

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
            // Bind from spec.view.parameters
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

For each spec column, generate:
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

If spec.parameters exist:
1. Create filter panel UI (RadzenNumeric, RadzenDropdown, etc.)
2. Bind inputs to filterValues dictionary
3. In OnApplyFilters, rebuild parameters object
4. Call LoadDataAsync again

### Action Button Resolution

For spec actions with {Id} placeholders:
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

#### 1. Spec Schema Validation Tests
- Ensure YAML deserializes correctly
- Validate required fields present
- Validate column properties match ViewModel
- Validate view names exist in views.yaml

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

### Documentation
- [ ] `specs/SPEC_FORMAT.md` created with complete schema
- [ ] `specs/README.md` created with overview
- [ ] `specs/IMPLEMENTATION_GUIDE.md` created
- [ ] `specs/templates/README.md` created
- [ ] `PHASE3_VIEW_UI.md` updated with completion notes

### Templates
- [ ] `specs/templates/grid-template.razor` created
- [ ] `specs/templates/form-template.razor` created
- [ ] `specs/templates/dashboard-template.razor` created
- [ ] All templates compile without errors
- [ ] All placeholder names documented

### Example Specs
- [ ] `specs/examples/ProductSalesGrid.yaml` created
- [ ] `specs/examples/FilteredProductGrid.yaml` created
- [ ] `specs/examples/ProductForm.yaml` created
- [ ] `specs/examples/ExecutiveDashboard.yaml` created
- [ ] All specs validate against schema

### Reference Components
- [ ] `Components/Pages/ProductSalesGrid.razor` created
- [ ] `Components/Pages/FilteredProductGrid.razor` created
- [ ] `Components/Pages/ProductForm.razor` created
- [ ] `Components/Pages/ExecutiveDashboard.razor` created
- [ ] All components render and load data correctly
- [ ] Navigation links work

### SKILLS.md
- [ ] "Building Blazor Components from Specs" section added
- [ ] Spec format overview included
- [ ] Implementation process documented
- [ ] Common patterns documented
- [ ] Full example implementation shown
- [ ] Validation checklist provided

### Tests
- [ ] `tests/DotNetWebApp.Tests/Specs/SpecValidationTests.cs` created
- [ ] `tests/DotNetWebApp.Tests/Specs/ComponentIntegrationTests.cs` created
- [ ] All tests pass: `make test`
- [ ] Test coverage for spec validation
- [ ] Test coverage for component rendering

### Navigation
- [ ] `Components/Shared/NavMenu.razor` updated
- [ ] Dashboard section added to menu
- [ ] Example components linked in menu
- [ ] All navigation links work

### Code Quality
- [ ] No compiler warnings or errors
- [ ] Consistent code style (indentation, naming)
- [ ] Proper error handling in all components
- [ ] Logging in all async operations
- [ ] Comments on complex logic

---

## Phase 3 Success Criteria

After Phase 3 completion:

✅ Developers can write YAML specs describing UI layouts
✅ LLMs can read specs and implement consistent component patterns
✅ Human + LLM collaboration is efficient (spec → implementation)
✅ Components are type-safe (use generated ViewModels)
✅ Data binding is automatic (IViewService + parameter binding)
✅ Multi-tenant support works automatically
✅ All components follow consistent patterns
✅ New components can be added without boilerplate

---

## Next Steps After Phase 3

1. **Build domain-specific specs** for your actual use cases
2. **Create more view models** in Phase 2 as needed
3. **Extend SKILLS.md** with additional component patterns (charts, drilldown, etc.)
4. **Automate spec→component generation** (future: Spec.yaml → ComponentName.razor generation)
5. **Build spec validator CLI** to catch errors before implementation

---

## Key Dependencies

**Phase 3 requires:**
- ✅ Phase 1: IEntityOperationService (CRUD operations)
- ✅ Phase 2: IViewService + ViewModels (data access)
- ✅ Existing: Radzen components (UI library)
- ✅ Existing: Blazor Server (runtime)

**Phase 3 provides for future phases:**
- Spec format for describing UI
- Template-based implementation patterns
- SKILLS.md integration for LLM guidance
- Foundation for automation (spec validation, generation)

---

**End of Phase 3 Implementation Plan**
