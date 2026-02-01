# Claude Context for DotNetWebApp

## 🚫 CRITICAL GIT RULE - ENFORCE STRICTLY

**Claude MUST NEVER execute git write operations. PERIOD.**

- ❌ FORBIDDEN: `git add`, `git commit`, `git push`, `git reset`, `git rebase`, `git pull`, `git checkout`, `git restore`
- ✅ ALLOWED ONLY: `git status`, `git log`, `git diff`, `git show`, `git branch`, `git remote`

**Consequence:** Using forbidden git commands breaks the codebase. This rule is non-negotiable.

## Developer Profile
You're an expert .NET/C# engineer with deep knowledge of:
- ASP.NET Core Web APIs
- Entity Framework Core
- Modern C# patterns and best practices
- RESTful API design
- Fullstack development with excellent programming skills in Javascript, HTML & CSS
- Database schema modeling (DDL-first)

## Project Overview
This is a .NET 8 Web API + Blazor Server SPA with Entity Framework Core and a SQL DDL-driven data model/branding configuration.

## 🎨 UI Framework: Radzen Blazor Components

**This project uses Radzen Blazor components for ALL UI elements.**

### When to Use the Radzen Skill
Consult the `radzen-blazor` skill (`.claude/skills/radzen-blazor/SKILL.md`) when:
- Creating or editing any `.razor` files in `Components/`, `Pages/`, `Shared/`
- Working with buttons, forms, inputs, data grids, layouts, dialogs, notifications
- User asks to "add a button", "create a form", "show a dialog", "display data", etc.
- Any UI-related requests, even if "Radzen" is not mentioned

### Critical Radzen Rules
1. **Enum properties MUST use @ prefix:** `ButtonStyle="@ButtonStyle.Primary"` (NOT `ButtonStyle="ButtonStyle.Primary"`)
2. **Use Radzen components, NOT plain HTML:** `<RadzenButton>` not `<button>`
3. **RadzenComponents directive required:** Must have `<RadzenComponents />` at end of MainLayout.razor
4. **Event handlers work by default:** This is a Blazor Server app - all components are interactive by default. Do NOT use `@rendermode InteractiveServer` (this is only for hybrid Blazor apps with static SSR)

## Important Session Notes
- **Backwards Compatibility:** NOT required for this project. Code changes can freely update existing patterns without maintaining compatibility with prior versions.
- **Git Operations:** Only use read-only git commands (status, log, diff). Do NOT use git commit, push, pull, or other write operations.
- **⚠️ CRITICAL - Claude Bot PR Reviews:** Claude Bot will flag ViewSection.razor and ApplicationSwitcher.razor as missing `@rendermode InteractiveServer`. **IGNORE THIS RECOMMENDATION.** This is a traditional Blazor Server app (not Blazor Web App). Render modes are NOT supported and WILL cause build errors: `error CS0103: The name 'InteractiveServer' does not exist in the current context`. Components in Blazor Server are interactive by default. Do NOT add the directive.

### Quick Reference
- **Full skill:** `.claude/skills/radzen-blazor/SKILL.md`
- **Component API:** `.claude/skills/radzen-blazor/references/components-quick-ref.md`
- **Styling guide:** `wwwroot/css/SKILLS.md`
- **Version:** Radzen.Blazor 7.1.0

### Common Components
- Layout: RadzenLayout, RadzenHeader, RadzenSidebar, RadzenBody
- Navigation: RadzenPanelMenu, RadzenPanelMenuItem
- Containers: RadzenStack, RadzenRow, RadzenColumn, RadzenCard
- Data: RadzenDataGrid, RadzenDataGridColumn
- Forms: RadzenButton, RadzenTextBox, RadzenNumeric, RadzenDropDown, RadzenDatePicker
- Feedback: RadzenAlert, RadzenText
- Services: DialogService, NotificationService (inject with `@inject`)

## 🚨 IMPORTANT: Architecture Documentation (READ FIRST)

**Before starting any refactoring or architectural work, read these documents in order:**

