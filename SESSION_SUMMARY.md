### Project State Summary

**Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.yaml` file for dynamic customization.

**Current Needs:** Below are the current needs by the developer team (if empty, ask for a task or wait for next prompt):
 1. Data Model should be driven by @sample-schema.sql first, then by @app.yaml
 2. Some clients using this project will have minimal programming experience, so we will need Claude Code SKILLS.md files throughout the project for each application layer via DDL/Data Pipleline (see @Makefile), e.g. Database, SQL, application yaml/configs, .NET/C# Data/ORM/Entity source code, API/Controller/Service source code, and front-end Blazor and Radzen UI components.
 3. All .NET/C# should be in proper modules and follow best practices for maintaining, extending, and unit testing. Refactor as needed to decouple application layers, reduce source code complexity, and make maintainability easier.


**Major Accomplishments:**

1. **YAML-Driven Configuration:** Application loads app metadata, theme, and data model from `app.yaml`.
2. **Dynamic Model Generation:** `ModelGenerator` reads `app.yaml` and generates entity classes in `Models/Generated` with nullable value types for optional fields.
3. **Dynamic Data Layer:** `AppDbContext` discovers entities via reflection and pluralizes table names (e.g., `Product` -> `Products`).
4. **Generic API:** `GenericController<T>` powers entity endpoints with singular names matching entity names.
5. **Dynamic UI:** `GenericEntityPage.razor` + `DynamicDataGrid.razor` render entities from YAML; `NavMenu.razor` provides dynamic navigation.
6. **DDL to YAML Parser Pipeline:** ✅ **COMPLETE**
   - **DdlParser** console project converts SQL Server DDL files to `app.yaml` format
   - Uses `Microsoft.SqlServer.TransactSql.ScriptDom` (170.147.0) for robust T-SQL parsing
   - Extracts: table definitions, column metadata (type, nullability, constraints), foreign keys, IDENTITY columns, DEFAULT values
   - Handles: VARCHAR/NVARCHAR max lengths, DECIMAL precision/scale, PRIMARY KEY and FOREIGN KEY constraints
   - Pipeline: `database.sql → DdlParser → app.yaml → ModelGenerator → Models/Generated/*.cs`
   - Makefile target: `make test-ddl-pipeline` orchestrates full workflow with validation
   - Test files: `sample-schema.sql` demonstrates Categories/Products schema; generates `app-test.yaml`
   - All nullable reference warnings (CS8601) resolved with null-coalescing defaults
7. **ModelGenerator Path Bug Fixed:** ✅ **COMPLETE (2026-01-21)**
   - Fixed nested directory bug: line 32 changed from `../DotNetWebApp/Models/Generated` to `../Models/Generated`
   - Created `ModelGenerator.Tests` project with 3 unit tests validating path resolution
   - Tests prevent regression by verifying correct output path and detecting nested structure
   - All tests passing; files now correctly generate to `Models/Generated/` (not nested)
8. **Developer Context Updated:** ✅ **COMPLETE (2026-01-21)**
   - `CLAUDE.md` fully updated with current project state from git logs, source code, and documentation
   - Restructured "Current State" into ✅ Completed Features, ⚠️ Limitations, 🔧 Development Status
   - Expanded "Architecture Notes" with detailed technical descriptions
   - Added "Key Files and Their Purposes" table and "Recent Development History" section
9. **Makefile Shellcheck Clean:** ✅ **COMPLETE**
   - Quoted `$(BUILD_CONFIGURATION)` in `Makefile` commands to satisfy `shellcheck` in `make check`
10. **DDL Pipeline Runtime Fix:** ✅ **COMPLETE**
   - Restored runtime project references so `DdlParser` and `ModelGenerator` can load `DotNetWebApp` during `make test-ddl-pipeline`
11. **Native MSSQL Log Helper:** ✅ **COMPLETE**
   - Added `make ms-logs` to tail systemd and `/var/opt/mssql/log/errorlog` for native Linux installs

**Build / Tooling:**
- `make check` runs `shellcheck` on `setup.sh` and `dotnet-build.sh`, then restores and builds.
- `make build` is clean; `make test-ddl-pipeline` tests complete DDL→YAML→Models→Build workflow.
- `make migrate` requires SQL Server running and valid connection string.
- `dotnet-build.sh` sets `DOTNET_ROOT` for global tools and bypasses `global.json` locally.
- **DdlParser** integrated into `DotNetWebApp.sln` as separate console project (excludes from main project compilation).
- `DotNetWebApp.Tests` now covers `SampleDataSeeder` via SQLite-backed integration tests so `make test` (Release) can validate the seed script and missing-file paths.
- **ModelGenerator.Tests** (2026-01-21) validates path resolution with 3 unit tests; prevents nested directory regression.
- `make test` runs all 5 tests (2 DotNetWebApp.Tests + 3 ModelGenerator.Tests) - all passing.

**Database State / Migrations:**
- Migration `AddCatalogSchema` creates `Categories` table and adds `CategoryId`, `CreatedAt`, `Description` to `Products`.
- Apply with: `make migrate` (requires SQL Server running via `make db-start`).
- `sample-seed.sql` provides example rows for the default schema; it now guards against duplicates and is executed by `SampleDataSeeder`.
- `make seed` invokes `dotnet run --project DotNetWebApp.csproj -- --seed`, which runs `Database.MigrateAsync()` and then executes the contents of `sample-seed.sql` via `ExecuteSqlRawAsync`; it keeps the seeding logic within EF without external tooling.
- README now documents how to install `mssql-tools` inside the SQL Server Docker container and how to query `dbo.Categories`/`dbo.Products` after running `make seed`.

**Tenant Schema:** Schema selection via `X-Customer-Schema` header (defaults to `dbo`).

**Current Task Status:** ✅ **READY FOR NEXT PHASE**
- ModelGenerator path bug fixed and tested (2026-01-21)
- CLAUDE.md updated with current project state (2026-01-21)
- All tests passing (5/5); full DDL pipeline verified
- Ready to implement: Transitioning from product-specific SPA/API to app.yaml-driven entities
- Foundation complete: `IEntityMetadataService` maps app.yaml entities to CLR types for reuse in API/UI
- Manual merge with `templify_merged_5-6` completed; branch re-synced with latest templify UI/build updates (2026-01-21)

**How to Use DDL Parser:**
```bash
# Test pipeline with sample schema
make test-ddl-pipeline

# Or manually parse custom SQL:
cd DdlParser && ../dotnet-build.sh run -- /path/to/schema.sql ../app.yaml
cd ../ModelGenerator && ../dotnet-build.sh run ../app.yaml
make build
```

**File Structure (New):**
```
DdlParser/
  ├── DdlParser.csproj
  ├── Program.cs              (CLI entry point)
  ├── SqlDdlParser.cs         (ScriptDom wrapper)
  ├── CreateTableVisitor.cs   (AST visitor for CREATE TABLE)
  ├── TypeMapper.cs           (SQL → YAML type conversion)
  ├── YamlGenerator.cs        (Metadata → YAML serialization)
  └── README.md               (Usage documentation)
```

**Known Limitations (By Design):**
- Composite primary keys not supported (single column PKs only)
- CHECK and UNIQUE constraints ignored
- Computed columns ignored
- Schema names normalized (all tables assumed in dbo schema)

**Next Steps (Optional):**
- Use `make test-ddl-pipeline` to validate any new SQL schema files
- Or integrate into CI/CD pipeline for automatic model regeneration from DDL
- Extend TypeMapper or CreateTableVisitor for additional SQL types if needed
