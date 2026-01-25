# DotNetWebApp

.NET 8 Web API + Blazor Server application with **SQL DDL-driven data models** and a **DDL → YAML → C# pipeline**.

> **Primary Goal:** Use SQL DDL as the source of truth and generate `app.yaml` + C# models for dynamic customization.

---

## Quick Start (5 minutes)

### 1. Install SQL Server
```bash
./setup.sh
```
Choose Docker or native Linux installation.

### 2. Install .NET tools
```bash
dotnet tool install --global dotnet-ef --version 8.*
```

### 3. Build and run
```bash
make check     # Lint scripts, restore packages, build
make db-start  # Start SQL Server (Docker only)
make run-ddl-pipeline  # Generate app.yaml, models, and migration from SQL DDL
make migrate   # Apply generated migration
make dev       # Start dev server (http://localhost:5000)
```

**That's it!** Navigate to http://localhost:5000 to see the app.

---

## Feature: Bring Your Own Database Schema

The **DdlParser** converts your SQL Server DDL files into `app.yaml` format, which then generates C# entity models automatically.

### How It Works

```
your-schema.sql → DdlParser → app.yaml → ModelGenerator → Models/Generated/*.cs → Migration → Build & Run
```

### Example: Parse Your Own Schema

Create a file `my-schema.sql`:
```sql
CREATE TABLE Companies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    RegistrationNumber NVARCHAR(50) NOT NULL,
    FoundedYear INT NULL
);

CREATE TABLE Employees (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Salary DECIMAL(18,2) NULL,
    HireDate DATETIME2 NULL DEFAULT GETDATE(),
    CompanyId INT NOT NULL,
    FOREIGN KEY (CompanyId) REFERENCES Companies(Id)
);
```

Then run:
```bash
# Parse DDL to YAML
cd DdlParser
../dotnet-build.sh run -- ../my-schema.sql ../app.yaml

# Generate models and build
cd ../ModelGenerator
../dotnet-build.sh run ../app.yaml

cd ..
make build

# Start the app
make run-ddl-pipeline
make migrate
make dev
```

The app now has **Companies** and **Employees** entities with:
- ✅ Auto-generated `Models/Generated/Company.cs` and `Models/Generated/Employee.cs`
- ✅ Database tables with correct types, constraints, and relationships
- ✅ Navigation UI automatically includes Company and Employee links
- ✅ Generic REST API endpoints (`/api/companies`, `/api/employees`)
- ✅ Dynamic CRUD UI pages with data grids

**Visit http://localhost:5000 → click "Data" in sidebar → select Company or Employee**

---

## Project Structure

```
DotNetWebApp/
├── Controllers/              # API endpoints (GenericController<T>, EntitiesController, etc.)
├── Components/
│   ├── Pages/               # Blazor routable pages (Home.razor, SpaApp.razor)
│   └── Sections/            # SPA components (Dashboard, Settings, Entity, etc.)
├── Data/                    # EF Core DbContext
├── Models/
│   ├── Generated/           # 🔄 Auto-generated entities from app.yaml
│   └── AppDictionary/       # YAML model classes
├── Migrations/              # Generated EF Core migrations (ignored in repo)
├── DdlParser/               # 🆕 SQL DDL → YAML converter
│   ├── Program.cs
│   ├── CreateTableVisitor.cs
│   └── TypeMapper.cs
├── ModelGenerator/          # YAML → C# entity generator
├── wwwroot/                 # Static files (CSS, JS, images)
├── app.yaml                 # 📋 Generated data model definition (from SQL DDL)
├── Makefile                 # Build automation
└── dotnet-build.sh          # SDK version wrapper script
```

---

## Current State

