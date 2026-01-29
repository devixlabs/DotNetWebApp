# Phase 4: Editable View Components & UI-Driven Architecture

**Status:** PLANNING PHASE - REVISED (2026-01-27)
**Last Updated:** 2026-01-28 (Updated for multi-app architecture, IEntityOperationService status)
**Duration:** 1-2 weeks (hybrid approach reduces complexity)
**Priority:** MEDIUM (enables advanced CRUD patterns for complex views)
**Prerequisite:** Phase 2 (View Pipeline) must be complete
**Approach:** HYBRID - Reusable components + optional YAML config (see "REVISED APPROACH" section)

---

## ⚠️ IMPORTANT - Pre-Implementation Context (2026-01-28)

### Multi-App Architecture Now Active
This project uses **multi-app architecture** with `apps.yaml`. Before implementing Phase 4:
- Views are **app-scoped**: `IViewRegistry.GetViewsForApplication(appName)`
- Entities are **app-scoped**: `IEntityMetadataService.GetEntitiesForApplication(appName)`
- Routes are **app-prefixed**: `/{appName}/...` (e.g., `/admin/dashboard`)
- See `MULTI_APP_IMPLEMENTATION_SUMMARY.md` for full details

### Current State of Key Components

| Component | Status | Location | Notes |
|-----------|--------|----------|-------|
| `IEntityOperationService` | ✅ COMPLETE | `Services/IEntityOperationService.cs` | Full CRUD: GetAll, GetById, Create, Update, Delete |
| `EntityOperationService` | ✅ COMPLETE | `Services/EntityOperationService.cs` | Compiled delegates for performance |
| `DynamicDataGrid.razor` | ✅ EXISTS (Read-only) | `Shared/DynamicDataGrid.razor` | Reflection-based grid, NO edit capabilities |
| `EntitySection.razor` | ✅ EXISTS (Read-only) | `Components/Sections/EntitySection.razor` | Uses DynamicDataGrid |
| `IViewService` | ✅ COMPLETE | `Services/Views/IViewService.cs` | ExecuteViewAsync, ExecuteViewSingleAsync |
| `ViewDefinition.cs` | ⚠️ NEEDS EXTENSION | `Models/AppDictionary/ViewDefinition.cs` | Missing Phase 4 UI metadata classes |
| `SmartDataGrid<T>` | ❌ NOT STARTED | N/A | This is what Phase 4 implements |
| `ColumnConfig` | ❌ NOT STARTED | N/A | This is what Phase 4 implements |

### IEntityOperationService Interface (Already Available)
```csharp
public interface IEntityOperationService
{
    Task<IList> GetAllAsync(Type entityType, CancellationToken ct = default);
    Task<int> GetCountAsync(Type entityType, CancellationToken ct = default);
    Task<object> CreateAsync(Type entityType, object entity, CancellationToken ct = default);
    Task<object?> GetByIdAsync(Type entityType, object id, CancellationToken ct = default);
    Task<object> UpdateAsync(Type entityType, object entity, CancellationToken ct = default);
    Task DeleteAsync(Type entityType, object id, CancellationToken ct = default);
}
```

---

## Overview

Phase 4 extends the SQL-first view pipeline with UI/UX metadata capabilities. This enables developers to:

1. Define which columns in a view are **read-only** vs. **editable**
2. Specify which **database table** editable columns map to
3. Auto-generate Blazor components that render smart data grids with:
   - Read-only columns (non-editable display)
   - Editable columns (form inputs with validation)
   - Automatic write operations to appropriate tables
4. Support complex dashboards with **mixed read-write patterns**:
   - Example: View joins Company (read-only) + User (read-only) + Product (editable)
   - UI automatically handles row updates to correct table

## Architecture Vision

```
PHASE 2 (Read-Only Views - COMPLETE)
SQL SELECT → views.yaml → ViewModels/*.cs → IViewService (read)

PHASE 4 (Editable Views - PLANNING)
views.yaml + UI metadata → Enhanced ViewModels → Smart Blazor Components
                        ↓
              Knows which columns are writable
              Knows which table to update
              Validates permissions & business rules
              ↓
          Calls IEntityOperationService (writes) + IViewService (reads)
```

---

## Design Principles

### 1. UI Metadata in YAML (Not C# Code)

Developers define UI/UX decisions in `views.yaml`, not hardcoded in Blazor components:

```yaml
properties:
  - name: ProductPrice
    type: decimal
    ui:
      editable: true      # ← UI metadata
      data_type: "number"
      step: 0.01
```

**Benefits:**
- Non-developers can modify UI behavior without touching C#
- UI metadata regenerated with view models (always in sync)
- Reusable across multiple components

### 2. Partial Class Pattern for Component Extensions

Generated view models are data contracts. Custom Blazor components extend them:

```csharp
// Generated: ProductDashboard.generated.cs (overwritten on regen)
public partial class ProductDashboard
{
    public string CompanyName { get; set; } = null!;
    public decimal ProductPrice { get; set; }
}

// User maintains: ProductDashboard.cs (never overwritten)
public partial class ProductDashboard
{
    // Custom computed properties for UI
    public string FormattedPrice => ProductPrice.ToString("C");

    // Validation logic
    public bool IsPriceValid => ProductPrice > 0 && ProductPrice < 10000;
}
```

### 3. Metadata Classes Auto-Generated

ViewModelGenerator creates metadata classes describing writability:

```csharp
// Generated: ProductDashboardMetadata.cs
public static class ProductDashboardMetadata
{
    public static ViewMetadata GetMetadata() => new ViewMetadata
    {
        Title = "Product Dashboard",
        Icon = "dashboard",
        RefreshIntervalMs = 5000,
        WritableSources = new[]
        {
            new WritableSource
            {
                Table = "Products",
                KeyColumn = "ProductId",
                ColumnsToUpdate = new[] { "ProductPrice" },
                Operation = "update"
            }
        }
    };
}
```

