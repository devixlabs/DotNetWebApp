# Refactoring Plan: DotNetWebApp Architecture Analysis & Improvements

## Executive Summary

After comprehensive analysis of the DDL pipeline and comparison with the .NET ecosystem, I've identified that **DotNetWebApp fills a genuine gap** - no existing .NET solution provides the complete SQL DDL → YAML → Code → Dynamic API → Multi-tenant UI workflow. However, several areas need refactoring for improved maintainability, and specific components could benefit from mature third-party libraries.

## Part 1: Current Architecture Assessment

### DDL Pipeline (End-to-End Flow)

```
schema.sql (SQL DDL)
    ↓
DdlParser (TSql160Parser + CreateTableVisitor)
    → TableMetadata objects
    ↓
YamlGenerator (converts to AppDefinition)
    → app.yaml
    ↓
AppDictionaryService (singleton, loads YAML)
    ↓
EntityMetadataService (maps YAML entities → CLR types)
    ↓
ModelGenerator (Scriban templates)
    → Models/Generated/*.cs
    ↓
AppDbContext (reflection-based entity discovery)
    → DbSet<TEntity> auto-registration
    ↓
Controllers (EntitiesController)
    → REST API endpoints
    ↓
Blazor Components (DynamicDataGrid, GenericEntityPage)
    → Dynamic UI rendering
```

### Key Design Patterns Identified

1. **Metadata/Registry Pattern** - EntityMetadataService as central registry ✅
2. **Visitor Pattern** - CreateTableVisitor traverses T-SQL AST ✅
3. **Strategy Pattern** - ITenantSchemaAccessor for schema resolution ✅
4. **Dependency Injection** - Services properly registered ✅
5. **Template Method** - Scriban-based code generation ✅
6. **Record Pattern** - Immutable value types (EntityMetadata) ✅

### Code Quality Assessment

| Aspect | Rating | Key Issues |
|--------|--------|------------|
| Immutability | 7/10 | YAML models use mutable properties; should use `init` accessors |
| Error Handling | 6/10 | Reflection invocations lack context in exceptions |
| Validation | 5/10 | No input validation in controllers before deserialization |
| Separation of Concerns | 7/10 | Reflection logic in controllers should be extracted to service |
| Code Duplication | 6/10 | Reflection patterns repeated across multiple methods |
| Tight Coupling | 6/10 | Controllers directly reference DbContext (no repository abstraction) |
| Configuration | 7/10 | Mixed sources (appsettings.json, app.yaml, hard-coded values) |
| Testability | 7/10 | Good test doubles, but DbContext coupling limits mocking |

## Part 2: Framework & Library Alternatives

### Component-by-Component Analysis

#### 1. SQL DDL Parsing: **KEEP CURRENT**
- **Current:** Microsoft.SqlServer.TransactSql.ScriptDom v170.147.0
- **Alternatives:** Gudu SQLParser (commercial), DacFx (different use case)
- **Verdict:** ✅ ScriptDom is optimal - official Microsoft parser with full T-SQL fidelity

#### 2. Code Generation: **KEEP CURRENT**
- **Current:** Scriban v6.5.2
- **Alternatives:** T4 Templates (legacy), Roslyn Source Generators (compile-time)
- **Verdict:** ✅ Scriban is optimal for runtime YAML-driven generation

#### 3. Multi-Tenant Schema Switching: **RECOMMEND MIGRATION**
- **Current:** Custom ITenantSchemaAccessor + HeaderTenantSchemaAccessor
- **Alternative:** **Finbuckle.MultiTenant** (mature, actively maintained)
- **Verdict:** ⚠️ **MIGRATE TO FINBUCKLE** for:
  - Better tenant resolution strategies (subdomain, route, claim, header)
  - Robust data isolation patterns
  - Active maintenance and community support
  - ASP.NET Core Identity integration
- **Files to modify:**
  - `/Data/Tenancy/ITenantSchemaAccessor.cs`
  - `/Data/Tenancy/HeaderTenantSchemaAccessor.cs`
  - `/Data/Tenancy/TenantSchemaOptions.cs`
  - `/Data/AppDbContext.cs` (constructor)
  - `Program.cs` (service registration)

#### 4. Dynamic REST API: **KEEP WITH IMPROVEMENTS**
- **Current:** EntitiesController (dynamic, YAML-driven)
- **Alternatives:** OData (over-engineered), ServiceStack AutoQuery (commercial), EasyData (less flexible)
- **Verdict:** ✅ Current approach is simpler than OData, more flexible than EasyData
- **Improvement needed:** Extract reflection logic to IEntityOperationService
- **NOTE:** GenericController<T> has been removed; EntitiesController is the active pattern.

