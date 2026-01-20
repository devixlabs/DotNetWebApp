# GEMINI Project Context: DotNetWebApp

## Project Overview

This is a .NET 8 web application built with a Blazor Server frontend and a Web API backend. It provides a SPA experience and supports multi-tenancy. Data access is via Entity Framework Core against SQL Server. The UI is built with Radzen Blazor components.

**Key Technologies:**

*   **.NET 8:** Core framework for the application.
*   **ASP.NET Core:** For the web server and API.
*   **Blazor Server:** Reactive frontend UI.
*   **Entity Framework Core:** Data access and migrations.
*   **SQL Server:** Relational database.
*   **Radzen.Blazor:** UI component library.
*   **Docker:** Used for dev containers (app + database).

**Architecture:**

*   **`Program.cs`:** Entry point and service registration.
*   **`Components/`:** Blazor UI components.
*   **`Controllers/`:** API controllers.
*   **`Data/`:** `AppDbContext`, tenancy helpers, and dynamic model wiring.
*   **`Models/`:** Entity models (including `Models/Generated`).
*   **`Services/`:** Business logic and DI services.
*   **`Migrations/`:** EF Core migration files.

## Current Direction (App Example YAML)

The app is moving toward a single-source config in `app.example.yaml` that drives:
*   app branding + theme
*   dynamic model generation (`ModelGenerator`)
*   API and UI entity navigation

Generated entities live in `Models/Generated` and are wired into `AppDbContext` via reflection. Table names are pluralized (e.g., `Product` -> `Products`) to align with existing SQL tables.

## Current State / Recent Fixes

*   YAML-driven metadata and model definitions live in `app.example.yaml`.
*   `ModelGenerator` creates `Models/Generated`; optional value types are nullable to avoid forced defaults.
*   `AppDictionaryService` exposes YAML metadata to the UI and navigation.
*   UI uses Radzen panel menu components and includes a dynamic "Data" section.
*   Generic entity pages load data via `GenericEntityPage.razor` with the route `api/{entity.Name}` and singular controllers.

## Database / Migrations

There is a migration named `AddCatalogSchema` that:
*   creates `Categories`
*   adds `CategoryId`, `CreatedAt`, and `Description` to `Products`
*   aligns name length and nullable fields

If you see errors like:
*   `Invalid object name 'dbo.Category'`
*   `Invalid column name 'CategoryId'`

the database schema is not migrated. Run `make db-start` (if using Docker) then `make migrate`.

## Building and Running

The project uses a `Makefile` to simplify common development tasks.

### Prerequisites

1.  **Install SQL Server:** Run `./setup.sh` to install SQL Server via Docker or on the host machine.
2.  **Install .NET EF Tools:** `dotnet tool install --global dotnet-ef --version 8.*`
3.  **Use the wrapper:** `make` targets call `./dotnet-build.sh`, which sets `DOTNET_ROOT` for global tools and bypasses `global.json` locally.

### Key Commands

*   **Check and Restore Dependencies:**
    ```bash
    make check
    ```

*   **Run Database Migrations:**
    ```bash
    make migrate
    ```

*   **Build the Application:**
    ```bash
    make build
    ```

*   **Run in Development Mode (with hot reload):**
    ```bash
    make dev
    ```

*   **Run in Production-like Mode:**
    ```bash
    make run
    ```

*   **Run Tests:**
    ```bash
    make test
    ```

*   **Build Docker Image:**
    ```bash
    make docker-build
    ```

## Development Conventions

*   **Dependency Injection:** Services are registered in `Program.cs` and injected into constructors. This is the standard pattern for .NET Core applications.
*   **Async/Await:** Asynchronous programming is used for I/O operations, particularly in the service layer and controllers when interacting with the database.
*   **Separation of Concerns:** The project is organized into distinct layers (UI, API, Services, Data) to keep the codebase clean and maintainable.
*   **Configuration:** Application settings are managed in `appsettings.json` and `appsettings.Development.json`. Secrets are managed using the .NET User Secrets manager (see `SECRETS.md`).
*   **Multi-Tenancy:** The `Data/Tenancy` folder and the `AppDbContext` show a mechanism for supporting multiple tenants with different database schemas.

## Guardrails (Do Not Break)

*   `make check` runs `shellcheck` on `setup.sh` and `dotnet-build.sh` before the build.
*   Do not modify or reinstall the system .NET runtime; use the `dotnet-build.sh` wrapper via `make`.
*   Keep Radzen UI wiring intact (NavMenu and theme CSS).
*   Ensure migrations are applied before debugging 500s in entity pages.