Blazor components use this metadata to determine which columns allow editing.

---

## Step 1: Extend views.yaml Schema (Day 1)

### 1.1 Define UI Metadata Structure

Add new optional fields to existing views.yaml:

```yaml
views:
  - name: CompanyProductDashboard
    description: "Company info + editable product pricing"
    sql_file: "sql/views/CompanyProductDashboard.sql"

    # NEW: UI/UX configuration
    ui_hints:
      title: "Company Dashboard"                  # Display title
      icon: "dashboard"                           # Radzen icon name
      refresh_interval_ms: 5000                   # Auto-refresh interval
      allow_inline_edit: true                     # Enable cell-level editing
      show_action_column: true                    # Show Edit/Delete buttons

    # Parameters (existing, no change)
    parameters:
      - name: CompanyId
        type: int
        nullable: false
        default: "1"

    # NEW: Define which columns are editable and where they write to
    properties:
      - name: CompanyId
        type: int
        nullable: false
        ui:
          editable: false
          hidden: false
          display_name: "Company ID"
          sortable: true
          filterable: true

      - name: CompanyName
        type: string
        nullable: false
        max_length: 100
        ui:
          editable: false
          hidden: false
          display_name: "Company"
          sortable: true
          filterable: true

      - name: ProductId
        type: int
        nullable: false
        ui:
          editable: false
          hidden: false
          display_name: "Product ID"
          sortable: true
          filterable: false

      - name: ProductName
        type: string
        nullable: false
        max_length: 100
        ui:
          editable: false
          hidden: false
          display_name: "Product Name"
          sortable: true
          filterable: true

      - name: ProductPrice                        # ← EDITABLE COLUMN
        type: decimal
        nullable: false
        ui:
          editable: true                          # Can be edited inline
          hidden: false
          display_name: "Price"
          sortable: true
          filterable: false
          data_type: "decimal"                    # Numeric input
          step: 0.01                              # Increment step
          min: 0.01
          max: 99999.99

    # NEW: Describes write operations
    writable_sources:
      - name: "ProductPrice"                      # Property name in DTO
        table: "Products"                         # Target table
        key_column: "ProductId"                   # Primary key column
        columns_to_update:
          - "Price"                               # Actual table column
        operation: "update"                       # update, insert, or delete
        requires_permission: "products:write"     # Optional authorization
```

### 1.2 Complex Multi-Write Example

A view with multiple writable tables:

```yaml
views:
  - name: OrderManagementDashboard
    description: "Orders + Customers + line items"
    sql_file: "sql/views/OrderManagementDashboard.sql"

    writable_sources:
      # Customers table updates
      - name: "CustomerName"
        table: "Customers"
        key_column: "CustomerId"
        columns_to_update: ["Name"]
        operation: "update"

      # OrderDetails table updates (quantity)
      - name: "LineItemQuantity"
        table: "OrderDetails"
        key_column: "OrderDetailId"
        columns_to_update: ["Quantity"]
        operation: "update"

      # Orders table soft-delete
      - name: "IsDeleted"
        table: "Orders"
        key_column: "OrderId"
        columns_to_update: ["DeletedAt", "Status"]
        operation: "delete"
        soft_delete: true
```

**Deliverable:** Extended views.yaml schema documentation

---

## Step 2: Extend ViewDefinition YAML Models (Day 1)

### 2.1 Add New C# Classes to ViewDefinition.cs

**File:** `DotNetWebApp.Models/AppDictionary/ViewDefinition.cs` (add to existing)

> **⚠️ Note (2026-01-28):** `ViewDefinition.cs` already exists with basic Phase 2 classes (ViewDefinition, ViewParameter, ViewProperty, ValidationConfig). The classes below are **additions** for Phase 4 UI metadata support.

```csharp
// ============================================================
// ALREADY EXISTS in ViewDefinition.cs (from Phase 2)
// ============================================================
public class ViewDefinition
{
    public string Name { get; set; }
    public string Description { get; set; }
    [YamlMember(Alias = "sql_file")]
    public string SqlFile { get; set; }
    [YamlMember(Alias = "generate_partial")]
    public bool GeneratePartial { get; set; } = true;
    public List<ViewParameter>? Parameters { get; set; }
    public List<ViewProperty> Properties { get; set; } = new();

    // ============================================================
    // NEW: Add these properties for Phase 4 UI metadata
    // ============================================================
    [YamlMember(Alias = "ui_hints")]
    public UiHints? UiHints { get; set; }
    [YamlMember(Alias = "writable_sources")]
    public List<WritableSource>? WritableSources { get; set; }
}

// NEW: UI presentation hints
public class UiHints
{
    public string? Title { get; set; }
    public string? Icon { get; set; }
    public int RefreshIntervalMs { get; set; } = 5000;
    public bool AllowInlineEdit { get; set; } = false;
    public bool ShowActionColumn { get; set; } = true;
    public string? CssClass { get; set; }
}

// NEW: Property-level UI configuration
public class UiMetadata
{
    public bool Editable { get; set; } = false;
    public bool Hidden { get; set; } = false;
    public string? DisplayName { get; set; }
    public bool Sortable { get; set; } = true;
    public bool Filterable { get; set; } = true;

    // For editable columns
    public string? DataType { get; set; }        // "text", "number", "date", "checkbox", etc.
    public string? Step { get; set; }            // For numeric inputs
    public string? Min { get; set; }
    public string? Max { get; set; }
    public string? Pattern { get; set; }         // Regex validation
    public string? Placeholder { get; set; }
}

// NEW: Describes a column that maps to a writable table
public class WritableSource
{
    public string Name { get; set; } = null!;           // Property name in DTO
    public string Table { get; set; } = null!;          // Target table
    public string KeyColumn { get; set; } = null!;      // Primary key in table
    public List<string> ColumnsToUpdate { get; set; } = new();
    public string Operation { get; set; } = "update";   // update, insert, delete
    public bool SoftDelete { get; set; } = false;       // For logical deletes
    public string? RequiresPermission { get; set; }     // Authorization check
}

// NEW: View-level metadata (mirrors WritableSource but at view level)
public class ViewMetadata
{
    public string Title { get; set; } = null!;
    public string? Icon { get; set; }
    public int RefreshIntervalMs { get; set; } = 5000;
    public WritableSource[] WritableSources { get; set; } = Array.Empty<WritableSource>();
}
```

