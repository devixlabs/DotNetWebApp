# Task #2 Implementation Review: Dynamic API Endpoints

**Date:** 2026-01-22
**Status:** ✅ Ready for Commit
**Branch:** templify

---

## Summary

Implemented dynamic API endpoints at `api/entities/{entityName}` that work with any entity defined in app.yaml. The implementation uses reflection to handle runtime type resolution since EF Core 8 lacks a non-generic `DbContext.Set(Type)` method.

---

## Files Changed

### New Files (2)
1. **Controllers/EntitiesController.cs** (142 lines)
   - Dynamic API controller with reflection-based entity access
   - Three endpoints: GET list, GET count, POST create

2. **tests/DotNetWebApp.Tests/EntitiesControllerTests.cs** (265 lines)
   - Comprehensive unit tests for all endpoints
   - 9 test cases covering success and error scenarios

### Modified Files (2)
1. **TODO.txt**
   - Marked Task #2 as complete
   - Added implementation notes about reflection approach

2. **app.yaml**
   - Copied from app.example.yaml for testing
   - Contains Product and Category entity definitions

---

## API Endpoints Implemented

### 1. GET /api/entities/{entityName}
**Purpose:** Retrieve all entities of specified type
**Response:** JSON array of entities
**Status Codes:**
- 200 OK - Success with entity array
- 404 Not Found - Entity name not found in app.yaml

**Example:**
```bash
curl https://localhost:7012/api/entities/product
```

### 2. GET /api/entities/{entityName}/count
**Purpose:** Get count of entities
**Response:** Integer count
**Status Codes:**
- 200 OK - Success with count
- 404 Not Found - Entity name not found

**Example:**
```bash
curl https://localhost:7012/api/entities/product/count
```

### 3. POST /api/entities/{entityName}
**Purpose:** Create new entity
**Request Body:** JSON representing entity (PascalCase properties)
**Response:** Created entity with Location header
**Status Codes:**
- 201 Created - Success
- 400 Bad Request - Invalid JSON or empty body
- 404 Not Found - Entity name not found

**Example:**
```bash
curl -X POST https://localhost:7012/api/entities/category \
  -H "Content-Type: application/json" \
  -d '{"Name":"Electronics"}'
```

---

## Technical Implementation

### Key Challenge
EF Core 8 does not provide a non-generic `DbContext.Set(Type)` method like Entity Framework 6 did. This required using reflection to invoke generic methods at runtime.

### Solution Architecture

**1. Entity Resolution:**
```csharp
GetDbSet(Type entityType)
```
- Uses reflection to call `DbContext.Set<T>()`
- Invokes generic method with runtime type parameter

**2. Async Query Execution:**
```csharp
ExecuteToListAsync(Type entityType, IQueryable query)
ExecuteCountAsync(Type entityType, IQueryable query)
```
- Finds generic `ToListAsync<T>()` / `CountAsync<T>()` methods
- Creates specialized version via `MakeGenericMethod()`
- Invokes and awaits Task result via reflection

**3. JSON Deserialization:**
```csharp
JsonSerializer.Deserialize(json, metadata.ClrType)
```
- Uses runtime type overload of `JsonSerializer.Deserialize()`
- Converts JSON to strongly-typed entity instance

### Design Decisions

**✅ Non-breaking:** Existing `ProductController` and `CategoryController` remain functional
**✅ Type-safe:** Uses `IEntityMetadataService` to validate entity names
**✅ Tenant-aware:** Inherits schema support from `AppDbContext`
**✅ Error handling:** Returns appropriate HTTP status codes with error messages
**✅ Testable:** Comprehensive unit test coverage with mocked dependencies

---

## Test Coverage

### Test Results
```
Passed!  - Failed: 0, Passed: 11, Skipped: 0, Total: 11, Duration: 1s
```

### Test Cases (9 new tests)

**GET Endpoints (4 tests):**
1. ✅ `GetEntities_ReturnsProducts_WhenEntityExists`
2. ✅ `GetEntities_ReturnsCategories_WhenEntityExists`
3. ✅ `GetEntities_Returns404_WhenEntityNotFound`
4. ✅ `GetEntityCount_ReturnsCount_WhenEntityExists`

**Count Endpoint (1 test):**
5. ✅ `GetEntityCount_Returns404_WhenEntityNotFound`

**POST Endpoint (4 tests):**
6. ✅ `CreateEntity_CreatesAndReturnsEntity_WhenValidJson`
7. ✅ `CreateEntity_Returns404_WhenEntityNotFound`
8. ✅ `CreateEntity_ReturnsBadRequest_WhenEmptyBody`
9. ✅ `CreateEntity_ReturnsBadRequest_WhenInvalidJson`

### Test Infrastructure
- Uses SQLite in-memory database
- Mock implementations of `IEntityMetadataService` and `ITenantSchemaAccessor`
- Tests both success and failure scenarios
- Validates HTTP status codes and response types

---

## Manual Testing Results

### Test Environment
- **Server:** https://localhost:7012
- **Entities:** Product (5 records), Category (7 records)

### Test Scenarios

**✅ GET Products:**
```bash
curl https://localhost:7012/api/entities/product
# Response: 200 OK, JSON array with 5 products
```

