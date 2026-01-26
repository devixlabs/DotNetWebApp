# Repository Guidelines

## Project Structure & Module Organization

- `Components/`, `Pages/`, `Shared/`: Blazor UI components and layouts.
- `Controllers/`: Web API endpoints (generic and entity controllers).
- `Services/`: Business logic and DI services.
- `Data/`: `AppDbContext`, tenancy helpers, and EF configuration.
- `DdlParser/`: SQL DDL → `app.yaml` converter used in the pipeline.
- `DotNetWebApp.Models/`: Separate models assembly containing all data models, configuration classes, and YAML model classes.
- `DotNetWebApp.Models/Generated/`: Auto-generated entity types from `ModelGenerator`.
- `DotNetWebApp.Models/AppDictionary/`: YAML model classes for app.yaml structure.
- `ModelGenerator/`: Reads `app.yaml` and produces generated models.
- `Migrations/`: Generated EF Core migration files (current baseline checked in; pipeline regenerates).
- `wwwroot/`: Static assets (CSS, images, JS).

## Build, Test, and Development Commands

- `make check`: Runs `shellcheck` on `setup.sh`, `dotnet-build.sh`, and `Makefile`, then restores and builds.
- `make restore`: Restores app, generator, parser, and test projects.
- `make build`: Builds `DotNetWebApp.Models`, `DotNetWebApp`, `ModelGenerator`, and `DdlParser` (default `BUILD_CONFIGURATION=Debug`).
- `make build-all`: Builds the full solution, including tests; automatically runs `cleanup-nested-dirs` to prevent inotify exhaustion.
- `make build-release`: Release builds for main projects only.
- `make run-ddl-pipeline`: DDL → YAML → models → migration pipeline, then build.
- `make migrate`: Applies the current EF Core migration (SQL Server must be running).
- `make dev`: Runs with hot reload (`dotnet watch`).
- `make run`: Runs once without hot reload.
- `make test`: Builds and runs `dotnet test` for `tests/DotNetWebApp.Tests` and `tests/ModelGenerator.Tests` (uses `BUILD_CONFIGURATION`); automatically runs `cleanup-nested-dirs`.
- `make seed`: Runs the app in seed mode to apply `seed.sql` via EF (`-- --seed`).
- `make cleanup-nested-dirs`: Removes nested project directories created by MSBuild to prevent inotify watch exhaustion on Linux.
- Docker DB helpers: `make db-start`, `make db-stop`, `make db-logs`, `make db-drop`.
- Local SQL Server helpers: `make ms-status`, `make ms-start`, `make ms-logs`, `make ms-drop`.

## Project Goal & Session Notes

- **Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.yaml` file for dynamic customization.
- **Current State:** DDL → YAML → models → migration pipeline drives generated models and schema; run `make run-ddl-pipeline` before `make migrate`/`make seed` when the DDL changes. Seed data lives in `seed.sql` and is applied via `make seed`.
- Review `SESSION_SUMMARY.md` before starting work and update it when you make meaningful progress or decisions.

## Coding Style & Naming Conventions

- C#: 4-space indentation, PascalCase for types/props, camelCase for locals/params, `Async` suffix for async methods.
- Razor components: PascalCase filenames (e.g., `GenericEntityPage.razor`).
- Generated files in `DotNetWebApp.Models/Generated/` should not be edited directly; update `ModelGenerator/EntityTemplate.scriban` and regenerate instead.
- Model classes in `DotNetWebApp.Models/` are shared across the application; ensure changes don't break existing consumers.
- Keep Radzen UI wiring intact in `Shared/` and `_Layout.cshtml`.

## Testing Guidelines

- Tests live in `tests/` using a `ProjectName.Tests` project and `*Tests` class naming.
- Run tests via `make test` and include failing/passing notes in PRs.

## Commit & Pull Request Guidelines

- Commit messages are short and imperative (e.g., “Add docker database commands”, “Fix nav bar button”); keep them concise.
- PRs should include: a brief summary, commands run (`make check`, `make build`, etc.), screenshots for UI changes, and DDL pipeline notes if schema changed.

## Configuration & Safety Notes

- Secrets belong in user secrets or environment variables; see `SECRETS.md`.
- `app.yaml` drives model generation; branding/navigation labels still come from `appsettings.json` via `AppCustomizationOptions`.
- `dotnet-build.sh` sets `DOTNET_ROOT` for global tools; do not modify or reinstall the system .NET runtime.
- Tenant schema switching uses the `X-Customer-Schema` header (defaults to `dbo`).
- Models are in separate `DotNetWebApp.Models` project; YamlDotNet dependency lives there.