**Deliverable:** Extended ViewDefinition.cs with Phase 4 support

---

## Step 3: Update ViewModelGenerator Template (Days 2-3)

### 3.1 Extend ViewModelTemplate.scriban

**File:** `ModelGenerator/ViewModelTemplate.scriban` (add sections)

```scriban
{{! NEW: Include UI metadata attributes on properties }}

{{~ for property in View.Properties ~}}

{{! Read-only indicator }}
{{~ if property.Ui?.Editable == false ~}}
/// <remarks>Read-only field (not editable in UI)</remarks>
{{~ else if property.Ui?.Editable == true ~}}
/// <remarks>Editable field in UI</remarks>
{{~ end ~}}

{{! Generate attributes based on editability }}
{{~ if property.Ui?.Editable == true ~}}
[Editable]
{{~ else ~}}
[ReadOnly(true)]
{{~ end ~}}

{{~ if property.Ui?.Hidden == true ~}}
[Hidden]
{{~ end ~}}

public {{ property.Type }}{{ if property.Nullable }}?{{ end }} {{ property.Name }} { get; set; }}

{{~ end ~}}

{{! NEW: Generate metadata class }}

/// <summary>
/// Metadata for {{ View.Name }} - describes editability, permissions, and write targets
/// </summary>
public static class {{ View.Name }}Metadata
{
    public static ViewMetadata GetMetadata() => new ViewMetadata
    {
        Title = "{{ View.UiHints?.Title ?? View.Name }}",
        Icon = "{{ View.UiHints?.Icon ?? "table" }}",
        RefreshIntervalMs = {{ View.UiHints?.RefreshIntervalMs ?? 5000 }},
        WritableSources = new[]
        {
            {{~ for source in View.WritableSources ~}}
            new WritableSource
            {
                Name = "{{ source.Name }}",
                Table = "{{ source.Table }}",
                KeyColumn = "{{ source.KeyColumn }}",
                ColumnsToUpdate = new[] { {{ for col in source.ColumnsToUpdate }}"{{ col }}"{{ if !for.last }}, {{ end }}{{ end }} },
                Operation = "{{ source.Operation }}",
                SoftDelete = {{ source.SoftDelete | string.downcase }},
                RequiresPermission = {{ source.RequiresPermission ? ("\"" + source.RequiresPermission + "\"") : "null" }}
            },
            {{~ end ~}}
        }
    };

    {{! Helper method to check if property is writable }}
    public static bool IsPropertyWritable(string propertyName)
    {
        var metadata = GetMetadata();
        return metadata.WritableSources.Any(ws => ws.Name == propertyName);
    }

    {{! Helper method to get write target for a property }}
    public static WritableSource? GetWriteTarget(string propertyName)
    {
        var metadata = GetMetadata();
        return metadata.WritableSources.FirstOrDefault(ws => ws.Name == propertyName);
    }
}
```

### 3.2 Example Generated Output

After running `make run-view-pipeline` with extended views.yaml:

```csharp
// Generated: ProductDashboard.generated.cs (auto-generated 2026-01-27)

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Models.ViewModels
{
    public partial class ProductDashboard
    {
        [ReadOnly(true)]
        public int CompanyId { get; set; }

        [ReadOnly(true)]
        [MaxLength(100)]
        public string CompanyName { get; set; } = null!;

        [ReadOnly(true)]
        public int ProductId { get; set; }

        [ReadOnly(true)]
        [MaxLength(100)]
        public string ProductName { get; set; } = null!;

        [Editable]  // ← This one is writable
        [Range(0.01, 99999.99)]
        public decimal ProductPrice { get; set; }
    }

    /// <summary>
    /// Metadata for ProductDashboard - describes editability and write targets
    /// </summary>
    public static class ProductDashboardMetadata
    {
        public static ViewMetadata GetMetadata() => new ViewMetadata
        {
            Title = "Product Dashboard",
            Icon = "dashboard",
            RefreshIntervalMs = 5000,
            WritableSources = new[]
            {
                new WritableSource
                {
                    Name = "ProductPrice",
                    Table = "Products",
                    KeyColumn = "ProductId",
                    ColumnsToUpdate = new[] { "Price" },
                    Operation = "update",
                    SoftDelete = false,
                    RequiresPermission = null
                }
            }
        };

        public static bool IsPropertyWritable(string propertyName)
        {
            var metadata = GetMetadata();
            return metadata.WritableSources.Any(ws => ws.Name == propertyName);
        }

        public static WritableSource? GetWriteTarget(string propertyName)
        {
            var metadata = GetMetadata();
            return metadata.WritableSources.FirstOrDefault(ws => ws.Name == propertyName);
        }
    }
}
```

**Deliverable:** Updated ViewModelTemplate.scriban + examples of generated metadata

---

## Step 4: Research & Design Blazor Components (Days 4-7)

### 4.1 Required Research Areas

Before implementing, research:

1. **Radzen DataGrid Capabilities**
   - Inline editing modes (cell-level vs. row-level)
   - Column templates for read-only vs. editable
   - Event handling for row updates
   - Validation integration
   - Permission-based column hiding

2. **Blazor Component Patterns**
   - Generic component patterns for metadata-driven rendering
   - Parameter passing for write operations
   - Error handling and user feedback
   - Optimistic vs. pessimistic updates

