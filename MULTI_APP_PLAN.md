# Multi-App Support Implementation Plan

> **Last Updated:** 2026-01-27 | **Version:** 2.0 (Amended)
>
> **Amendments from Review (v2.0):**
> - Added complete interface definitions for all services (IAppDictionaryService, IEntityMetadataService, ISpaSectionService)
> - Fixed ApplicationContextAccessor to return null instead of throwing exceptions
> - Added static path collision handling (css, js, _framework excluded from app routing)
> - Added EntityApiService update (was missing - critical for Blazor components)
> - Changed HTTP 403 to 404 for entity visibility (prevents info leakage)
> - Added root "/" route handling with redirect to first app
> - Added GenericEntityPage.razor handling (remove or update)
> - Added Phase 5.5: ViewService integration and Dashboard clarification
> - Added DDL pipeline migration note
> - Added migration checklist
> - Fixed test naming (ApplicationId → ApplicationName)
> - Added concrete curl test commands in verify.sh
> - **Added verify.sh Tests 1-12 URL update table (all routes need appName)**
> - **Added EntitiesControllerTests.cs update instructions (mock + appName param)**
> - **Added EntityApiServiceTests.cs update instructions (IApplicationContextAccessor mock)**
> - **Added TestEntityMetadataService interface extension code**
> - **Added TestAppDictionaryService mock code**
> - **Added TestApplicationContextAccessor mock code**
> - **Added Phase 5.5: Blazor Component Updates (Home.razor, DashboardSection.razor)**
> - **Added PipelineIntegrationTests.cs fix (appDefinition.App.Name → Applications[0].Name)**
> - Updated Critical Files table (22 files, ~430 lines)

## Overview
Extend DotNetWebApp to support multiple applications (admin, reporting, metrics, etc.) with independent routing, shared/dedicated schemas, and flexible database requirements.

## Requirements (OPINIONATED APPROACH - No Backward Compatibility)
- **App naming:** Arbitrary names using `AppName` (admin, reporting, metrics) - NOT "AppId"
- **Database flexibility:** Apps can share schemas (acme, initech) or use 'default' schema
- **Data sharing:** Multiple apps can access same schema with entity-level filtering
- **Universal APIs:** All apps get API endpoints; no entities returns 204 No Content
- **Navigation:** Apps shown in side navigation menu
- **URLs:** `/{appName}/section` (e.g., `/admin/dashboard`, `/reporting/reports`)
- **Configuration:** ONLY `apps.yaml` - no fallback to `app.yaml`, no dual format
- **Routing:** Clean break - `/app` routes completely removed, no legacy support
- **Schema requirement:** Apps MUST specify a schema (acme, initech, or default) - no null/optional schemas

## Architecture Decisions

### 1. Configuration: Single apps.yaml (OPINIONATED - No Fallback)
Use centralized `apps.yaml` with applications array. NO fallback to `app.yaml`. All apps must be defined explicitly.

```yaml
applications:
  - name: admin
    title: Admin Portal
    schema: acme
    entities: [acme:Company, acme:User, acme:Role]
    views: [UserActivityView]

  - name: reporting
    title: Reporting Dashboard
    schema: acme  # Shared with admin
    entities: [acme:Company, acme:Product]  # Different visibility
    views: [SalesReportView]

  - name: metrics
    title: Metrics & Analytics
    schema: initech
    entities: [initech:Company, initech:Metric]
    views: [MetricsView]

dataModel:
  entities: [...]  # Global definitions (acme:* and initech:*)

views:
  views: [...]  # Global view definitions
```

### 2. Application Context Resolution
Create `IApplicationContextAccessor` service (mirrors existing `ITenantSchemaAccessor` pattern) that extracts app name from route path.

**Resolution logic:** `/admin/dashboard` → ApplicationName = "admin"

### 3. Entity Filtering
Extend `IEntityMetadataService` with per-app filtering to prevent cross-app data access when sharing schemas.

**Example:** admin and reporting both use 'acme' schema, but admin sees [Company, User, Role] while reporting sees [Company, Product].

### 4. Routing Strategy (CLEAN BREAK - No Legacy Support)
- **Blazor pages:** `@page "/{AppName}/{*Section}"` only (NO `/app/...` routes)
- **API:** `[Route("api/{appName}/entities")]` only (NO `/api/entities/...` routes)
- **Validation:** AppName must match configured application names

## Implementation Steps

### Phase 1: Models & Configuration (Priority: Critical)

**File: `DotNetWebApp.Models/AppDictionary/AppDefinition.cs`**

Replace with multi-app structure (OPINIONATED - no legacy support).

> **IMPORTANT:** Remove the old `App` property entirely. The new structure has `Applications` list instead.

```csharp
public class AppDefinition
{
    // REMOVED: public AppMetadata App { get; set; }  // <-- DELETE THIS

    // Multi-app configuration (only format supported)
    public List<ApplicationInfo> Applications { get; set; } = new();

    // Global definitions shared by all apps
    public DataModel DataModel { get; set; } = new();
    public ViewsRoot? Views { get; set; }
}

public class ApplicationInfo
{
    public string Name { get; set; } = string.Empty;  // admin, reporting, metrics, etc.
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Icon { get; set; }
    public string Schema { get; set; } = string.Empty;  // REQUIRED: acme, initech, default, etc.
    public List<string> Entities { get; set; } = new();  // Filtered visibility: [acme:User, acme:Role]
    public List<string> Views { get; set; } = new();
    public Theme? Theme { get; set; }
}
```

**File: `Services/IAppDictionaryService.cs`** (UPDATED INTERFACE)

> **CRITICAL:** Add new methods to the interface - implementation depends on these.

```csharp
using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services;

public interface IAppDictionaryService
{
    AppDefinition AppDefinition { get; }

    // NEW: Multi-app helper methods
    IReadOnlyList<ApplicationInfo> GetAllApplications();
    ApplicationInfo? GetApplication(string appName);
}
```

**File: `Services/AppDictionaryService.cs`**

Simplify for apps.yaml only (OPINIONATED - no legacy loading):

