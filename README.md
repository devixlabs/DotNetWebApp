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

### 3. Set SA_PASSWORD environment variable
```bash
export SA_PASSWORD='YourStrongPassword123!'
```

### 4. Build and run
```bash
make check     # Lint scripts/Makefile, restore packages, build
make db-create # Create SQL Server Docker container (first time only)
make run-ddl-pipeline  # Generate app.yaml, models, and migration from SQL DDL
make migrate   # Create databases ({PRIMARY_DB}, {SECONDARY_DB}) and apply schema
make seed      # Seed sample data
make dev       # Start dev server (https://localhost:7012 or http://localhost:5210)
```

**That's it!** Navigate to https://localhost:7012 (or http://localhost:5210) to see the app.

You can also run in the background:
```bash
nohup make dev > dev.log 2>&1 &
```

> **Note:** This project uses two databases: **{PRIMARY_DB}** (primary) and **{SECONDARY_DB}** (secondary). Both are created automatically by `make migrate`.

---

## Feature: Bring Your Own Database Schema

The **DdlParser** converts your SQL Server DDL files into `app.yaml` format, which then generates C# entity models automatically.

### How It Works

```
your-schema.sql → DdlParser → app.yaml → ModelGenerator → DotNetWebApp.Models/Generated/*.cs → Migration → Build & Run
```

### Example: Parse Your Own Schema

Create or replace `sql/schema.sql`:
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
make run-ddl-pipeline
make migrate
make dev
```

The app now has **Companies** and **Employees** entities with:
- ✅ Auto-generated `DotNetWebApp.Models/Generated/Company.cs` and `DotNetWebApp.Models/Generated/Employee.cs`
- ✅ Database tables with correct types, constraints, and relationships
- ✅ Navigation UI automatically includes Company and Employee links
- ✅ Generic REST API endpoints (`/api/companies`, `/api/employees`)
- ✅ Dynamic CRUD UI pages with data grids

**Visit https://localhost:7012 (or http://localhost:5210) → click "Data" in sidebar → select Company or Employee**

---

## Project Structure

```
DotNetWebApp/
├── Components/
│   ├── Pages/               # Blazor routable pages (Home.razor, SpaApp.razor)
│   ├── Sections/            # SPA components (Dashboard, Settings, Entity, etc.)
│   └── Shared/              # Shared UI components
├── Controllers/              # API endpoints (EntitiesController, etc.)
├── Data/                    # EF Core DbContext
├── DdlParser/               # 🆕 SQL DDL → YAML converter
│   ├── Program.cs
│   ├── CreateTableVisitor.cs
│   └── TypeMapper.cs
├── DotNetWebApp.Models/     # 🔄 Separate models assembly
│   ├── Generated/           # 🔄 Auto-generated entities from app.yaml
│   ├── AppDictionary/       # YAML model classes
│   └── *.cs                 # Options classes (AppCustomizationOptions, DataSeederOptions, etc.)
├── ModelGenerator/          # YAML → C# entity generator
├── Migrations/              # Generated EF Core migrations (current baseline checked in; pipeline regenerates)
├── Pages/                   # Host and layout pages
├── Services/                # Business logic and DI services
├── Shared/                  # Layout and shared UI
├── tests/                   # Test projects
│   ├── DotNetWebApp.Tests/
│   └── ModelGenerator.Tests/
├── wwwroot/                 # Static files (CSS, JS, images)
├── app.yaml                 # 📋 Generated data model definition (from SQL DDL)
├── sql/
│   ├── schema.sql           # Source SQL DDL
│   ├── seed.sql             # Seed data
│   └── views/               # SQL SELECT queries for views
├── Makefile                 # Build automation
└── dotnet-build.sh          # SDK version wrapper script
```

---

## Current State

- ✅ `app.yaml` is generated from SQL DDL and drives app metadata, theme, and data model shape
- ✅ `ModelGenerator` produces entities in `DotNetWebApp.Models/Generated` with proper nullable types
- ✅ Models extracted to separate `DotNetWebApp.Models` assembly for better separation of concerns
- ✅ `AppDbContext` auto-discovers entities via reflection
- ✅ **Phase 1 Complete (2026-01-27):** `IEntityOperationService` with compiled delegates (250x perf improvement)
  - Centralizes all CRUD operations for 200+ entities
  - `EntitiesController` reduced from 369 to 236 lines (36% reduction)
  - All reflection logic moved to service layer
  - Comprehensive test suite added
- ✅ **DMS Phase 1 MVP Complete (2026-02-02):** Dock Management System
  - 39-column RadzenDataGrid with order type classification and color coding
  - Status workflow state machine (NA → CheckIn → Loading → Unloading → Shipped → Received)
  - AppID batch operations (orders with same AppID move together)
  - Soft delete pattern (type + 10) with undelete capability
  - Multi-warehouse support (CPFG, Northlake)
  - 105 unit tests, 15 comprehensive seed orders
  - 10 REST API endpoints, full CRUD operations
- ✅ `EntitiesController` provides dynamic REST endpoints
- ✅ `GenericEntityPage.razor` + `DynamicDataGrid.razor` provide dynamic CRUD UI
- ✅ **DdlParser** converts SQL DDL files to `app.yaml` format
- ✅ Migrations generated from SQL DDL pipeline (current baseline checked in; pipeline regenerates)
- ⚠️ Branding currently from `appsettings.json` (can be moved to YAML)
- ✅ Tenant schema switching via `X-Customer-Schema` header (defaults to `dbo`)
- ✅ Dynamic API routes: `/api/entities/{entityName}` and `/api/entities/{entityName}/count`
- ✅ SPA example routes are optional via `AppCustomization:EnableSpaExample` (default true)

---

## Multi-Schema Support

**Schemas are derived from `USE [database]` statements in `sql/schema.sql`:**

```sql
USE [acme]                          -- Sets schema to "acme"
CREATE TABLE [dbo].[Product](...)   -- → acme:Product

