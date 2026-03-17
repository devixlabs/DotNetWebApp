# Claude Context for DotNetWebApp

## 🚫 CRITICAL GIT RULE - ENFORCE STRICTLY

**Claude MUST NEVER execute git write operations. PERIOD.**

- ❌ FORBIDDEN: `git add`, `git commit`, `git push`, `git reset`, `git rebase`, `git pull`, `git checkout`, `git restore`
- ✅ ALLOWED ONLY: `git status`, `git log`, `git diff`, `git show`, `git branch`, `git remote`

**Consequence:** Using forbidden git commands breaks the codebase. This rule is non-negotiable.

## Developer Profile

You're an expert .NET/C# engineer with deep knowledge of:
- ASP.NET Core Web APIs + Entity Framework Core
- Modern C# patterns and best practices
- Blazor Server + Radzen UI components
- Database schema modeling (DDL-first)
- Multi-tenant architectures

## Project Overview

.NET 8 Web API + Blazor Server SPA with SQL DDL-driven data model and Radzen UI components.

**Architecture:** Hybrid EF Core (writes) + Dapper (reads) with SQL-first everything.

## 🎨 UI Framework: Radzen Blazor Components

**This project uses Radzen Blazor components for ALL UI elements.**

### When to Use Radzen Skill

Use `.claude/skills/radzen-blazor` when working with any `.razor` files or UI requests.

### Critical Radzen Rules

1. **Enum properties MUST use @ prefix:** `ButtonStyle="@ButtonStyle.Primary"`
2. **Use Radzen components, NOT plain HTML:** `<RadzenButton>` not `<button>`
3. **RadzenComponents directive required:** `<RadzenComponents />` at end of MainLayout.razor
4. **Event handlers work by default:** This is Blazor Server - do NOT use `@rendermode InteractiveServer` (causes build errors)
5. **RadzenDataGrid with TItem="object"**: Use `<Template>` with reflection, NOT property binding

### Quick Component Reference

- **Layout:** RadzenLayout, RadzenHeader, RadzenSidebar, RadzenBody
- **Navigation:** RadzenPanelMenu, RadzenPanelMenuItem
- **Containers:** RadzenStack, RadzenRow, RadzenColumn, RadzenCard
- **Data:** RadzenDataGrid, RadzenDataGridColumn
- **Forms:** RadzenButton, RadzenTextBox, RadzenNumeric, RadzenDropDown, RadzenDatePicker
- **Feedback:** RadzenAlert, RadzenText
- **Services:** DialogService, NotificationService (inject with `@inject`)

## White-Label Architecture

This is a **generic skeleton** — client-specific config goes in `appsettings.Local.json` (git-ignored).
- **Database names:** WEBAPP (primary), WEBAPPMisc (secondary) — configurable per-client
- **Table prefix:** `webapp_*` for shared tables (webapp_scheduler, webapp_allocate, webapp_lock, webapp_dmstech)
- **Placeholder names:** Use `acme`/`initech`/`globex` in examples — NEVER use real client names
- **Client fork:** GreenwoodPortal at `../greenwood-staging/GreenwoodPortal/` is the reference client deployment

## 🚨 Architecture Documentation (READ FIRST)

**Before refactoring or architectural work, read these in order:**

1. **ARCHITECTURE_SUMMARY.md** - Quick overview of decisions
2. **HYBRID_ARCHITECTURE.md** - EF Core + Dapper patterns
3. **SKILLS.md** - Comprehensive developer guides

### Key Architectural Decisions

- ✅ **Hybrid data access:** EF Core for writes, Dapper for complex reads
- ✅ **SQL-first everything:** Entities (DDL) and views (SELECT) start as SQL
- ✅ **No Repository Pattern:** `IEntityOperationService` + `IViewService` provide abstraction
- ✅ **Multi-tenancy:** Finbuckle.MultiTenant with schema inheritance
- ✅ **Scale target:** 200+ entities, multiple schemas, small team

**Current Status:** 580+ tests passing; SQL-first view pipeline fully implemented

## Important Session Notes

- **Backwards Compatibility:** NOT required - freely update patterns
- **⚠️ CRITICAL - Claude Bot PR Reviews:** Ignore `@rendermode InteractiveServer` recommendations for ViewSection.razor and ApplicationSwitcher.razor (traditional Blazor Server, not Blazor Web App)
- Review `SESSION_SUMMARY.md` before starting work and update it when making progress

