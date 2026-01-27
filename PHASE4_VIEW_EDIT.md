# Phase 4: Editable View Components & UI-Driven Architecture

**Status:** PLANNING PHASE (2026-01-27)
**Duration:** 2-4 weeks (requires Radzen/Blazor UI research)
**Priority:** MEDIUM (enables advanced CRUD patterns for complex views)
**Prerequisite:** Phase 2 (View Pipeline) must be complete

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

```csharp
public class ViewDefinition
{
    public string Name { get; set; } = null!;
    public string Description { get; set; } = null!;
    public string SqlFile { get; set; } = null!;
    public bool GeneratePartial { get; set; } = true;

    // EXISTING
    public List<ViewParameter>? Parameters { get; set; }
    public List<ViewProperty> Properties { get; set; } = new();

    // NEW: Phase 4 UI metadata
    public UiHints? UiHints { get; set; }
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

Create a reusable component that:

```razor
@* Components/Sections/ViewEditGrid.razor *@
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

**Total Effort:** 2-4 weeks (accounting for Radzen research, Blazor complexity, and testing)

---

## Success Criteria

After Phase 4 completion:

✅ Views support mixed read-write patterns via YAML metadata
✅ Editable properties are identified in generated DTOs with `[Editable]` attribute
✅ ViewMetadata class auto-generated with property writability info
✅ Generic `ViewEditGrid<T>` component renders columns appropriately
✅ Editable columns trigger IEntityOperationService updates
✅ Permission checks respected during write operations
✅ Multi-table views update correct tables automatically
✅ Soft-delete supported for logical deletes
✅ Comprehensive tests for metadata + components
✅ Example ProductDashboard page demonstrates full flow

---

## Known Risks & Research Questions

1. **Radzen Limitations**
   - Does DataGrid support dynamic column generation with templates?
   - How to handle complex validation rules (cross-column validation)?
   - Can we embed permission checks in column rendering?

2. **Blazor Constraints**
   - How to efficiently detect changed properties without tracking state?
   - Optimistic vs. pessimistic updates - which strategy for Blazor Server?
   - How to handle validation errors from database constraints?

3. **Entity Operation Service**
   - Does IEntityOperationService support arbitrary column updates (not just PK)?
   - How to handle foreign key constraints in write operations?
   - Should we add a new `UpdateColumnsAsync()` method for selective updates?

4. **Multi-Tenant Edge Cases**
   - Do schema-qualified names work correctly in ViewEditGrid for multi-tenant?
   - Should permission checks include schema isolation?
   - Testing across multiple schemas with identical table names

---

## References & Next Steps

- **Phase 2 (Prerequisite):** PHASE2_VIEW_PIPELINE.md
- **Phase 3 (Related):** PHASE3_VIEW_UI.md (static view rendering)
- **Radzen Documentation:** https://blazor.radzen.com/datagrid (to be researched)
- **Blazor Patterns:** Research component lifecycle, parameter binding, event handling
- **Entity Operation Service:** Review IEntityOperationService for update capabilities

---

**End of Phase 4 Planning Document**

---

## Quick Checklist for Tomorrow's Session

- [ ] Research Radzen DataGrid capabilities (2-3 hours)
- [ ] Design ViewEditGrid<T> component architecture (1-2 hours)
- [ ] Decide on inline edit vs. row-edit strategy
- [ ] Determine validation error UX (toast, inline, modal)
- [ ] Design permission check integration points
- [ ] Start coding ViewDefinition.cs extensions
- [ ] Update ViewModelTemplate.scriban
- [ ] Begin ViewEditGrid<T> implementation