```csharp
public class AppDictionaryService : IAppDictionaryService
{
    public AppDefinition AppDefinition { get; }

    public AppDictionaryService(string yamlFilePath)
    {
        if (!File.Exists(yamlFilePath))
            throw new FileNotFoundException($"apps.yaml not found at {yamlFilePath}");

        var yamlContent = File.ReadAllText(yamlFilePath);
        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        AppDefinition = deserializer.Deserialize<AppDefinition>(yamlContent)
            ?? throw new InvalidOperationException("Failed to deserialize apps.yaml");

        if (!AppDefinition.Applications.Any())
            throw new InvalidOperationException("apps.yaml must define at least one application");
    }

    public IReadOnlyList<ApplicationInfo> GetAllApplications()
    {
        return AppDefinition.Applications.AsReadOnly();
    }

    public ApplicationInfo? GetApplication(string appName)
    {
        return AppDefinition.Applications.FirstOrDefault(a =>
            a.Name.Equals(appName, StringComparison.OrdinalIgnoreCase));
    }
}
```

### Phase 2: Application Context Service (Priority: Critical)

**File: `Services/IApplicationContextAccessor.cs` (NEW)**

> **NOTE:** Returns nullable string to allow graceful handling of invalid/missing app context.

```csharp
namespace DotNetWebApp.Services;

public interface IApplicationContextAccessor
{
    /// <summary>
    /// Gets the current application name from the request path.
    /// Returns null if no valid application context is available.
    /// </summary>
    string? ApplicationName { get; }
}
```

**File: `Services/ApplicationContextAccessor.cs` (NEW)**

> **IMPORTANT:** Returns `null` for invalid apps instead of throwing exceptions.
> This allows callers to handle gracefully with redirects or 404s.

```csharp
namespace DotNetWebApp.Services;

public class ApplicationContextAccessor : IApplicationContextAccessor
{
    // Static paths that should NOT be treated as app names
    private static readonly HashSet<string> StaticPathPrefixes = new(StringComparer.OrdinalIgnoreCase)
    {
        "css", "js", "lib", "images", "_framework", "_blazor", "api"
    };

    private readonly IHttpContextAccessor _httpContextAccessor;
    private readonly IAppDictionaryService _appDictionary;
    private string? _cachedApplicationName;
    private bool _cacheInitialized;

    public ApplicationContextAccessor(
        IHttpContextAccessor httpContextAccessor,
        IAppDictionaryService appDictionary)
    {
        _httpContextAccessor = httpContextAccessor;
        _appDictionary = appDictionary;
    }

    public string? ApplicationName
    {
        get
        {
            if (_cacheInitialized)
                return _cachedApplicationName;

            // Handle null HttpContext (can happen in Blazor Server after initial connection)
            var httpContext = _httpContextAccessor.HttpContext;
            if (httpContext == null)
            {
                _cacheInitialized = true;
                _cachedApplicationName = null;
                return null;
            }

            var path = httpContext.Request.Path.Value ?? "";
            _cachedApplicationName = ExtractApplicationNameFromPath(path);
            _cacheInitialized = true;
            return _cachedApplicationName;
        }
    }

    private string? ExtractApplicationNameFromPath(string path)
    {
        // Remove leading slash and split
        var segments = path.TrimStart('/').Split('/', StringSplitOptions.RemoveEmptyEntries);

        if (segments.Length == 0)
            return null;  // Root path, no app context

        var firstSegment = segments[0];

        // Skip static resource paths
        if (StaticPathPrefixes.Contains(firstSegment))
            return null;

        // Check if it's a valid app name
        var app = _appDictionary.GetApplication(firstSegment);
        return app?.Name;  // Returns null if not a valid app
    }
}
```

### Phase 3: Entity Filtering (Priority: High)

**File: `Services/IEntityMetadataService.cs`** (COMPLETE INTERFACE)

> **CRITICAL:** Show the complete interface so implementer knows exactly what to add.

```csharp
using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface IEntityMetadataService
{
    // Existing methods (keep these)
    IReadOnlyList<EntityMetadata> Entities { get; }
    EntityMetadata? Find(string qualifiedName);

    // NEW: App-filtered entity access
    IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName);
    bool IsEntityVisibleInApplication(EntityMetadata entity, string appName);
}
```

**File: `Services/EntityMetadataService.cs`**

Extend with app-aware filtering methods:

> **NOTE:** The matching logic builds a qualified name from entity's Schema and Name fields,
> then checks if it exists in the app's Entities list. Both use colon separator (e.g., "acme:Company").

```csharp
public class EntityMetadataService : IEntityMetadataService
{
    private readonly IAppDictionaryService _appDictionary;

    // Existing property and methods unchanged
    public IReadOnlyList<EntityMetadata> Entities { get; }
    public EntityMetadata? Find(string qualifiedName) { /* existing implementation */ }

    // NEW: App-filtered entity access
    public IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName)
    {
        var app = _appDictionary.GetApplication(appName);
        if (app == null)
            return Array.Empty<EntityMetadata>();

        if (app.Entities.Count == 0)
            return Array.Empty<EntityMetadata>();

        return Entities
            .Where(e => IsEntityVisibleInApplication(e, app))
            .ToList();
    }

    public bool IsEntityVisibleInApplication(EntityMetadata entity, string appName)
    {
        var app = _appDictionary.GetApplication(appName);
        return app != null && IsEntityVisibleInApplication(entity, app);
    }

    private bool IsEntityVisibleInApplication(EntityMetadata entity, ApplicationInfo app)
    {
        // Build qualified name from entity definition (same format as apps.yaml entities list)
        var qualifiedName = string.IsNullOrEmpty(entity.Definition.Schema)
            ? entity.Definition.Name
            : $"{entity.Definition.Schema}:{entity.Definition.Name}";

        // Case-insensitive match against app's entity list
        return app.Entities.Contains(qualifiedName, StringComparer.OrdinalIgnoreCase);
    }
}
```

> **Implementation Note:** The constructor must now accept `IAppDictionaryService` dependency.
> Update constructor to: `public EntityMetadataService(IAppDictionaryService appDictionary, ...)`

### Phase 4: Routing Changes (Priority: Critical)

**File: `Components/Pages/SpaApp.razor`**