1. **ARCHITECTURE_SUMMARY.md** - Quick overview of architecture decisions and current state
2. **HYBRID_ARCHITECTURE.md** - EF Core + Dapper architecture reference and data access patterns
3. **SKILLS.md** - Comprehensive developer guides including data layer, views, API, services patterns

**Key Architectural Decisions (2026-01-27):**
- ✅ **Phase 1: Reflection Logic Extraction (2026-01-27)** - `IEntityOperationService` with compiled delegates for 250x performance optimization
- ✅ **Phase 2: SQL-First View Pipeline (2026-01-27)** - `IViewRegistry`, `IViewService`, `IDapperQueryService` services with 18 unit tests; Dapper ORM integration; ProductDashboard example component
- ✅ **Hybrid data access:** EF Core for writes (200+ entities), Dapper for complex reads (SQL-first views)
- ✅ **SQL-first everything:** Both entities (DDL) and views (SELECT queries) start as SQL
- ✅ **Single-project organization:** Namespace-based separation (NOT 4 separate projects)
- ✅ **Multi-tenancy:** Finbuckle.MultiTenant with automatic schema inheritance for Dapper
- ✅ **No Repository Pattern:** `IEntityOperationService` + `IViewService` provide sufficient abstraction
- ✅ **Scale target:** 200+ entities, multiple schemas, small team

**Current Status:** Architecture complete (Phase 1, 2, 3+4) - 192 tests passing; SQL-first view pipeline fully implemented

## 🧪 CRITICAL: Unit Testing Requirements

**Unit tests are VERY IMPORTANT for this project.** All new code must include comprehensive unit tests.

### Testing Principles
1. **Test-First Mindset:** Write tests alongside or before implementation code
2. **No Untested Code:** Every new service, generator, or significant change requires tests
3. **Run Tests Before Commit:** Always run `make test` before considering work complete
4. **Test Coverage Target:** 80%+ code coverage on service layer and generators

### Test Projects
| Project | Purpose | Run Command |
|---------|---------|-------------|
| `tests/DotNetWebApp.Tests/` | Services, Controllers, Integration | `make test` |
| `tests/ModelGenerator.Tests/` | Path resolution, template validation | `make test` |
| `tests/DdlParser.Tests/` | SQL parsing, type mapping, YAML generation | `make test` |

### What MUST Be Tested
- **All new services** (IEntityOperationService, IViewService, IViewRegistry, etc.)
- **Type mapping changes** (TypeMapper.cs has 125+ tests)
- **Code generators** (ViewModelGenerator, EntityGenerator)
- **YAML deserialization** (ViewDefinition, AppDefinition classes)
- **Controller endpoints** (CRUD operations, validation)
- **Multi-tenant scenarios** (schema isolation)

### Testing Commands
```bash
make test                    # Run all tests (builds test projects first)
make build-all               # Build including test projects
./dotnet-build.sh test tests/DdlParser.Tests/DdlParser.Tests.csproj --no-restore  # Run specific project
```

### Example Test Pattern
```csharp
[Fact]
public async Task ServiceMethod_ValidInput_ReturnsExpectedResult()
{
    // Arrange
    var service = new MyService(mockDependency);

    // Act
    var result = await service.DoSomethingAsync(input);

    // Assert
    Assert.NotNull(result);
    Assert.Equal(expected, result.Value);
}
```

## Project Goal & Session Notes
- **Primary Goal:** Use SQL DDL as the source of truth, generating `app.yaml` and C# models for dynamic customization.
- Review `SESSION_SUMMARY.md` before starting work and update it when you make meaningful progress or decisions.
- **Build Optimizations:** See `BUILD_OPTIMIZATION_SUMMARY.md` for complete details on build performance improvements (30+ min → 2-5 min)