USE [initech]                       -- Sets schema to "initech"
CREATE TABLE [dbo].[Company](...)   -- → initech:Company
```

**Example schema mapping:**
| SQL Statement | EF Schema | Result |
|---------------|-----------|--------|
| `USE [acme]` | `acme` | `acme:Product`, `acme:Category` |
| `USE [initech]` | `initech` | `initech:Company`, `initech:User` |

**⚠️ IMPORTANT:** When `schema.sql` changes, you MUST update:
1. `appsettings.json` → Applications → Schema and Entities
2. `verify.sh` → Test URLs to match new schemas/entities

```json
{
  "Name": "admin",
  "Schema": "acme",
  "Entities": ["acme:Product", "acme:Category", ...]
}
```

---

## Commands Reference

| Command | Purpose |
|---------|---------|
| `make check` | Lint scripts/Makefile, restore, build |
| `make restore` | Restore app, generator, parser, and test projects |
| `make build` | Build main projects (Debug by default; set `BUILD_CONFIGURATION`) |
| `make build-all` | Build full solution including tests |
| `make build-release` | Release build for main projects |
| `make clean` | Clean build outputs and binlog |
| `make run-ddl-pipeline` | Parse `sql/schema.sql` → app.yaml → models → migration → build |
| `make migrate` | Apply migration via EF Core (`dotnet ef database update`) |
| `make db-migrate` | Apply migration via Docker/sqlcmd (idempotent; safe for existing tables) |
| `make seed` | Seed sample data from `sql/seed.sql` |
| `make dev` | Start dev server with hot reload (https://localhost:7012 / http://localhost:5210) |
| `make run` | Start server without hot reload |
| `make test` | Run DotNetWebApp.Tests and ModelGenerator.Tests |
| `make db-start` | Start SQL Server container (Docker) |
| `make db-stop` | Stop SQL Server container (Docker) |
| `make db-logs` | Tail SQL Server container logs |
| `make db-drop` | Drop local dev database in Docker |
| `make ms-status` | Check native SQL Server status |
| `make ms-start` | Start native SQL Server |
| `make ms-logs` | Tail native SQL Server logs |
| `make ms-drop` | Drop local dev database in native SQL Server |
| `make docker-build` | Build Docker image |
| `make compose-up` | Start full Docker stack (SQL Server health → db-migrate → db-seed → app) |
| `make compose-down` | Stop Docker Compose containers (volume/data preserved) |

---

## Database Migrations

After modifying `sql/schema.sql` or running the DDL parser:

```bash
export SA_PASSWORD='YourStrongPassword123!'
make db-start           # Start SQL Server (Docker)
make run-ddl-pipeline   # Generate migration from DDL
make migrate            # Create {PRIMARY_DB}/{SECONDARY_DB} databases and apply schema
make seed               # Seed sample data into both databases
```

**Note:** The `migrate` target creates both databases ({PRIMARY_DB} and {SECONDARY_DB}) and applies `sql/schema.sql`. The `seed` target runs `sql/seed.sql` which populates both databases.

---

## Sample Seed Data

`sql/seed.sql` contains INSERT statements for both {PRIMARY_DB} and {SECONDARY_DB} databases, wrapped in `IF NOT EXISTS` guards so the script can safely run multiple times without duplicating rows. After running `make run-ddl-pipeline` + `make migrate`, populate the demo data with:

```bash
make seed
```

This seeds data into both databases:
- **{PRIMARY_DB}**: Products (dmprod), units (dmunit), billing (dmbill), vendors (dmvend), etc.
- **{SECONDARY_DB}**: Acid corrections, Brix charts, allocations, etc.

Then verify the data landed via the container's `sqlcmd` (see the Docker section for setup and example queries).

---

## Docker (Quick Start)

### Prerequisites
- Docker and Docker Compose installed
- SA_PASSWORD environment variable set (or copy `.env.example` → `.env`)

### Run Everything (Recommended)

```bash
# Set SQL Server password
export SA_PASSWORD='YourStrongPassword123!'