Replace with multi-app routes only (OPINIONATED - no legacy support):

> **IMPORTANT:** Routes are greedy - they will match static paths like `/css/app.css`.
> The validation logic handles this by redirecting to first app if AppName is invalid.

```razor
@page "/"
@page "/{AppName}"
@page "/{AppName}/{*Section}"

@inject NavigationManager NavigationManager
@inject IAppDictionaryService AppDictionary

[Parameter] public string? AppName { get; set; }
[Parameter] public string? Section { get; set; }

@code {
    // Static paths that should not be treated as app names
    private static readonly HashSet<string> StaticPaths = new(StringComparer.OrdinalIgnoreCase)
    {
        "css", "js", "lib", "images", "_framework", "_blazor"
    };

    protected override void OnParametersSet()
    {
        // Handle root "/" route - redirect to first app
        if (string.IsNullOrEmpty(AppName))
        {
            var firstApp = AppDictionary.GetAllApplications().FirstOrDefault();
            if (firstApp != null)
                NavigationManager.NavigateTo($"/{firstApp.Name}/dashboard", replace: true);
            return;
        }

        // Skip static resource paths (let static file middleware handle)
        if (StaticPaths.Contains(AppName))
            return;

        // Validate AppName exists
        var app = AppDictionary.GetApplication(AppName);
        if (app == null)
        {
            // Invalid app, redirect to first app
            var firstApp = AppDictionary.GetAllApplications().FirstOrDefault();
            if (firstApp != null)
                NavigationManager.NavigateTo($"/{firstApp.Name}/dashboard", replace: true);
            return;
        }

        // Rest of existing logic unchanged (section handling, etc.)
    }
}
```

**File: `Components/Pages/GenericEntityPage.razor`** (REMOVE or UPDATE)

> **CLEAN BREAK DECISION:** Remove legacy direct entity routes to avoid security holes.

Option A - **DELETE** (Recommended for clean break):
```
Delete Components/Pages/GenericEntityPage.razor entirely.
All entity access goes through /{appName}/... routes with proper app context.
```

Option B - **UPDATE** (If direct entity access still needed):
```razor
@page "/{AppName}/entity/{EntityName}"
@page "/{AppName}/entity/{Schema}/{EntityName}"

[Parameter] public string? AppName { get; set; }
[Parameter] public string? Schema { get; set; }
[Parameter] public string? EntityName { get; set; }

@code {
    // Validate AppName and entity visibility before rendering
}
```

**File: `Controllers/EntitiesController.cs`**

Replace with appName parameter (OPINIONATED - no legacy routes):

> **IMPORTANT:** Use 404 (not 403) for entity visibility checks.
> 403 implies the entity EXISTS but user is unauthorized - leaks information.
> 404 means "not found in this app context" - proper REST semantics.

```csharp
[ApiController]
[Route("api/{appName}/entities")]
public class EntitiesController : ControllerBase
{
    private readonly IEntityMetadataService _metadataService;
    private readonly IEntityOperationService _entityOperations;
    private readonly IAppDictionaryService _appDictionary;

    [HttpGet("{schema}/{entityName}")]
    public async Task<ActionResult<IEnumerable<object>>> GetEntities(
        string appName,
        string schema,
        string entityName)
    {
        // Validate app exists
        var app = _appDictionary.GetApplication(appName);
        if (app == null)
            return NotFound(new { error = $"Application '{appName}' not found" });

        // If app has no entities, return 204 No Content
        if (!app.Entities.Any())
            return NoContent();

        var qualifiedName = BuildQualifiedName(schema, entityName);
        var entityMetadata = _metadataService.Find(qualifiedName);

        if (entityMetadata == null)
            return NotFound(new { error = $"Entity '{qualifiedName}' not found" });

        // Validate entity is visible in this app - use 404, NOT 403
        if (!_metadataService.IsEntityVisibleInApplication(entityMetadata, appName))
            return NotFound(new { error = $"Entity '{qualifiedName}' not found in app '{appName}'" });

        // Rest of logic unchanged
        var entities = await _entityOperations.GetAllAsync(entityMetadata.Type);
        return Ok(entities);
    }

    // Apply same pattern to all other endpoints:
    // - GetEntityCount(appName, schema, entityName)
    // - CreateEntity(appName, schema, entityName, entity)
    // - GetEntity(appName, schema, entityName, id)
    // - UpdateEntity(appName, schema, entityName, id, entity)
    // - DeleteEntity(appName, schema, entityName, id)
}
```

**File: `Services/EntityApiService.cs`** (CRITICAL UPDATE)

> **MISSING FROM ORIGINAL PLAN:** This Blazor client service constructs API URLs.
> It must include appName in all API calls.

```csharp
public sealed class EntityApiService : IEntityApiService
{
    private readonly HttpClient _httpClient;
    private readonly IEntityMetadataService _metadataService;
    private readonly IApplicationContextAccessor _appContext;  // NEW DEPENDENCY

    public EntityApiService(
        HttpClient httpClient,
        IEntityMetadataService metadataService,
        IApplicationContextAccessor appContext)  // NEW
    {
        _httpClient = httpClient;
        _metadataService = metadataService;
        _appContext = appContext;
    }

    // Convert internal colon format to URL slash format
    private static string ToUrlFormat(string entityName)
    {
        if (entityName.Contains(':'))
            return entityName.Replace(':', '/');
        return $"dbo/{entityName}";
    }

    public async Task<IEnumerable<object>> GetEntitiesAsync(string entityName)
    {
        var appName = _appContext.ApplicationName
            ?? throw new InvalidOperationException("No application context available");

        var metadata = _metadataService.Find(entityName);
        if (metadata?.ClrType == null)
            throw new InvalidOperationException($"Entity '{entityName}' not found");

        var urlPath = ToUrlFormat(entityName);
        // NEW URL FORMAT: /api/{appName}/entities/{schema}/{entity}
        var response = await _httpClient.GetAsync($"api/{appName}/entities/{urlPath}");
        // ... rest unchanged
    }

    // Apply same pattern to GetCountAsync, CreateEntityAsync, etc.
}
```