#### 5. Dynamic Blazor UI: **KEEP CURRENT**
- **Current:** Radzen Blazor + custom DynamicDataGrid
- **Alternatives:** MudBlazor (equivalent), Syncfusion (commercial)
- **Verdict:** ✅ Radzen is a solid choice
- **Enhancement opportunity:** Add dynamic form generation for Create/Edit operations

### Unique Value Proposition

**DotNetWebApp fills a gap:** No single .NET solution provides this complete workflow:
- ✅ DDL-first approach (not database-first like EF scaffolding)
- ✅ YAML intermediate metadata layer (enables runtime introspection)
- ✅ .NET-native throughout (unlike Hasura, PostgREST, Directus)
- ✅ Self-hosted, cloud-agnostic (unlike Azure Data API Builder)
- ✅ Simpler than OData, more flexible than low-code platforms
- ✅ Developer-centric with full code control

## Part 3: Refactoring Recommendations

### HIGH PRIORITY (Address First)

#### 1. Extract Reflection Logic to Service Layer

**PREREQUISITE:** ✅ COMPLETED (2026-01-25) - Missing CRUD operations (GetById, Update, Delete) have been implemented. This task is now unblocked.

**Problem:** EntitiesController contains reflection logic scattered across multiple methods that should be encapsulated.

**Files affected:**
- `/Controllers/EntitiesController.cs` (lines 30-56, 58-77, 94-106, 321-325, 327-337, 339-367)

**Solution:** Create `IEntityOperationService`

```csharp
// New file: /Services/IEntityOperationService.cs
public interface IEntityOperationService
{
    Task<IList> GetAllAsync(Type entityType, CancellationToken ct = default);
    Task<int> GetCountAsync(Type entityType, CancellationToken ct = default);
    Task<object> CreateAsync(Type entityType, object entity, CancellationToken ct = default);
    Task<object?> GetByIdAsync(Type entityType, object id, CancellationToken ct = default);
    Task<object> UpdateAsync(Type entityType, object entity, CancellationToken ct = default);
    Task DeleteAsync(Type entityType, object id, CancellationToken ct = default);
}
```

**Benefit:** Reduces EntitiesController from 369 lines to ~150-180 lines; centralizes reflection logic for reuse and testing.

#### 2. SQL-First View Pipeline (NEW: Dapper for Complex Reads)

**CONTEXT:** With 200+ entities and multiple database schemas, we need a scalable way to handle complex SQL queries (JOINs, aggregations, reports) without hand-writing services for each view. Legacy SQL queries should be the source of truth for UI features.

**Problem:**
- Blazor/Radzen components need complex multi-table queries
- Hand-writing Dapper services for 200+ entities is not scalable
- Legacy SQL queries exist but have no C# type safety
- Need to avoid bloated JavaScript/AJAX on front-end

**Solution:** Create SQL-first view generation pipeline (mirrors existing DDL-first entity pipeline)

**Architecture:**
```
ENTITY MODELS (200+ tables)
SQL DDL → app.yaml → Models/Generated/*.cs → EF Core CRUD (existing)

VIEW MODELS (complex queries)
SQL SELECT → views.yaml → Models/ViewModels/*.cs → Dapper reads (NEW)
```

**Files to create:**
- `views.yaml` - YAML registry of SQL views
- `sql/views/*.sql` - SQL query files
- `ModelGenerator/ViewModelGenerator.cs` - Scriban-based view model generator
- `Services/Views/IViewRegistry.cs` - View definition registry (singleton)
- `Services/Views/ViewRegistry.cs` - Implementation
- `Services/Views/IViewService.cs` - View execution service
- `Services/Views/ViewService.cs` - Implementation
- `Data/Dapper/IDapperQueryService.cs` - Read-only Dapper abstraction
- `Data/Dapper/DapperQueryService.cs` - Implementation (shares EF connection)
- `Models/ViewModels/*.cs` - Generated view models (auto-generated)