- ✅ `app.yaml` is generated from SQL DDL and drives app metadata, theme, and data model shape
- ✅ `ModelGenerator` produces entities in `Models/Generated` with proper nullable types
- ✅ `AppDbContext` auto-discovers entities via reflection
- ✅ `GenericController<T>` provides REST endpoints
- ✅ `GenericEntityPage.razor` + `DynamicDataGrid.razor` provide dynamic CRUD UI
- ✅ **DdlParser** converts SQL DDL files to `app.yaml` format
- ✅ Migrations generated from SQL DDL pipeline (kept out of source control)
- ⚠️ Branding currently from `appsettings.json` (can be moved to YAML)
- ✅ Tenant schema switching via `X-Customer-Schema` header (defaults to `dbo`)
- ✅ Dynamic API routes: `/api/entities/{entityName}` and `/api/entities/{entityName}/count`
- ✅ SPA example routes are optional via `AppCustomization:EnableSpaExample` (default true)

---

## Commands Reference

| Command | Purpose |
|---------|---------|
| `make check` | Lint, restore packages, build |
| `make build` | Clean build |
| `make dev` | Start dev server with hot reload |
| `make run` | Start server without hot reload |
| `make test` | Run unit tests |
| `make migrate` | Apply generated migration |
| `make db-start` | Start SQL Server container (Docker) |
| `make db-stop` | Stop SQL Server container (Docker) |
| `make docker-build` | Build Docker image |
<<<<<<< HEAD
| `make run-ddl-pipeline` | Parse DDL → generate models → migration → build (full pipeline run) |

---

## Database Migrations

After modifying `schema.sql` or running the DDL parser:

```bash
# Start SQL Server
make db-start

# Generate migration from DDL, then apply it
make run-ddl-pipeline
make migrate
```

---

## Sample Seed Data

`seed.sql` contains INSERT statements wrapped in `IF NOT EXISTS` guards so the script can safely run multiple times without duplicating rows. After running `make run-ddl-pipeline` + `make migrate`, populate the demo catalog data with:

```bash
make seed
```

Then verify the data landed via the container's `sqlcmd` (see the Docker section for setup and example queries).

The new `make seed` target executes `dotnet run --project DotNetWebApp.csproj -- --seed`. That mode of the application applies the generated migration (`Database.MigrateAsync()`) and then runs `seed.sql` via the `DataSeeder` service, which uses `ExecuteSqlRawAsync` under the current connection string. Ensure the migration has been generated from the DDL pipeline before seeding. You can still run `seed.sql` manually (e.g., `sqlcmd`, SSMS) if you need fine-grained control.

---

## Docker

### Build the image
```bash
make docker-build
```

### Run the container
```bash
docker run -d \
  -p 8080:80 \
  --name dotnetwebapp \
  dotnetwebapp:latest
```

### SQL Server tooling + example queries

Run the following commands from your host (the first must be executed as `root` inside the container) to install the SQL Server CLI tooling (`sqlcmd`) and verify the `DotNetWebAppDb` demo data:

```bash
docker exec -it --user root sqlserver-dev bash -lc "ACCEPT_EULA=Y apt-get update && \
  ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev"
docker exec -it sqlserver-dev \
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" \
  -d DotNetWebAppDb -Q "SELECT Id, Name FROM dbo.Categories;"
docker exec -it sqlserver-dev \
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" \
  -d DotNetWebAppDb -Q "SELECT Name, Price, CategoryId FROM dbo.Products;"
```

These commands let you run `seed.sql` manually or troubleshoot seed data without installing SQL tooling on the host.

---

## Development Setup

### 1. Install SQL Server
```bash
./setup.sh
# Choose "1" for Docker or "2" for native Linux
```

### 2. Install global .NET tools
```bash
dotnet tool install --global dotnet-ef --version 8.*
```

### 3. Restore and build
```bash
make check
```

### 4. Start database and apply generated schema
```bash
make db-start      # Only needed for Docker
make run-ddl-pipeline
make migrate
```

### 5. Run development server
```bash
make dev
```

Visit **http://localhost:5000** in your browser.

---

## Adding a New Data Entity from DDL