**File: `Services/IEntityApiService.cs`** (NO CHANGE)

Interface remains the same - implementation change is internal.

### Phase 5: Navigation Updates (Priority: High)

**File: `Services/ISpaSectionService.cs`** (COMPLETE INTERFACE)

> **CRITICAL:** Add the new app-aware method to the interface.

```csharp
using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface ISpaSectionService
{
    // Existing methods (may be deprecated or kept for backward compat during transition)
    SpaSectionInfo? DefaultSection { get; }
    IReadOnlyList<SpaSectionInfo> Sections { get; }
    SpaSectionInfo? FromUri(string uri);
    SpaSectionInfo? FromRouteSegment(string? segment);
    SpaSectionInfo? GetInfo(SpaSection section);
    void NavigateTo(SpaSectionInfo section, bool replace = true);

    // NEW: App-filtered section generation
    IReadOnlyList<SpaSectionInfo> GetSectionsForApplication(string appName);
}
```

**File: `Services/SpaSectionService.cs`**

Make app-aware with AppName:

> **NOTE:** Constructor must add `IAppDictionaryService` and `IEntityMetadataService` dependencies.

```csharp
public sealed class SpaSectionService : ISpaSectionService
{
    private readonly IAppDictionaryService _appDictionary;
    private readonly IEntityMetadataService _metadataService;
    private readonly NavigationManager _navigationManager;

    public SpaSectionService(
        IAppDictionaryService appDictionary,
        IEntityMetadataService metadataService,
        NavigationManager navigationManager)
    {
        _appDictionary = appDictionary;
        _metadataService = metadataService;
        _navigationManager = navigationManager;
    }

    // NEW: App-filtered section generation
    public IReadOnlyList<SpaSectionInfo> GetSectionsForApplication(string appName)
    {
        var sections = new List<SpaSectionInfo>();

        // Dashboard section (always present)
        sections.Add(new SpaSectionInfo(
            Section: SpaSection.Dashboard,
            NavLabel: "Dashboard",
            Title: "Dashboard",
            RouteSegment: "dashboard"));

        // Entity sections filtered by app
        var entities = _metadataService.GetEntitiesForApplication(appName);
        foreach (var entity in entities)
        {
            var routeSegment = string.IsNullOrWhiteSpace(entity.Definition.Schema)
                ? entity.Definition.Name
                : $"{entity.Definition.Schema}/{entity.Definition.Name}";

            sections.Add(new SpaSectionInfo(
                Section: SpaSection.Entity,
                NavLabel: entity.Definition.Name,
                Title: entity.Definition.Name,
                RouteSegment: routeSegment,
                EntityName: BuildQualifiedName(entity)));
        }

        // Settings section (only if app has entities)
        var app = _appDictionary.GetApplication(appName);
        if (app?.Entities.Any() == true)
        {
            sections.Add(new SpaSectionInfo(
                Section: SpaSection.Settings,
                NavLabel: "Settings",
                Title: "Settings",
                RouteSegment: "settings"));
        }

        return sections;
    }

    private static string BuildQualifiedName(EntityMetadata entity)
    {
        return string.IsNullOrWhiteSpace(entity.Definition.Schema)
            ? entity.Definition.Name
            : $"{entity.Definition.Schema}:{entity.Definition.Name}";
    }

    // Keep existing methods for backward compatibility during transition...
}
```

**File: `Shared/NavMenu.razor`**

Update to render multiple apps (OPINIONATED - apps shown in menu):

> **FIX:** IsActiveApp() must handle URLs without trailing slash (e.g., "/admin")

```razor
@inject IAppDictionaryService AppDictionary
@inject ISpaSectionService SpaSections
@inject NavigationManager NavigationManager

<RadzenPanelMenu>
    @* Home redirects to first app *@
    <RadzenPanelMenuItem Text="Home" Icon="home" Path="@GetHomePath()" />

    @foreach (var app in AppDictionary.GetAllApplications())
    {
        <RadzenPanelMenuItem Text="@app.Title" Icon="@(app.Icon ?? "apps")" Expanded="@IsActiveApp(app.Name)">
            @foreach (var section in SpaSections.GetSectionsForApplication(app.Name))
            {
                <RadzenPanelMenuItem
                    Text="@section.NavLabel"
                    Icon="@GetSectionIcon(section.Section)"
                    Path="@GetSectionPath(app.Name, section)" />
            }
        </RadzenPanelMenuItem>
    }
</RadzenPanelMenu>

@code {
    private string GetHomePath()
    {
        var firstApp = AppDictionary.GetAllApplications().FirstOrDefault();
        return firstApp != null ? $"/{firstApp.Name}/dashboard" : "/";
    }

    private bool IsActiveApp(string appName)
    {
        var uri = new Uri(NavigationManager.Uri);
        var path = uri.AbsolutePath;

        // Handle both "/admin/..." and "/admin" (no trailing content)
        return path.Equals($"/{appName}", StringComparison.OrdinalIgnoreCase)
            || path.StartsWith($"/{appName}/", StringComparison.OrdinalIgnoreCase);
    }

    private string GetSectionPath(string appName, SpaSectionInfo section)
    {
        return $"/{appName}/{section.RouteSegment}";
    }

    private string GetSectionIcon(SpaSection section) => section switch
    {
        SpaSection.Dashboard => "dashboard",
        SpaSection.Settings => "settings",
        SpaSection.Entity => "table_chart",
        _ => "article"
    };
}
```

### Phase 5.5: Blazor Component Updates (Priority: High)

> **CRITICAL:** Several Blazor components use `AppDefinition.App` which will be removed.

**File: `Components/Pages/Home.razor`** (UPDATE or REMOVE)

Current code uses removed properties:
```razor
<PageTitle>@AppDictionary.AppDefinition.App.Title</PageTitle>
<h1>Welcome to @AppDictionary.AppDefinition.App.Name!</h1>
```

**Option A - REMOVE** (Recommended - root "/" now redirects to first app):
```
Delete Home.razor entirely. The "/" route is handled by SpaApp.razor which redirects.
```