## Key Commands
- Check/Setup: `make check` (restore and build main projects - 4-8 min)
- Build: `make build` (fast Debug build, main projects only - 2-5 min)
- Build All: `make build-all` (includes test projects - 10-20 min, higher memory)
- Build Release: `make build-release` (production build - 10-20 min)
- Run (dev): `make dev` (with hot reload - use for active development)
- Run (prod): `make run` (without hot reload - use for production-like testing)
- Test: `make test` (build and run tests sequentially - 10-15 min)
- Run DDL Pipeline: `make run-ddl-pipeline` (unified pipeline: entities + views from sql/schema.sql + appsettings.json → app.yaml)
- End-to-End Verification: `./verify.sh` (complete pipeline + seed + dev server + integration tests; use instead of manual command sequences)
- Seed Database: `make seed` - Executes sql/seed.sql; ensure all column names match schema.sql exactly
- Apply Migration: `make migrate`
- Docker Build: `make docker-build`
- Clean: `make clean` (cleans build outputs + stops build servers + stops dev sessions)
- Stop Dev: `make stop-dev` (kills orphaned `dotnet watch` processes)
- Shutdown Build Servers: `make shutdown-build-servers` (kills MSBuild/Roslyn processes)

**Important:** Default `make build` excludes test projects to prevent OOM errors. Use `make build-all` if you need tests built.

## Build Commands
- The project uses a Makefile with the following targets: `check`, `build`, `dev`, `run`, `test`, `migrate`, `docker-build`, `clean`, `stop-dev`, `shutdown-build-servers`
- The dotnet-build.sh script is located in the project root and handles global.json SDK version conflicts
- Use `make <target>` for standard operations
- Use `./dotnet-build.sh <command>` directly only for advanced dotnet CLI operations not covered by Makefile targets
- **Process cleanup:** If you notice accumulating dotnet processes, run `make clean` (full cleanup) or individually `make stop-dev` / `make shutdown-build-servers`

## SDK Version Management
The project uses `dotnet-build.sh` wrapper script to handle SDK version conflicts between Windows and WSL environments. Different developers may have different .NET SDK versions installed (e.g., from Snap, apt-get, or native installers). The wrapper temporarily bypasses `global.json` version enforcement during local development, allowing flexibility while keeping the version specification in place for CI/CD servers.

**For Windows + WSL developers**: Install any supported .NET 8.x version locally. The wrapper script handles compatibility. CI/CD and production use the exact version specified in `global.json`.