# Start full stack: SQL Server → init databases → seed → app
make compose-up
```

**Then navigate to:**
- 🌐 **HTTP:** http://localhost:5210

**What `make compose-up` does:**
- ✅ Starts SQL Server and waits for health check
- ✅ Runs `make db-migrate` (creates GAI/GAIMisc databases, applies schema + EF migrations)
- ✅ Runs `make db-seed` (populates sample data)
- ✅ Starts app container — databases are guaranteed to exist

**Note on HTTPS:** The container runs on HTTP only. In production, HTTPS/TLS termination is handled by the nginx reverse proxy (see "External Access" section below). For local development with HTTPS, see "HTTPS Certificate Options" section.

### Stop Everything
```bash
make compose-down
```

### Build the Image Manually
```bash
docker build -t dotnetwebapp.local .
```

### HTTPS Certificate Options

The default Docker setup uses **HTTP only** (port 5210), with HTTPS/TLS handled by the nginx reverse proxy in production. If you need HTTPS inside the container for local development, choose one of these approaches:

#### Option 2: Generate Dev Certificate in Container
Add to `Dockerfile` before `ENTRYPOINT`:
```dockerfile
RUN dotnet dev-certs https --check --trust 2>/dev/null || \
    dotnet dev-certs https -ep /app/cert.pfx -p YourCertPassword123! && \
    dotnet dev-certs https --trust 2>/dev/null || true
```

Then update `docker-compose.yml` environment:
```yaml
environment:
  ASPNETCORE_URLS: 'https://+:7012;http://+:5210'
  ASPNETCORE_Kestrel__Certificates__Default__Path: '/app/cert.pfx'
  ASPNETCORE_Kestrel__Certificates__Default__Password: 'YourCertPassword123!'
```

**Pros:** Self-contained; works in isolated environments
**Cons:** Certificate regenerates on each build; adds ~2-3 min to build time

#### Option 3: Mount Certificate from Host
Generate a certificate on the host:
```bash
dotnet dev-certs https -ep ./dev-certs/certificate.pfx -p YourCertPassword123!
```

Update `docker-compose.yml`:
```yaml
dotnetwebapp:
  volumes:
    - ./dev-certs:/app/certs:ro
  environment:
    ASPNETCORE_URLS: 'https://+:7012;http://+:5210'
    ASPNETCORE_Kestrel__Certificates__Default__Path: '/app/certs/certificate.pfx'
    ASPNETCORE_Kestrel__Certificates__Default__Password: 'YourCertPassword123!'
```

**Pros:** Faster builds; certificate persists across rebuilds
**Cons:** Requires certificate management on host; certificate expires after 1 year

---

### Files Included
- `Dockerfile` — Multi-stage build (SDK → aspnet runtime)
- `docker-compose.yml` — Orchestrates app + SQL Server with networking
- `.env.example` — Template for environment variables (copy to `.env` to customize)

### Verify Data in SQL Server
```bash
# Query {PRIMARY_DB} (GAI)
docker exec -it sqlserver-dev \
  /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C \
  -d GAI -Q "SELECT TOP 5 * FROM dbo.dmprod;"

# Query {SECONDARY_DB} (GAIMisc)
docker exec -it sqlserver-dev \
  /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C \
  -d GAIMisc -Q "SELECT * FROM dbo.AcidCorrection;"
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

### 3. Set SA_PASSWORD environment variable
```bash
export SA_PASSWORD='YourStrongPassword123!'
```

### 4. Restore and build
```bash
make check
```

### 5. Create database container and apply schema
```bash
make db-create         # Create Docker container (first time only)
make run-ddl-pipeline  # Generate models from DDL
make migrate           # Create {PRIMARY_DB}/{SECONDARY_DB} databases and apply schema
make seed              # Seed sample data
```

### 6. Run development server
```bash
make dev
```

Visit **https://localhost:7012** (or **http://localhost:5210**) in your browser.

---

## External Access (Optional)

To make the application accessible from your local network or the internet (via port forwarding), set up an Nginx reverse proxy.

### 1. Generate SSL Certificates
```bash
make https
```
Follow the on-screen instructions to move the generated `dotnetwebapp.crt` and `dotnetwebapp.key` files to `/etc/nginx/ssl/`.

### 2. Configure Nginx
Create or update `/etc/nginx/conf.d/dotnetwebapp.conf` with the following configuration:

