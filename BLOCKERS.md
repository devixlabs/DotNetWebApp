# Known Implementation Blockers

## 🔴 BLOCKER: GAISystem Database Schema Not Integrated

**Status:** BLOCKING DMSService forklift operator functionality

**Affected Code:**
- `Services/DMS/DMSService.cs:575-618` - `GetAvailableOperatorsAsync()` method
- `tests/DotNetWebApp.Tests/Services/DMS/DMSServiceTests.cs:378-435` - Two test methods (SKIPPED with `[Fact(Skip = "...")]`)
  - `GetAvailableOperatorsAsync_CallsDapperWithCorrectSQL`
  - `GetAvailableOperatorsAsync_ReturnsAllOperators`

**Root Cause:**
The DMSService implementation requires querying the external GAISystem database (`gaisystem.dbo.dxuser` and `GAI.dbo.dtd2`), which has not yet been added to the DotNetWebApp project's DDL pipeline.

**Spec Reference:**
- Document: `specs/BUSINESS_LOGIC_COMPLETE-DMS.md` (lines 338-346)
- Query requirements: Join `gaisystem.dbo.dxuser` with `GAI.dbo.dtd2` tables
- Key Group IDs:
  - **478** = Forklift operator flag
  - **687** = CPFG user flag (warehouse-specific)

**Current Behavior:**
- `GetAvailableOperatorsAsync()` logs a warning and returns empty list
- Related unit tests are SKIPPED pending schema integration
- Forklift operator dropdowns in DMS UI will be empty
- All forklift operator assignments will fail silently

**Required To Unblock:**
1. ✅ Add GAISystem database schema to `sql/schema.sql` (via external JIRA system)
2. ⬜ Generate `gaisystem.dbo.dxuser` entity via DDL pipeline
3. ⬜ Ensure `GAI.dbo.dtd2` entity exists (may already be present)
4. ⬜ Update `SecondaryDbContext` to register these entities
5. ⬜ Implement correct Dapper query with proper joins and warehouse filtering
6. ⬜ Add integration tests for operator filtering by warehouse

**External Dependency:**
- GAISystem schema stored in external JIRA/ticketing system (not in this repo)
- Team must import/provide GAISystem DDL before this can be unblocked

**Temporary Workaround:**
Currently returning empty list. To proceed with testing, forklift operator assignment can be:
- Hard-coded for testing
- Mocked in integration tests
- Disabled until schema is available

---

**Last Updated:** 2026-02-02
**Documented By:** Claude