## Project Structure
```
DotNetWebApp/
├── sql/
│   ├── schema.sql                # 📋 SQL DDL source (entities)
│   └── views/                    # 🆕 SQL SELECT queries for complex views
│       ├── ProductSalesView.sql
│       └── ...
├── Controllers/                  # API endpoints (EntitiesController, etc.)
├── Components/
│   ├── Pages/                    # Routable Blazor pages (Home.razor, SpaApp.razor)
│   └── Sections/                 # SPA components (Dashboard, Settings, Entity, etc.)
├── Data/
│   ├── AppDbContext.cs           # EF Core DbContext with dynamic entity discovery
│   ├── DataSeeder.cs             # Executes sql/seed.sql via EF
│   └── Dapper/                   # 🆕 Dapper infrastructure (SQL view execution)
│       ├── IDapperQueryService.cs
│       └── DapperQueryService.cs
├── DotNetWebApp.Models/          # 🔄 Separate models assembly (extracted from main project)
│   ├── Generated/                # 🔄 Auto-generated entities from app.yaml (Product.cs, Category.cs, etc.)
│   ├── ViewModels/               # 🆕 Auto-generated view models from appsettings.json ViewDefinitions
│   ├── AppDictionary/            # YAML model classes (AppDefinition.cs, Entity.cs, Property.cs, etc.)
│   ├── AppCustomizationOptions.cs  # App customization settings
│   ├── DashboardSummary.cs       # Dashboard data model
│   ├── DataSeederOptions.cs      # Data seeder configuration
│   ├── EntityMetadata.cs         # Entity metadata record
│   ├── SpaSection.cs             # SPA section model
│   └── SpaSectionInfo.cs         # SPA section info model
├── Services/
│   ├── AppDictionaryService.cs   # Loads and caches app.yaml
│   ├── IEntityMetadataService.cs # Maps YAML entities to CLR types
│   ├── EntityMetadataService.cs  # Implementation
│   ├── IEntityOperationService.cs # ✅ EF CRUD operations (Phase 1 - COMPLETED 2026-01-27)
│   ├── EntityOperationService.cs  # ✅ Implementation with compiled delegates (Phase 1 - COMPLETED 2026-01-27)
│   └── Views/                    # 🆕 Dapper view services (Phase 2)
│       ├── IViewRegistry.cs
│       ├── ViewRegistry.cs
│       ├── IViewService.cs
│       └── ViewService.cs
├── Migrations/                   # Generated EF Core migrations
├── Pages/                        # Blazor host pages (_Host.cshtml, _Layout.cshtml)
├── Shared/                       # Shared Blazor components (MainLayout.razor, NavMenu.razor, GenericEntityPage.razor, DynamicDataGrid.razor)
├── DdlParser/                    # SQL DDL → YAML converter (separate console project)
│   ├── Program.cs
│   ├── SqlDdlParser.cs
│   ├── CreateTableVisitor.cs
│   ├── TypeMapper.cs
│   └── YamlGenerator.cs
├── ModelGenerator/               # YAML → C# generator (separate console project)
│   ├── EntityGenerator.cs        # Entities from app.yaml (existing)
│   └── ViewModelGenerator.cs     # 🆕 Views from appsettings.json ViewDefinitions
├── tests/
│   ├── DotNetWebApp.Tests/       # Unit/integration tests
│   └── ModelGenerator.Tests/     # Model generator path resolution tests
├── wwwroot/                      # Static files (CSS, JS, images)
├── _Imports.razor                # Global Blazor using statements
├── appsettings.json              # Configuration: includes ViewDefinitions for view generation
├── app.yaml                      # 📋 Final runtime config (generated: entities + views)
├── sql/
│   ├── schema.sql                # Source SQL DDL for testing DDL parser
│   ├── seed.sql                  # Seed data (Categories, Products)
│   └── views/                    # SQL SELECT queries for views
├── Makefile                      # Build automation
├── dotnet-build.sh               # .NET SDK version wrapper
├── HYBRID_ARCHITECTURE.md        # EF+Dapper architecture reference
├── ARCHITECTURE_SUMMARY.md       # Quick architecture overview
├── DotNetWebApp.sln              # Solution file (includes all projects)
└── DotNetWebApp.csproj           # Main project file
```

## Current State

### ✅ Completed Features
- **DDL-driven data model:** SQL DDL generates `app.yaml` and entity models
- **Model Generation:** `ModelGenerator` reads `app.yaml` and generates C# entities with nullable value types for optional fields
- **Modular Architecture:** Models extracted to separate `DotNetWebApp.Models` assembly for better separation of concerns
- **Dynamic Data Layer:** `AppDbContext` discovers entities via reflection and pluralizes table names (e.g., `Product` → `Products`)
- **Dynamic Entity API:** `EntitiesController` provides CRUD endpoints at `/api/entities/{entityName}` and `/api/entities/{entityName}/count`
- **Optional SPA example:** Toggle the `/app` routes via `AppCustomization:EnableSpaExample` in `appsettings.json`
- **Generic CRUD UI:** `GenericEntityPage.razor` + `DynamicDataGrid.razor` render dynamic data grids from YAML definitions
- **Dynamic Navigation:** `NavMenu.razor` renders "Data" section with schema-qualified links (e.g., `/entity/acme/Company`) and labels showing schema for disambiguation
- **DDL to YAML Parser:** Complete pipeline (DdlParser → app.yaml → ModelGenerator → DotNetWebApp.Models/Generated)
  - Converts SQL Server DDL files to `app.yaml` format
  - Handles table definitions, constraints, foreign keys, IDENTITY columns, DEFAULT values
  - Pipeline target: `make run-ddl-pipeline` executes the full workflow