**Option B - UPDATE** (If keeping a landing page):
```razor
@page "/"
@inject IAppDictionaryService AppDictionary
@inject NavigationManager NavigationManager

@code {
    protected override void OnInitialized()
    {
        // Redirect to first app
        var firstApp = AppDictionary.GetAllApplications().FirstOrDefault();
        if (firstApp != null)
            NavigationManager.NavigateTo($"/{firstApp.Name}/dashboard", replace: true);
    }
}
```

---

**File: `Components/Sections/DashboardSection.razor`** (UPDATE)

Current code shows ALL entities:
```razor
@foreach (var entityMeta in EntityMetadataService.Entities)
```

Must be updated to show only app-filtered entities. **Requires app context parameter.**

```razor
@inject IDashboardService DashboardService
@inject IEntityMetadataService EntityMetadataService

@code {
    [Parameter]
    public string AppName { get; set; } = string.Empty;  // NEW: Required parameter

    protected override async Task OnInitializedAsync()
    {
        // Use app-scoped dashboard
        summary = await DashboardService.GetSummaryForApplicationAsync(AppName);

        // Get only entities visible in this app
        var appEntities = EntityMetadataService.GetEntitiesForApplication(AppName);
        // ... rest of logic
    }
}
```

**File: `Components/Pages/SpaApp.razor`** (UPDATE - pass AppName to sections)

Must pass `AppName` to child components:
```razor
@* In the section rendering logic: *@
<DashboardSection AppName="@AppName" />
```

---

### Phase 5.7: ViewService Integration (Priority: Medium)

> **Context:** Phase 2B implemented `IViewService`, `IViewRegistry`, `IDapperQueryService` for SQL-first views.
> Views are per-app in the new configuration. This phase makes views app-aware.

**File: `Services/Views/IViewRegistry.cs`** (EXTEND)

Add app-aware view lookup:

```csharp
public interface IViewRegistry
{
    // Existing
    ViewDefinition? GetView(string viewName);
    IReadOnlyList<ViewDefinition> GetAllViews();

    // NEW: App-filtered view access
    IReadOnlyList<ViewDefinition> GetViewsForApplication(string appName);
    bool IsViewVisibleInApplication(string viewName, string appName);
}
```

**File: `Services/Views/ViewRegistry.cs`** (EXTEND)

```csharp
public class ViewRegistry : IViewRegistry
{
    private readonly IAppDictionaryService _appDictionary;

    // NEW: App-filtered view access
    public IReadOnlyList<ViewDefinition> GetViewsForApplication(string appName)
    {
        var app = _appDictionary.GetApplication(appName);
        if (app == null || app.Views.Count == 0)
            return Array.Empty<ViewDefinition>();

        return GetAllViews()
            .Where(v => app.Views.Contains(v.Name, StringComparer.OrdinalIgnoreCase))
            .ToList();
    }

    public bool IsViewVisibleInApplication(string viewName, string appName)
    {
        var app = _appDictionary.GetApplication(appName);
        return app?.Views.Contains(viewName, StringComparer.OrdinalIgnoreCase) ?? false;
    }
}
```

**Dashboard Clarification:**

> **DECISION:** Dashboard is **app-scoped**. Each app's dashboard shows only that app's entities and views.
> The `DashboardService` should accept an `appName` parameter.

**File: `Services/DashboardService.cs`** (EXTEND)

```csharp
public interface IDashboardService
{
    // Existing (global)
    Task<DashboardSummary> GetSummaryAsync();

    // NEW: App-scoped dashboard
    Task<DashboardSummary> GetSummaryForApplicationAsync(string appName);
}

public class DashboardService : IDashboardService
{
    public async Task<DashboardSummary> GetSummaryForApplicationAsync(string appName)
    {
        // Only count entities visible in this app
        var entities = _metadataService.GetEntitiesForApplication(appName);
        var counts = new Dictionary<string, int>();

        foreach (var entity in entities)
        {
            var qualifiedName = BuildQualifiedName(entity);
            var count = await _entityOperations.GetCountAsync(entity.Type);
            counts[qualifiedName] = count;
        }

        return new DashboardSummary { EntityCounts = counts };
    }
}
```

### Phase 6: DI Registration (Priority: Critical)

**File: `Program.cs`**

Register new services:

```csharp
// Application context accessor (SCOPED - per request)
builder.Services.AddScoped<IApplicationContextAccessor, ApplicationContextAccessor>();

// App dictionary service (SINGLETON - loads apps.yaml once)
builder.Services.AddSingleton<IAppDictionaryService>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var appsYamlPath = Path.Combine(env.ContentRootPath, "apps.yaml");
    return new AppDictionaryService(appsYamlPath);  // Throws if file missing or invalid
});

// EntityMetadataService (SINGLETON - filtering happens at method level)
builder.Services.AddSingleton<IEntityMetadataService, EntityMetadataService>();
```

### Phase 7: Configuration Files (Priority: Medium)

**File: `apps.yaml` (NEW)**

Create initial multi-app configuration with real schemas (acme, initech):

```yaml
applications:
  - name: admin
    title: Admin Portal
    description: Administrative functions and user management
    icon: admin_panel_settings
    schema: acme
    entities:
      - acme:Company
      - acme:Product
      - acme:Category
    views:
      - ProductDashboardView
    theme:
      primaryColor: '#007bff'
      secondaryColor: '#6c757d'

  - name: reporting
    title: Reporting
    description: Analytics and reports
    icon: assessment
    schema: acme  # Shares with admin
    entities:
      - acme:Company
      - acme:Product
    views:
      - ProductDashboardView
    theme:
      primaryColor: '#28a745'

  - name: metrics
    title: Metrics Dashboard
    description: Initech metrics and KPIs
    icon: trending_up
    schema: initech
    entities:
      - initech:Company
      - initech:User
    theme:
      primaryColor: '#fd7e14'

# Global entity definitions (shared by all apps - from existing app.yaml)
dataModel:
  entities:
    - name: Company
      schema: acme
      properties:
        - name: id
          type: int
          required: true
        - name: name
          type: string
          required: true
    - name: Product
      schema: acme
      properties:
        - name: id
          type: int
          required: true
        - name: name
          type: string
    - name: Category
      schema: acme
      properties:
        - name: id
          type: int
          required: true
    # ... initech entities ...

# Global view definitions
views:
  views:
    - name: ProductDashboardView
      sqlFile: sql/views/ProductDashboardView.sql
```

