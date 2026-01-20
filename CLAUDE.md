# Claude Context for DotNetWebApp

## Developer Profile
You're an expert .NET/C# engineer with deep knowledge of:
- ASP.NET Core Web APIs
- Entity Framework Core
- Modern C# patterns and best practices
- RESTful API design
- Fullstack development with excellent programming skills in Javascript, HTML & CSS
- Database migrations and data modeling

## Project Overview
This is a .NET 8 Web API + Blazor Server SPA with Entity Framework Core and a YAML-driven data model/branding configuration.

## Project Goal & Session Notes
- **Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.example.yaml` file for dynamic customization.
- Review `SESSION_SUMMARY.md` before starting work and update it when you make meaningful progress or decisions.

## Key Commands
- Check/Setup: `make check` (restore and build)
- Build: `make build`
- Run (dev): `make dev` (with hot reload - use for active development)
- Run (prod): `make run` (without hot reload - use for production-like testing)
- Test: `make test`
- Apply Migrations: `make migrate`
- Add Migration: `./dotnet-build.sh ef migrations add <MigrationName>`
- Docker Build: `make docker-build`
- Clean: `make clean`

## Build Commands
- The project uses a Makefile with the following targets: `check`, `build`, `dev`, `run`, `test`, `migrate`, `docker-build`, `clean`
- The dotnet-build.sh script is located in the project root and handles global.json SDK version conflicts
- Use `make <target>` for standard operations
- Use `./dotnet-build.sh <command>` directly only for advanced dotnet CLI operations not covered by Makefile targets

## SDK Version Management
The project uses `dotnet-build.sh` wrapper script to handle SDK version conflicts between Windows and WSL environments. Different developers may have different .NET SDK versions installed (e.g., from Snap, apt-get, or native installers). The wrapper temporarily bypasses `global.json` version enforcement during local development, allowing flexibility while keeping the version specification in place for CI/CD servers.

**For Windows + WSL developers**: Install any supported .NET 8.x version locally. The wrapper script handles compatibility. CI/CD and production use the exact version specified in `global.json`.

## Project Structure
- Controllers/ - API controllers
- Models/ - Data models and DTOs
- Data/ - DbContext and data access
- Migrations/ - EF Core migrations
- Pages/ - Blazor host pages and layouts (_Host.cshtml, _Layout.cshtml)
- Components/Pages/ - Blazor routable pages (Home.razor, SpaApp.razor)
- Components/Sections/ - SPA section components (Dashboard, Products, Settings)
- Shared/ - Shared Blazor components (MainLayout.razor, NavMenu.razor)
- wwwroot/ - Static files (CSS, favicon, etc.)
- _Imports.razor - Global Blazor using statements

## Current State
- YAML-driven metadata and model definitions live in `app.example.yaml`.
- `ModelGenerator` produces entities in `Models/Generated` with nullable optional value types.
- `AppDbContext` discovers generated entities via reflection and pluralizes table names.
- Generic entity UI (`GenericEntityPage.razor`, `DynamicDataGrid.razor`) and singular controllers (`ProductController`, `CategoryController`) are in place.
- Nav menu renders a dynamic "Data" section using `AppDictionaryService`.
- Migration `AddCatalogSchema` adds `Categories` and `Products` columns; run `make migrate` before Product/Category pages.
- `make check`/`make build` pass; `make migrate` requires SQL Server running and a valid connection string.

## Architecture Notes
- Hybrid architecture: Web API backend + Blazor Server frontend
- SignalR connection for Blazor Server real-time updates
- Shared data access through Entity Framework with dynamic model registration
- `GenericController<T>` routes match singular entity names; UI uses generic entity pages
- `ModelGenerator` + `app.example.yaml` define entities; generated files live in `Models/Generated`
- CSS animations defined in wwwroot/css/app.css (pulse, spin, slideIn)

## Secrets Management
- Project uses **User Secrets** for local development (see SECRETS.md for details)
- Connection strings stored in `~/.microsoft/usersecrets/`, never in git
- `setup.sh` script automatically configures User Secrets when setting up SQL Server
- Manual management: `dotnet user-secrets list`, `dotnet user-secrets set`, etc.

## Development Notes
- Development occurs on both Windows and WSL (Ubuntu/Debian via apt-get)
- global.json specifies .NET 8.0.410 as the target version
- New developer setup: Run `./setup.sh`, then `make check`, `make db-start` (if Docker), and `make migrate`
- For new migrations, use: `./dotnet-build.sh ef migrations add <MigrationName>`
- `dotnet-build.sh` sets `DOTNET_ROOT` for global tools and temporarily hides global.json during execution
- `make check` runs `shellcheck setup.sh` and `shellcheck dotnet-build.sh` before restore/build
- `make migrate` requires SQL Server running and a valid connection string; `dotnet-ef` may warn about version mismatches
- Makefile uses the wrapper script for consistency across all dotnet operations; do not modify the system .NET runtime
- Package versions use wildcards (`8.*`) to support flexibility across different developer environments while maintaining .NET 8 compatibility