- **Entity Metadata Service:** `IEntityMetadataService` maps app.yaml entities to CLR types for API/UI reuse
- **Seed Data System:** `DataSeeder` executes `sql/seed.sql` once schema exists
  - Run with: `make seed`
  - Guards against duplicate inserts
- **Tenant Schema Support:** Multi-schema via `X-Customer-Schema` header (defaults to `dbo`)
- **Unit Tests:** `DotNetWebApp.Tests` covers DataSeeder with SQLite-backed integration tests; `ModelGenerator.Tests` validates path resolution
- **Shell Script Validation:** `make check` runs `shellcheck` on setup.sh, dotnet-build.sh, and verify.sh
- **Build Passes:** `make check` and `make build` pass; `make test` passes with Release config
- **Build Optimization:** `cleanup-nested-dirs` Makefile target prevents inotify exhaustion on Linux systems
- **Docker Support:** Makefile includes Docker build and SQL Server container commands
- **Phase 1 - Reflection Logic Extraction (2026-01-27):** ✅ COMPLETED
  - `IEntityOperationService` interface centralizes all CRUD operations
  - `EntityOperationService` implementation with compiled expression tree delegates
  - Cached compiled delegates provide 250x performance improvement (first call ~500μs, subsequent ~2μs)
  - EntitiesController reduced from 369 to 236 lines (36% reduction)
  - All reflection logic removed from controller (moved to service layer)
  - Comprehensive test suite added (30+ tests for EntityOperationService)
  - All existing tests passing (45 total tests across all projects)

### ⚠️ Current Limitations / WIP
- Generated models folder (`DotNetWebApp.Models/Generated/`) is empty initially; populated by `make run-ddl-pipeline` or manual `ModelGenerator` run
- Branding currently mixed between `appsettings.json` and `app.yaml` (could be fully moved to YAML)
- **Composite primary/foreign keys not supported in DDL parser** (single column PKs/FKs only). Tables using composite keys are commented out in `sql/*.sql` files:
  - `acuity_forms` - composite PK (`id`, `appointment_id`)
  - `acuity_form_values` - composite FK referencing `acuity_forms`
- **`__EFMigrationsHistory` must NOT be in schema.sql** - EF Core creates this table automatically. Including it causes "table already exists" errors during migration. This table is commented out in all `sql/*.sql` files.
- CHECK and UNIQUE constraints ignored by DDL parser
- Computed columns ignored by DDL parser

### ⚠️ Seed Data Constraints

- **seed.sql MUST match schema.sql exactly** - Column names, NOT NULL constraints, and foreign key dependencies must align. When fixing seed.sql, examine the CREATE TABLE statements in schema.sql directly rather than relying on documentation.
- **NOT NULL columns require values** - Complex legacy tables often have many NOT NULL columns. Full seed data requires satisfying complete FK dependency chains; alternatively, exclude these tables and seed only via application logic.
- **Minimal seed strategy for testing** - Seed only simple, dependency-free tables when building test datasets. Complex tables with FK requirements should be excluded or populated by application logic.
- **Commented-out tables in schema.sql should not be seeded** - Keep seed.sql in sync with which tables are disabled. Update seed comments when schema.sql table definitions change.

### Database Reset & Seed Pipeline

- **Standard reset flow:** `make db-drop && make run-ddl-pipeline && make migrate && make seed` - Use this for clean slate after schema.sql changes.
- **End-to-end testing:** Use `./verify.sh` instead of running commands individually - it handles the full pipeline, starts the dev server, and runs comprehensive CRUD tests with automatic cleanup.
- **Verify.sh stages:** (1) make check, (2) make test, (3) db-drop, (4) run-ddl-pipeline, (5) migrate, (6) seed, (7) start dev server, (8) run integration tests.