3. **Finbuckle Multi-Tenant Integration**
   - Ensure writes respect current tenant schema
   - Handle schema qualification in entity operations
   - Test isolation between schemas

### 4.2 Design Questions to Answer

- Should editable columns always be inline-editable, or support row-edit mode?
- How to handle validation errors (show in grid, modal dialog, toast notification)?
- Should permission checks happen in Blazor component or via API/IEntityOperationService?
- How to handle optimistic locking (prevent concurrent updates)?
- Should there be a "Save All" button or auto-save per row?
- How to show unsaved changes indicator?

**Deliverable:** Research summary + design decisions document

---

## Step 5: Implement Smart Blazor Components (Days 8-14)

### 5.1 Generic ViewEditGrid<T> Component

> **Note (2026-01-28):** The existing `DynamicDataGrid.razor` in `Shared/` is read-only and uses reflection. Phase 4 introduces `SmartDataGrid<T>` as a generic, editable replacement. Consider placing it in `Shared/SmartDataGrid.razor`.

Create a reusable component that:

```razor
@* Shared/SmartDataGrid.razor (replaces/enhances DynamicDataGrid) *@
@typeparam T where T : class
@inject IViewService ViewService
@inject IEntityOperationService EntityOperationService
@inject ILogger<ViewEditGrid<T>> Logger

<RadzenDataGrid @ref="grid"
                Data="@Data"
                TItem="T"
                EditMode="DataGridEditMode.Single"
                RowUpdate="@OnUpdateRow"
                RowCreate="@OnCreateRow"
                DeleteRow="@OnDeleteRow"
                AllowFiltering="true"
                AllowSorting="true"
                AllowPaging="true"
                PageSize="20">

    <Columns>
        @* Render columns based on metadata *@
        @foreach (var property in GetPropertyMetadata())
        {
            if (!property.Hidden)
            {
                if (property.Editable)
                {
                    <RadzenDataGridColumn TItem="T" Property="@property.Name"
                                          Title="@property.DisplayName"
                                          EditTemplate="@GetEditTemplate(property)">
                        <Template Context="row">
                            @GetDisplayValue(property, row)
                        </Template>
                    </RadzenDataGridColumn>
                }
                else
                {
                    <RadzenDataGridColumn TItem="T" Property="@property.Name"
                                          Title="@property.DisplayName"
                                          Sortable="@property.Sortable"
                                          Filterable="@property.Filterable" />
                }
            }
        }

        @* Action column for edit/delete *@
        <RadzenDataGridColumn Title="Actions" Sortable="false" Filterable="false" Width="100px">
            <Template Context="row">
                <RadzenButton Icon="edit" Size="ButtonSize.Small" Click="@((args) => grid.EditRow(row))" />
                <RadzenButton Icon="delete" Size="ButtonSize.Small" ButtonStyle="ButtonStyle.Danger"
                              Click="@((args) => grid.DeleteRow(row))" />
            </Template>
        </RadzenDataGridColumn>
    </Columns>
</RadzenDataGrid>

@code {
    [Parameter]
    public IEnumerable<T>? Data { get; set; }

    [Parameter]
    public EventCallback<T> OnSaveAsync { get; set; }

    private RadzenDataGrid<T>? grid;

    private async Task OnUpdateRow(T row)
    {
        // Get metadata for this view
        var metadata = GetViewMetadata();

        // Find which properties were edited
        var changedProperties = GetChangedProperties(row);

        // For each changed property, find its write target
        foreach (var prop in changedProperties)
        {
            var writeTarget = metadata.WritableSources
                .FirstOrDefault(ws => ws.Name == prop.Name);

            if (writeTarget != null)
            {
                // Check permission
                if (writeTarget.RequiresPermission != null &&
                    !UserHasPermission(writeTarget.RequiresPermission))
                {
                    ShowError($"Permission denied: {writeTarget.RequiresPermission}");
                    continue;
                }

                // Call IEntityOperationService to update
                try
                {
                    await EntityOperationService.UpdateAsync(
                        entityName: writeTarget.Table,
                        id: GetKeyValue(row, writeTarget.KeyColumn),
                        values: new { [writeTarget.ColumnsToUpdate[0]] = prop.Value }
                    );

                    Logger.LogInformation("Updated {Table}.{Column} for {KeyColumn}={KeyValue}",
                        writeTarget.Table, writeTarget.ColumnsToUpdate[0],
                        writeTarget.KeyColumn, GetKeyValue(row, writeTarget.KeyColumn));
                }
                catch (Exception ex)
                {
                    Logger.LogError(ex, "Failed to update {Table}", writeTarget.Table);
                    ShowError($"Failed to save: {ex.Message}");
                }
            }
        }

        if (OnSaveAsync.HasDelegate)
        {
            await OnSaveAsync.InvokeAsync(row);
        }
    }

    private async Task OnCreateRow(T row)
    {
        // Similar to OnUpdateRow but for INSERT operations
    }

    private async Task OnDeleteRow(T row)
    {
        // Handle soft-delete or hard-delete based on metadata
    }

    private RenderFragment GetEditTemplate(PropertyMetadata prop)
    {
        // Render appropriate input control based on data_type
        // text → RadzenTextBox
        // number → RadzenNumeric<decimal>
        // date → RadzenDatePicker
        // checkbox → RadzenCheckBox
        // etc.
        return builder => { /* ... */ };
    }

    private List<PropertyMetadata> GetPropertyMetadata()
    {
        // Use reflection + metadata to describe all properties
        return typeof(T).GetProperties()
            .Select(pi => new PropertyMetadata { /* ... */ })
            .ToList();
    }
}
```

### 5.2 Example Usage in a Page