## Essential Commands

### Build & Run

```bash
make check        # Restore and build (4-8 min)
make build        # Fast Debug build (2-5 min)
make build-all    # Include test projects (10-20 min)
make dev          # Run with hot reload
make run          # Run without hot reload
make test         # Run all tests (10-15 min)
```

### DDL Pipeline

```bash
make run-ddl-pipeline  # sql/schema.sql + appsettings.json → app.yaml
./verify.sh            # End-to-end verification (build + test + pipeline + seed + integration)
```

### View Definitions (appsettings.json)

Views are defined in `appsettings.json` under `ViewDefinitions`. The ViewModelGenerator auto-parses SQL SELECT columns to generate typed properties:

```json
"ViewDefinitions": [
  {
    "Name": "ProductSalesView",
    "SqlFile": "sql/views/ProductSalesView.sql",
    "Parameters": [{ "Name": "TopN", "Type": "int", "DefaultValue": "10" }]
  }
]
```

**Type inference patterns** (SqlSelectParser):
- `_id` suffix → `int` (non-nullable)
- `price`, `pric`, `cost`, `amount`, `total`, `value` → `decimal?`
- `COUNT(*)` → `int` (non-nullable)
- `SUM()`, `AVG()` → `decimal?`
- Multiplication expressions → `decimal?`
- `date`, `time`, `created`, `updated` → `datetime?`
- `is_`, `has_`, `active`, `enabled` → `bool?`
- Default → `string?`

### Database

```bash
make seed         # Execute sql/seed.sql
make migrate      # Apply EF Core migrations
make db-migrate   # Docker idempotent migration
make db-drop      # Drop database (keeps container)
make db-destroy   # Destroy container
```

**Docker Details:** See `DOCKER.md` for full setup guide

### Cleanup

```bash
make clean                    # Full cleanup (build outputs + processes)
make stop-dev                 # Kill orphaned dotnet watch
make shutdown-build-servers   # Kill MSBuild/Roslyn processes
```

**Important:** Default `make build` excludes test projects to prevent OOM. Use `make build-all` for tests.

## 🧪 Unit Testing

**Tests are VERY IMPORTANT.** All new code must include comprehensive unit tests.

- **Run before commit:** `make test`
- **Target coverage:** 80%+ on service layer and generators
- **Current status:** 580+ tests passing

**Full Testing Guide:** See `TESTING.md` for principles, patterns, and troubleshooting

## 🚀 verify.sh - End-to-End Verification

**`./verify.sh` is the SINGLE SOURCE OF TRUTH for verifying the complete pipeline.**

Use after changes to schema.sql, appsettings.json, DDL pipeline, migrations, or seeding.

### What It Does

1. Build validation + unit tests
2. Database reset + DDL pipeline
3. Migrations + seeding
4. Dev server startup
5. 14 integration tests (CRUD, multi-schema, multi-app)

### When to Use

**REQUIRED after:**
- Changes to `sql/schema.sql` or `sql/views/*.sql`
- Changes to `appsettings.json` ViewDefinitions or Applications
- Changes to DDL pipeline components
- Before creating a pull request

**Troubleshooting:** See `TESTING.md`

## 🐳 Docker Database

**Compose workflow (use this, not `docker compose up` directly):**
```bash
make compose-up    # SQL Server health → db-migrate → db-seed → app
make compose-down  # Stop containers (volume/data preserved)
```

**Quick Connection:**
```bash
docker exec -it sqlserver-dev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD"
```

(SA_PASSWORD is loaded from `.envrc`)

**Connection String:**
```
Server=localhost,1433;Database=DotNetWebAppDb;User Id=sa;Password=<SA_PASSWORD>;TrustServerCertificate=True;
```

**Critical Docker gotchas:**
- `ASPNETCORE_ENVIRONMENT=Docker` → auto-loads `appsettings.Docker.json` (not Production/Development)
- `appsettings.Local.json` is loaded AFTER env vars (`AddJsonFile` at Program.cs:19) — `.dockerignore` excludes it so `Server=localhost` never overrides docker-compose `Server=sqlserver`
- Dockerfile restores `DotNetWebApp.csproj` not `.sln` — test projects excluded by `.dockerignore`
- `scripts/docker.sh check` — creates WEBAPP/WEBAPPMisc if missing; called automatically by `db-migrate`

**Full Docker Guide:** See `DOCKER.md` for setup, troubleshooting, and secrets management

