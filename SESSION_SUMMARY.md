### Project State Summary

**Primary Goal:** Abstract the application's data model, configuration, and branding into a single `app.yaml` file for dynamic customization.

---

## Documentation Index

This project is documented across multiple files. Refer to the appropriate document for your needs:

| Document | Purpose |
|----------|---------|
| [CLAUDE.md](CLAUDE.md) | Developer context, project overview, completed features, architecture, build commands |
| [README.md](README.md) | Quick start guide, feature overview, project structure, commands reference, troubleshooting |
| [SKILLS.md](SKILLS.md) | Skill guides for developers (Database & DDL, SQL Operations, App Configuration & YAML, Blazor/Radzen, pending: .NET/C# Data Layer, .NET/C# API & Services) |
| [REFACTOR.md](REFACTOR.md) | Comprehensive refactoring plan with 5 prioritized phases, architecture assessment, risk analysis, testing strategy |
| [TODO.txt](TODO.txt) | Actionable next steps and work items |

---

## Major Accomplishments (Completed)

See [CLAUDE.md](CLAUDE.md#completed-features) for full details. Summary:

- ✅ YAML-Driven Configuration
- ✅ Dynamic Model Generation
- ✅ Dynamic Data Layer (EF Core with reflection-based entity discovery)
- ✅ Dynamic Entity API (`/api/entities/{entityName}`)
- ✅ Dynamic UI (GenericEntityPage + DynamicDataGrid)
- ✅ DDL to YAML Parser Pipeline
- ✅ ModelGenerator with proper nullable types
- ✅ Complete test coverage (5 unit/integration tests)
- ✅ Build optimizations (30+ min → 2-5 min)
- ✅ Shell script linting (shellcheck)
- ✅ Docker support and deployment
- ✅ Multi-tenant schema switching via headers

---

## Active Work: Refactoring Initiative

See [REFACTOR.md](REFACTOR.md) for comprehensive analysis and implementation details.

**5 Priority Phases (estimated 7-10 days total):**

1. **Phase 1: Extract Reflection Logic** (1-2 days) - HIGH PRIORITY
   - Create `IEntityOperationService` to encapsulate EntitiesController logic

2. **Phase 2: Add Input Validation** (1 day) - HIGH PRIORITY
   - Validate entity deserialization before database persistence

3. **Phase 3: Migrate to Finbuckle.MultiTenant** (2-3 days) - HIGH PRIORITY
   - Replace custom tenant implementation with mature library

4. **Phase 4: Implement Repository Pattern** (2 days) - MEDIUM PRIORITY
   - Decouple controllers from EF Core via `IRepository<T>`

5. **Phase 5: Configuration & Immutability** (1 day) - MEDIUM PRIORITY
   - Move hard-coded values to `appsettings.json`
   - Make YAML models immutable with `init` accessors

---

## Orphans
- Add more SQL types to TypeMapper