```razor
@* Components/Pages/ProductDashboard.razor *@
@page "/views/product-dashboard"
@inject IViewService ViewService

<h3>Product Dashboard</h3>

<ViewEditGrid T="ProductDashboard" Data="@data" OnSaveAsync="@OnDataSaved" />

@code {
    private IEnumerable<ProductDashboard>? data;

    protected override async Task OnInitializedAsync()
    {
        data = await ViewService.ExecuteViewAsync<ProductDashboard>(
            "CompanyProductDashboard",
            new { CompanyId = 1 }
        );
    }

    private async Task OnDataSaved(ProductDashboard row)
    {
        // Refresh data
        data = await ViewService.ExecuteViewAsync<ProductDashboard>(
            "CompanyProductDashboard",
            new { CompanyId = 1 }
        );
    }
}
```

**Deliverable:** Reusable ViewEditGrid<T> component + example usage pages

---

## Step 6: Add Unit & Integration Tests (Days 15-16)

### 6.1 Test ViewMetadata Generation

```csharp
[Fact]
public void ProductDashboardMetadata_IsPropertyWritable_ReturnsTrueForPrice()
{
    // Arrange & Act
    bool isWritable = ProductDashboardMetadata.IsPropertyWritable("ProductPrice");

    // Assert
    Assert.True(isWritable);
}

[Fact]
public void ProductDashboardMetadata_GetWriteTarget_ReturnsProductTable()
{
    // Arrange & Act
    var target = ProductDashboardMetadata.GetWriteTarget("ProductPrice");

    // Assert
    Assert.NotNull(target);
    Assert.Equal("Products", target.Table);
    Assert.Equal("ProductId", target.KeyColumn);
    Assert.Contains("Price", target.ColumnsToUpdate);
}
```

### 6.2 Test ViewEditGrid Component

```csharp
[Fact]
public async Task ViewEditGrid_OnUpdateRow_CallsEntityOperationService()
{
    // Arrange
    var mockEntityService = new Mock<IEntityOperationService>();
    var component = new ViewEditGrid<ProductDashboard> { /* ... */ };

    // Act
    var row = new ProductDashboard { ProductId = 1, ProductPrice = 99.99m };
    await component.OnUpdateRow(row);

    // Assert
    mockEntityService.Verify(
        x => x.UpdateAsync("Products", 1, It.IsAny<object>()),
        Times.Once
    );
}
```

**Deliverable:** Comprehensive test suite for metadata and components

---

## Implementation Difficulty Assessment

### Original Plan (Heavy YAML)
| Component | Difficulty | Effort | Blocker? |
|-----------|-----------|--------|----------|
| **YAML schema extension** | ✅ Trivial | 1 hour | No |
| **ViewDefinition.cs classes** | ✅ Easy | 1-2 hours | No |
| **ViewModelGenerator template** | ✅ Easy | 2-3 hours | No |
| **Generated metadata classes** | ✅ Easy | 0 hours (automatic) | No |
| **Radzen research** | ⚠️ Moderate | 4-6 hours | No |
| **Generic component design** | ⚠️ Moderate | 4-6 hours | No |
| **ViewEditGrid<T> implementation** | ❌ Hard | 8-12 hours | Yes |
| **Validation/permission integration** | ❌ Hard | 4-6 hours | Yes |
| **Multi-table update logic** | ❌ Hard | 4-6 hours | Yes |
| **Tests + documentation** | ⚠️ Moderate | 4-6 hours | No |

**Original Total Effort:** 2-4 weeks

### Revised Plan (Hybrid Approach) - Updated 2026-01-28
| Component | Difficulty | Effort | Blocker? | Status |
|-----------|-----------|--------|----------|--------|
| **ColumnConfig model** | ✅ Trivial | 30 min | No | ❌ Not started |
| **SmartDataGrid<T> component** | ⚠️ Moderate | 4-6 hours | No | ❌ Not started |
| **INotificationService** | ✅ Easy | 1-2 hours | No | Can use Radzen's built-in |
| **EventCallback wiring** | ✅ Easy | 1-2 hours | No | ❌ Not started |
| **IEntityOperationService integration** | ✅ Easy | 2-3 hours | No | ✅ Service exists, just wire up |
| **Confirmation dialogs** | ✅ Easy | 1-2 hours | No | Use Radzen DialogService |
| **Optional: ViewDefinition.cs extensions** | ✅ Easy | 1-2 hours | No | ❌ Not started |
| **Optional: views.yaml UI metadata** | ⚠️ Moderate | 2-3 hours | No | Can defer |
| **Tests + documentation** | ⚠️ Moderate | 3-4 hours | No | ❌ Not started |

**Revised Total Effort:** 1-2 weeks (no blockers, incremental delivery possible)

> **Note:** IEntityOperationService with full CRUD already exists and has 30+ unit tests. This significantly reduces Phase 4 effort since the service layer is complete.

---

## Success Criteria

### Revised Success Criteria (Hybrid Approach)

After Phase 4 completion:

**Core Components:**
- [ ] `SmartDataGrid<T>` component renders data with configurable columns
- [ ] Action column displays Edit/Delete buttons when enabled
- [ ] Inline editing works via Radzen's built-in EditMode
- [ ] `EventCallback<T>` properly delegates events to parent components

**Write Operations:**
- [ ] `OnRowUpdate` triggers `IEntityOperationService.UpdateAsync()`
- [ ] `OnRowDelete` triggers `IEntityOperationService.DeleteAsync()`
- [ ] Confirmation dialog appears before destructive actions
- [ ] Toast notifications show success/failure feedback

**Configuration (Optional):**
- [ ] `ColumnConfig` model allows display name, format, visibility overrides
- [ ] Components work without YAML config (reflection-based defaults)
- [ ] `ui_config.yaml` can optionally enhance column configuration

**Integration:**
- [ ] EntitySection.razor uses SmartDataGrid instead of DynamicDataGrid
- [ ] Full CRUD flow works end-to-end for existing entities
- [ ] Multi-app architecture respected (entities scoped per app)
- [ ] Multi-tenant schema isolation respected in all operations
- [ ] Test in all three apps: admin (acme schema), reporting (acme schema), metrics (initech schema)