```nginx
server {
    listen 80;
    server_name _; 

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name _;

    # SSL Configuration using .NET Self-Signed Certs
    ssl_certificate /etc/nginx/ssl/dotnetwebapp.crt;
    ssl_certificate_key /etc/nginx/ssl/dotnetwebapp.key;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {
        # Proxy to the HTTPS port to avoid 307 Redirect loops from the app
        proxy_pass https://127.0.0.1:7012;
        
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Disable SSL verification for the backend (since it's localhost self-signed)
        proxy_ssl_verify off;
    }
}
```
Then reload Nginx:
```bash
sudo nginx -t && sudo systemctl reload nginx
```

### 3. Configure Router (Port Forwarding)
If using a typical home or small office router:

1. Log in to your router (usually `http://192.168.0.1`).
2. Go to **Forwarding** > **Virtual Servers**.
3. Add **Rule 1**: Port `80` → Your Local IP (`hostname -I`) Port `80`.
4. Add **Rule 2**: Port `443` → Your Local IP (`hostname -I`) Port `443`.
5. Save settings.

---

## Adding a New Data Entity from DDL

### Step 1: Update your SQL schema file
File: `sql/schema.sql`
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

### Step 2: Run the DDL → YAML → model pipeline
```bash
make run-ddl-pipeline
```

Output: `app.yaml` now contains `Author` and `Book` entities.

Generated files:
- `DotNetWebApp.Models/Generated/Author.cs`
- `DotNetWebApp.Models/Generated/Book.cs`

### Step 3: Apply migration and run
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

### Port 7012/5210 already in use
```bash
# Change port in launchSettings.json or run on different port
make dev  # Uses ports from launchSettings.json
```

---

## Key Files

| File | Purpose |
|------|---------|
| `app.yaml` | 📋 Generated data model (from SQL DDL) plus app metadata |
| `sql/schema.sql` | 📄 Source SQL DDL for the generation pipeline |
| `DotNetWebApp.Models/` | 🔄 Separate models assembly containing all data models |
| `DotNetWebApp.Models/Generated/` | 🔄 Auto-generated C# entities (don't edit directly) |
| `DotNetWebApp.Models/AppDictionary/` | YAML model classes for app.yaml structure |
| `Migrations/` | 📚 Generated schema history (current baseline checked in; pipeline regenerates) |
| `sql/seed.sql` | 🧪 Seed data for the default schema (run after schema apply) |
| `DdlParser/` | 🆕 Converts SQL DDL → YAML |
| `ModelGenerator/` | 🔄 Converts YAML → C# entities |
| `SECRETS.md` | 🔐 Connection string setup guide |
| `SESSION_SUMMARY.md` | 📝 Documentation index |
| `SKILLS.md` | 📚 Comprehensive developer skill guides |

---

## Next Steps

1. **Parse your own database schema** → See "Adding a New Data Entity from DDL" above
2. **Customize theme colors** → Edit `app.yaml` theme section
3. **Add validation rules** → Update `ModelGenerator/EntityTemplate.scriban` (or `app.yaml` metadata) and regenerate
4. **Create custom pages** → Add `.razor` files to `Components/Pages/`
5. **Extend REST API** → Add custom controllers in `Controllers/`

---

## Architecture

- **Backend:** ASP.NET Core 8 Web API with Entity Framework Core + Dapper (hybrid)
- **Frontend:** Blazor Server with Radzen UI components
- **Database:** SQL Server (Docker or native) with **two databases**:
  - **{PRIMARY_DB}** (primary): Main application data
  - **{SECONDARY_DB}** (secondary): Auxiliary/metrics data
- **Multi-Database Routing:** `IDbContextResolver` routes entities to correct database based on namespace
- **Configuration:** DDL-driven data models + JSON appsettings with `DatabaseMapping` section
- **Model Generation:** Automated from YAML via Scriban templates
- **Modular Design:** Models in separate `DotNetWebApp.Models` assembly for better separation of concerns

---

## Development Notes

- `dotnet-build.sh` manages .NET SDK version conflicts; do not modify system .NET install
- `DdlParser` and `ModelGenerator` are part of `DotNetWebApp.sln`; use `make run-ddl-pipeline` to regenerate models/migrations
- Generated entities use nullable reference types (`#nullable enable`)
- All value types for optional properties are nullable (`int?`, `decimal?`, etc.)
- **Phase 1 Complete:** See ARCHITECTURE_SUMMARY.md for detailed refactoring status and next steps
- For detailed implementation plans and architecture decisions, refer to CLAUDE.md

---

## Support

- See `SECRETS.md` for connection string setup
- See `CLAUDE.md` for developer context
- Review `SESSION_SUMMARY.md` for current project state
