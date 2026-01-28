# Files Affected by Error Handling Audit

## Audit Report Documents (Generated)

These documents provide detailed findings and recommendations:

1. **ERROR_HANDLING_AUDIT_PR7.md**
   - Main audit report
   - All 9 issues with severity levels
   - Summary table
   - Immediate action items
   - ~400 lines

2. **ERROR_HANDLING_AUDIT_DETAILS.md**
   - Detailed code analysis with before/after examples
   - Shows exactly what's wrong and how to fix it
   - Exception nesting flow diagrams
   - ~800 lines

3. **ERROR_HANDLING_TEST_RECOMMENDATIONS.md**
   - Specific test cases to add
   - Test helper classes
   - Coverage gaps analysis
   - ~400 lines

4. **ERROR_HANDLING_AUDIT_SUMMARY.txt**
   - Executive summary
   - Quick reference table
   - Timeline and effort estimates
   - Success metrics

## Source Files Requiring Changes (Priority Order)

### CRITICAL (Fix Before Merge)

#### 1. Data/Dapper/DapperQueryService.cs
**Issues Found:**
- CRITICAL: Overly broad catch (Exception ex) on lines 48-59, 80-91
- MEDIUM: Missing parameter validation
- MEDIUM: Unclear connection resource management
- MEDIUM: Inconsistent error message format

**Recommendation:**
- Replace bare catch blocks with specific catches (SqlException, OperationCanceledException, ArgumentException, OutOfMemoryException)
- Add null/empty validation for sql parameter
- Standardize error messages with error codes

**Effort:** 4-6 hours

---

#### 2. Services/Views/ViewRegistry.cs
**Issues Found:**
- CRITICAL: Silent failure on missing views.yaml (lines 43-46)
- CRITICAL: Overly broad catch (Exception ex) for file I/O (lines 113-125)
- MEDIUM: Missing parameter validation
- MEDIUM: Inconsistent error message format

**Recommendation:**
- Fail fast with FileNotFoundException or log as ERROR on missing views.yaml
- Replace bare catch blocks with specific catches (FileNotFoundException, UnauthorizedAccessException, DirectoryNotFoundException, IOException, OutOfMemoryException)
- Add null/empty validation for viewName parameter
- Standardize error messages with error codes

**Effort:** 4-6 hours for file I/O + 2-3 hours for initialization = 6-9 hours total

---

#### 3. Services/Views/ViewService.cs
**Issues Found:**
- CRITICAL: Overly broad catch (Exception ex) that double-wraps errors (lines 38-59, 66-87)
- MEDIUM: Missing parameter validation
- MEDIUM: Inconsistent error message format

