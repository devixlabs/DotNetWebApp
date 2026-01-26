# DotNetWebApp Architecture Summary

**Last Updated:** 2026-01-26
**Status:** Architecture finalized, ready for Phase 1 implementation

---

## Quick Navigation

| Document | Purpose | When to Read |
|----------|---------|--------------|
| **REFACTOR.md** | Complete refactoring plan with all 5 phases | Before starting any refactoring work |
| **PHASE2_VIEW_PIPELINE.md** | Detailed step-by-step implementation guide for View Pipeline | When implementing Phase 2 |
| **HYBRID_ARCHITECTURE.md** | Simplified EF+Dapper architecture reference | When understanding data access patterns |
| **CLAUDE.md** | Project context for Claude Code sessions | Every new Claude session |
| **SESSION_SUMMARY.md** | Development log and decisions | When catching up on recent work |

---

## Architecture Overview

### Core Philosophy: SQL-First Everything

```
┌─────────────────────────────────────────────────────────────┐
│ ENTITIES (200+ tables)                                      │
│ SQL DDL → app.yaml → Generated/*.cs → EF Core CRUD          │
│                                                             │
│ Pipeline: make run-ddl-pipeline                            │
│ Data Access: IEntityOperationService (reflection-based)    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ VIEWS (complex queries)                                     │
│ SQL SELECT → views.yaml → ViewModels/*.cs → Dapper reads   │
│                                                             │
│ Pipeline: make run-view-pipeline                           │
│ Data Access: IViewService (type-safe queries)              │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ BUSINESS LOGIC                                              │
│ Blazor Server → C# event handlers (no JavaScript/AJAX)     │
│                                                             │
│ Writes: IEntityOperationService (EF Core)                  │
│ Reads: IViewService (Dapper for complex JOINs)             │
└─────────────────────────────────────────────────────────────┘
```

---

## Key Architectural Decisions

### ✅ What We ARE Doing

1. **Hybrid Data Access:**
   - EF Core for all writes (200+ generated entities)
   - Dapper for complex reads (SQL-first views)
   - Shared connection for automatic tenant schema inheritance

2. **SQL-First View Pipeline:**
   - Legacy SQL queries as source of truth
   - YAML registry (`views.yaml`)
   - Generated C# view models
   - Type-safe service layer (`IViewService`)

3. **Multi-Tenancy:**
   - Finbuckle.MultiTenant for robust tenant isolation
   - Header-based strategy (`X-Customer-Schema`)
   - Automatic schema propagation to Dapper (via shared EF connection)

4. **Single-Project Organization:**
   - Namespace-based separation (not 4 separate projects)
   - Pragmatic for small team
   - Can refactor to projects later if team grows

5. **Dynamic Patterns:**
   - Reflection-based entity operations (scalable to 200+ entities)
   - Dynamic API endpoints (`/api/entities/{entityName}`)
   - Runtime YAML-driven UI components

### ❌ What We Are NOT Doing

1. **Full Clean Architecture:**
   - No Domain/Application/Infrastructure/WebUI projects
   - Namespaces provide sufficient organization

2. **Repository Pattern:**
   - `IEntityOperationService` + `IViewService` are sufficient abstractions
   - Avoids redundant layers

3. **CQRS/Mediator:**
   - Adds complexity without benefit at this scale
   - Direct service calls are clearer

4. **OData:**
   - Our reflection-based approach is simpler
   - More flexible for dynamic requirements

5. **Client-Side Complexity:**
   - No bloated JavaScript/AJAX
   - Server-side C# event handlers via Blazor SignalR

---

## Implementation Phases

### ✅ Completed (Before 2026-01-26)

- DDL-first entity generation pipeline
- Dynamic EF Core entity discovery
- Generic CRUD API (`EntitiesController`)
- Blazor Server SPA with Radzen components
- Multi-tenant schema switching (custom implementation)

### 🔄 Phase 1: Extract Reflection Logic (1-2 weeks)

**Goal:** Centralize EF Core operations for 200+ entities

**Deliverables:**
- `IEntityOperationService` interface
- `EntityOperationService` implementation
- Updated `EntitiesController` (reduced from 369 to ~150 lines)
- Unit tests

**Why First:** Foundation for all subsequent work

### 🔄 Phase 2: SQL-First View Pipeline (1-2 weeks)