**File: `app.yaml` (REMOVE)**

Delete the old single-app configuration file - no longer needed.

> **DDL PIPELINE NOTE:** The `make run-ddl-pipeline` command generates `app.yaml`, not `apps.yaml`.
> After this migration, you must either:
> 1. Manually merge DDL pipeline output into `apps.yaml` `dataModel.entities` section, OR
> 2. Update `DdlParser/YamlGenerator.cs` to generate `apps.yaml` format (future enhancement)

**Migration Checklist:**

```markdown
[ ] Create apps.yaml with applications array
[ ] Migrate dataModel.entities from app.yaml to apps.yaml
[ ] Migrate views from app.yaml to apps.yaml (if any)
[ ] Delete app.yaml
[ ] Update Program.cs to load "apps.yaml" instead of "app.yaml"
[ ] Remove old `/app` routes from SpaApp.razor
[ ] Update all API routes in EntitiesController
[ ] Update EntityApiService to include appName
[ ] Update NavMenu.razor for multi-app
[ ] Update SpaSectionService for app-aware sections
[ ] Delete or update GenericEntityPage.razor
[ ] Run all tests - fix any that reference old routes
[ ] Update verify.sh with new test cases
[ ] Test static files still work (css, js, images)
[ ] Test root "/" redirects to first app
```

### Phase 8: Testing (Priority: High)

#### 8.1 Update Existing verify.sh Tests (1-12)

> **CRITICAL:** All existing CRUD tests use old API routes. Every URL must be updated.

**File: `verify.sh`** - Update Tests 1-12 with appName in API routes:

```bash
# OLD FORMAT (will return 404 after migration):
curl -k -s https://localhost:7012/api/entities/acme/Product

# NEW FORMAT (with app context):
curl -k -s https://localhost:7012/api/admin/entities/acme/Product
```

**Complete test updates:**

| Test | Old URL | New URL |
|------|---------|---------|
| 1 | `/api/entities/acme/Product` | `/api/admin/entities/acme/Product` |
| 2 | `/api/entities/acme/Product/1` | `/api/admin/entities/acme/Product/1` |
| 3 | `/api/entities/acme/Product/count` | `/api/admin/entities/acme/Product/count` |
| 4 | POST `/api/entities/acme/Product` | POST `/api/admin/entities/acme/Product` |
| 5 | `/api/entities/acme/Product/{id}` | `/api/admin/entities/acme/Product/{id}` |
| 6 | PUT `/api/entities/acme/Product/{id}` | PUT `/api/admin/entities/acme/Product/{id}` |
| 7 | `/api/entities/acme/Product/{id}` | `/api/admin/entities/acme/Product/{id}` |
| 8 | DELETE `/api/entities/acme/Product/{id}` | DELETE `/api/admin/entities/acme/Product/{id}` |
| 9 | `/api/entities/acme/Product/{id}` | `/api/admin/entities/acme/Product/{id}` |
| 10 | `/api/entities/acme/Product/99999` | `/api/admin/entities/acme/Product/99999` |
| 11 | `/api/entities/invalidEntity/1` | `/api/admin/entities/invalidEntity/1` |
| 12a | `/api/entities/acme/Company` | `/api/admin/entities/acme/Company` |
| 12b | `/api/entities/initech/Company` | `/api/metrics/entities/initech/Company` |
| Final | `/api/entities/acme/Product/count` | `/api/admin/entities/acme/Product/count` |

> **NOTE:** Test 12b uses `metrics` app since that's the app configured to access `initech` schema.

Also update the server readiness check:
```bash
# OLD:
curl -k -s https://localhost:7012/api/entities/acme/Product

# NEW:
curl -k -s https://localhost:7012/api/admin/entities/acme/Product
```

---

#### 8.2 Update Existing Unit Tests

**File: `tests/DotNetWebApp.Tests/EntitiesControllerTests.cs`**

> **Changes Required:**
> 1. Controller constructor needs `IAppDictionaryService` mock
> 2. All test methods need `appName` parameter added
> 3. `TestEntityMetadataService` needs new interface methods

```csharp
// BEFORE:
var controller = new EntitiesController(operationService, metadataService);
var result = await controller.GetEntities("dbo", "Product");

// AFTER:
var appDictionary = new TestAppDictionaryService();  // NEW mock
var controller = new EntitiesController(operationService, metadataService, appDictionary);
var result = await controller.GetEntities("admin", "dbo", "Product");  // appName added
```

**Update `TestEntityMetadataService` to implement new interface:**
```csharp
private sealed class TestEntityMetadataService : IEntityMetadataService
{
    // ... existing code ...

    // NEW: Required interface methods
    public IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName)
        => _metadata != null ? new[] { _metadata } : Array.Empty<EntityMetadata>();

    public bool IsEntityVisibleInApplication(EntityMetadata entity, string appName)
        => true;  // Allow all in tests by default
}
```

**Add `TestAppDictionaryService` mock:**
```csharp
private sealed class TestAppDictionaryService : IAppDictionaryService
{
    public AppDefinition AppDefinition => new()
    {
        Applications = new List<ApplicationInfo>
        {
            new() { Name = "admin", Schema = "dbo", Entities = new List<string> { "dbo:Product", "dbo:Category" } }
        }
    };

    public IReadOnlyList<ApplicationInfo> GetAllApplications()
        => AppDefinition.Applications.AsReadOnly();

    public ApplicationInfo? GetApplication(string appName)
        => AppDefinition.Applications.FirstOrDefault(a =>
            a.Name.Equals(appName, StringComparison.OrdinalIgnoreCase));
}
```

---

**File: `tests/DotNetWebApp.Tests/EntityApiServiceTests.cs`**

> **Changes Required:**
> 1. Service constructor needs `IApplicationContextAccessor` mock
> 2. `TestEntityMetadataService` needs new interface methods (same as above)

