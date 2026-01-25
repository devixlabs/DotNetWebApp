# Claude Context for DotNetWebApp

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
- Run DDL Pipeline: `make run-ddl-pipeline`
- Apply Migration: `make migrate`
- Docker Build: `make docker-build`
- Clean: `make clean`

**Important:** Default `make build` excludes test projects to prevent OOM errors. Use `make build-all` if you need tests built.

## Build Commands
- The project uses a Makefile with the following targets: `check`, `build`, `dev`, `run`, `test`, `migrate`, `docker-build`, `clean`
- The dotnet-build.sh script is located in the project root and handles global.json SDK version conflicts
- Use `make <target>` for standard operations
- Use `./dotnet-build.sh <command>` directly only for advanced dotnet CLI operations not covered by Makefile targets

## SDK Version Management
The project uses `dotnet-build.sh` wrapper script to handle SDK version conflicts between Windows and WSL environments. Different developers may have different .NET SDK versions installed (e.g., from Snap, apt-get, or native installers). The wrapper temporarily bypasses `global.json` version enforcement during local development, allowing flexibility while keeping the version specification in place for CI/CD servers.

**For Windows + WSL developers**: Install any supported .NET 8.x version locally. The wrapper script handles compatibility. CI/CD and production use the exact version specified in `global.json`.

## Project Structure
```
DotNetWebApp/
├── Controllers/                   # API endpoints (GenericController<T>, EntitiesController, etc.)
├── Components/
│   ├── Pages/                    # Routable Blazor pages (Home.razor, SpaApp.razor)
│   └── Sections/                 # SPA components (Dashboard, Settings, Entity, etc.)
├── Data/
│   ├── AppDbContext.cs           # EF Core DbContext with dynamic entity discovery
│   └── DataSeeder.cs       # Executes seed.sql via EF
├── Models/
│   ├── Generated/                # 🔄 Auto-generated entities from app.yaml (Product.cs, Category.cs, etc.)
│   ├── AppDictionary/            # YAML model classes (AppDictionary.cs, Entity.cs, Property.cs, etc.)
│   └── DTOs/                     # Data transfer objects (if any)
├── Services/
│   ├── AppDictionaryService.cs   # Loads and caches app.yaml
│   ├── IEntityMetadataService.cs # Maps YAML entities to CLR types
│   └── EntityMetadataService.cs  # Implementation
├── Migrations/                   # Generated EF Core migrations (ignored in repo)
├── Pages/                        # Blazor host pages (_Host.cshtml, _Layout.cshtml)
├── Shared/                       # Shared Blazor components (MainLayout.razor, NavMenu.razor, GenericEntityPage.razor, DynamicDataGrid.razor)
├── DdlParser/                    # 🆕 SQL DDL → YAML converter (separate console project)
│   ├── Program.cs
│   ├── SqlDdlParser.cs
│   ├── CreateTableVisitor.cs
│   ├── TypeMapper.cs
│   └── YamlGenerator.cs
├── ModelGenerator/               # YAML → C# entity generator (separate console project)
├── tests/
│   └── DotNetWebApp.Tests/       # Unit/integration tests
├── wwwroot/                      # Static files (CSS, JS, images)
├── _Imports.razor                # Global Blazor using statements
├── app.yaml                      # 📋 Generated data model and theme metadata (from SQL DDL)
├── schema.sql             # Sample SQL DDL for testing DDL parser
├── seed.sql               # Sample seed data (Categories, Products)
├── Makefile                      # Build automation
├── dotnet-build.sh               # .NET SDK version wrapper
├── DotNetWebApp.sln              # Solution file
└── DotNetWebApp.csproj           # Main project file
```

## Current State

### ✅ Completed Features
- **DDL-driven data model:** SQL DDL generates `app.yaml` and entity models
- **Model Generation:** `ModelGenerator` reads `app.yaml` and generates C# entities with nullable value types for optional fields
- **Dynamic Data Layer:** `AppDbContext` discovers entities via reflection and pluralizes table names (e.g., `Product` → `Products`)
- **Generic REST API:** `GenericController<T>` provides CRUD endpoints with singular entity names (e.g., `/api/products`)
- **Dynamic Entity API:** `EntitiesController` supports `/api/entities/{entityName}` and `/api/entities/{entityName}/count`
- **Optional SPA example:** Toggle the `/app` routes via `AppCustomization:EnableSpaExample` in `appsettings.json`
- **Generic CRUD UI:** `GenericEntityPage.razor` + `DynamicDataGrid.razor` render dynamic data grids from YAML definitions
- **Dynamic Navigation:** `NavMenu.razor` renders "Data" section with links to all entities via `AppDictionaryService`
- **DDL to YAML Parser:** Complete pipeline (DdlParser → app.yaml → ModelGenerator → Models/Generated)
  - Converts SQL Server DDL files to `app.yaml` format
  - Handles table definitions, constraints, foreign keys, IDENTITY columns, DEFAULT values
  - Pipeline target: `make run-ddl-pipeline` executes the full workflow