**Goal:** Enable legacy SQL as source of truth for complex UI features

**Deliverables:**
- `views.yaml` schema definition
- SQL view files in `sql/views/`
- `ViewModelGenerator` (extends ModelGenerator)
- `ViewRegistry`, `ViewService`, `DapperQueryService`
- `make run-view-pipeline` Makefile target
- Example Blazor component

**Why Critical:** Scales to 200+ entities without hand-writing services

**Detailed Plan:** See `PHASE2_VIEW_PIPELINE.md`

### 🔄 Phase 3: Validation Pipeline (1 day)

**Goal:** Prevent invalid data entry

**Deliverables:**
- Validation middleware in controllers
- Integration tests

### 🔄 Phase 4: Finbuckle Multi-Tenancy (2-3 days)

**Goal:** Robust tenant isolation for multiple schemas

**Deliverables:**
- `TenantInfo` class
- Finbuckle DI registration
- Updated `AppDbContext`
- Multi-tenant integration tests (EF + Dapper)

### 🔄 Phase 5: Configuration & Immutability (1 day)

**Goal:** Code quality improvements

**Deliverables:**
- YAML models with `init` accessors
- Configuration consolidation

**Total Timeline:** 3-4 weeks

---

## Data Access Patterns

### Pattern 1: Simple CRUD (Use EF Core)

```csharp
@inject IEntityOperationService EntityService

private async Task OnSaveAsync()
{
    var productType = typeof(Product);
    var product = new Product { Name = "Widget", Price = 9.99m };
    await EntityService.CreateAsync(productType, product);
}
```

**When:**
- Single entity operations
- Simple queries
- All writes (inserts, updates, deletes)

### Pattern 2: Complex Views (Use Dapper)

```csharp
@inject IViewService ViewService

protected override async Task OnInitializedAsync()
{
    products = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = 50 });
}
```

**When:**
- Multi-table JOINs (3+ tables)
- Aggregations (SUM, AVG, GROUP BY)
- Reports and dashboards
- Read-only queries

---

## Project Structure

```
DotNetWebApp/
├── sql/
│   ├── schema.sql                      # DDL (entities)
│   └── views/                          # SQL views (NEW)
├── app.yaml                            # Entity definitions
├── views.yaml                          # View definitions (NEW)
├── DotNetWebApp.Models/
│   ├── Generated/                      # EF entities
│   ├── ViewModels/                     # Dapper DTOs (NEW)
│   └── AppDictionary/                  # YAML models
├── Services/
│   ├── IEntityOperationService.cs      # EF CRUD (NEW)
│   ├── EntityOperationService.cs       # (NEW)
│   └── Views/                          # Dapper services (NEW)
│       ├── IViewRegistry.cs
│       ├── ViewRegistry.cs
│       ├── IViewService.cs
│       └── ViewService.cs
├── Data/
│   ├── AppDbContext.cs                 # EF Core
│   └── Dapper/                         # (NEW)
│       ├── IDapperQueryService.cs
│       └── DapperQueryService.cs
├── Controllers/
│   └── EntitiesController.cs           # Dynamic CRUD API
├── Components/
│   ├── Pages/                          # Blazor pages
│   └── Shared/                         # Reusable components
├── ModelGenerator/
│   ├── EntityGenerator.cs              # Existing
│   └── ViewModelGenerator.cs           # (NEW)
├── Makefile
├── REFACTOR.md                         # Complete refactoring plan
├── PHASE2_VIEW_PIPELINE.md             # Phase 2 detailed guide
├── HYBRID_ARCHITECTURE.md              # Architecture reference
├── ARCHITECTURE_SUMMARY.md             # This file
└── CLAUDE.md                           # Claude Code context
```

---

## Multi-Tenancy Strategy

### Header-Based Tenant Resolution

```http
GET /api/entities/Product
X-Customer-Schema: customer1

# Resolves to: SELECT * FROM customer1.Products
```

### Finbuckle Configuration

```csharp
builder.Services.AddMultiTenant<TenantInfo>()
    .WithHeaderStrategy("X-Customer-Schema")
    .WithInMemoryStore(/* tenants */);
```

### Automatic Schema Inheritance (EF → Dapper)