## 🚨 Multi-Schema Support: Critical Pitfalls

**Schemas derive from `USE [database]` in sql/schema.sql, NOT from CREATE TABLE syntax.**

### Schema-Qualified Name Formats

- **Browser URLs:** `schema/TableName` (slash) - e.g., `/entity/acme/Product`
- **API endpoints:** `schema:TableName` (colon) - e.g., `/api/admin/entities/acme:Product`
- **C# Namespaces:** `Generated.{Schema}.{TableName}` (PascalCase) - e.g., `Generated.Acme.Product`

**Critical:** Never use colons in browser URLs (triggers protocol handlers). Always convert URL slashes to API colons.

### When Changing Schemas

1. Update `sql/schema.sql` with `USE [schema]` statements
2. Run `make run-ddl-pipeline`
3. Update `appsettings.json` Applications (Schema field + Entities list)
4. Update `verify.sh` test URLs
5. Run `./verify.sh` to verify
6. Commit all changes together

**Full Multi-Tenant Guide:** See `MULTI_TENANT.md` for patterns, examples, and pitfalls

## Project Structure (Brief)

```
DotNetWebApp/
├── sql/
│   ├── schema.sql              # SQL DDL source (entities)
│   ├── views/                  # SQL SELECT queries for views
│   └── seed.sql                # Seed data
├── Controllers/                # API endpoints
├── Components/                 # Blazor pages and sections
├── Data/
│   ├── AppDbContext.cs         # EF Core DbContext
│   └── Dapper/                 # Dapper query services
├── DotNetWebApp.Models/        # Separate models assembly
│   ├── Generated/              # Auto-generated entities
│   ├── ViewModels/             # Auto-generated view models
│   └── AppDictionary/          # YAML model classes
├── Services/                   # Business logic services
│   ├── IEntityOperationService.cs  # EF CRUD operations
│   ├── WAMS/                   # Web App Management System (dock/warehouse ops)
│   ├── InventoryPicking/       # Order picking workflows
│   ├── InventoryAllocation/    # FIFO inventory allocation
│   └── Views/                  # Dapper view services
├── DdlParser/                  # SQL DDL → YAML converter
├── ModelGenerator/             # YAML → C# generator
├── tests/                      # Unit/integration tests
├── Makefile                    # Build automation
├── dotnet-build.sh             # SDK version wrapper
└── appsettings.json            # Configuration + ViewDefinitions
```

**Full Details:** See `ARCHITECTURE_SUMMARY.md`

## Current State

### ✅ Completed Features

- DDL-driven data model with full pipeline (DdlParser → app.yaml → ModelGenerator)
- Dynamic Entity API + Generic CRUD UI (Radzen components)
- Entity Metadata Service + compiled delegates (250x performance)
- SQL-first view pipeline (Dapper) with 38 unit tests
- SqlSelectParser: Auto-generates view model properties from SQL SELECT columns with type inference
- Multi-schema support with tenant isolation
- Unit tests: 580+ passing (DataSeeder, ModelGenerator, DdlParser, SqlSelectParser, Services)
- Build optimization (30+ min → 2-5 min)
- Docker SQL Server support

### ⚠️ Current Limitations

- Generated models folder empty initially (run `make run-ddl-pipeline`)
- Composite primary/foreign keys not supported (single column only)
- `__EFMigrationsHistory` must NOT be in schema.sql (EF creates automatically)
- CHECK/UNIQUE constraints and computed columns ignored by parser

### ⚠️ Seed Data Constraints

- **seed.sql MUST match schema.sql exactly** (column names, NOT NULL, FKs)
- Examine CREATE TABLE statements directly when fixing seed data
- Use minimal seed strategy for complex tables with FK dependencies

### ⚠️ Proprietary Data - DO NOT COMMIT

- `sql/schema.sql` and `sql/seed.sql` may contain proprietary client data
- Documentation uses example schemas (`acme`, `initech`)
- Actual runtime schemas derive from `USE [database]` statements in schema.sql

## Architecture Notes

- **Hybrid:** ASP.NET Core Web API + Blazor Server SPA
- **Data access:** EF Core (writes) + Dapper (complex reads)
- **UI:** Radzen Blazor components throughout
- **Multi-tenancy:** Finbuckle.MultiTenant with `X-Customer-Schema` header
- **Dynamic model registration:** AppDbContext discovers entities via reflection
- **YAML-driven generation:** app.yaml → C# entities → EF migrations