### 🔧 Development Status
- All Makefile targets working (`check`, `build`, `dev`, `run`, `test`, `migrate`, `seed`, `docker-build`, `db-start`, `db-stop`, `db-destroy`, `db-create`, `db-drop`, `stop-dev`, `shutdown-build-servers`)
- `dotnet-build.sh` wrapper manages .NET SDK version conflicts across Windows/WSL/Linux
- `make migrate` requires SQL Server running and valid connection string
- Session tracking via `SESSION_SUMMARY.md` for LLM continuity between sessions
- **Database schema changes:** When `schema.sql` structure changes significantly, run `make db-drop` before `make migrate` to clear stale EF migrations that cause "already exists" errors. The `db-drop` target now clears migrations AND drops the database for a clean slate.

### ⚠️ Known Process Management Pitfalls
- **MSBuild node reuse:** `dotnet build` spawns MSBuild node processes (`/nodeReuse:true`) that persist after builds. Use `make shutdown-build-servers` to force-kill them.
- **dotnet build-server shutdown limitations:** The `dotnet build-server shutdown` command claims success but orphaned MSBuild/Roslyn processes may not actually terminate. Our `shutdown-build-servers` target force-kills stuck processes after attempting graceful shutdown.
- **dotnet watch signal handling:** `dotnet watch` catches SIGTERM (default `kill` signal) for graceful shutdown but ignores it when orphaned/detached. Must use `kill -9` (SIGKILL) to terminate. Use `make stop-dev` which handles this correctly.
- **Zombie processes:** Killed processes may become zombies (`<defunct>`) until parent reaps them. These are harmless and don't consume resources.
- **Process accumulation:** Running multiple `make` commands (especially `test`, `run-ddl-pipeline`) without cleanup causes dotnet process accumulation. Run `make clean` periodically or `make stop-dev` + `make shutdown-build-servers` as needed.
- **Wrapper script processes:** The `dotnet-build.sh` wrapper may leave bash process entries after termination. These typically become zombies and don't need manual cleanup.

## 🚨 Multi-Schema Support: Critical Pitfalls

**This project is DDL-driven.** Everything flows from `sql/schema.sql` → `app.yaml` → generated C# models. Multiple schemas with identical table names (e.g., `acme.Companies` and `initech.Companies`) are perfectly valid SQL but require careful handling throughout the codebase.

### The Problem
When the same table name exists in multiple schemas, components must use **schema-qualified names** (`schema:TableName`) everywhere—not just plain table names. Failing to do so causes:
- **Wrong data returned:** API fetches `acme.Company` when `initech.Company` was requested
- **Type casting errors:** `InvalidCastException: Unable to cast 'Acme.Company' to 'Initech.Company'`
- **Dictionary key collisions:** `An item with the same key has already been added. Key: Company`

### Schema-Qualified Name Formats
- **Browser URLs:** `schema/TableName` (e.g., `/entity/acme/Company`, `/app/initech/Company`) - uses slash, URL-safe
- **API endpoints:** `schema:TableName` (e.g., `/api/entities/acme:Company`) - uses colon internally
- **C# Namespaces:** `DotNetWebApp.Models.Generated.{PascalSchema}.{TableName}` (e.g., `...Generated.Acme.Company`)
- **YAML (app.yaml):** Uses lowercase `schema:` field (e.g., `schema: initech`)

**Important:** Colons in URLs are interpreted by browsers as protocol schemes (like `mailto:`), causing `xdg-open` popups. Always use slashes for browser-facing URLs and convert to colons for API calls.

### Files That Must Use Qualified Names
| File | What to use | NOT this |
|------|-------------|----------|
| `EntityMetadataService.cs` | Pascal-cased schema in namespace: `Generated.Initech.Company` | `Generated.initech.Company` |
| `DashboardService.cs` | `$"{schema}:{name}"` in both try AND catch blocks | `entity.Definition.Name` |
| `EntitySection.razor` | `EntityName` parameter (colon format for API) | `metadata.Definition.Name` |
| `GenericEntityPage.razor` | Convert URL `Schema/EntityName` to API `schema:name` | Using URL format for API |
| `NavMenu.razor` | Build path as `entity/{schema}/{name}` (slash for URLs) | Colons in browser URLs |
| `SpaSectionService.cs` | RouteSegment=`schema/name`, EntityName=`schema:name` | Same format for both |
| `SpaApp.razor` | Convert URL slash format to API colon format | Using slash format for API |