```csharp
// Dapper shares EF's connection
builder.Services.AddScoped<IDapperQueryService>(sp =>
{
    var dbContext = sp.GetRequiredService<AppDbContext>();
    return new DapperQueryService(dbContext);  // ✅ Same connection
});
```

**Result:** No manual schema injection needed!

---

## Testing Strategy

### Unit Tests
- `EntityOperationService` (EF Core operations)
- `ViewRegistry` (YAML loading)
- `ViewService` (view execution)
- Validation pipeline

### Integration Tests
- Multi-tenant scenarios (EF + Dapper with different schemas)
- End-to-end API tests
- View pipeline (SQL → generated model → Blazor render)

### Performance Tests
- Benchmark Dapper vs EF for complex JOINs
- Query profiling with Application Insights

---

## Common Workflows

### Adding a New Entity

1. Update `schema.sql` with DDL
2. Run `make run-ddl-pipeline`
3. Run `dotnet ef migrations add AddNewEntity`
4. Run `make migrate`
5. Entity automatically available via `/api/entities/NewEntity`

### Adding a New SQL View

1. Create `sql/views/MyView.sql`
2. Add entry to `views.yaml`
3. Run `make run-view-pipeline`
4. Use generated `MyView.cs` in Blazor components:
   ```csharp
   @inject IViewService ViewService
   var data = await ViewService.ExecuteViewAsync<MyView>("MyView");
   ```

### Adding Business Logic

1. Create server-side event handler in Blazor component:
   ```csharp
   private async Task OnProcessAsync(int id)
   {
       // Business logic in C# (not JavaScript)
       await EntityService.UpdateAsync(/* ... */);
   }
   ```
2. Bind to Radzen component:
   ```razor
   <RadzenButton Text="Process" Click="@(() => OnProcessAsync(item.Id))" />
   ```

---

## Performance Optimization Guidelines

1. **Use compiled queries for hot paths** (EF Core)
2. **Add caching to metadata services** (EntityMetadataService, ViewRegistry)
3. **Convert slow EF queries to Dapper** (after profiling)
4. **Enable query splitting for collections** (EF Core)
5. **Use Dapper for read-heavy endpoints** (dashboards, reports)

---

## FAQ for Future Claude Sessions

### Q: Should I use EF Core or Dapper for this feature?

**A:** See "Data Access Patterns" section above. General rule:
- **Writes:** Always EF Core (via `IEntityOperationService`)
- **Simple reads:** EF Core
- **Complex reads (3+ table JOINs):** Dapper (via `IViewService`)

### Q: How do I add a new entity?

**A:** Update `schema.sql`, run `make run-ddl-pipeline`, run migrations. See "Common Workflows" above.

### Q: How do I add a new SQL view?

**A:** Create SQL file, update `views.yaml`, run `make run-view-pipeline`. See "Common Workflows" above.

### Q: Do I need to implement a repository for each entity?

**A:** No! `IEntityOperationService` handles all 200+ entities dynamically via reflection.

### Q: How does multi-tenancy work with Dapper?

**A:** Dapper shares EF Core's connection, so tenant schema is automatic. No manual injection needed.

### Q: Should I use Clean Architecture with separate projects?

**A:** No. We use namespace-based organization in a single project. See "Key Architectural Decisions" above.

---

## Success Criteria

After completing all phases:

- ✅ EntitiesController reduced from 369 to ~150 lines
- ✅ SQL-first view pipeline operational
- ✅ Legacy SQL queries as source of truth
- ✅ Dapper for complex reads, EF for writes
- ✅ Finbuckle multi-tenancy with automatic Dapper schema inheritance
- ✅ All tests passing
- ✅ Blazor components use C# event handlers (no JavaScript/AJAX)
- ✅ Scalable to 200+ entities

---

## Next Steps

1. **Begin Phase 1:** Extract `IEntityOperationService` (see REFACTOR.md)
2. **After Phase 1:** Implement Phase 2 View Pipeline (see PHASE2_VIEW_PIPELINE.md)
3. **After Phase 2:** Continue with Phases 3-5 (see REFACTOR.md)

---

**For detailed implementation guidance, refer to:**
- **REFACTOR.md** - All phases with code examples
- **PHASE2_VIEW_PIPELINE.md** - Step-by-step Phase 2 guide
- **HYBRID_ARCHITECTURE.md** - Architecture patterns and reference
