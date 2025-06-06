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
- Build: `./dotnet-build.sh build`
- Run: `./dotnet-build.sh run`
- Test: `./dotnet-build.sh test` (if tests exist)
- Add Migration: `./dotnet-build.sh ef migrations add <MigrationName>`
- Update Database: `./dotnet-build.sh ef database update`

## Build Commands
- The dotnet-build.sh script is located in the project root and handles global.json SDK version conflicts
- Use `./dotnet-build.sh <command>` instead of `dotnet <command>` for all dotnet CLI operations

## Project Structure
- Controllers/ - API controllers
- Models/ - Data models and DTOs
- Data/ - DbContext and data access
- Migrations/ - EF Core migrations
- Pages/ - Blazor host pages and layouts
- Components/ - Blazor components and pages
- Shared/ - Shared Blazor components and layouts

## Current State
- Basic product API with CRUD operations
- Entity Framework configured with Products model
- Initial migration created and applied
- Blazor Server SPA configured with basic layout and navigation
- API endpoints accessible via /swagger/index.html

## Architecture Notes
- Hybrid architecture: Web API backend + Blazor Server frontend
- SignalR connection for Blazor Server real-time updates
- Shared data access through Entity Framework