### Key Patterns

**URL Routing (use slashes):**
```csharp
// ✅ CORRECT - slash-separated for browser URLs
var path = $"entity/{entity.Schema}/{entity.Name}";  // "/entity/acme/Company"

// ❌ WRONG - colon triggers browser protocol handler popup
var path = $"{entity.Schema}:{entity.Name}";  // "acme:Company" causes xdg-open!
```

**API Calls (use colons):**
```csharp
// ✅ CORRECT - colon-separated for API calls
var qualifiedName = $"{schema}:{entityName}";  // "acme:Company"
var result = await EntityApiService.GetEntitiesAsync(qualifiedName);

// ❌ WRONG - strips schema, returns wrong data when duplicate table names exist
var result = await EntityApiService.GetEntitiesAsync(metadata.Definition.Name);
```

### Regression Test
`verify.sh` Test 12 validates multi-schema isolation by checking that `acme:Company` returns `name` field and `initech:Company` returns `companyName` field (they have different schemas with different properties).

## Architecture Notes
- **Hybrid architecture:** ASP.NET Core Web API backend + Blazor Server SPA frontend
- **SignalR connection:** Real-time updates between client and server
- **Entity Framework Core:** Dynamic model registration via reflection; DbContext discovers entities at startup
- **REST API design:** `EntitiesController` serves dynamic endpoints at `/api/entities/{entityName}`
- **UI architecture:** Generic Blazor pages (`GenericEntityPage.razor`) with reusable data grid components
- **YAML-driven generation:** `ModelGenerator` reads `app.yaml` → generates entities → migration generated for schema application
- **DDL parser pipeline:** SQL Server DDL → `app.yaml` → C# entities → migration generation
- **Data model:** All entities support IDENTITY primary keys, nullable value types for optional fields, foreign key relationships
- **Multi-tenancy:** Schema switching via `X-Customer-Schema` HTTP header
- **CSS:** Global animations (pulse, spin, slideIn) in `wwwroot/css/app.css`
- **Dependency injection:** Services registered in `Program.cs` (DbContext, AppDictionaryService, EntityMetadataService, DataSeeder)

## Secrets Management
- Project uses **User Secrets** for local development (see SECRETS.md for details)
- Connection strings stored in `~/.microsoft/usersecrets/`, never in git
- `setup.sh` script automatically configures User Secrets when setting up SQL Server
- Manual management: `dotnet user-secrets list`, `dotnet user-secrets set`, etc.

## Key Files and Their Purposes