**Implementation steps:**
1. Create `views.yaml` schema and example SQL view files
2. Extend `ModelGenerator` to support view mode (`--mode=views`)
3. Create `ViewRegistry` service (loads views.yaml at startup)
4. Create `DapperQueryService` (shares EF Core's connection for automatic tenant schema)
5. Create `ViewService` (executes views by name)
6. Update `Program.cs` DI registration
7. Update Makefile with `run-view-pipeline` target
8. Create example Blazor component using `IViewService`

**Usage in Blazor components:**
```csharp
@inject IViewService ViewService

@code {
    private IEnumerable<ProductSalesView>? products;

    protected override async Task OnInitializedAsync()
    {
        // Execute registered view (SQL loaded from views.yaml)
        products = await ViewService.ExecuteViewAsync<ProductSalesView>(
            "ProductSalesView",
            new { TopN = 50 });
    }
}
```

**Benefits:**
- ✅ Legacy SQL as source of truth for complex features
- ✅ Generated C# models (type-safe, no manual writing)
- ✅ YAML registry for documentation and versioning
- ✅ Automatic multi-tenant schema isolation (via Finbuckle + shared EF connection)
- ✅ Scalable to 200+ entities
- ✅ No JavaScript/AJAX needed (server-side C# event handlers)
- ✅ Dapper used ONLY for complex reads (EF Core handles all writes via IEntityOperationService)

**Detailed plan:** See `PHASE2_VIEW_PIPELINE.md` for complete implementation guide.

**Duration:** 1-2 weeks

#### 3. Add Input Validation Pipeline

**Problem:** Controllers deserialize JSON without schema validation.

**Files affected:**
- `/Controllers/EntitiesController.cs` (CreateEntity, UpdateEntity methods)

**Solution:** Add FluentValidation or Data Annotations validation middleware

```csharp
[HttpPost("{entityName}")]
public async Task<ActionResult> CreateEntity(string entityName)
{
    var metadata = _metadataService.Find(entityName);
    var entity = JsonSerializer.Deserialize(json, metadata.ClrType);

    // NEW: Validate before saving
    var validationResults = new List<ValidationResult>();
    var context = new ValidationContext(entity);
    if (!Validator.TryValidateObject(entity, context, validationResults, validateAllProperties: true))
    {
        return BadRequest(new { errors = validationResults.Select(v => v.ErrorMessage) });
    }

    await _operationService.CreateAsync(metadata.ClrType, entity);
    return CreatedAtAction(nameof(GetEntities), new { entityName }, entity);
}
```

**Benefit:** Prevents invalid data from reaching the database; respects [Required], [MaxLength], etc. attributes on generated models.

#### 4. Migrate to Finbuckle.MultiTenant

**Problem:** Custom multi-tenant implementation lacks advanced features and maintenance support.

**Files to replace/modify:**
- DELETE: `/Data/Tenancy/ITenantSchemaAccessor.cs`
- DELETE: `/Data/Tenancy/HeaderTenantSchemaAccessor.cs`
- DELETE: `/Data/Tenancy/TenantSchemaOptions.cs`
- MODIFY: `/Data/AppDbContext.cs` (use Finbuckle's ITenantInfo)
- MODIFY: `Program.cs` (register Finbuckle services)

**Implementation steps:**
1. Install NuGet package: `Finbuckle.MultiTenant.AspNetCore` v8.x
2. Configure tenant resolution strategy (header-based)
3. Implement `ITenantInfo` with Schema property
4. Update AppDbContext to use `MultiTenantDbContext<AppDbContext, TenantInfo>`
5. Remove custom tenant accessor classes

**Benefit:** Robust tenant resolution, better data isolation patterns, active community support.

### MEDIUM PRIORITY

#### 5. Implement Repository Pattern (OPTIONAL - DEFERRED)

**DECISION:** SKIP this for now. The combination of `IEntityOperationService` (Phase 1) for EF Core writes and `IViewService` (Phase 2) for Dapper reads provides sufficient abstraction without adding a repository layer.

**Rationale:**
- `IEntityOperationService` already centralizes EF Core operations
- Repository Pattern would add redundant abstraction
- Can be added later if needed (e.g., for unit testing with mocks)
- Small team benefits from simpler architecture

**If implemented later:**
```csharp
public interface IRepository<TEntity> where TEntity : class
{
    Task<IEnumerable<TEntity>> GetAllAsync(CancellationToken ct = default);
    Task<TEntity?> GetByIdAsync(object id, CancellationToken ct = default);
    Task<TEntity> CreateAsync(TEntity entity, CancellationToken ct = default);
    Task<TEntity> UpdateAsync(TEntity entity, CancellationToken ct = default);
    Task DeleteAsync(object id, CancellationToken ct = default);
    Task<int> CountAsync(CancellationToken ct = default);
}
```

#### 6. Make YAML Models Immutable

**Problem:** AppDefinition, Entity, Property classes and related nested classes use mutable properties.

**Files affected:**
- `/DotNetWebApp.Models/AppDictionary/AppDefinition.cs` (contains all nested classes: AppMetadata, Theme, DataModel, Entity, Property, Relationship)

**Solution:** Change all `set` accessors to `init`

```csharp
public class AppDefinition
{
    public AppMetadata App { get; init; } = null!;
    public Theme Theme { get; init; } = null!;
    public DataModel DataModel { get; init; } = null!;
}
```

**Benefit:** Prevents accidental mutation after deserialization; better thread safety; clearer intent.

#### 7. Consolidate Configuration Sources

**AUDIT COMPLETE:** Configuration consolidation items are resolved.

**Summary:**
- ✅ TenantSchemaOptions: Properly configured (defaults overridden by appsettings.json)
- ✅ DdlParser YamlGenerator: Defaults are appropriate for the generation tool
- ✅ DataSeeder.SeedFileName: Configured via `DataSeeder` section in appsettings.json

**Problem:** Configuration scattered across appsettings.json, app.yaml, and hard-coded constants.

**Files affected:**
- `appsettings.json` (DataSeeder section added)
- `/Services/DataSeeder.cs` (reads `DataSeederOptions` instead of const)
- `/Models/DataSeederOptions.cs` (new options class)

**Solution:** Move all hard-coded values to configuration

```csharp
// appsettings.json
{
  "DataSeeder": {
    "SeedFileName": "seed.sql"
  },
  "TenantSchema": {
    "DefaultSchema": "dbo",
    "HeaderName": "X-Customer-Schema"
  }
}
```

**Benefit:** Single source of configuration truth; easier environment-specific overrides.

### NICE-TO-HAVE (Future Enhancements)

#### 8. Add Dynamic Form Generation

**Enhancement:** Add BlazorDynamicForm or MudBlazor.Forms for Create/Edit operations.

**New files:**
- `/Components/Shared/DynamicEntityForm.razor`

**Benefit:** Complete CRUD UI without manual form coding.

#### 9. Expression-Based Queries

**Enhancement:** Replace reflection with expression trees for better performance.

**Files affected:**
- New file: `/Services/ExpressionHelpers.cs`
- `/Services/EntityOperationService.cs`

**Benefit:** Better performance, compile-time type safety.

## Part 4: Critical Files for Refactoring

### Tier 1 - Core Abstractions (Modify First)
1. `/Services/IEntityMetadataService.cs` - Metadata abstraction
2. `/Services/EntityMetadataService.cs` - Metadata implementation
3. `/Data/AppDbContext.cs` - Entity registration and tenant schema

### Tier 2 - Controllers (Extract Logic)
4. `/Controllers/EntitiesController.cs` - Reflection-heavy dynamic API

**NOTE:** Existing services (EntityApiService, DashboardService, SpaSectionService) do NOT require changes during refactoring. See TODO.txt #3 for service layer integration analysis.

### Tier 3 - Multi-Tenancy (Replace with Finbuckle)
6. `/Data/Tenancy/ITenantSchemaAccessor.cs`
7. `/Data/Tenancy/HeaderTenantSchemaAccessor.cs`
8. `/Data/Tenancy/TenantSchemaOptions.cs`

### Tier 4 - YAML Models (Add Immutability)
9. `/DotNetWebApp.Models/AppDictionary/AppDefinition.cs` (all nested classes)

### Tier 5 - Services (New Abstractions)
10. NEW: `/Services/IEntityOperationService.cs` (Phase 1)
11. NEW: `/Services/EntityOperationService.cs` (Phase 1)
12. NEW: `/Services/Views/IViewRegistry.cs` (Phase 2)
13. NEW: `/Services/Views/ViewRegistry.cs` (Phase 2)
14. NEW: `/Services/Views/IViewService.cs` (Phase 2)
15. NEW: `/Services/Views/ViewService.cs` (Phase 2)
16. NEW: `/Data/Dapper/IDapperQueryService.cs` (Phase 2)
17. NEW: `/Data/Dapper/DapperQueryService.cs` (Phase 2)
18. NEW: `ModelGenerator/ViewModelGenerator.cs` (Phase 2)

## Part 5: Implementation Sequence

### Phase 1: Extract Reflection Logic (1-2 weeks)
1. Create `IEntityOperationService` interface
2. Implement `EntityOperationService` with all reflection logic
3. Update `EntitiesController` to use service
4. Add unit tests for `EntityOperationService`
5. Verify existing functionality unchanged

### Phase 2: SQL-First View Pipeline (1-2 weeks) **[NEW]**
1. Create `views.yaml` schema definition and example SQL view files
2. Extend `ModelGenerator` to support view generation mode
3. Create `ViewRegistry` service (loads views.yaml)
4. Create `DapperQueryService` (shares EF Core connection)
5. Create `ViewService` (executes views by name)
6. Update `Program.cs` DI registration
7. Update Makefile with `run-view-pipeline` target
8. Create example Blazor component using `IViewService`
9. Add integration tests for view pipeline
10. Test with multiple tenant schemas

**Detailed plan:** See `PHASE2_VIEW_PIPELINE.md`

### Phase 3: Add Validation (1 day)
1. Add FluentValidation NuGet package (or use built-in Data Annotations)
2. Create validation pipeline in controllers
3. Add integration tests for validation scenarios
4. Verify invalid entities are rejected

### Phase 4: Migrate to Finbuckle.MultiTenant (2-3 days)
1. Install `Finbuckle.MultiTenant.AspNetCore` NuGet package
2. Create `TenantInfo` class implementing `ITenantInfo`
3. Configure header-based tenant resolution
4. Update `AppDbContext` to inherit `MultiTenantDbContext<AppDbContext, TenantInfo>`
5. Update `Program.cs` service registration
6. Remove custom tenant accessor classes
7. Test multi-tenant scenarios (different schemas via headers)
8. Verify Dapper queries inherit tenant schema automatically (via shared EF connection)

### Phase 5: Configuration & Immutability (1 day)
1. Move hard-coded values to `appsettings.json`
2. Update YAML models to use `init` accessors
3. Verify YAML deserialization still works
4. Update tests for new configuration sources

## Part 6: Testing Strategy

### Unit Tests (New)
- `EntityOperationService` - All reflection methods (GetAllAsync, CreateAsync, etc.)
- `ViewRegistry` - YAML loading and SQL file resolution
- `ViewService` - View execution with parameters
- `DapperQueryService` - Query execution with shared connection
- `ValidationPipeline` - Valid/invalid entity scenarios

### Integration Tests (Update)
- Multi-tenant scenarios with Finbuckle (different schemas for EF + Dapper)
- End-to-end API tests with validation
- View pipeline: SQL query → view model generation → Blazor component rendering
- Verify Dapper queries respect tenant schema automatically

### Regression Tests
- Verify DDL pipeline still generates correct models (existing)
- Verify View pipeline generates correct view models (new)
- Verify existing API endpoints return same results
- Verify Blazor UI still renders correctly

## Part 7: Risk Assessment

| Change | Risk | Mitigation |
|--------|------|------------|
| Extract reflection logic | Low | Good test coverage; logic unchanged |
| View pipeline (SQL-first) | Low-Medium | Similar to existing DDL pipeline; test with multiple schemas |
| Add validation | Low | Existing data annotations already defined |
| Finbuckle migration | Medium | Test multi-tenant scenarios thoroughly; staged rollout; verify Dapper inherits schema |
| Immutable YAML models | Low | YamlDotNet handles `init` properties correctly |
| Dapper shared connection | Low | EF connection sharing is standard pattern; test transaction scenarios |

## Part 8: Success Criteria

After refactoring:
- ✅ EntitiesController reduced from 369 lines to ~150-180 lines
- ✅ Reflection logic centralized in EntityOperationService
- ✅ **SQL-first view pipeline operational (views.yaml → ViewModels/*.cs → IViewService)** [NEW]
- ✅ **Legacy SQL queries used as source of truth for complex UI features** [NEW]
- ✅ **Dapper integrated for complex reads; EF Core handles all writes** [NEW]
- ✅ All API endpoints validate input before persistence
- ✅ Multi-tenancy powered by Finbuckle.MultiTenant
- ✅ **Dapper queries automatically respect tenant schema (via shared EF connection)** [NEW]
- ✅ YAML models immutable (init accessors)
- ✅ All hard-coded values in configuration
- ✅ All existing tests passing
- ✅ Code coverage increased (new service/view tests)
- ✅ **Blazor components use server-side C# event handlers (no JavaScript/AJAX)** [NEW]
- ✅ Architecture documented in updated REFACTOR.md + PHASE2_VIEW_PIPELINE.md

## Part 9: Architectural Strengths to Preserve

**DO NOT CHANGE:**
1. ✅ SQL DDL → YAML → Code pipeline (unique advantage)
2. ✅ YAML metadata layer (enables runtime introspection)
3. ✅ Scriban-based code generation (optimal for this use case)
4. ✅ Dynamic entity discovery via reflection (scalable)
5. ✅ ScriptDom for SQL parsing (best-in-class)
6. ✅ Radzen Blazor for UI (solid choice)
7. ✅ Dependency injection patterns (clean)
8. ✅ Test doubles and integration tests (good foundation)

## Part 10: Future Considerations (Beyond Current Scope)

1. **SQL-to-YAML Auto-Discovery Tool:** Automatically generate views.yaml from legacy SQL files (reduces manual YAML writing)
2. **View Parameter Validation:** Add parameter validation for SQL views (prevent SQL injection via parameters)
3. **Compiled Queries:** Add EF compiled queries for frequently executed operations (performance optimization)
4. **View Caching:** Add IMemoryCache for ViewRegistry SQL cache (reduce file I/O)
5. **Row-Level Security:** Add tenant-aware query filters in DbContext
6. **Rate Limiting:** Add ASP.NET Core rate limiting middleware
7. **API Versioning:** Support versioned endpoints for breaking changes
8. **Audit Logging:** Track entity changes (created, modified, deleted)
9. **Soft Deletes:** Add IsDeleted flag and query filters
10. **Background Jobs:** Use Hangfire/Quartz for async data processing
11. **Event Sourcing:** Track all entity state changes
12. **Database Migrations per Tenant:** Automate schema migrations for multi-tenant databases

## Verification Plan

### Manual Testing
1. Run `make run-ddl-pipeline` - verify entity models generated correctly
2. **Run `make run-view-pipeline` - verify view models generated correctly** [NEW]
3. Run `make migrate` - verify EF Core migrations work
4. Run `make dev` - verify app starts and API endpoints respond
5. Test `/api/entities/Product` with different `X-Customer-Schema` headers
6. **Test view execution with different `X-Customer-Schema` headers (verify Dapper inherits schema)** [NEW]
7. Verify DynamicDataGrid renders correctly in Blazor UI
8. **Verify Blazor components using IViewService render correctly** [NEW]
9. Verify Create/Edit operations with valid and invalid data

### Automated Testing
1. Run `make test` - verify all unit and integration tests pass
2. Run new EntityOperationService tests
3. **Run new ViewRegistry tests** [NEW]
4. **Run new ViewService tests** [NEW]
5. **Run new DapperQueryService tests** [NEW]
6. Run multi-tenant integration tests with Finbuckle (EF + Dapper)

### Performance Testing
1. Benchmark EntityOperationService vs direct reflection (should be equivalent)
2. **Benchmark Dapper vs EF for complex JOIN queries (expect 2-5x improvement)** [NEW]
3. Verify no performance regression in API response times
4. Verify DbContext pooling still effective with Finbuckle

---

## Source Code Verification Status

This refactoring plan has been verified against the actual source code. Prior verification items
(controller architecture, service layer integration, and configuration consolidation) are resolved.

## Recommended Next Steps

**UPDATED for 200+ entities + multiple schemas + small team:**

1. **Phase 1 (CRITICAL):** Extract Reflection Logic to IEntityOperationService (1-2 weeks)
   - Centralizes CRUD for all 200+ generated entities
   - Reduces controller complexity
   - Foundation for all subsequent work

2. **Phase 2 (CRITICAL):** Implement SQL-First View Pipeline (1-2 weeks)
   - Enables legacy SQL queries as source of truth
   - Generates type-safe view models
   - Powers complex Blazor/Radzen components
   - **See PHASE2_VIEW_PIPELINE.md for detailed plan**

3. **Phase 3 (HIGH):** Add Validation Pipeline (1 day)
   - Prevents invalid data entry
   - Respects data annotations

4. **Phase 4 (HIGH):** Migrate to Finbuckle.MultiTenant (2-3 days)
   - Essential for multiple schema management at scale
   - Automatic tenant isolation for EF + Dapper

5. **Phase 5 (MEDIUM):** Configuration & Immutability (1 day)
   - Code quality and maintainability improvements

**Total timeline:** 3-4 weeks for Phases 1-5

**Incremental approach recommended:**
- Implement phases sequentially
- Test thoroughly between phases
- Don't skip Phase 1 and Phase 2 (foundation for scale)