## Key Files

| File | Purpose |
|------|---------|
| `app.yaml` | Generated runtime config (entities + views) |
| `appsettings.json` | ViewDefinitions + Applications config |
| `sql/schema.sql` | SQL DDL source (entities) |
| `sql/views/*.sql` | SQL SELECT queries (views) |
| `Data/AppDbContext.cs` | EF Core DbContext |
| `Services/IEntityOperationService.cs` | EF CRUD operations |
| `Services/Views/` | Dapper view services |
| `Controllers/EntitiesController.cs` | Dynamic CRUD endpoints |
| `Components/Shared/GenericEntityPage.razor` | Reusable CRUD UI |
| `DdlParser/` | SQL DDL → YAML converter |
| `ModelGenerator/` | YAML → C# generator |
| `ModelGenerator/SqlSelectParser.cs` | SQL SELECT → ViewProperty[] with type inference |
| `Makefile` | Build automation |

## SDK Version Management

The `dotnet-build.sh` wrapper handles SDK version conflicts between Windows/WSL. Different developers can have different .NET 8.x versions installed. The wrapper bypasses `global.json` locally while keeping it for CI/CD.

## Known Process Management Pitfalls

- **MSBuild node reuse:** Spawns persistent processes. Use `make shutdown-build-servers` to kill.
- **dotnet watch:** Ignores SIGTERM when orphaned. Use `make stop-dev` (SIGKILL).
- **Process accumulation:** Run `make clean` periodically or use individual cleanup targets.

## Development Workflow

### New Developer Setup

```bash
./setup.sh                    # Configure User Secrets
make check                    # Build and validate
make db-create                # Create Docker container
make run-ddl-pipeline         # Generate models
make migrate                  # Apply migrations
make seed                     # Seed data
make dev                      # Start dev server
```

### After Schema Changes

```bash
./verify.sh                   # Full end-to-end verification
```

### Before Committing

```bash
make test                     # Run all unit tests
./verify.sh                   # Verify full pipeline
```

## Additional Documentation

- **ARCHITECTURE_SUMMARY.md** - Architecture decisions and current state
- **HYBRID_ARCHITECTURE.md** - EF Core + Dapper patterns
- **SKILLS.md** - Comprehensive developer guides
- **TESTING.md** - Full testing guide
- **DOCKER.md** - Docker setup and troubleshooting
- **MULTI_TENANT.md** - Multi-schema patterns and pitfalls
- **SESSION_SUMMARY.md** - Session tracking for LLM continuity
- **BUILD_OPTIMIZATION_SUMMARY.md** - Build performance improvements
- **SECRETS.md** - User Secrets management

## Documentation Maintenance

- **CLAUDE.md target size:** < 40k characters (performance threshold)
- **Pattern for large files:** Extract specialized topics to separate .md files (TESTING.md, DOCKER.md, etc.)
- **Cross-references:** Use "See FILENAME.md" pattern to link deep-dive content
- **Optimization history:** 2026-02-01 reduced from 42.2k → 13.5k by extracting testing, Docker, and multi-tenant details

## Recent Development History

1. Foundation: Blazor Server + API setup, Docker integration
2. Data Model Generation: YAML-driven approach with ModelGenerator
3. DDL Parser Pipeline: SQL DDL → YAML → C# entities
4. Entity Metadata Service: YAML → CLR type mapping
5. Seed Data + Unit Tests: DataSeeder with SQLite integration tests
6. Models Extraction: Separate DotNetWebApp.Models assembly
7. Build Optimization: cleanup-nested-dirs target
8. Documentation Expansion: SKILLS.md comprehensive guides
9. Phase 1 (2026-01-27): IEntityOperationService with compiled delegates
10. Phase 2 (2026-01-27): SQL-first view pipeline with Dapper
11. Phase 3 (2026-02-01): SqlSelectParser for auto-generating view model properties from SQL SELECT columns
12. Seed Data (2026-02-04): Added Feb 4-29, 2026 test data to sql/seed.sql (78 Inventory Picking orders)
13. White-Label (2026-03-17): Refactored to generic skeleton — GAI→WEBAPP, service renames (DMS→WAMS, PrePick→InventoryPicking, Allocation→InventoryAllocation), removed ICT and AppointmentImport/Deacom services, stripped proprietary SQL

Latest work: white-label refactoring complete; ready for PR to master.