- **Entity Metadata Service:** `IEntityMetadataService` maps app.yaml entities to CLR types for API/UI reuse
- **Seed Data System:** `DataSeeder` executes `seed.sql` once schema exists
  - Run with: `make seed`
  - Guards against duplicate inserts
- **Tenant Schema Support:** Multi-schema via `X-Customer-Schema` header (defaults to `dbo`)
- **Unit Tests:** `DotNetWebApp.Tests` covers DataSeeder with SQLite-backed integration tests
- **Shell Script Validation:** `make check` runs `shellcheck` on setup.sh and dotnet-build.sh
- **Build Passes:** `make check` and `make build` pass; `make test` passes with Release config
- **Docker Support:** Makefile includes Docker build and SQL Server container commands

### ⚠️ Current Limitations / WIP
- Generated models folder (`Models/Generated/`) is empty; needs `make build` or manual `ModelGenerator` run to populate
- Branding currently mixed between `appsettings.json` and `app.yaml` (could be fully moved to YAML)
- Composite primary keys not supported in DDL parser (single column PKs only)
- CHECK and UNIQUE constraints ignored by DDL parser
- Computed columns ignored by DDL parser

### 🔧 Development Status
- All Makefile targets working (`check`, `build`, `dev`, `run`, `test`, `migrate`, `seed`, `docker-build`, `db-start`, `db-stop`, `db-drop`)
- `dotnet-build.sh` wrapper manages .NET SDK version conflicts across Windows/WSL/Linux
- `make migrate` requires SQL Server running and valid connection string
- Session tracking via `SESSION_SUMMARY.md` for LLM continuity between sessions

## Architecture Notes
- **Hybrid architecture:** ASP.NET Core Web API backend + Blazor Server SPA frontend
- **SignalR connection:** Real-time updates between client and server
- **Entity Framework Core:** Dynamic model registration via reflection; DbContext discovers entities at startup
- **REST API design:** `GenericController<T>` provides endpoints with singular entity names (e.g., `/api/products`, `/api/categories`)
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
| `app.yaml` | 📋 Generated data model and theme configuration (from SQL DDL) |
| `Models/Generated/` | 🔄 Auto-generated C# entities (don't edit manually) |
| `schema.sql` | Sample SQL DDL demonstrating Categories/Products schema; used by `make run-ddl-pipeline` |
| `seed.sql` | Sample seed data INSERT statements for default schema; executed by `make seed` |
| `Data/AppDbContext.cs` | EF Core DbContext that discovers generated entities via reflection |
| `Services/AppDictionaryService.cs` | Loads and caches `app.yaml` for runtime access to entity definitions |
| `Services/IEntityMetadataService.cs` | Maps YAML entity names to CLR types for API/UI |
| `Controllers/GenericController<T>` | Base controller providing CRUD endpoints for all entities |
| `Components/Shared/GenericEntityPage.razor` | Reusable page component for rendering any entity's CRUD UI |
| `Components/Shared/DynamicDataGrid.razor` | Dynamic data grid component that renders columns from YAML definitions |
| `DdlParser/` | Console project: SQL DDL → `app.yaml` (standalone, not compiled into main app) |
| `ModelGenerator/` | Console project: YAML → C# entities (run separately when updating models) |
| `Makefile` | Build automation with targets for check, build, dev, test, migrate, seed, docker |
| `dotnet-build.sh` | Wrapper script managing .NET SDK version conflicts across environments |

## Recent Development History (git log)

Recent commits show the project has evolved through:
1. **Foundation (earlier commits):** Initial Blazor Server + API setup, Docker integration, self-signed certs
2. **Data Model Generation:** Introduction of YAML-driven approach with ModelGenerator
3. **DDL Parser Pipeline:** SQL DDL → YAML → C# entities workflow (commits: `7691ff2`, `d22ff0e`)
4. **Entity Metadata Service:** System for mapping YAML entities to CLR types (`5cdab1f`)
5. **Seed Data Implementation:** Integration of sample data seeding (`0e08572`)
6. **Unit Tests:** Test suite covering seed logic and integration scenarios (`89f1d3c`)

Latest work focuses on transitioning to a fully YAML-driven architecture with proper service abstraction.

## Development Notes
- Development occurs on both Windows and WSL (Ubuntu/Debian via apt-get)
- global.json specifies .NET 8.0.410 as the target version
- New developer setup: Run `./setup.sh`, then `make check`, `make db-start` (if Docker), `make run-ddl-pipeline`, and `make migrate`
- `dotnet-build.sh` sets `DOTNET_ROOT` for global tools and temporarily hides global.json during execution
- `make check` runs `shellcheck setup.sh` and `shellcheck dotnet-build.sh` before restore/build
- `make migrate` requires SQL Server running and a valid connection string; `dotnet-ef` may warn about version mismatches
- Makefile uses the wrapper script for consistency across all dotnet operations; do not modify the system .NET runtime
- Package versions use wildcards (`8.*`) to support flexibility across different developer environments while maintaining .NET 8 compatibility
