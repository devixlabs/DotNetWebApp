# Multi-Schema Support Guide

## Overview

**This project is DDL-driven.** Everything flows from `sql/schema.sql` → `app.yaml` → generated C# models.

## Critical: Schema Derivation from SQL

**Schemas are derived from `USE [database]` statements in `sql/schema.sql`**, NOT from the `[schema].[table]` syntax in CREATE TABLE statements.

### Example

```sql
USE [acme]                          -- Sets schema to "acme" for following tables
CREATE TABLE [dbo].[Product](...)   -- Table name: Product, Schema: acme (not dbo!)

USE [initech]                       -- Sets schema to "initech" for following tables
CREATE TABLE [dbo].[Company](...)   -- Table name: Company, Schema: initech
```

### Schema Mapping Table

| SQL Statement | EF Core Schema | Result |
|---------------|----------------|--------|
| `USE [acme]` | `acme` | Tables become `acme:TableName` |
| `USE [initech]` | `initech` | Tables become `initech:TableName` |

## Critical: appsettings.json MUST Match Schemas

**Applications in `appsettings.json` MUST reference entities that exist in `app.yaml`!**

When schema.sql changes (new `USE [database]` statements), you MUST update:
1. `appsettings.json` → Applications → Schema field
2. `appsettings.json` → Applications → Entities list
3. `verify.sh` → Test URLs to match new schema/entity names

### Example Application Configuration

```json
{
  "Name": "admin",
  "Schema": "acme",
  "Entities": ["acme:Product", "acme:Category", "acme:Company", ...]
},
{
  "Name": "metrics",
  "Schema": "initech",
  "Entities": ["initech:Company", "initech:User", ...]
}
```

## Schema-Qualified Name Formats

Different parts of the system use different formats for schema-qualified names:

- **Browser URLs:** `schema/TableName` (e.g., `/entity/acme/Product`) - uses slash, URL-safe
- **API endpoints:** `schema:TableName` (e.g., `/api/admin/entities/acme/Product`)
- **C# Namespaces:** `DotNetWebApp.Models.Generated.{Schema}.{TableName}` (e.g., `...Generated.Acme.Product`)
- **YAML (app.yaml):** `schema:` field matches database name (e.g., `schema: acme`)

**Important:** Colons in URLs are interpreted by browsers as protocol schemes (like `mailto:`), causing `xdg-open` popups. Always use slashes for browser-facing URLs and convert to colons for API calls.

## Critical Patterns by File

| File | What to use | NOT this |
|------|-------------|----------|
| `EntityMetadataService.cs` | Pascal-cased schema in namespace: `Generated.Acme.Product` | `Generated.acme.Product` |
| `DashboardService.cs` | `$"{schema}:{name}"` in both try AND catch blocks | `entity.Definition.Name` |
| `EntitySection.razor` | `EntityName` parameter (colon format for API) | `metadata.Definition.Name` |
| `GenericEntityPage.razor` | Convert URL `Schema/EntityName` to API `schema:name` | Using URL format for API |
| `NavMenu.razor` | Build path as `entity/{schema}/{name}` (slash for URLs) | Colons in browser URLs |
| `SpaSectionService.cs` | RouteSegment=`schema/name`, EntityName=`schema:name` | Same format for both |
| `SpaApp.razor` | Convert URL slash format to API colon format | Using slash format for API |

## Code Examples

### URL Routing (Use Slashes)

```csharp
// ✅ CORRECT - slash-separated for browser URLs
var path = $"entity/{entity.Schema}/{entity.Name}";  // "/entity/acme/Product"

// ❌ WRONG - colon triggers browser protocol handler popup
var path = $"{entity.Schema}:{entity.Name}";  // "acme:Product" causes xdg-open!
```

### API Calls (Use Colons)

```csharp
// ✅ CORRECT - colon-separated for API calls
var qualifiedName = $"{schema}:{entityName}";  // "acme:Product"
var result = await EntityApiService.GetEntitiesAsync(qualifiedName);

// ❌ WRONG - strips schema, returns wrong data when duplicate table names exist
var result = await EntityApiService.GetEntitiesAsync(metadata.Definition.Name);
```

## Multi-Tenancy Implementation

### HTTP Header

Schema switching via `X-Customer-Schema` HTTP header (defaults to `dbo`)

### Finbuckle.MultiTenant

- Automatic schema inheritance for Dapper queries
- Schema isolation at database level
- See `HYBRID_ARCHITECTURE.md` for full details

## Regression Testing

`verify.sh` Test 12 validates multi-schema isolation by checking that:
- `acme:Company` returns `name` field
- `initech:Company` returns `companyName` field

These entities have different schemas with different properties, ensuring schema isolation works correctly.

## Common Pitfalls

### 1. Using Colons in Browser URLs

**Problem:** Colons trigger browser protocol handlers (like `mailto:`)

**Solution:** Use slashes in all browser-facing URLs, convert to colons for API calls

### 2. Not Updating verify.sh After Schema Changes

**Problem:** Tests reference old entity names that no longer exist

**Solution:** Always update verify.sh test URLs when modifying schema.sql

### 3. Missing Schema Prefix in API Calls

**Problem:** API calls use bare entity name instead of schema-qualified name

**Solution:** Always use `schema:EntityName` format for API calls

### 4. Wrong Schema in appsettings.json Applications

**Problem:** Application references entity that doesn't exist in app.yaml

**Solution:** Ensure Applications.Schema and Applications.Entities match generated app.yaml

## Verification Checklist

When adding or modifying schemas:

- [ ] Update `sql/schema.sql` with `USE [schema]` statements
- [ ] Run `make run-ddl-pipeline` to regenerate models
- [ ] Update `appsettings.json` Applications to reference correct schemas
- [ ] Update `verify.sh` test URLs to match new entity names
- [ ] Run `./verify.sh` to verify end-to-end
- [ ] Commit schema.sql, appsettings.json, and verify.sh together

## Proprietary Data Warning

- **`sql/schema.sql` and `sql/seed.sql` may contain proprietary client database schemas**
- **DO NOT commit real client data to git**
- **Documentation uses example schemas** (`acme`, `initech`)
- **Actual runtime schemas** are derived from whatever `USE [database]` statements exist in schema.sql