```csharp
// BEFORE:
var service = new EntityApiService(httpClient, metadataService);

// AFTER:
var appContext = new TestApplicationContextAccessor("admin");  // NEW mock
var service = new EntityApiService(httpClient, metadataService, appContext);
```

**Add `TestApplicationContextAccessor` mock:**
```csharp
private sealed class TestApplicationContextAccessor : IApplicationContextAccessor
{
    public TestApplicationContextAccessor(string? appName) => ApplicationName = appName;
    public string? ApplicationName { get; }
}
```

---

**Summary of Unit Test Files Requiring Updates:**

| File | Changes |
|------|---------|
| `EntitiesControllerTests.cs` | Add `IAppDictionaryService` mock, add `appName` param to all calls |
| `EntityApiServiceTests.cs` | Add `IApplicationContextAccessor` mock |
| Both files | Update `TestEntityMetadataService` with new interface methods |

**File: `tests/DotNetWebApp.Tests/PipelineIntegrationTests.cs`**

> **BREAKING:** Uses `appDefinition.App.Name` which will not exist after migration.

```csharp
// BEFORE (line 120):
Assert.NotEmpty(appDefinition.App.Name);

// AFTER:
Assert.NotEmpty(appDefinition.Applications);
Assert.NotEmpty(appDefinition.Applications[0].Name);
```

**Files that do NOT need route updates:**
- `DataSeederTests.cs` - tests seeding, not API routes
- `EntityOperationServiceTests.cs` - tests service layer, not routes
- `AppDbContextSchemaTests.cs` - tests DB context, not routes
- `ViewPipelineTests.cs` - tests view pipeline, not routes
- `DdlParser.Tests/*` - tests parser, not routes
- `ModelGenerator.Tests/*` - tests generator, not routes

---

#### 8.3 New Multi-App Unit Tests

**File: `tests/DotNetWebApp.Tests/MultiAppRoutingTests.cs` (NEW)**

> **FIX:** Use `ApplicationName` (not `ApplicationId`) - consistent with interface.

```csharp
using Xunit;
using Moq;
using Microsoft.AspNetCore.Http;

namespace DotNetWebApp.Tests;

public class MultiAppRoutingTests
{
    [Fact]
    public void ApplicationContextAccessor_AdminRoute_ReturnsAdmin()
    {
        // Arrange
        var httpContextAccessor = CreateMockHttpContextAccessor("/admin/dashboard");
        var appDictionary = CreateMockAppDictionary();
        var accessor = new ApplicationContextAccessor(httpContextAccessor, appDictionary);

        // Act
        var appName = accessor.ApplicationName;  // NOT ApplicationId

        // Assert
        Assert.Equal("admin", appName);
    }

    [Fact]
    public void ApplicationContextAccessor_StaticPath_ReturnsNull()
    {
        // Arrange
        var httpContextAccessor = CreateMockHttpContextAccessor("/css/app.css");
        var appDictionary = CreateMockAppDictionary();
        var accessor = new ApplicationContextAccessor(httpContextAccessor, appDictionary);

        // Act
        var appName = accessor.ApplicationName;

        // Assert - static paths should return null, not throw
        Assert.Null(appName);
    }

    [Fact]
    public void ApplicationContextAccessor_InvalidApp_ReturnsNull()
    {
        // Arrange
        var httpContextAccessor = CreateMockHttpContextAccessor("/unknown-app/dashboard");
        var appDictionary = CreateMockAppDictionary();
        var accessor = new ApplicationContextAccessor(httpContextAccessor, appDictionary);

        // Act
        var appName = accessor.ApplicationName;

        // Assert - graceful null, not exception
        Assert.Null(appName);
    }

    [Fact]
    public void EntityMetadataService_GetEntitiesForApplication_FiltersCorrectly()
    {
        // Arrange
        var service = CreateEntityMetadataService();

        // Act
        var adminEntities = service.GetEntitiesForApplication("admin");
        var reportingEntities = service.GetEntitiesForApplication("reporting");

        // Assert - admin has Category, reporting does not
        Assert.Contains(adminEntities, e => e.Definition.Name == "Category");
        Assert.DoesNotContain(reportingEntities, e => e.Definition.Name == "Category");
    }

    [Fact]
    public void EntityMetadataService_IsEntityVisibleInApplication_ReturnsFalseForHiddenEntity()
    {
        // Arrange
        var service = CreateEntityMetadataService();
        var categoryEntity = service.Find("acme:Category");

        // Act & Assert
        Assert.True(service.IsEntityVisibleInApplication(categoryEntity!, "admin"));
        Assert.False(service.IsEntityVisibleInApplication(categoryEntity!, "reporting"));
    }

    // Helper methods for test setup...
    private static IHttpContextAccessor CreateMockHttpContextAccessor(string path) { /* ... */ }
    private static IAppDictionaryService CreateMockAppDictionary() { /* ... */ }
    private static IEntityMetadataService CreateEntityMetadataService() { /* ... */ }
}
```

## Verification (Update verify.sh)

Update `verify.sh` to test multi-app functionality with **concrete commands**:

