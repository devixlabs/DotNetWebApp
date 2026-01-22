# DotNetWebApp

.NET 8 Web API + Blazor Server application with **YAML-driven data models** and **SQL DDL to YAML parser pipeline**.

> **Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.yaml` file for dynamic customization.

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
make migrate   # Apply database migrations
make dev       # Start dev server (http://localhost:5000)
```

**That's it!** Navigate to http://localhost:5000 to see the app.

---

## Feature: Bring Your Own Database Schema

The **DdlParser** converts your SQL Server DDL files into `app.yaml` format, which then generates C# entity models automatically.

### How It Works

```
your-schema.sql → DdlParser → app.yaml → ModelGenerator → Models/Generated/*.cs → Build & Run
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
├── Controllers/              # API endpoints (ProductController, CategoryController, etc.)
├── Components/
│   ├── Pages/               # Blazor routable pages (Home.razor, SpaApp.razor)
│   └── Sections/            # SPA components (Dashboard, Products, Settings, etc.)
├── Data/                    # EF Core DbContext
├── Models/
│   ├── Generated/           # 🔄 Auto-generated entities from app.yaml
│   └── AppDictionary/       # YAML model classes
├── Migrations/              # EF Core database migrations
├── DdlParser/               # 🆕 SQL DDL → YAML converter
│   ├── Program.cs
│   ├── CreateTableVisitor.cs
│   └── TypeMapper.cs
├── ModelGenerator/          # YAML → C# entity generator
├── wwwroot/                 # Static files (CSS, JS, images)
├── app.yaml                 # 📋 Data model definition (source of truth)
├── Makefile                 # Build automation
└── dotnet-build.sh          # SDK version wrapper script
```

---

## Current State

- ✅ `app.yaml` drives app metadata, theme, and data model shape
- ✅ `ModelGenerator` produces entities in `Models/Generated` with proper nullable types
- ✅ `AppDbContext` auto-discovers entities via reflection
- ✅ `GenericController<T>` provides REST endpoints
- ✅ `GenericEntityPage.razor` + `DynamicDataGrid.razor` provide dynamic CRUD UI
- ✅ **DdlParser** converts SQL DDL files to `app.yaml` format
- ✅ Migrations tracked in `Migrations/` folder
- ⚠️ Branding currently from `appsettings.json` (can be moved to YAML)
- ✅ Tenant schema switching via `X-Customer-Schema` header (defaults to `dbo`)

---

## Commands Reference

| Command | Purpose |
|---------|---------|
| `make check` | Lint, restore packages, build |
| `make build` | Clean build |
| `make dev` | Start dev server with hot reload |
| `make run` | Start server without hot reload |
| `make test` | Run unit tests |
| `make migrate` | Apply pending database migrations |
| `make db-start` | Start SQL Server container (Docker) |
| `make db-stop` | Stop SQL Server container (Docker) |
| `make docker-build` | Build Docker image |
| `make test-ddl-pipeline` | Parse DDL → generate models → build (full pipeline test) |

---

## Database Migrations

After modifying `app.yaml` or running the DDL parser:

```bash
# Start SQL Server
make db-start

# Apply migrations
make migrate
```

---

## Sample Seed Data

`sample-seed.sql` contains INSERT statements wrapped in `IF NOT EXISTS` guards so the script can safely run multiple times without duplicating rows. After running `make migrate`, populate the demo catalog data with:

```bash
make seed
```

Then verify the data landed via the container's `sqlcmd`:
```bash
docker exec -it --user root sqlserver-dev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT Name FROM dbo.Categories"
```
Repeat a similar query for `dbo.Products` to confirm the product seed rows.

The new `make seed` target executes `dotnet run --project DotNetWebApp.csproj -- --seed`. That mode of the application applies pending EF migrations (`Database.MigrateAsync()`) and then runs `sample-seed.sql` via the `SampleDataSeeder` service, which uses `ExecuteSqlRawAsync` under the current connection string. This keeps the seeding logic within the EF toolchain and avoids any provider-specific tooling. You can still run `sample-seed.sql` manually (e.g., `sqlcmd`, SSMS) if you need fine-grained control.

If you need to add a new migration manually:
```bash
./dotnet-build.sh ef migrations add YourMigrationName
make migrate
```

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

### Install SQL Server tools inside the container

To run `sqlcmd` from within the Dockerized SQL Server instance:

1. Open a root shell in the container (required for `apt-get`):
   ```bash
   docker exec -it --user root sqlserver-dev bash
   ```
2. Refresh package metadata and install the tools:
   ```bash
   apt-get update
   ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev
   ```
3. Add the CLI tools to your shell session (or update `/etc/profile` if you want it permanent):
   ```bash
   export PATH="$PATH:/opt/mssql-tools/bin"
   ```
4. Run an example query with the container's SA credentials (replace `$SA_PASSWORD` as needed):
   ```bash
   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT TOP 5 Name FROM dbo.Categories"
   ```

When you are done, exit the container shell with `exit`. These commands let you run any `sample-seed.sql` script manually or troubleshoot seed data without needing extra tooling on the host.

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

### 4. Start database and migrations
```bash
make db-start      # Only needed for Docker
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

### Step 4: Create database and run
```bash
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
# Apply pending migrations
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
| `app.yaml` | 📋 Source of truth for data model, theme, app metadata |
| `Models/Generated/` | 🔄 Auto-generated C# entities (don't edit directly) |
| `Migrations/` | 📚 Database schema history |
| `sample-seed.sql` | 🧪 Seed data for the default schema (run after migrations) |
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
- **Configuration:** YAML-driven data models + JSON appsettings
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