| File | Purpose |
|------|---------|
| `appsettings.json` | Configuration file with ViewDefinitions section; defines SQL views for code generation and app visibility |
| `app.yaml` | 📋 Generated runtime configuration with entities + views (generated from sql/schema.sql + appsettings.json) |
| `DotNetWebApp.Models/` | 🔄 Separate models assembly containing all data models and configuration classes |
| `DotNetWebApp.Models/Generated/` | 🔄 Auto-generated C# entities (don't edit manually) |
| `DotNetWebApp.Models/ViewModels/` | 🔄 Auto-generated C# view models from appsettings.json ViewDefinitions (don't edit manually) |
| `DotNetWebApp.Models/AppDictionary/` | YAML model classes for app.yaml structure |
| `sql/schema.sql` | SQL DDL source for entities; parsed by `make run-ddl-pipeline` |
| `sql/views/` | SQL SELECT queries for views; referenced by appsettings.json ViewDefinitions |
| `sql/seed.sql` | Sample seed data INSERT statements for default schema; executed by `make seed` |
| `Data/AppDbContext.cs` | EF Core DbContext that discovers generated entities via reflection |
| `Services/AppDictionaryService.cs` | Loads and caches `app.yaml` for runtime access to entity definitions |
| `Services/IEntityMetadataService.cs` | Maps YAML entity names to CLR types for API/UI |
| `Controllers/EntitiesController.cs` | Dynamic controller providing CRUD endpoints for all entities |
| `Components/Shared/GenericEntityPage.razor` | Reusable page component for rendering any entity's CRUD UI |
| `Components/Shared/DynamicDataGrid.razor` | Dynamic data grid component that renders columns from YAML definitions |
| `Services/Views/` | View services for Dapper-based read operations (IViewRegistry, IViewService, IDapperQueryService) |
| `DdlParser/` | Console project: SQL DDL → YAML (standalone, not compiled into main app) |
| `ModelGenerator/` | Console project: YAML → C# entities & view models (run separately when updating models) |
| `YamlMerger/` | Console project: Merges appsettings.json ViewDefinitions into data.yaml during pipeline |
| `AppsYamlGenerator/` | Console project: Merges Applications from appsettings.json with data.yaml to generate app.yaml |
| `Makefile` | Build automation with unified `make run-ddl-pipeline` target that handles entities + views |
| `dotnet-build.sh` | Wrapper script managing .NET SDK version conflicts across environments |

## Recent Development History (git log)

Recent commits show the project has evolved through:
1. **Foundation (earlier commits):** Initial Blazor Server + API setup, Docker integration, self-signed certs
2. **Data Model Generation:** Introduction of YAML-driven approach with ModelGenerator
3. **DDL Parser Pipeline:** SQL DDL → YAML → C# entities workflow
4. **Entity Metadata Service:** System for mapping YAML entities to CLR types
5. **Seed Data Implementation:** Integration of sample data seeding
6. **Unit Tests:** Test suite covering seed logic and integration scenarios
7. **Models Extraction (2026-01-25):** Models moved to separate `DotNetWebApp.Models` project for better separation of concerns (commits: `552127d`, `601f84d`)
8. **Build Optimization (2026-01-25):** Added `cleanup-nested-dirs` Makefile target to prevent inotify exhaustion on Linux
9. **Documentation Expansion (2026-01-25):** SKILLS.md significantly expanded with comprehensive guides; SESSION_SUMMARY.md simplified to documentation index

Latest work focuses on modular architecture and comprehensive developer documentation.

## Development Notes
- Development occurs on both Windows and WSL (Ubuntu/Debian via apt-get)
- global.json specifies .NET 8.0.410 as the target version
- New developer setup: Run `./setup.sh`, then `make check`, `make db-start` (if Docker), `make run-ddl-pipeline`, and `make migrate`
- `dotnet-build.sh` sets `DOTNET_ROOT` for global tools and temporarily hides global.json during execution
- `make check` runs `shellcheck` on all shell scripts (setup.sh, dotnet-build.sh, verify.sh) before restore/build
- `make migrate` requires SQL Server running and a valid connection string; `dotnet-ef` may warn about version mismatches
- `make cleanup-nested-dirs` removes nested project directories created by MSBuild to prevent inotify watch exhaustion on Linux (runs automatically after `make build-all` and `make test`)
- Makefile uses the wrapper script for consistency across all dotnet operations; do not modify the system .NET runtime
- Package versions use wildcards (`8.*`) to support flexibility across different developer environments while maintaining .NET 8 compatibility
- Models are in separate `DotNetWebApp.Models` project; YamlDotNet dependency lives there (removed from main project)
- **SQL table case sensitivity:** `schema.sql` and `seed.sql` must use identical table name casing (lowercase recommended); the codebase cannot apply automatic case transformations without breaking SQL queries
- **verify.sh end-to-end test:** `./verify.sh` runs the complete pipeline (db-drop → run-ddl-pipeline → migrate → seed → CRUD tests) and is the canonical way to verify clean slate database setup from schema.sql changes. Update test entity names in verify.sh when changing schema.sql entities (currently hardcoded to acme:Product, initech:Company)