**Recommendation:**
- Let registry exceptions propagate directly (don't catch them)
- Only catch InvalidOperationException from Dapper
- Add null/empty validation for viewName parameter
- Standardize error messages

**Effort:** 2-3 hours

---

### HIGH PRIORITY (Fix Before Release)

#### 4. Components/Pages/ProductDashboard.razor
**Issues Found:**
- HIGH: Poor error messages to user (lines 233-240, 276-280)
- Missing user-friendly error message differentiation
- No retry guidance

**Recommendation:**
- Replace raw exception message with user-friendly messages
- Differentiate between permanent errors (config issues) and transient errors (network/timeout)
- Add retry guidance for timeouts
- Log with correlation ID for debugging

**Effort:** 3-4 hours

---

#### 5. tests/DotNetWebApp.Tests/ViewPipelineTests.cs
**Issues Found:**
- HIGH: Missing error scenario test coverage
- No tests for connection failures, SQL errors, type mapping failures
- No tests for parameter validation
- ~18 existing tests, need 20+ additional tests

**Recommendation:**
- Add test suite for DapperQueryService exception handling
- Add test suite for ViewRegistry error scenarios
- Add test suite for ViewService exception propagation
- Add component-level error handling tests
- Add test helpers for mocking and verification

**Effort:** 8-12 hours

---

### MEDIUM PRIORITY (Should Fix Before Release)

#### 6. All Services - Add Error ID Constants
**New File:** Constants/ErrorIds.cs or similar

**Recommendation:**
- Create constants for standard error IDs:
  - VIEW_NOT_FOUND
  - SQL_FILE_NOT_FOUND
  - QUERY_EXECUTION_FAILED
  - SQL_ERROR
  - PERMISSION_DENIED
  - DISK_ERROR
  - TYPE_MAPPING_FAILED

**Effort:** 1-2 hours

---

## Review Checklist

When reviewing the audit findings, verify:

### For Each Critical Issue:
- [ ] Original error types are not lost in wrapping
- [ ] Error messages are specific (not generic)
- [ ] Users receive actionable feedback
- [ ] Operators can debug from logs
- [ ] No silent failures occur

### For Exception Handling:
- [ ] Catch blocks are specific (not bare `catch (Exception)`)
- [ ] Each catch block has explicit error logging
- [ ] Error messages include context (schema, entity type, operation)
- [ ] Original exceptions are preserved in InnerException
- [ ] No double-wrapping of exceptions

### For File I/O:
- [ ] FileNotFoundException is handled specially
- [ ] UnauthorizedAccessException is logged
- [ ] OutOfMemoryException is not wrapped
- [ ] User gets actionable error message
- [ ] Permissions issues are distinguished from missing files

### For Database Operations:
- [ ] SqlException errors include error codes
- [ ] Timeouts are distinguished from other errors
- [ ] Connection failures are explicit
- [ ] Parameter errors are caught separately
- [ ] Memory exhaustion is not wrapped

### For Tests:
- [ ] Happy path tests exist
- [ ] Error scenario tests exist
- [ ] Parameter validation tests exist
- [ ] Connection failure tests exist
- [ ] SQL syntax error tests exist
- [ ] Type mapping failure tests exist

---

## Files to Review in Detail

1. **Priority 1 (Review First):**
   - ERROR_HANDLING_AUDIT_PR7.md (main findings)
   - Data/Dapper/DapperQueryService.cs (lines 33-106)

2. **Priority 2 (Review Second):**
   - ERROR_HANDLING_AUDIT_DETAILS.md (code examples)
   - Services/Views/ViewRegistry.cs (lines 14-150)
   - Services/Views/ViewService.cs (lines 1-89)

3. **Priority 3 (Review Third):**
   - ERROR_HANDLING_TEST_RECOMMENDATIONS.md (tests)
   - Components/Pages/ProductDashboard.razor (lines 171-287)
   - tests/DotNetWebApp.Tests/ViewPipelineTests.cs (lines 1-371)

---

## Rollback Plan

If critical issues are discovered during implementation:

1. Revert changes to affected services
2. Keep error handling audit documents for future reference
3. Schedule fixes in next sprint
4. Block PR merge until all CRITICAL issues are fixed

---

## Verification Steps After Fixes

1. Run `make test` to verify all tests pass
2. Run ProductDashboard locally and trigger error scenarios:
   - Delete views.yaml and reload app
   - Remove read permissions from a SQL file and trigger view
   - Simulate database timeout
3. Check application logs for:
   - Specific error codes
   - No hidden exceptions
   - User-friendly messages in application output
4. Verify exception nesting depth (should be max 1 level)

---

## Success Criteria

- [ ] All CRITICAL issues identified in audit have been fixed
- [ ] All exception catch blocks are specific (no bare `catch (Exception)`)
- [ ] All error messages include context and are actionable
- [ ] Exception nesting is minimal (max 1 level)
- [ ] Test coverage increased to 95%
- [ ] All tests pass
- [ ] PR review checklist completed
- [ ] Documentation updated with error handling patterns

---

**Generated:** 2026-01-27
**Audit Status:** Ready for Implementation
