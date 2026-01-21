### Project State Summary

**Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.example.yaml` file for dynamic customization.

**Progress:**
- **YAML-Driven Configuration:** The application loads app metadata, theme, and data model structure from `app.example.yaml`.
- **Dynamic Model Generation:** `ModelGenerator` reads `app.example.yaml` and generates entity classes in `Models/Generated`. The template makes non-required value types nullable.
- **Dynamic Data Layer:** `AppDbContext` discovers generated entities via reflection and maps them to pluralized table names (e.g., `Product` -> `Products`) to align with existing schema.
- **Generic API:** `GenericController<T>` powers entity endpoints; controllers are singular (`ProductController`, `CategoryController`) to align API routes with entity names.
- **Dynamic UI:** `GenericEntityPage.razor` + `DynamicDataGrid.razor` render any entity from the YAML file; `NavMenu.razor` renders dynamic entity navigation using Radzen.
- **Radzen UI Restored:** Radzen theme CSS is back in `_Layout.cshtml`, and Radzen scaffolding components are present in `MainLayout.razor`.
- **Branding Source:** `AppCustomizationOptions` still reads from `appsettings.json`; YAML currently drives the data model only.
- **Tenant Schema:** Schema selection can be overridden via `X-Customer-Schema` header (defaults to `dbo`).

**Build / Tooling:**
- `make check` runs `shellcheck` on `setup.sh` and `dotnet-build.sh`, then restores and builds.
- `make build` is clean. `make migrate` requires SQL Server running and a valid connection string.
- `dotnet-build.sh` sets `DOTNET_ROOT` for global tools and bypasses `global.json` locally; do not modify the system .NET install.
- `dotnet-ef` may warn about minor version mismatches with the runtime; do not upgrade system tooling unless requested.
- `ModelGenerator` is not part of `DotNetWebApp.sln`; run it manually when regenerating models.

**Database State / Migrations:**
- Added migration `AddCatalogSchema` to create `Categories` and add `CategoryId`, `CreatedAt`, and `Description` to `Products`, plus enforce `Products.Name` length.
- The runtime errors (`Invalid object name 'dbo.Category'`, `Invalid column name 'CategoryId'`) occur until migrations are applied.

**Current Task Status:** UI and build are stable; dynamic navigation and entity pages are working. The remaining step to clear the runtime error is applying migrations in the target environment.

**Next Step (Required):**
- Run `make migrate` (and ensure SQL Server is running via `make db-start`) to apply the `AddCatalogSchema` migration.

**Known Runtime Issue (If Present):**
- If you still see SQL errors like `Invalid column name 'CategoryId'` or `Invalid object name 'dbo.Category'`, the database schema has not been updated yet. Apply the migration above.
- If `make migrate` fails, verify SQL Server is running (Docker: `make db-start`) and the connection string in `SECRETS.md`.
