# Testing Guide

## Overview

**Unit tests are VERY IMPORTANT for this project.** All new code must include comprehensive unit tests.

## Testing Principles

1. **Test-First Mindset:** Write tests alongside or before implementation code
2. **No Untested Code:** Every new service, generator, or significant change requires tests
3. **Run Tests Before Commit:** Always run `make test` before considering work complete
4. **Test Coverage Target:** 80%+ code coverage on service layer and generators

## Test Projects

| Project | Purpose | Run Command |
|---------|---------|-------------|
| `tests/DotNetWebApp.Tests/` | Services, Controllers, Integration | `make test` |
| `tests/ModelGenerator.Tests/` | Path resolution, template validation | `make test` |
| `tests/DdlParser.Tests/` | SQL parsing, type mapping, YAML generation | `make test` |

## What MUST Be Tested

- **All new services** (IEntityOperationService, IViewService, IViewRegistry, etc.)
- **Type mapping changes** (TypeMapper.cs has 125+ tests)
- **Code generators** (ViewModelGenerator, EntityGenerator)
- **YAML deserialization** (ViewDefinition, AppDefinition classes)
- **Controller endpoints** (CRUD operations, validation)
- **Multi-tenant scenarios** (schema isolation)

## Testing Commands

```bash
make test                    # Run all tests (builds test projects first)
make build-all               # Build including test projects
./dotnet-build.sh test tests/DdlParser.Tests/DdlParser.Tests.csproj --no-restore  # Run specific project
```

## Example Test Pattern

```csharp
[Fact]
public async Task ServiceMethod_ValidInput_ReturnsExpectedResult()
{
    // Arrange
    var service = new MyService(mockDependency);

    // Act
    var result = await service.DoSomethingAsync(input);

    // Assert
    Assert.NotNull(result);
    Assert.Equal(expected, result.Value);
}
```

## Test Status

**Current Status:** 192+ tests passing across all projects
- DotNetWebApp.Tests: Services, Controllers, Integration tests
- ModelGenerator.Tests: Path resolution tests
- DdlParser.Tests: 125+ type mapping tests, SQL parsing tests

## Integration Testing with verify.sh

The `./verify.sh` script runs comprehensive end-to-end integration tests:

### Test Coverage

1. **Tests 1-9:** Basic CRUD operations (GET, POST, PUT, DELETE)
2. **Test 10-11:** Error handling (non-existent entities, invalid names)
3. **Test 12:** Multi-schema isolation (acme vs initech schemas)
4. **Test 13:** Cross-app entity isolation (admin, reporting, metrics apps)
5. **Test 14:** Invalid app error handling

### What verify.sh Tests Validate

- ✅ **Schema generation**: Entities correctly generated from SQL DDL
- ✅ **View generation**: Views correctly generated from ViewDefinitions + SQL
- ✅ **Multi-tenancy**: Schema isolation works (acme vs initech)
- ✅ **Multi-app security**: App visibility rules enforced
- ✅ **CRUD correctness**: Create, Read, Update, Delete all work end-to-end
- ✅ **Error handling**: Proper 404s for missing entities, invalid apps
- ✅ **Data persistence**: Updates persist correctly
- ✅ **Database cleanup**: Automatic cascade deletion works

### When to Run verify.sh

**REQUIRED after:**
- Changes to `sql/schema.sql` (entity definitions)
- Changes to `sql/views/*.sql` (SQL view definitions)
- Changes to `appsettings.json` ViewDefinitions or Applications
- Changes to DDL pipeline, YamlMerger, ModelGenerator, or AppsYamlGenerator
- Changes to migrations or seeding logic
- Before creating a pull request with pipeline changes

### Troubleshooting Test Failures

**Tests 1-11 fail (CRUD tests):**
- Check `/tmp/dotnet-dev.log` for server startup errors
- Verify Docker container is running: `docker ps | grep sqlserver-dev`
- Verify `SA_PASSWORD` is set: `echo $SA_PASSWORD`
- Run `make db-drop && make db-create` to recreate container

**Test 12 fails (multi-schema isolation):**
- Schema names in verify.sh don't match schema.sql
- Update verify.sh to use correct schemas and entity names
- Ensure acme:Company and initech:Company have different properties in schema.sql

**Test 13 fails (cross-app isolation):**
- Application definitions in appsettings.json don't match what verify.sh expects
- Update appsettings.json Applications list or update test URLs in verify.sh

**Dev server never starts:**
- Port 7012 (HTTPS) may be in use: `lsof -i :7012`
- Kill the process: `make stop-dev`
- Rerun: `./verify.sh`

## Keeping Tests Up to Date

When modifying schema.sql or appsettings.json Applications:

1. **Update schema definitions** in schema.sql
2. **Regenerate via DDL pipeline** (`make run-ddl-pipeline`)
3. **Update test URLs in verify.sh** if entity/app names changed
4. **Run full verification** (`./verify.sh`)
5. **Commit both schema changes AND verify.sh updates together**

Never commit schema.sql changes without also updating verify.sh tests to match the new entities/apps.
