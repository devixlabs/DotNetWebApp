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
This is a .NET 8 Web API project with Entity Framework Core for data access and is an SPA (Single Page Application) using Blazor Server.

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
- Basic product API with CRUD operations
- Entity Framework configured with Products model using .NET 8 with wildcard package versions (`8.*`)
- Initial migration checked in and ready to apply with `make migrate`
- Blazor Server SPA configured with basic layout and navigation
- API endpoints accessible via /swagger/index.html
- Main SPA application at /app route with three sections:
  - Dashboard: Metrics and activity overview
  - Products: AJAX-loaded product management with CRUD operations
  - Settings: Application configuration interface
- Client-side navigation with no page reloads between sections
- HttpClient configured for API communication
- Makefile provides convenient targets for all common operations

## Architecture Notes
- Hybrid architecture: Web API backend + Blazor Server frontend
- SignalR connection for Blazor Server real-time updates
- Shared data access through Entity Framework
- SPA uses component-based architecture with section-specific components
- CSS animations defined in wwwroot/css/app.css (pulse, spin, slideIn)
- Product model defined inline in SpaApp.razor (should be moved to Models/ folder)

## Secrets Management
- Project uses **User Secrets** for local development (see SECRETS.md for details)
- Connection strings stored in `~/.microsoft/usersecrets/`, never in git
- `setup.sh` script automatically configures User Secrets when setting up SQL Server
- Manual management: `dotnet user-secrets list`, `dotnet user-secrets set`, etc.

## Development Notes
- Development occurs on both Windows and WSL (Ubuntu/Debian via apt-get)
- global.json specifies .NET 8.0.410 as the target version
- New developer setup: Run `./setup.sh` to install SQL Server and configure secrets, then `make check` and `make migrate`
- For new migrations, use: `./dotnet-build.sh ef migrations add <MigrationName>`
- The dotnet-build.sh wrapper script temporarily hides global.json during execution, allowing local development flexibility while supporting CI/CD servers with strict version requirements
- dotnet-build.sh validates that both `dotnet` and `dotnet-ef` CLIs are installed before execution
- All build errors have been resolved and application compiles successfully
- Makefile uses the wrapper script for consistency across all dotnet operations
- Package versions use wildcards (`8.*`) to support flexibility across different developer environments while maintaining .NET 8 compatibility