```bash
#!/bin/bash
set -e

BASE_URL="${BASE_URL:-http://localhost:5000}"

echo "=== Multi-App Routing Tests ==="

# Test 1: Static files still work
echo "Test 1: Static files..."
curl -sf "${BASE_URL}/css/app.css" > /dev/null && echo "  ✓ CSS loads" || echo "  ✗ CSS broken"
curl -sf "${BASE_URL}/_framework/blazor.server.js" > /dev/null && echo "  ✓ Blazor JS loads" || echo "  ✗ Blazor JS broken"

# Test 2: Root redirect
echo "Test 2: Root redirect..."
REDIRECT=$(curl -s -o /dev/null -w "%{redirect_url}" "${BASE_URL}/")
[[ "$REDIRECT" == *"/admin"* ]] && echo "  ✓ Root redirects to first app" || echo "  ✗ Root redirect failed: $REDIRECT"

# Test 3: App routes work
echo "Test 3: App routes..."
curl -sf "${BASE_URL}/admin/dashboard" > /dev/null && echo "  ✓ /admin/dashboard" || echo "  ✗ /admin/dashboard"
curl -sf "${BASE_URL}/reporting/dashboard" > /dev/null && echo "  ✓ /reporting/dashboard" || echo "  ✗ /reporting/dashboard"
curl -sf "${BASE_URL}/metrics/dashboard" > /dev/null && echo "  ✓ /metrics/dashboard" || echo "  ✗ /metrics/dashboard"

# Test 4: API with app context
echo "Test 4: API endpoints..."
curl -sf "${BASE_URL}/api/admin/entities/acme/Company" > /dev/null && echo "  ✓ Admin API works" || echo "  ✗ Admin API failed"
curl -sf "${BASE_URL}/api/reporting/entities/acme/Company" > /dev/null && echo "  ✓ Reporting API works" || echo "  ✗ Reporting API failed"

# Test 5: Entity visibility enforcement (should return 404, not 403)
echo "Test 5: Entity visibility..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/api/admin/entities/acme/Category")
[[ "$STATUS" == "200" ]] && echo "  ✓ admin sees Category" || echo "  ✗ admin should see Category (got $STATUS)"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/api/reporting/entities/acme/Category")
[[ "$STATUS" == "404" ]] && echo "  ✓ reporting hidden from Category (404)" || echo "  ✗ reporting should NOT see Category (got $STATUS)"

# Test 6: Unknown app returns 404
echo "Test 6: Error handling..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/api/unknown-app/entities/acme/Company")
[[ "$STATUS" == "404" ]] && echo "  ✓ Unknown app returns 404" || echo "  ✗ Unknown app should return 404 (got $STATUS)"

# Test 7: Legacy routes are gone
echo "Test 7: Legacy routes removed..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/api/entities/acme/Company")
[[ "$STATUS" == "404" ]] && echo "  ✓ Legacy API route returns 404" || echo "  ✗ Legacy API should be gone (got $STATUS)"

echo "=== Tests Complete ==="
```

## Rollback Strategy

No rollback path - this is a clean break. The design is opinionated and forward-only:
- `/app` routes are completely removed
- `apps.yaml` is required (no fallback)
- All clients must update to new URL format (`/{appName}/...`)

Git branches can be used for staged rollout if needed.

## Critical Files Modified

| File | Change Type | Lines Changed (est.) |
|------|-------------|---------------------|
| `DotNetWebApp.Models/AppDictionary/AppDefinition.cs` | Rewrite | ~25 |
| `Services/IAppDictionaryService.cs` | **UPDATE** | +3 |
| `Services/AppDictionaryService.cs` | Rewrite | ~30 |
| `Services/IApplicationContextAccessor.cs` | **NEW** | ~10 |
| `Services/ApplicationContextAccessor.cs` | **NEW** | ~60 |
| `Services/IEntityMetadataService.cs` | **UPDATE** | +4 |
| `Services/EntityMetadataService.cs` | Enhancement | +30 |
| `Services/ISpaSectionService.cs` | **UPDATE** | +2 |
| `Services/SpaSectionService.cs` | Enhancement | +40 |
| `Services/EntityApiService.cs` | **UPDATE** | +10 |
| `Services/Views/IViewRegistry.cs` | **UPDATE** | +4 |
| `Services/Views/ViewRegistry.cs` | Enhancement | +20 |
| `Services/IDashboardService.cs` | **UPDATE** | +2 |
| `Services/DashboardService.cs` | Enhancement | +20 |
| `Components/Pages/SpaApp.razor` | Rewrite | ~35 |
| `Components/Pages/Home.razor` | **DELETE or UPDATE** | ~10 |
| `Components/Pages/GenericEntityPage.razor` | **DELETE or UPDATE** | - |
| `Components/Sections/DashboardSection.razor` | **UPDATE** | +15 |
| `Controllers/EntitiesController.cs` | Rewrite | ~40 |
| `Shared/NavMenu.razor` | Rewrite | ~40 |
| `Program.cs` | Enhancement | +8 |
| `app.yaml` | **DELETE** | - |
| `apps.yaml` | **NEW** | ~60 |
| `tests/DotNetWebApp.Tests/MultiAppRoutingTests.cs` | **NEW** | ~80 |
| `tests/DotNetWebApp.Tests/EntitiesControllerTests.cs` | **UPDATE** | +50 |
| `tests/DotNetWebApp.Tests/EntityApiServiceTests.cs` | **UPDATE** | +30 |
| `verify.sh` | **REWRITE** (all URLs) | ~60 |
| `tests/DotNetWebApp.Tests/PipelineIntegrationTests.cs` | **UPDATE** | +5 |

**Total estimated:** ~430 lines added/modified across 22 files

## Timeline Estimate

- **Phase 1-2 (Models + Context):** 1-2 days (simpler without dual-format)
- **Phase 3-4 (Filtering + Routing):** 2-3 days (cleaner rewrites)
- **Phase 5 (Navigation):** 1-2 days
- **Phase 6-7 (DI + Config):** 1 day
- **Phase 8 (Testing):** 1-2 days

**Total:** ~6-10 days (faster due to opinionated approach)

## Success Criteria

1. ✅ Multiple apps accessible via `/{appName}/...` URLs (admin, reporting, metrics)
2. ✅ Apps can share database schemas (admin + reporting both use acme) with entity-level isolation
3. ✅ Apps have dedicated schemas (metrics uses initech, admin uses acme)
4. ✅ Navigation menu shows all configured apps in left sidebar
5. ✅ API endpoints: `/api/{appName}/entities/{schema}/{entity}` respect app-level visibility
6. ✅ Hidden entities return **404 Not Found** (not 403 - avoids info leakage)
7. ✅ Apps with no entities return 204 No Content
8. ✅ Old `/app` routes throw 404 (clean break)
9. ✅ Old `/api/entities/...` routes throw 404 (clean break)
10. ✅ Static files work (`/css/app.css`, `/_framework/blazor.server.js`)
11. ✅ Root "/" redirects to first app's dashboard
12. ✅ Dashboard is app-scoped (shows only that app's entities)
13. ✅ Views are app-scoped (filtered by app.views list)
14. ✅ All existing tests updated for new routing
15. ✅ New multi-app tests pass (routing, filtering, error cases)
16. ✅ verify.sh updated with concrete test commands