### Step 1: Create your SQL schema file
File: `my-tables.sql`
```sql
CREATE TABLE Authors (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NULL
);

CREATE TABLE Books (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,
    ISBN NVARCHAR(13) NOT NULL,
    PublishedYear INT NULL,
    AuthorId INT NOT NULL,
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
);
```

### Step 2: Parse DDL to YAML
```bash
cd DdlParser
../dotnet-build.sh run -- ../my-tables.sql ../app.yaml
cd ..
```

Output: `app.yaml` now contains `Author` and `Book` entities.

### Step 3: Generate models and build
```bash
cd ModelGenerator
../dotnet-build.sh run ../app.yaml
cd ..

make build
```

Generated files:
- `Models/Generated/Author.cs`
- `Models/Generated/Book.cs`

### Step 4: Generate migration, apply schema, and run
```bash
make run-ddl-pipeline
make migrate
make dev
```

**Result:**
- ✅ REST API endpoints: `GET /api/authors`, `POST /api/books`, etc.
- ✅ UI: Click "Data" → "Author" or "Book" for CRUD pages
- ✅ Relationships: Book pages show Author name; Author pages list Books

---

## Secrets Management

Connection strings and API keys are stored in **User Secrets** (never in git):

```bash
# Set connection string
dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Server=localhost;Database=DotNetWebApp;..."

# View all secrets
dotnet user-secrets list

# See SECRETS.md for details
cat SECRETS.md
```

---

## Troubleshooting

### "Could not find SQL Server"
```bash
# Start SQL Server
make db-start
```

### "Invalid object name 'dbo.YourTable'"
```bash
# Regenerate schema from DDL and apply it
make run-ddl-pipeline
make migrate
```

### Build errors after modifying `app.yaml`
```bash
# Regenerate models
cd ModelGenerator
../dotnet-build.sh run ../app.yaml
cd ..

make build
```

### Port 5000 already in use
```bash
# Change port in launchSettings.json or run on different port
make dev  # Tries 5000, 5001, etc.
```

---

## Key Files

| File | Purpose |
|------|---------|
| `app.yaml` | 📋 Generated data model (from SQL DDL) plus app metadata |
| `Models/Generated/` | 🔄 Auto-generated C# entities (don't edit directly) |
| `Migrations/` | 📚 Generated schema history (ignored in repo) |
| `seed.sql` | 🧪 Seed data for the default schema (run after schema apply) |
| `DdlParser/` | 🆕 Converts SQL DDL → YAML |
| `ModelGenerator/` | 🔄 Converts YAML → C# entities |
| `SECRETS.md` | 🔐 Connection string setup guide |
| `SESSION_SUMMARY.md` | 📝 Project state & progress tracking |

---

## Next Steps

1. **Parse your own database schema** → See "Adding a New Data Entity from DDL" above
2. **Customize theme colors** → Edit `app.yaml` theme section
3. **Add validation rules** → Edit `Models/Generated/` entity attributes
4. **Create custom pages** → Add `.razor` files to `Components/Pages/`
5. **Extend REST API** → Add custom controllers in `Controllers/`

---

## Architecture

- **Backend:** ASP.NET Core 8 Web API with Entity Framework Core
- **Frontend:** Blazor Server with Radzen UI components
- **Database:** SQL Server (Docker or native)
- **Configuration:** DDL-driven data models + JSON appsettings
- **Model Generation:** Automated from YAML via Scriban templates

---

## Development Notes

- Keep `SESSION_SUMMARY.md` up to date; it is the living status document between LLM sessions
- `dotnet-build.sh` manages .NET SDK version conflicts; do not modify system .NET install
- `ModelGenerator` is not part of `DotNetWebApp.sln` (run separately when regenerating models)
- Generated entities use nullable reference types (`#nullable enable`)
- All value types for optional properties are nullable (`int?`, `decimal?`, etc.)

---

## Support

- See `SECRETS.md` for connection string setup
- See `CLAUDE.md` for developer context
- Review `SESSION_SUMMARY.md` for current project state
