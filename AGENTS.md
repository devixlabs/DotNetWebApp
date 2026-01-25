# Repository Guidelines

## Project Structure & Module Organization

- `Components/`, `Pages/`, `Shared/`: Blazor UI components and layouts.
- `Controllers/`: Web API endpoints (generic and entity controllers).
- `Services/`: Business logic and DI services.
- `Data/`: `AppDbContext`, tenancy helpers, and EF configuration.
- `Models/` and `Models/Generated/`: Entity models; generated types come from `ModelGenerator`.
- `ModelGenerator/`: Reads `app.yaml` and produces generated models.
- `Migrations/`: Generated EF Core migration files (kept empty in repo).
- `wwwroot/`: Static assets (CSS, images, JS).

## Build, Test, and Development Commands

- `make check`: Runs `shellcheck` on `setup.sh` and `dotnet-build.sh`, then restores and builds.
- `make build`: Release builds for `DotNetWebApp` and `ModelGenerator` (not the full solution).
- `make migrate`: Applies the generated EF Core migration after running the DDL pipeline (SQL Server must be running).
- `make dev`: Runs with hot reload (`dotnet watch`).
- `make run`: Runs once without hot reload.
- `make test`: Builds and runs `dotnet test` in Release for `tests/DotNetWebApp.Tests`.
- `make seed`: Runs the app in seed mode to apply `seed.sql` via EF (`-- --seed`).
- Docker DB helpers: `make db-start`, `make db-stop`, `make db-logs`, `make db-drop`.

## Project Goal & Session Notes

- **Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.yaml` file for dynamic customization.
<<<<<<< HEAD
- **Current State:** YAML drives generated models, API routes, and UI navigation; database schema should be created from the DDL pipeline before seeding. Seed data lives in `seed.sql` and is applied via `make seed`.
- Review `SESSION_SUMMARY.md` before starting work and update it when you make meaningful progress or decisions.

## Coding Style & Naming Conventions

- C#: 4-space indentation, PascalCase for types/props, camelCase for locals/params, `Async` suffix for async methods.
- Razor components: PascalCase filenames (e.g., `GenericEntityPage.razor`).
- Generated files in `Models/Generated/` should not be edited directly; update `ModelGenerator/EntityTemplate.scriban` and regenerate instead.
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