**✅ GET Categories:**
```bash
curl https://localhost:7012/api/entities/category
# Response: 200 OK, JSON array with 7 categories
```

**✅ GET Count:**
```bash
curl https://localhost:7012/api/entities/product/count
# Response: 200 OK, value: 5
```

**✅ POST Create:**
```bash
curl -X POST https://localhost:7012/api/entities/category \
  -H "Content-Type: application/json" \
  -d '{"Name":"Test Category 2"}'
# Response: 201 Created, Location header with new resource URL
```

**✅ Invalid Entity:**
```bash
curl https://localhost:7012/api/entities/invalid
# Response: 404 Not Found, {"error":"Entity 'invalid' not found"}
```

**✅ Existing Controllers Still Work:**
```bash
curl https://localhost:7012/api/product        # 5 products
curl https://localhost:7012/api/category       # 7 categories
```

---

## Performance Considerations

### Reflection Overhead
- Reflection occurs once per HTTP request (not per entity)
- Method resolution is fast (microseconds)
- Negligible impact compared to database query time
- Acceptable trade-off for YAML-driven flexibility

### Optimization Opportunities (Future)
- Cache reflected methods in static dictionary
- Add request-level caching for repeated entity queries
- Consider compiled expressions for high-throughput scenarios

---

## Known Limitations

### 1. JSON Property Naming
- POST endpoint requires **PascalCase** JSON properties (e.g., `{"Name":"value"}`)
- This matches C# property naming conventions
- **Future Enhancement:** Add `JsonSerializerOptions` with `PropertyNameCaseInsensitive = true`

### 2. Missing Endpoints
Not implemented in Task #2 (planned for future tasks):
- GET by ID: `/api/entities/{entityName}/{id}`
- PUT/PATCH for updates
- DELETE endpoint
- Filtering, pagination, sorting

### 3. Validation
- No property-level validation based on app.yaml constraints
- Relies on EF Core and database constraints
- **Future Enhancement:** Add validation from `Property.IsRequired`, `MaxLength`, etc.

---

## Security Considerations

**✅ SQL Injection:** Protected by Entity Framework parameterized queries
**✅ Entity Validation:** Only entities in app.yaml are accessible via `IEntityMetadataService`
**✅ Tenant Isolation:** Schema separation maintained via `ITenantSchemaAccessor`
**⚠️ No Authorization:** Currently no role/permission checks (add in future)
**⚠️ No Rate Limiting:** Consider adding for production use

---

## Compatibility

### Breaking Changes
**None.** Existing API routes continue to work:
- `/api/product` → `ProductController`
- `/api/category` → `CategoryController`

### New Routes
- `/api/entities/product` (new, coexists with `/api/product`)
- `/api/entities/category` (new, coexists with `/api/category`)

---

## Build Status

```bash
make build
# Build succeeded. 0 Warning(s), 0 Error(s)

make test
# Passed! Failed: 0, Passed: 11, Skipped: 0
```

---

## Next Steps

### Immediate (Task #3)
- Create `IEntityApiService` interface for Blazor UI
- Implement client-side API calls to new `/api/entities/{entityName}` routes

### Future Enhancements
1. Add GET by ID endpoint
2. Add PUT/PATCH/DELETE endpoints
3. Add filtering and pagination query parameters
4. Add authorization/permissions checking
5. Add camelCase JSON support via serializer options
6. Add OpenAPI/Swagger documentation for dynamic routes
7. Add request/response caching
8. Add validation based on app.yaml property constraints

---

## References

### Documentation Sources
- [EF Core DbContext.Set Method](https://learn.microsoft.com/en-us/dotnet/api/microsoft.entityframeworkcore.dbcontext.set?view=efcore-8.0)
- [EntityFrameworkQueryableExtensions.ToListAsync](https://learn.microsoft.com/en-us/dotnet/api/microsoft.entityframeworkcore.entityframeworkqueryableextensions.tolistasync?view=efcore-8.0)
- [GitHub Issue: Expose method DbContext.Set(Type)](https://github.com/aspnet/EntityFramework/issues/2586)
- [EF Core DbContext Source Code](https://github.com/dotnet/efcore/blob/main/src/EFCore/DbContext.cs)

### Implementation Plan
- See: `/home/jrade/.claude/plans/sprightly-herding-wand.md`

---

## Recommendation

✅ **Ready to commit.** All tests pass, manual testing successful, no breaking changes, comprehensive test coverage.

**Suggested commit message:**
```
Add dynamic API endpoints for YAML-driven entities

Implements Task #2: Dynamic API endpoints (non-breaking)
- Add EntitiesController with GET/POST endpoints at api/entities/{entityName}
- Use reflection for runtime type resolution (EF Core 8 lacks non-generic Set(Type))
- Keep existing ProductController/CategoryController for backward compatibility
- Add 9 comprehensive unit tests (all passing)
- No breaking changes to existing API routes

Endpoints:
- GET /api/entities/{entityName} - returns entity list
- GET /api/entities/{entityName}/count - returns count
- POST /api/entities/{entityName} - creates entity

Co-Authored-By: Claude Sonnet 4.5 (1M context) <noreply@anthropic.com>
```