### Original Success Criteria (Heavy YAML - Deferred)

These are retained for reference if heavy YAML automation is needed later:

- Views support mixed read-write patterns via YAML metadata
- Editable properties identified in generated DTOs with `[Editable]` attribute
- ViewMetadata class auto-generated with property writability info
- Multi-table views update correct tables automatically
- Soft-delete supported for logical deletes

---

## REVISED APPROACH: Hybrid Component Library (2026-01-27)

After analyzing the existing codebase patterns (DynamicDataGrid.razor, EntitySection.razor, AsyncUiState pattern) and Radzen's capabilities, **we recommend a Hybrid approach** instead of heavy YAML automation.

### Why Hybrid Over Heavy YAML?

| Factor | Heavy YAML (Original Phase 4) | Hybrid (Recommended) |
|--------|-------------------------------|----------------------|
| **Flexibility** | Limited to YAML schema | Full Radzen access |
| **Debugging** | Hard (generated code) | Easy (readable components) |
| **Non-dev editing** | Yes | Partial (config only) |
| **Radzen features** | Must generate each one | Use directly |
| **Maintenance** | Complex generators | Simple components |
| **Type safety** | Weak | Strong (generics) |
| **Event handling** | Generated boilerplate | Native Radzen events |

**Key Insight:** Radzen already provides `RowUpdate`, `RowCreate`, `EditMode`, inline editing, and validation. Generating these from YAML duplicates work and loses flexibility.

### Recommended Architecture

```
+------------------------------------------------------------------+
|                    YAML Configuration Layer                       |
|   views.yaml + ui_config.yaml (optional metadata hints)          |
+-----------------------------+------------------------------------+
                              | IUiConfigService loads config
                              v
+------------------------------------------------------------------+
|              Reusable Component Library                           |
|   SmartDataGrid<T>  |  EntityForm<T>  |  ActionButton            |
|   (wraps Radzen)    |  (wraps Radzen) |  (confirms + executes)   |
+-----------------------------+------------------------------------+
                              | EventCallback<T> for parent handling
                              v
+------------------------------------------------------------------+
|                   Page Components                                 |
|   ProductDashboard.razor  |  EntitySection.razor                 |
|   (orchestrates components + business logic)                     |
+------------------------------------------------------------------+
```

### SmartDataGrid<T> Component Design

Instead of generating components from YAML, build a **configurable** Radzen wrapper:

> **File Location:** `Shared/SmartDataGrid.razor` (same directory as existing `DynamicDataGrid.razor`)
>
> **Existing Reference:** See `Shared/DynamicDataGrid.razor` for current reflection-based read-only implementation.

```csharp
// Shared/SmartDataGrid.razor
@typeparam T where T : class, new()

<RadzenDataGrid @ref="grid"
                TItem="T"
                Data="@Data"
                EditMode="@(AllowInlineEdit ? DataGridEditMode.Single : DataGridEditMode.None)"
                RowUpdate="@OnRowUpdated"
                RowCreate="@OnRowCreated"
                AllowFiltering="@AllowFiltering"
                AllowSorting="@AllowSorting"
                AllowPaging="@AllowPaging">
    <Columns>
        @foreach (var column in GetColumnConfig())
        {
            @if (!column.Hidden)
            {
                <RadzenDataGridColumn TItem="T"
                                      Property="@column.Property"
                                      Title="@column.DisplayName"
                                      Sortable="@column.Sortable"
                                      Filterable="@column.Filterable"
                                      Editable="@column.Editable" />
            }
        }

        @if (ShowActionColumn)
        {
            <RadzenDataGridColumn TItem="T" Title="Actions" Sortable="false" Width="120px">
                <Template Context="row">
                    @if (AllowEdit)
                    {
                        <RadzenButton Icon="edit" Size="ButtonSize.Small"
                                      Click="@(_ => EditRow(row))" />
                    }
                    @if (AllowDelete)
                    {
                        <RadzenButton Icon="delete" Size="ButtonSize.Small"
                                      ButtonStyle="ButtonStyle.Danger"
                                      Click="@(_ => DeleteRow(row))" />
                    }
                </Template>
            </RadzenDataGridColumn>
        }
    </Columns>
</RadzenDataGrid>

@code {
    // Data binding
    [Parameter] public IEnumerable<T>? Data { get; set; }

    // Feature toggles (easy to configure)
    [Parameter] public bool AllowFiltering { get; set; } = true;
    [Parameter] public bool AllowSorting { get; set; } = true;
    [Parameter] public bool AllowPaging { get; set; } = true;
    [Parameter] public bool AllowInlineEdit { get; set; } = false;
    [Parameter] public bool AllowEdit { get; set; } = false;
    [Parameter] public bool AllowDelete { get; set; } = false;
    [Parameter] public bool ShowActionColumn { get; set; } = false;

    // Optional: YAML-derived column config
    [Parameter] public IEnumerable<ColumnConfig>? ColumnOverrides { get; set; }

    // Events - delegates to parent for business logic
    [Parameter] public EventCallback<T> OnRowUpdate { get; set; }
    [Parameter] public EventCallback<T> OnRowCreate { get; set; }
    [Parameter] public EventCallback<T> OnRowDelete { get; set; }
    [Parameter] public EventCallback<T> OnRowEdit { get; set; }

    private RadzenDataGrid<T>? grid;

    private IEnumerable<ColumnConfig> GetColumnConfig()
    {
        // If explicit overrides provided, use those
        if (ColumnOverrides != null && ColumnOverrides.Any())
            return ColumnOverrides;

        // Otherwise, derive from T's properties (like current DynamicDataGrid)
        return typeof(T).GetProperties()
            .Select(p => new ColumnConfig
            {
                Property = p.Name,
                DisplayName = p.Name,  // Could use [Display] attribute
                Sortable = true,
                Filterable = true,
                Editable = false,
                Hidden = false
            });
    }

    private async Task OnRowUpdated(T row)
    {
        if (OnRowUpdate.HasDelegate)
            await OnRowUpdate.InvokeAsync(row);
    }

    private async Task EditRow(T row)
    {
        if (AllowInlineEdit)
            await grid!.EditRow(row);
        else if (OnRowEdit.HasDelegate)
            await OnRowEdit.InvokeAsync(row);
    }

    private async Task DeleteRow(T row)
    {
        if (OnRowDelete.HasDelegate)
            await OnRowDelete.InvokeAsync(row);
    }
}
```

