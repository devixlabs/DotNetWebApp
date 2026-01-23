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
