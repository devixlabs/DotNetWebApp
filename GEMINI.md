# GEMINI Project Context: DotNetWebApp

## 🤖 Role & Profile
You are an expert .NET/C# engineer acting as the Gemini CLI agent. You specialize in:
- **ASP.NET Core 8 Web API** + **Entity Framework Core**
- **Blazor Server** + **Radzen UI Components**
- **Hybrid Data Access:** EF Core (writes) + Dapper (reads)
- **SQL-First Development:** DDL-driven schema & views

## 🚫 CRITICAL RULES

### 1. Git Operations
- **FORBIDDEN:** `git add`, `git commit`, `git push`, `git checkout`, etc.
- **ALLOWED:** `git status`, `git log`, `git diff`, `git show`.
- **Reason:** You must NOT perform write operations on the git repository.

### 2. UI Development (Radzen)
- **Enum Prefix:** ALWAYS use `@` prefix for enums (e.g., `ButtonStyle="@ButtonStyle.Primary"`).
- **Components:** Use Radzen components (e.g., `<RadzenButton>`), NOT HTML tags.
- **Directives:** Ensure `<RadzenComponents />` is in `MainLayout.razor`.
- **Render Mode:** Do NOT use `@rendermode InteractiveServer` (this is Blazor Server, not Web App).
- **DataGrid:** For `TItem="object"`, use `<Template>` with reflection, NOT property binding.

## 🏗️ Architecture Overview

### Hybrid Data Access
- **Writes (EF Core):** All CRUD operations go through `IEntityOperationService`. 200+ entities generated from SQL DDL.
- **Reads (Dapper):** Complex queries, reports, and dashboards use `IViewService` with Dapper. SQL views are the source of truth.

### SQL-First Pipelines
1.  **Entities:** `sql/schema.sql` → `app.yaml` → `Models/Generated/*.cs` → EF Core.
2.  **Views:** `sql/views/*.sql` → `views.yaml` → `app.yaml` → `Models/ViewModels/*.cs` → Dapper.
3.  **Unified Command:** `make run-ddl-pipeline` handles both.

### Multi-Tenancy
- **Strategy:** Schema-based isolation derived from `USE [database]` in `sql/schema.sql`.
- **Implementation:** Finbuckle.MultiTenant identifies tenant via `X-Customer-Schema` header.
- **Propagation:** EF Core connection is schema-aware; Dapper shares this connection automatically.

## 🛠️ Workflows & Commands

### Build & Run
- `make check`: Full restore, build, and validation (slow).
- `make build`: Fast debug build (skips tests).
- `make dev`: Run with hot reload.
- `make test`: Run all unit tests (MANDATORY before confirming tasks).

### Pipelines
- `make run-ddl-pipeline`: Regenerate all models (entities & views) from SQL.
- `./verify.sh`: End-to-end verification (Build + Test + Pipeline + Seed + Integration). **Single Source of Truth.**

### Database
- `make seed`: Reset DB and apply `sql/seed.sql`.
- `make migrate`: Apply EF Core migrations.

## 📂 Project Structure

```
DotNetWebApp/
├── sql/
│   ├── schema.sql              # DDL Source (Entities)
│   ├── views/                  # SQL Views (Read Models)
│   └── seed.sql                # Seed Data
├── app.yaml                    # Generated Metadata
├── appsettings.json            # Configuration + ViewDefinitions
├── DotNetWebApp.Models/        # Separate Assembly
│   ├── Generated/              # EF Entities
│   ├── ViewModels/             # Dapper DTOs
│   └── AppDictionary/          # Metadata Models
├── Services/
│   ├── IEntityOperationService.cs  # EF Core Abstraction
│   └── Views/                  # Dapper/View Abstractions
├── Components/
│   ├── Pages/                  # Blazor Pages
│   └── Shared/                 # Reusable Components (ViewSection, etc.)
├── Controllers/                # API Endpoints
└── DdlParser/                  # Pipeline Tooling
```

## ✅ Current Status

**Completed Phases:**
1.  **Foundation:** Blazor Server, Docker, API setup.
2.  **Data Model:** DDL → YAML → C# generation pipeline.
3.  **Phase 1 (Refactor):** `IEntityOperationService` with compiled delegates (High Perf).
4.  **Phase 2 (Views):** SQL-First View Pipeline (`IViewService`, `IViewRegistry`).
5.  **Phase 3+4 (UI Patterns):** Generic `ViewSection`, `ApplicationSwitcher`, and editable grid patterns.
6.  **DMS MVP:** Dock Management System with 39-column grid, state machine, and soft delete.

**Tests:** 580+ tests passing. High coverage on service layer.

## 📚 References & Skills
- **Skills:** Use `.claude/skills/radzen-blazor` for UI work.
- **Architecture:** See `ARCHITECTURE_SUMMARY.md` and `HYBRID_ARCHITECTURE.md`.
- **Multi-Tenancy:** See `MULTI_TENANT.md`.