### Column Configuration Model

> **Note:** The `DotNetWebApp.Models/UI/` directory does not exist yet. Create it when implementing this class.

```csharp
// DotNetWebApp.Models/UI/ColumnConfig.cs (NEW FILE - directory must be created)
public class ColumnConfig
{
    public string Property { get; set; } = null!;
    public string DisplayName { get; set; } = null!;
    public bool Sortable { get; set; } = true;
    public bool Filterable { get; set; } = true;
    public bool Editable { get; set; } = false;
    public bool Hidden { get; set; } = false;
    public string? FormatString { get; set; }  // e.g., "C2" for currency
    public int? Width { get; set; }
}
```

### Usage Example - Without YAML (Code-First)

> **Multi-App Context (2026-01-28):** Routes are now app-prefixed. The example below shows integration with the multi-app architecture.

```razor
@* Components/Sections/EntitySection.razor - Updated to use SmartDataGrid *@
@* Note: EntitySection already exists and passes EntityName (e.g., "acme:Product") *@
@inject IEntityOperationService EntityOperationService
@inject IEntityMetadataService EntityMetadataService

<SmartDataGrid T="object"
               Data="@entities"
               AllowEdit="true"
               AllowDelete="true"
               ShowActionColumn="true"
               OnRowUpdate="@HandleUpdate"
               OnRowDelete="@HandleDelete" />

@code {
    [Parameter]
    public string EntityName { get; set; } = string.Empty;  // e.g., "acme:Product"

    private IReadOnlyList<object>? entities;
    private Type? entityType;

    protected override async Task OnParametersSetAsync()
    {
        var metadata = EntityMetadataService.Find(EntityName);
        if (metadata == null) return;

        entityType = metadata.ClrType;
        var result = await EntityOperationService.GetAllAsync(entityType);
        entities = result.Cast<object>().ToList().AsReadOnly();
    }

    private async Task HandleUpdate(object entity)
    {
        if (entityType == null) return;
        await EntityOperationService.UpdateAsync(entityType, entity);
        // Refresh, show toast notification, etc.
    }

    private async Task HandleDelete(object entity)
    {
        if (entityType == null) return;
        // Get the Id property via reflection
        var idProp = entityType.GetProperty("Id");
        var id = idProp?.GetValue(entity);
        if (id != null)
        {
            await EntityOperationService.DeleteAsync(entityType, id);
            // Refresh list
        }
    }
}
```

### Usage Example - With YAML Configuration (Optional Enhancement)

```yaml
# ui_config.yaml (optional, enhances but not required)
grids:
  - name: ProductGrid
    entity: Product
    features:
      allow_inline_edit: true
      allow_delete: true
      show_action_column: true
    columns:
      - property: Id
        hidden: true
      - property: Name
        display_name: "Product Name"
        editable: true
      - property: Price
        display_name: "Unit Price"
        format: "C2"
        editable: true
      - property: CategoryId
        hidden: true
```

```razor
@* Pages/Products.razor - With optional YAML config *@
@inject IUiConfigService UiConfig

<SmartDataGrid T="Product"
               Data="@products"
               ColumnOverrides="@gridConfig?.Columns"
               AllowInlineEdit="@(gridConfig?.Features.AllowInlineEdit ?? false)"
               OnRowUpdate="@HandleUpdate" />

@code {
    private GridConfig? gridConfig;

    protected override void OnInitialized()
    {
        gridConfig = UiConfig.GetGridConfig("ProductGrid");  // Returns null if not configured
    }
}
```

### Revised Implementation Path (Updated 2026-01-28)

**Phase A: Core Components (1-2 days)**
1. Create `DotNetWebApp.Models/UI/ColumnConfig.cs` - Column configuration model
2. Create `Shared/SmartDataGrid.razor` - Configurable grid with edit/delete capabilities
3. Reference `Shared/DynamicDataGrid.razor` for reflection patterns (read-only baseline)

**Phase B: Event Infrastructure (1 day)**
1. Standardize `EventCallback<T>` patterns in SmartDataGrid
2. Use Radzen's built-in `NotificationService` for toast notifications
3. Reference `ProductDashboard.razor` for error handling patterns (already documented)

**Phase C: Write Operations Integration (2-3 days)**
1. Wire SmartDataGrid to `IEntityOperationService.UpdateAsync()` - service already exists!
2. Wire SmartDataGrid to `IEntityOperationService.DeleteAsync()` - service already exists!
3. Use Radzen's `DialogService` for confirmation dialogs
4. Update `EntitySection.razor` to use SmartDataGrid instead of DynamicDataGrid
5. Test in multi-app context: `/admin/acme/Product`, `/metrics/initech/User`

**Phase D: Optional YAML Layer (can defer)**
1. Extend `ViewDefinition.cs` with `UiHints` and `WritableSource` classes
2. Update `views.yaml` to support UI metadata
3. Add `ColumnOverrides` parameter to SmartDataGrid for YAML-driven config

### What Changes from Original Phase 4

| Original Plan | Revised Approach | Status (2026-01-28) |
|---------------|------------------|---------------------|
| Generate metadata classes from YAML | Build reusable generic components | Recommended approach |
| `ViewModelTemplate.scriban` extensions | `SmartDataGrid<T>` with EventCallbacks | Template exists, SmartDataGrid to be built |
| `[Editable]` / `[ReadOnly]` attributes | `ColumnConfig.Editable` property | ColumnConfig to be created |
| `WritableSource` complex mapping | Direct `IEntityOperationService` calls | ✅ Service already exists! |
| Permission checks in generated code | Permission checks in page components | Use app-scoped access from multi-app architecture |

