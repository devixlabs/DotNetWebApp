### Project State Summary

**Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.yaml` file for dynamic customization.

**Major Accomplishments:**

1. **YAML-Driven Configuration:** Application loads app metadata, theme, and data model from `app.yaml`.
2. **Dynamic Model Generation:** `ModelGenerator` reads `app.yaml` and generates entity classes in `Models/Generated` with nullable value types for optional fields.
3. **Dynamic Data Layer:** `AppDbContext` discovers entities via reflection and pluralizes table names (e.g., `Product` -> `Products`).
4. **Generic API:** `GenericController<T>` powers entity endpoints with singular names matching entity names.
5. **Dynamic UI:** `GenericEntityPage.razor` + `DynamicDataGrid.razor` render entities from YAML; `NavMenu.razor` provides dynamic navigation.
6. **DDL to YAML Parser Pipeline:** ✅ **NEW - COMPLETE**
   - **DdlParser** console project converts SQL Server DDL files to `app.yaml` format
   - Uses `Microsoft.SqlServer.TransactSql.ScriptDom` (170.147.0) for robust T-SQL parsing
   - Extracts: table definitions, column metadata (type, nullability, constraints), foreign keys, IDENTITY columns, DEFAULT values
   - Handles: VARCHAR/NVARCHAR max lengths, DECIMAL precision/scale, PRIMARY KEY and FOREIGN KEY constraints
   - Pipeline: `database.sql → DdlParser → app.yaml → ModelGenerator → Models/Generated/*.cs`
   - Makefile target: `make test-ddl-pipeline` orchestrates full workflow with validation
   - Test files: `sample-schema.sql` demonstrates Categories/Products schema; generates `app-test.yaml`
   - All nullable reference warnings (CS8601) resolved with null-coalescing defaults

**Build / Tooling:**
- `make check` runs `shellcheck` on `setup.sh` and `dotnet-build.sh`, then restores and builds.
- `make build` is clean; `make test-ddl-pipeline` tests complete DDL→YAML→Models→Build workflow.
- `make migrate` requires SQL Server running and valid connection string.
- `dotnet-build.sh` sets `DOTNET_ROOT` for global tools and bypasses `global.json` locally.
- **DdlParser** integrated into `DotNetWebApp.sln` as separate console project (excludes from main project compilation).

**Database State / Migrations:**
- Migration `AddCatalogSchema` creates `Categories` table and adds `CategoryId`, `CreatedAt`, `Description` to `Products`.
- Apply with: `make migrate` (requires SQL Server running via `make db-start`).

**Tenant Schema:** Schema selection via `X-Customer-Schema` header (defaults to `dbo`).

**Current Task Status:** ✅ **COMPLETE**
- UI and build stable; dynamic navigation and entity pages working
- DDL Parser pipeline fully implemented and tested
- Complete workflow: SQL → YAML → Models → Build → Deploy ready

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
