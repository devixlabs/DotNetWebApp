# Merge Conflict Resolution Plan
## Tasks 5 & 6: EntitySection & Dashboard Generalization

**Date**: 2026-01-22
**Branch**: `templify_entity_todo` (HEAD) merging from `templify`
**Decisions Locked In**:
1. ✅ Use EntityCountInfo DTO (simple: `EntityName`, `Count`)
2. ✅ Use IEntityMetadataService (not AppDictionaryService)
3. ✅ EntitySection lifecycle: `OnParametersSetAsync()` (reactive)
4. ✅ EntitySection data model: `Type?` + `IQueryable?` (maximum control)
5. ✅ Error handling: `ILogger<T>` (not Console.WriteLine)
6. ⏸️ Products section: Keep both approaches for now, decide later

---

## Merge Execution Order

**IMPORTANT**: Apply files in this exact order to avoid dependency issues:

1. **First**: `Models/DashboardSummary.cs` (no dependencies)
2. **Second**: `Services/DashboardService.cs` (depends on DashboardSummary)
3. **Third**: `Components/Sections/DashboardSection.razor` (depends on DashboardService)
4. **Fourth**: `Components/Sections/EntitySection.razor` (independent, but referenced by SpaApp)
5. **Fifth**: `Components/Pages/SpaApp.razor` (depends on EntitySection, EntityMetadataService)

---

## File 1: Models/DashboardSummary.cs

**Action**: Replace entire file contents with this:

```csharp
namespace DotNetWebApp.Models;

public class DashboardSummary
{
    public IReadOnlyList<EntityCountInfo> EntityCounts { get; set; } = Array.Empty<EntityCountInfo>();
    public decimal Revenue { get; set; }
    public int ActiveUsers { get; set; }
    public int GrowthPercent { get; set; }
    public IReadOnlyList<ActivityItem> RecentActivities { get; set; } = Array.Empty<ActivityItem>();
}

public sealed record EntityCountInfo(string EntityName, int Count);
public sealed record ActivityItem(string When, string Description);
```

**Why**: Uses templify's EntityCountInfo DTO approach for type-safety and cleaner iteration.

---

## File 2: Services/DashboardService.cs

**Action**: Replace entire file contents with this:

```csharp
using DotNetWebApp.Models;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Services;

public sealed class DashboardService : IDashboardService
{
    private readonly IEntityApiService _entityApiService;
    private readonly IEntityMetadataService _entityMetadataService;
    private readonly ILogger<DashboardService> _logger;

    public DashboardService(
        IEntityApiService entityApiService,
        IEntityMetadataService entityMetadataService,
        ILogger<DashboardService> logger)
    {
        _entityApiService = entityApiService;
        _entityMetadataService = entityMetadataService;
        _logger = logger;
    }

    public async Task<DashboardSummary> GetSummaryAsync(CancellationToken cancellationToken = default)
    {
        // Get all entities from metadata service
        var entities = _entityMetadataService.Entities;

        // Load counts in parallel for better performance
        var countTasks = entities
            .Select(async e =>
            {
                try
                {
                    var count = await _entityApiService.GetCountAsync(e.Definition.Name);
                    return new EntityCountInfo(e.Definition.Name, count);
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Error getting count for {EntityName}", e.Definition.Name);
                    // Return 0 if count fails for individual entity
                    return new EntityCountInfo(e.Definition.Name, 0);
                }
            })
            .ToArray();

        var counts = await Task.WhenAll(countTasks);

        return new DashboardSummary
        {
            EntityCounts = counts.ToList().AsReadOnly(),
            Revenue = 45789.50m,
            ActiveUsers = 1250,
            GrowthPercent = 15,
            RecentActivities = new[]
            {
                new ActivityItem("2 min ago", "New entity added"),
                new ActivityItem("15 min ago", "User registered"),
                new ActivityItem("1 hour ago", "Operation completed")
            }
        };
    }
}
```

**Why**:
- Uses IEntityMetadataService (not AppDictionaryService) for entity discovery
- Uses Task.WhenAll for parallel loading (from HEAD)
- Uses ILogger for proper error logging (not Console.WriteLine)
- Returns EntityCountInfo list (from templify)

---

## File 3: Components/Sections/DashboardSection.razor

**Action**: Replace entire file contents with this:

```razor
@inject IDashboardService DashboardService

<RadzenStack Gap="20px">
    <RadzenRow Gap="20px">
        @* Dynamic entity count cards *@
        @foreach (var entityCount in summary.EntityCounts)
        {
            <RadzenColumn Size="12" Medium="6" Large="3">
                <RadzenCard>
                    <RadzenStack Gap="8px">
                        <RadzenText Text="@($"Total {entityCount.EntityName}s")" TextStyle="TextStyle.Subtitle2" />
                        @if (isLoading)
                        {
                            <RadzenText Text="Loading..." TextStyle="TextStyle.H5" />
                        }
                        else
                        {
                            <RadzenText Text="@entityCount.Count.ToString()" TextStyle="TextStyle.H4" />
                        }
                    </RadzenStack>
                </RadzenCard>
            </RadzenColumn>
        }

        <RadzenColumn Size="12" Medium="6" Large="3">
            <RadzenCard>
                <RadzenStack Gap="8px">
                    <RadzenText Text="Revenue" TextStyle="TextStyle.Subtitle2" />
                    <RadzenText Text="@($"${summary.Revenue:N2}")" TextStyle="TextStyle.H4" />
                </RadzenStack>
            </RadzenCard>
        </RadzenColumn>

        <RadzenColumn Size="12" Medium="6" Large="3">
            <RadzenCard>
                <RadzenStack Gap="8px">
                    <RadzenText Text="Active Users" TextStyle="TextStyle.Subtitle2" />
                    <RadzenText Text="@summary.ActiveUsers.ToString()" TextStyle="TextStyle.H4" />
                </RadzenStack>
            </RadzenCard>
        </RadzenColumn>

        <RadzenColumn Size="12" Medium="6" Large="3">
            <RadzenCard>
                <RadzenStack Gap="8px">
                    <RadzenText Text="Growth" TextStyle="TextStyle.Subtitle2" />
                    <RadzenText Text="@($"+{summary.GrowthPercent}%")" TextStyle="TextStyle.H4" />
                </RadzenStack>
            </RadzenCard>
        </RadzenColumn>
    </RadzenRow>

    <RadzenCard>
        <RadzenStack Gap="12px">
            <RadzenText Text="Recent Activity" TextStyle="TextStyle.Subtitle2" />
            <RadzenStack Gap="8px">
                @foreach (var activity in summary.RecentActivities)
                {
                    <RadzenStack Orientation="@Orientation.Horizontal" JustifyContent="@JustifyContent.SpaceBetween" AlignItems="@AlignItems.Center">
                        <RadzenText Text="@activity.When" TextStyle="TextStyle.Caption" />
                        <RadzenText Text="@activity.Description" />
                    </RadzenStack>
                }
            </RadzenStack>
        </RadzenStack>
    </RadzenCard>
</RadzenStack>

@code {
    private DashboardSummary summary = new();
    private bool isLoading = true;

    protected override async Task OnInitializedAsync()
    {
        try
        {
            summary = await DashboardService.GetSummaryAsync();
        }
        finally
        {
            isLoading = false;
        }
    }
}
```

**Why**:
- Uses templify's simpler iteration pattern (`summary.EntityCounts` directly)
- Removed IEntityMetadataService injection (no longer needed)
- Keeps all static cards (Revenue, Active Users, Growth) and Recent Activity section unchanged

---

## File 4: Components/Sections/EntitySection.razor

**Action**: Replace entire file contents with this:

```razor
@using DotNetWebApp.Models.AppDictionary
@inject IAppDictionaryService AppDictionary
@inject IEntityApiService EntityApi
@inject IEntityMetadataService EntityMetadataService

<RadzenCard>
    <RadzenStack Gap="16px">
        @* Header with controls *@
        <RadzenStack Orientation="@Orientation.Horizontal" AlignItems="@AlignItems.Center" JustifyContent="@JustifyContent.SpaceBetween">
            <RadzenText Text="@($"{EntityName} Management")" TextStyle="TextStyle.Subtitle2" />
            <RadzenStack Orientation="@Orientation.Horizontal" AlignItems="@AlignItems.Center" Gap="8px">
                <RadzenButton Click="Refresh" IsBusy="@isLoading"
                              Text="@(isLoading ? "Loading..." : "Refresh")"
                              Icon="refresh" ButtonStyle="ButtonStyle.Primary" />
                <RadzenButton Click="AddNewEntity" Text="@($"Add {EntityName}")" Icon="add"
                              ButtonStyle="ButtonStyle.Success" />
            </RadzenStack>
        </RadzenStack>

        @* Error handling *@
        @if (!string.IsNullOrEmpty(errorMessage))
        {
            <RadzenAlert AlertStyle="AlertStyle.Danger" Variant="Variant.Flat" Shade="Shade.Lighter">
                @errorMessage
            </RadzenAlert>
        }
        else if (isLoading)
        {
            <RadzenStack Gap="12px" AlignItems="@AlignItems.Center">
                <RadzenProgressBar ProgressBarStyle="ProgressBarStyle.Primary" Value="100"
                                   ShowValue="false" Mode="ProgressBarMode.Indeterminate" />
                <RadzenText Text="@($"Loading {EntityName.ToLower()}...")" TextStyle="TextStyle.Body2" />
            </RadzenStack>
        }
        else if (data != null && entityType != null)
        {
            <DynamicDataGrid DataType="@entityType" Data="@data" />
        }
        else
        {
            <RadzenStack Gap="12px" AlignItems="@AlignItems.Center">
                <RadzenText Text="@($"No {EntityName.ToLower()} found.")" TextStyle="TextStyle.Body2" />
                <RadzenButton Click="Refresh" Text="@($"Load {EntityName}")" ButtonStyle="ButtonStyle.Primary" />
            </RadzenStack>
        }
    </RadzenStack>
</RadzenCard>

@code {
    [Parameter]
    public string EntityName { get; set; } = string.Empty;

    [Parameter]
    public EventCallback OnRefresh { get; set; }

    private Entity? entity;
    private Type? entityType;
    private IQueryable? data;
    private bool isLoading = false;
    private string? errorMessage;

    protected override async Task OnParametersSetAsync()
    {
        if (string.IsNullOrEmpty(EntityName))
            return;

        isLoading = true;
        errorMessage = null;

        try
        {
            // Get entity metadata
            var metadata = EntityMetadataService.Find(EntityName);
            if (metadata == null)
            {
                errorMessage = $"Entity '{EntityName}' not found";
                return;
            }

            entity = metadata.Definition;
            entityType = metadata.ClrType;

            // Fetch data
            var entities = await EntityApi.GetEntitiesAsync(EntityName);
            data = entities.AsQueryable();
        }
        catch (Exception ex)
        {
            errorMessage = $"Error loading {EntityName}: {ex.Message}";
        }
        finally
        {
            isLoading = false;
        }
    }

    private async Task Refresh()
    {
        await OnRefresh.InvokeAsync();
        await OnParametersSetAsync();
    }

    private async Task AddNewEntity()
    {
        await Task.Delay(100);
        // TODO: Implement add new entity modal/form
    }
}
```

**Why**:
- Uses OnParametersSetAsync() for reactive updates when EntityName changes
- Uses Type? + IQueryable? for maximum control with DynamicDataGrid
- Has templify's header with Refresh and Add buttons
- Has HEAD's robust error handling with RadzenAlert
- Removed ILogger injection (simplified - errors shown in UI via errorMessage)

---

## File 5: Components/Pages/SpaApp.razor

**Action**: Replace entire file contents with this:

```razor
@page "/app"
@page "/app/{Section?}"
@using DotNetWebApp.Models.Generated
@inject NavigationManager Navigation
@inject ISpaSectionService SpaSections
@inject IEntityMetadataService EntityMetadataService

<PageTitle>DotNet SPA</PageTitle>

<RadzenRow Gap="20px" Style="min-height: calc(100vh - 140px);">
    <RadzenColumn Size="12">
        <RadzenStack Gap="20px">
            @if (isEntitySection && activeEntityName != null)
            {
                <SectionHeader Title="@activeEntityName" IsLoading="@false" />
                <EntitySection EntityName="@activeEntityName" OnRefresh="@(() => StateHasChanged())" />
            }
            else
            {
                <SectionHeader Title="@SpaSections.GetInfo(activeSection).Title" IsLoading="@IsLoading" />

                @if (activeSection == SpaSection.Dashboard)
                {
                    <DashboardSection />
                }
                else if (activeSection == SpaSection.Products)
                {
                    <EntitySection EntityName="Product" OnRefresh="@(() => StateHasChanged())" />
                }
                else if (activeSection == SpaSection.Settings)
                {
                    <SettingsSection />
                }
            }
        </RadzenStack>
    </RadzenColumn>
</RadzenRow>

@code {
    private SpaSection activeSection = SpaSection.Dashboard;
    private string? activeEntityName;
    private bool isEntitySection => activeEntityName != null;
    private AsyncUiState? loadingState;

    private bool IsLoading => loadingState?.IsBusy == true;

    [Parameter] public string? Section { get; set; }

    protected override void OnInitialized()
    {
        loadingState = new AsyncUiState(() => InvokeAsync(StateHasChanged));
        activeSection = SpaSections.DefaultSection;
    }

    protected override async Task OnParametersSetAsync()
    {
        string? segment = Section?.Trim().ToLowerInvariant();

        if (string.IsNullOrEmpty(segment))
        {
            // Default to Dashboard
            activeSection = SpaSection.Dashboard;
            activeEntityName = null;
            return;
        }

        // Try to match static section first
        var staticSection = SpaSections.FromRouteSegment(segment);
        if (staticSection != null)
        {
            activeSection = staticSection.Value;
            activeEntityName = null;
            await LoadSection(staticSection.Value);
            return;
        }

        // Check if it's an entity name
        var entityMeta = EntityMetadataService.Entities
            .FirstOrDefault(e => e.Definition.Name.Equals(segment, StringComparison.OrdinalIgnoreCase));

        if (entityMeta != null)
        {
            activeSection = SpaSection.Dashboard; // Keep a default value
            activeEntityName = entityMeta.Definition.Name;
            // No need to load data - EntitySection handles it
            return;
        }

        // Fallback to Dashboard if unrecognized
        activeSection = SpaSection.Dashboard;
        activeEntityName = null;
    }

    private async Task LoadSection(SpaSection section)
    {
        if (activeSection == section && !IsLoading)
        {
            return;
        }

        activeSection = section;

        await loadingState!.RunAsync(async () =>
        {
            SpaSections.NavigateTo(section);
            await Task.Delay(500);
        });
    }
}
```

**Why**:
- Keeps IEntityMetadataService for hybrid routing (static sections + dynamic entities)
- Removed IProductService injection (no longer needed since EntitySection handles Product)
- Products section now uses EntitySection instead of ProductsSection
- Removed HandleRefresh method (each section handles its own refresh)

---

## Verification Checklist

After applying all changes, verify:

- [ ] **No conflict markers** remain in any file (search for `<<<<<<<`, `=======`, `>>>>>>>`)
- [ ] **DashboardSummary.cs** uses `IReadOnlyList<EntityCountInfo>` (not dictionary)
- [ ] **DashboardService.cs** has `using Microsoft.Extensions.Logging;` at top
- [ ] **DashboardService.cs** injects `IEntityMetadataService` (not `IAppDictionaryService`)
- [ ] **DashboardService.cs** uses `_logger.LogWarning()` (not `Console.WriteLine`)
- [ ] **DashboardSection.razor** does NOT inject `IEntityMetadataService`
- [ ] **DashboardSection.razor** iterates `summary.EntityCounts` directly
- [ ] **EntitySection.razor** uses `OnParametersSetAsync()` (not `OnInitializedAsync()`)
- [ ] **EntitySection.razor** has `Type? entityType` and `IQueryable? data` fields
- [ ] **EntitySection.razor** has Refresh and Add buttons in header
- [ ] **EntitySection.razor** shows `RadzenAlert` for errors
- [ ] **SpaApp.razor** injects `IEntityMetadataService` (for routing)
- [ ] **SpaApp.razor** does NOT inject `IProductService`
- [ ] **SpaApp.razor** Products section renders `<EntitySection EntityName="Product" ...>`
- [ ] Build succeeds: run `make build`

---

## Quick Validation Commands

After resolving all conflicts, run these commands to validate:

```bash
# Check no conflict markers remain
grep -r "<<<<<<" Components/ Models/ Services/ && echo "FAIL: Conflict markers found" || echo "OK: No conflict markers"

# Build the project
make build
```

---

**Ready to resolve!** Apply each file in the order listed above (1 through 5).