### Benefits of Revised Approach

1. **Incremental adoption** - Teams use pure code initially, add YAML as patterns emerge
2. **Lower risk** - No generator changes when requirements change
3. **Easier debugging** - Developers debug actual Razor code, not generated output
4. **Full Radzen access** - Use any Radzen feature without generator support
5. **Type safety** - Generic `<T>` provides compile-time checking
6. **Simpler onboarding** - New developers understand standard Blazor patterns

---

## Known Risks & Research Questions

### Resolved by Hybrid Approach

1. **Radzen Limitations** - RESOLVED
   - ~~Does DataGrid support dynamic column generation with templates?~~
     **Answer:** Yes, and SmartDataGrid<T> uses reflection + ColumnOverrides pattern
   - ~~Can we embed permission checks in column rendering?~~
     **Answer:** Yes, via `@if` in Razor template, no generation needed

2. **Blazor Constraints** - RESOLVED
   - ~~How to efficiently detect changed properties without tracking state?~~
     **Answer:** Radzen's `RowUpdate` event passes the modified row; let EF detect changes
   - ~~Optimistic vs. pessimistic updates?~~
     **Answer:** Optimistic - update immediately, show error toast on failure

### Remaining Questions

1. **Entity Operation Service** ✅ MOSTLY ANSWERED
   - `IEntityOperationService.UpdateAsync()` updates the full entity (not partial) - pass complete entity object
   - FK constraint violations will throw `DbUpdateException` - catch and show user-friendly message
   - No `ValidateAsync()` method exists - use DataAnnotations validation in form before calling service

2. **Multi-App/Multi-Tenant Edge Cases** (2026-01-28 Update)
   - Multi-app architecture now uses `apps.yaml` with app-scoped entities/views
   - Schema-qualified names (e.g., `acme:Product`) are used throughout
   - Verify `IEntityOperationService` respects schema context via `IEntityMetadataService.Find()`
   - Test CRUD operations within app context (admin app vs reporting app)
   - `X-Customer-Schema` header still flows through for tenant isolation

3. **Validation UX**
   - Recommend: Show validation errors inline (Radzen's default behavior)
   - Server-side errors (unique constraints, FK violations) → show as toast notification
   - Cross-field validation → implement in the calling component before service call

---

## References & Next Steps

- **Phase 2 (Prerequisite):** PHASE2_VIEW_PIPELINE.md ✅ COMPLETE
- **Phase 3 (Related):** PHASE3_VIEW_UI.md (static view rendering) - ProductDashboard reference exists
- **Multi-App Architecture:** MULTI_APP_IMPLEMENTATION_SUMMARY.md ⚠️ READ THIS FIRST
- **Radzen Documentation:** https://blazor.radzen.com/datagrid (to be researched)
- **Blazor Patterns:** Research component lifecycle, parameter binding, event handling
- **Entity Operation Service:** `Services/IEntityOperationService.cs` ✅ Already complete with full CRUD

### Key Files to Review Before Implementation

| File | Purpose |
|------|---------|
| `Shared/DynamicDataGrid.razor` | Existing read-only grid (to be enhanced/replaced) |
| `Components/Sections/EntitySection.razor` | Current entity display (uses DynamicDataGrid) |
| `Components/Pages/ProductDashboard.razor` | Reference for error handling, loading states |
| `Services/EntityOperationService.cs` | CRUD implementation with compiled delegates |
| `DotNetWebApp.Models/AppDictionary/ViewDefinition.cs` | Extend with Phase 4 UI classes |
| `apps.yaml` | Multi-app configuration (entities/views per app) |

---

**End of Phase 4 Planning Document**

---

## Quick Checklist - Revised Approach

> **Important (2026-01-28):** `IEntityOperationService` already exists with full CRUD support. `DynamicDataGrid.razor` exists but is read-only. The goal is to create `SmartDataGrid<T>` that adds edit capabilities.

**Phase A: Core Components**
- [ ] Create `ColumnConfig.cs` model in `DotNetWebApp.Models/UI/` (directory doesn't exist yet)
- [ ] Implement `SmartDataGrid<T>` in `Shared/SmartDataGrid.razor` (enhances read-only DynamicDataGrid)
- [ ] Add action column with Edit/Delete buttons
- [ ] Wire up `EventCallback<T>` for OnRowUpdate, OnRowDelete, OnRowEdit
- [ ] Test with existing Product entity (via `acme:Product` in admin app)

**Phase B: Event Infrastructure**
- [ ] Create `INotificationService` for toast notifications (or use Radzen's `NotificationService` directly)
- [ ] Integrate with Radzen's `NotificationService`
- [ ] Reuse existing error handling patterns from `ProductDashboard.razor`

**Phase C: Optional YAML Layer (can defer)**
- [ ] Extend `ViewDefinition.cs` with `UiHints` and `WritableSource` classes
- [ ] Update `views.yaml` schema to support `ui_hints:` and `writable_sources:` sections
- [ ] Add column override support to SmartDataGrid (optional)

**Phase D: Write Operations**
- [ ] Wire SmartDataGrid to `IEntityOperationService.UpdateAsync()` (service already exists!)
- [ ] Wire SmartDataGrid to `IEntityOperationService.DeleteAsync()` (service already exists!)
- [ ] Add confirmation dialog for delete operations (use Radzen's `DialogService`)
- [ ] Implement validation error display (Radzen built-in)
- [ ] Update `EntitySection.razor` to use SmartDataGrid instead of DynamicDataGrid
- [ ] Test full CRUD flow in multi-app context (e.g., `/admin/acme/Product`)
