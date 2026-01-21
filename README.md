# DotNetWebApp

.NET version 8 application manually created with the help of ChatGPT4.

## Project Goal

**Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.example.yaml` file for dynamic customization.

Keep `SESSION_SUMMARY.md` up to date; it is the living status document between LLM sessions.

## Current State

- `app.example.yaml` drives app metadata, theme, and data model shape.
- `ModelGenerator` produces entities in `Models/Generated`, and `AppDbContext` discovers them via reflection with pluralized table names.
- `GenericController<T>` and `GenericEntityPage.razor` provide dynamic entity endpoints and UI; the Nav menu includes a "Data" section for generated entities.
- Migration `AddCatalogSchema` adds `Categories` and extends `Products`; run it before using Product/Category pages.
- `make check`/`make build` are clean; `make migrate` requires SQL Server running and a valid connection string.
- Branding/navigation labels currently come from `appsettings.json` via `AppCustomizationOptions`, not from YAML.
- Tenant schema switching uses the `X-Customer-Schema` header (defaults to `dbo`).

# Setup

## 1. Install SQL Server
Run the setup script to install SQL Server (Docker or native Linux):
```bash
./setup.sh
```

## Database (Docker)
If you chose Docker in `./setup.sh`, use these commands to manage the SQL Server container:
```bash
make db-start
make db-stop
make db-logs
```

## 2. Setup .NET tools and build
```bash
dotnet tool install --global dotnet-ef --version 8.*
make check
make migrate
```
Note: `make` targets use `./dotnet-build.sh`, which sets `DOTNET_ROOT` for global tools. Do not reinstall the system .NET runtime as part of repo tasks.
If you're using native SQL Server (not Docker), ensure your connection string is set via User Secrets or an environment variable before running `make migrate`. See `SECRETS.md`.

# Build
```
make build
```

## Docker

### Build the image
```bash
make docker-build
```

# Testing
```
make test
```

# Running

For active development (with hot reload):
```
make dev
```

For production-like testing (without hot reload):
```
make run
```

### Run the container
```bash
docker run -d \
  -p 8080:80 \
  --name dotnetwebapp \
  dotnetwebapp:latest
```

# Database migrations
```
make migrate
```
