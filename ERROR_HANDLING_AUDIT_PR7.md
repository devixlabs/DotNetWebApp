# Error Handling Audit: Dapper Services & View Pipeline (PR #7)

**Audit Date:** 2026-01-27
**Branch:** refactor_phase_2
**Auditor:** Error Handling Auditor
**Overall Status:** ⚠️ CRITICAL ISSUES FOUND

---

## Executive Summary

The Dapper services and view pipeline implementation demonstrates **adequate logging and error propagation** but contains several **critical error handling gaps** that could result in **silent failures**, **masked exceptions**, and **poor user feedback**. The most serious issues involve:

1. **Connection/Resource Management** - Dapper queries may orphan database connections without proper cleanup
2. **Overly Broad Exception Catching** - Generic `catch (Exception ex)` blocks hide unrelated errors
3. **Exception Re-wrapping Loses Context** - Original exception types are obscured by re-wrapping in `InvalidOperationException`
4. **Inadequate Error Logging in Components** - ProductDashboard catches exceptions but doesn't log with sufficient context
5. **Missing Error Scenarios in Tests** - Test coverage doesn't include database connection failures, SQL syntax errors, or type mapping failures

---

## CRITICAL ISSUES

### ISSUE 1: CRITICAL - Overly Broad Exception Catching in DapperQueryService

**Location:** `/home/jrade/code/devixlabs/DotNetWebApp/Data/Dapper/DapperQueryService.cs` (lines 48-59, 80-91)

**Severity:** CRITICAL

**Problem:**

The `QueryAsync` and `QuerySingleAsync` methods use bare `catch (Exception ex)` blocks that catch ALL exceptions, including programming errors and system failures unrelated to query execution:

```csharp
try
{
    return await connection.QueryAsync<T>(sql, param);
}
catch (Exception ex)  // ❌ CATCHES EVERYTHING
{
    _logger.LogError(ex, "Dapper query failed...");
    throw new InvalidOperationException(..., ex);
}
```

**Hidden Errors That Get Caught and Re-wrapped:**

This catch block could hide:
- `OutOfMemoryException` - Large result sets exhausting heap memory
- `InvalidOperationException` - Connection not opened (infrastructure issue)
- `SqlException` - Specific SQL Server errors (T-SQL syntax, permissions, timeouts) - gets wrapped and loses SQL error details
- `NullReferenceException` - Bug in parameter mapping or Dapper internals
- `TypeLoadException` - Missing type definition for generic parameter T
- `ArgumentException` - Invalid SQL query text or parameter names
- `AggregateException` - Multiple failures in async operation
- `OperationCanceledException` - Query timeout or cancellation

**User Impact:**

1. Users see generic `"Query execution failed"` instead of root cause (e.g., "SQL Server connection timeout", "Insufficient memory", "Invalid SQL syntax")
2. Debugging becomes harder - original exception type is lost
3. Production logs show re-wrapped `InvalidOperationException` instead of actual failure reason

**Recommendation:**

Catch only the **expected exception types** that Dapper/SqlClient throw for query execution. Create multiple catch blocks for different scenarios:

```csharp
public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
{
    var connection = _dbContext.Database.GetDbConnection();

    try
    {
        _logger.LogDebug(
            "Executing Dapper query (Schema: {Schema}, Type: {ResultType}): {Sql}",
            _dbContext.Schema ?? "default",
            typeof(T).Name,
            TruncateSql(sql));

        return await connection.QueryAsync<T>(sql, param);
    }
    catch (Microsoft.Data.SqlClient.SqlException ex)
    {
        _logger.LogError(
            ex,
            "SQL Server error executing query (Schema: {Schema}, Type: {ResultType}, ErrorCode: {ErrorCode}): {Sql}",
            _dbContext.Schema ?? "default",
            typeof(T).Name,
            ex.Number,
            TruncateSql(sql));

        throw new InvalidOperationException(
            $"SQL Server error: {GetFriendlyErrorMessage(ex.Number)} (Code: {ex.Number})", ex);
    }
    catch (OperationCanceledException ex)
    {
        _logger.LogError(
            ex,
            "Query timeout for type {ResultType}",
            typeof(T).Name);

        throw new InvalidOperationException(
            "Query execution timed out. The database is responding slowly.", ex);
    }
    catch (ArgumentException ex)
    {
        // This indicates a bug in SQL or parameter mapping
        _logger.LogError(
            ex,
            "Invalid query or parameters for type {ResultType}: {Sql}",
            typeof(T).Name,
            TruncateSql(sql));

        throw;  // Re-throw original ArgumentException, don't wrap
    }
    catch (OutOfMemoryException ex)
    {
        // Application is in critical state
        _logger.LogCritical(ex, "Out of memory executing query");
        throw;  // Re-throw, don't wrap - caller needs to know memory is exhausted
    }
}

private static string GetFriendlyErrorMessage(int sqlErrorCode)
{
    return sqlErrorCode switch
    {
        -2 => "Connection timeout - database is not responding",
        15007 => "User does not have permission to execute this query",
        207 => "Invalid column name in query",
        208 => "Invalid table name in query",
        _ => "Database error"
    };
}
```

---

### ISSUE 2: CRITICAL - Silent Failure in ViewRegistry.LoadViews() Initialization

**Location:** `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewRegistry.cs` (lines 41-79)

**Severity:** CRITICAL

**Problem:**

The `LoadViews()` method has incomplete error handling. While it logs errors (line 76), **it continues execution and throws from constructor**, but the more serious issue is line 77: after logging the error, **it throws**, which means ViewRegistry initialization fails. However, the **graceful handling** on line 43-46 means if `views.yaml` is missing, the service silently initializes with zero views without warning the application that a critical configuration file is missing:

```csharp
private void LoadViews(string yamlPath)
{
    if (!File.Exists(yamlPath))
    {
        _logger.LogWarning("views.yaml not found at {Path}. No views registered.", yamlPath);
        return;  // ⚠️ SILENTLY CONTINUES - service initialized but empty
    }

    // ... later ...
    catch (Exception ex)
    {
        _logger.LogError(ex, "Failed to load views from {Path}", yamlPath);
        throw;  // ✅ This part is OK - throws on YAML parsing error
    }
}
```

**User Impact:**

1. **Configuration Error Goes Unnoticed:** If `views.yaml` is missing (wrong deployment, file not copied), the application boots successfully but all view operations fail with cryptic "View not found" errors
2. **No Startup Warning:** In production, operators won't know that views are disabled until users try to access them
3. **Inconsistent Error Handling:** Missing file gets logged as WARNING and silently ignored; parsing error throws and crashes startup (inconsistent patterns)

**Recommendation:**

Either require views.yaml (fail fast on missing file) or at minimum, log this as an ERROR with context about impact:

```csharp
private void LoadViews(string yamlPath)
{
    if (!File.Exists(yamlPath))
    {
        // Option 1: Fail fast (RECOMMENDED)
        throw new FileNotFoundException(
            $"views.yaml not found at {yamlPath}. The view registry requires views.yaml to be present at application startup.");

        // Option 2: Log as ERROR (not WARNING) if graceful degradation is acceptable
        _logger.LogError(
            "CRITICAL: views.yaml not found at {Path}. No views registered. " +
            "All view execution will fail. Check deployment and ensure views.yaml is copied to the application root.",
            yamlPath);
        return;
    }

    // ... rest of method ...
}
```

---

### ISSUE 3: CRITICAL - Overly Broad Exception Catching in ViewRegistry.GetViewSqlAsync()

**Location:** `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewRegistry.cs` (lines 113-125)

**Severity:** CRITICAL

**Problem:**

The file I/O operation catches all exceptions without distinguishing different failure modes:

```csharp
try
{
    var sql = await File.ReadAllTextAsync(sqlPath);
    _sqlCache.TryAdd(viewName, sql);
    _logger.LogDebug("Loaded SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
    return sql;
}
catch (Exception ex)  // ❌ TOO BROAD
{
    _logger.LogError(ex, "Failed to load SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
    throw new InvalidOperationException(
        $"Failed to load SQL for view '{viewName}': {ex.Message}", ex);
}
```

**Hidden Errors:**

- `FileNotFoundException` (file deleted between registration and load) - handled but loses specific error
- `UnauthorizedAccessException` (permission denied on file) - loses specific error
- `DirectoryNotFoundException` (path is invalid) - loses specific error
- `IOException` (file in use, disk full) - loses specific error
- `OutOfMemoryException` (SQL file too large) - wrapped in generic error, loses critical severity

**User Impact:**

1. Users can't distinguish between "file missing" vs "permission denied" vs "disk full" - all show generic message
2. Permission issues silently fail (authorization error gets re-wrapped as generic operation failure)
3. Out-of-memory conditions lose their critical severity

**Recommendation:**

Catch specific exception types and provide differentiated error messages:

```csharp
try
{
    var sql = await File.ReadAllTextAsync(sqlPath);
    _sqlCache.TryAdd(viewName, sql);
    _logger.LogDebug("Loaded SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
    return sql;
}
catch (FileNotFoundException ex)
{
    _logger.LogError(ex, "SQL file not found for view {ViewName}: {SqlPath}", viewName, sqlPath);
    throw new FileNotFoundException(
        $"SQL file for view '{viewName}' not found at {sqlPath}. " +
        "Check that all SQL files referenced in views.yaml exist in the sql/views/ directory.", ex);
}
catch (UnauthorizedAccessException ex)
{
    _logger.LogError(ex, "Permission denied reading SQL file for view {ViewName}: {SqlPath}", viewName, sqlPath);
    throw new UnauthorizedAccessException(
        $"Access denied reading SQL file for view '{viewName}' at {sqlPath}. " +
        "Check file permissions.", ex);
}
catch (DirectoryNotFoundException ex)
{
    _logger.LogError(ex, "SQL file path is invalid for view {ViewName}: {SqlPath}", viewName, sqlPath);
    throw new InvalidOperationException(
        $"Invalid path for SQL file of view '{viewName}': {sqlPath}. Directory does not exist.", ex);
}
catch (IOException ex) when (ex.Message.Contains("disk", StringComparison.OrdinalIgnoreCase))
{
    _logger.LogError(ex, "Disk error reading SQL file for view {ViewName}", viewName);
    throw;  // Re-throw unchanged - disk full is critical and caller needs to know
}
catch (OutOfMemoryException ex)
{
    _logger.LogCritical(ex, "Out of memory loading SQL file for view {ViewName}: {SqlPath} may be too large", viewName, sqlPath);
    throw;  // Re-throw unchanged - this is critical
}
catch (IOException ex)
{
    _logger.LogError(ex, "I/O error reading SQL file for view {ViewName}: {SqlPath}", viewName, sqlPath);
    throw new InvalidOperationException(
        $"Failed to read SQL file for view '{viewName}'. The file may be locked by another process.", ex);
}
```

---

### ISSUE 4: CRITICAL - Overly Broad Exception Catching in ViewService

**Location:** `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewService.cs` (lines 38-59, 66-87)

**Severity:** CRITICAL

**Problem:**

Both `ExecuteViewAsync` and `ExecuteViewSingleAsync` catch all exceptions without distinguishing between:
- Registry errors (view not found, SQL file missing) - should propagate immediately
- Dapper execution errors (SQL syntax, connection failure) - different handling
- Type mapping errors - indicates code generation problem

```csharp
public async Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null)
{
    try
    {
        var sql = await _registry.GetViewSqlAsync(viewName);  // Can throw
        _logger.LogInformation("Executing view: {ViewName} (Type: {ResultType})", viewName, typeof(T).Name);
        return await _dapper.QueryAsync<T>(sql, parameters);  // Can throw different error
    }
    catch (Exception ex)  // ❌ CATCHES BOTH registry AND dapper errors
    {
        _logger.LogError(ex, "Failed to execute view: {ViewName} (Type: {ResultType})", viewName, typeof(T).Name);
        throw new InvalidOperationException(
            $"Failed to execute view '{viewName}': {ex.Message}", ex);
    }
}
```

**Hidden Errors:**

- `InvalidOperationException` (view not found) - wrapped in another `InvalidOperationException`, doubling the nesting
- `FileNotFoundException` (SQL file missing) - wrapped, loses file path info
- `ArgumentNullException` (null parameters) - wrapped, indicates bug in caller
- Type mapping errors from Dapper (T doesn't match SQL columns) - wrapped, loses Dapper's specific error
- Connection failures - wrapped, loses SQL-specific error details

**User Impact:**

1. Doubled exception nesting makes debugging harder (ViewService wraps Dapper's wrap of DapperQueryService's wrap of SqlException)
2. Original error context is buried in InnerException chain
3. Can't distinguish between "view not found" vs "query syntax error" vs "no database connection"

**Recommendation:**

Let specific exceptions propagate; only catch and wrap Dapper execution errors:

```csharp
public async Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null)
{
    // Let registry errors propagate directly - they have good error messages
    var sql = await _registry.GetViewSqlAsync(viewName);

    try
    {
        _logger.LogInformation(
            "Executing view: {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        return await _dapper.QueryAsync<T>(sql, parameters);
    }
    catch (InvalidOperationException ex)
    {
        // Dapper query service wraps SQL execution errors - log and re-throw
        _logger.LogError(
            ex,
            "View execution failed: {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        throw;  // Don't wrap, let caller see DapperQueryService's InvalidOperationException
    }
    catch (Exception ex)
    {
        // Unexpected errors (OutOfMemory, StackOverflow, etc.)
        _logger.LogCritical(
            ex,
            "Unexpected error executing view {ViewName}",
            viewName);
        throw;
    }
}
```

---

## HIGH-SEVERITY ISSUES

### ISSUE 5: HIGH - Inadequate Error Logging in ProductDashboard Component

**Location:** `/home/jrade/code/devixlabs/DotNetWebApp/Components/Pages/ProductDashboard.razor` (lines 233-240, 276-280)

**Severity:** HIGH

**Problem:**

The component catches exceptions but logs minimal context and doesn't include request-specific information:

```csharp
try
{
    products = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = 50 });

    Logger.LogInformation("Loaded {Count} products for dashboard", products?.Count() ?? 0);
}
catch (Exception ex)
{
    // Log the full exception for debugging
    Logger.LogError(ex, "Failed to load product dashboard");

    // Show user-friendly error message
    errorMessage = $"Failed to load dashboard: {ex.Message}";  // ❌ Shows raw ex.Message to user
}
```

**Missing Context:**

1. No trace ID or correlation ID - can't find this request in logs
2. Error message shown to user is raw exception message (e.g., "Query execution failed for type ProductSalesView") - not user-friendly
3. No indication whether error is permanent (bad configuration) or transient (network blip)
4. No retry guidance for users

**User Impact:**

1. User sees confusing technical message like `"Failed to load dashboard: Query execution failed for type ProductSalesView"`
2. Operator can't correlate error in component with error in backend logs (no correlation ID)
3. User doesn't know if they should retry or contact support

**Recommendation:**

Add user-friendly error messages and correlation IDs:

```csharp
private async Task LoadDashboardDataAsync()
{
    isLoading = true;
    errorMessage = null;
    products = null;

    try
    {
        products = await ViewService.ExecuteViewAsync<ProductSalesView>(
            "ProductSalesView",
            new { TopN = 50 });

        Logger.LogInformation(
            "Dashboard loaded successfully: {Count} products",
            products?.Count() ?? 0);
    }
    catch (FileNotFoundException ex)
    {
        Logger.LogError(
            ex,
            "Dashboard view SQL file missing");

        errorMessage = "Dashboard is not configured. Please contact your administrator.";
    }
    catch (InvalidOperationException ex) when (ex.Message.Contains("not found in registry"))
    {
        Logger.LogError(
            ex,
            "Dashboard view not registered in views.yaml");

        errorMessage = "Dashboard view is not available. Please contact your administrator.";
    }
    catch (InvalidOperationException ex) when (ex.Message.Contains("timeout"))
    {
        Logger.LogWarning(
            ex,
            "Dashboard query timeout - database is slow");

        errorMessage = "Dashboard is loading slowly. Please try again in a moment.";
    }
    catch (Exception ex)
    {
        Logger.LogError(
            ex,
            "Unexpected error loading dashboard");

        errorMessage = "Unable to load dashboard. Please refresh the page or contact support if the problem persists.";
    }
    finally
    {
        isLoading = false;
    }
}
```

---

### ISSUE 6: HIGH - Missing Error Scenario Test Coverage

**Location:** `/home/jrade/code/devixlabs/DotNetWebApp/tests/DotNetWebApp.Tests/ViewPipelineTests.cs`

**Severity:** HIGH

**Problem:**

The test suite covers happy path and basic error cases but **misses critical failure scenarios**:

**Missing Test Cases:**

1. **Database Connection Failures** - What happens if database is unavailable?
   - Dapper connection timeout
   - Connection pooling exhaustion
   - Network disconnection

2. **SQL Syntax Errors** - What if SQL view has invalid syntax?
   - Missing `SELECT` keyword
   - Invalid column names
   - Unclosed string literals

3. **Type Mapping Failures** - What if SQL result columns don't match DTO properties?
   - Missing column (Dapper can't map)
   - Type mismatch (e.g., SQL returns `nvarchar`, DTO expects `int`)
   - Case sensitivity issues

4. **Concurrency Issues** - What if multiple threads access the same view?
   - Race condition in SQL cache
   - Connection pool contention

5. **Parameter Injection** - Are parameters properly escaped?
   - SQL injection attempts
   - NULL parameter handling

6. **Resource Exhaustion**
   - Very large result sets
   - Memory leaks in cache
   - Connection not disposed

**Recommendation:**

Add integration tests with real database:

```csharp
[Fact]
public async Task DapperQueryService_Handles_ConnectionTimeout()
{
    // Arrange: Mock a timeout scenario
    var mockConnection = new Mock<DbConnection>();
    mockConnection
        .Setup(c => c.QueryAsync<TestDataDto>(It.IsAny<string>(), It.IsAny<object>()))
        .ThrowsAsync(new SqlException("Timeout expired", new SqlError[0], "Connection timeout", 1205, null));

    // Act & Assert
    await Assert.ThrowsAsync<InvalidOperationException>(
        () => service.QueryAsync<TestDataDto>("SELECT * FROM Tests", null));
}

[Fact]
public async Task ViewService_Handles_InvalidSqlSyntax()
{
    // Arrange: Create a view with invalid SQL
    var invalidSql = "SLECT * FROM NonExistent";  // Typo in SELECT

    // Act & Assert
    await Assert.ThrowsAsync<InvalidOperationException>(
        () => dapperService.QueryAsync<TestDataDto>(invalidSql, null));
}

[Fact]
public async Task ViewService_Handles_TypeMappingFailure()
{
    // Arrange: SQL returns columns that don't match DTO
    var sql = "SELECT 1 AS UnmatchedColumn";
    var mockDapper = new Mock<IDapperQueryService>();
    mockDapper
        .Setup(d => d.QueryAsync<TestDataDto>(sql, It.IsAny<object>()))
        .ThrowsAsync(new DataException(
            "Error parsing column 0 (UnmatchedColumn=Object) to testDataDto.Name"));

    // Act & Assert
    await Assert.ThrowsAsync<InvalidOperationException>(
        () => service.ExecuteViewAsync<TestDataDto>("BrokenView"));
}
```

---

## MEDIUM-SEVERITY ISSUES

### ISSUE 7: MEDIUM - Missing Connection Resource Management

**Location:** `/home/jrade/code/devixlabs/DotNetWebApp/Data/Dapper/DapperQueryService.cs` (lines 35-46, 68-78)

**Severity:** MEDIUM

**Problem:**

The Dapper methods obtain a connection but don't explicitly manage its lifecycle:

```csharp
public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
{
    var connection = _dbContext.Database.GetDbConnection();

    try
    {
        return await connection.QueryAsync<T>(sql, param);
        // Connection is not explicitly closed or disposed
    }
    catch (Exception ex)
    {
        // No cleanup in catch block either
    }
}
```

**Assumptions:**

- Assumes `connection.QueryAsync()` will close the connection after use ✓ (Dapper does this)
- Assumes EF Core will dispose the connection ✓ (happens via DbContext)
- **BUT:** If exception occurs DURING QueryAsync, connection state is unclear

**User Impact:**

1. If `QueryAsync` throws while reading results (large result set), connection may be left open
2. Connection pooling behavior depends on internal Dapper/SqlClient implementation
3. In high-load scenarios, connection pool exhaustion could occur if connections aren't properly closed

**Recommendation:**

Explicitly manage connection with `using` if there's any risk of orphaned connections:

```csharp
public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
{
    var connection = _dbContext.Database.GetDbConnection();

    try
    {
        _logger.LogDebug(
            "Executing Dapper query (Schema: {Schema}, Type: {ResultType}): {Sql}",
            _dbContext.Schema ?? "default",
            typeof(T).Name,
            TruncateSql(sql));

        var results = await connection.QueryAsync<T>(sql, param);
        return results;
    }
    catch (Microsoft.Data.SqlClient.SqlException ex)
    {
        _logger.LogError(
            ex,
            "SQL error executing query (Schema: {Schema}, ErrorCode: {ErrorCode})",
            _dbContext.Schema ?? "default",
            ex.Number);

        throw new InvalidOperationException(
            $"SQL Server error executing query: {ex.Message}", ex);
    }
    finally
    {
        // EF Core manages connection, but explicitly close if opened here
        if (connection.State == ConnectionState.Open)
        {
            connection.Close();
        }
    }
}
```

**Note:** If EF Core guarantees connection pooling, this may be unnecessary. **Verify with EF Core documentation** before adding finally block.

---

### ISSUE 8: MEDIUM - Insufficient Parameter Validation

**Location:** All three services - `DapperQueryService`, `ViewRegistry`, `ViewService`

**Severity:** MEDIUM

**Problem:**

Methods accept parameters but don't validate them before use:

**DapperQueryService.QueryAsync:**
```csharp
public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
{
    // No validation that sql is not empty
    // No validation that sql doesn't contain dangerous commands
    var connection = _dbContext.Database.GetDbConnection();
    return await connection.QueryAsync<T>(sql, param);
}
```

**ViewRegistry.GetViewSqlAsync:**
```csharp
public async Task<string> GetViewSqlAsync(string viewName)
{
    // No validation that viewName is not null/empty
    // Could cause confusing "not found" error instead of validation error
    if (!_views.TryGetValue(viewName, out var view))
    {
        throw new InvalidOperationException(...);
    }
}
```

**User Impact:**

1. Null/empty parameters cause cryptic errors instead of validation errors
2. No protection against accidental SQL injection (though Dapper parameters help)
3. Hard to debug "view not found" when actual problem was null viewName passed

**Recommendation:**

Add null/empty validation at method entry:

```csharp
public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
{
    if (string.IsNullOrWhiteSpace(sql))
        throw new ArgumentException("SQL query cannot be null or empty", nameof(sql));

    // ... rest of method
}

public async Task<string> GetViewSqlAsync(string viewName)
{
    if (string.IsNullOrWhiteSpace(viewName))
        throw new ArgumentException("View name cannot be null or empty", nameof(viewName));

    // ... rest of method
}
```

---

### ISSUE 9: MEDIUM - Inconsistent Error Message Format

**Severity:** MEDIUM

**Problem:**

Different services use different error message formats, making it hard for users/operators to recognize and handle errors:

**DapperQueryService:**
```csharp
throw new InvalidOperationException(
    $"Query execution failed for type {typeof(T).Name}: {ex.Message}", ex);
```

**ViewRegistry.GetViewSqlAsync:**
```csharp
throw new InvalidOperationException(
    $"Failed to load SQL for view '{viewName}': {ex.Message}", ex);
```

**ViewService:**
```csharp
throw new InvalidOperationException(
    $"Failed to execute view '{viewName}': {ex.Message}", ex);
```

**User Impact:**

1. No consistent error ID for Sentry tracking or user support reference
2. Users can't recognize whether error is from view layer or Dapper layer
3. No standard format for providing recovery guidance

**Recommendation:**

Use consistent error message format with error ID:

```csharp
// In a shared constants file:
public static class ViewErrorIds
{
    public const string ViewNotFound = "VIEW_NOT_FOUND";
    public const string SqlFileNotFound = "SQL_FILE_NOT_FOUND";
    public const string QueryExecutionFailed = "QUERY_EXECUTION_FAILED";
    public const string SqlError = "SQL_ERROR";
}

// In DapperQueryService:
throw new InvalidOperationException(
    $"[{ViewErrorIds.QueryExecutionFailed}] Query execution failed for type {typeof(T).Name}: {ex.Message}", ex);

// In ViewRegistry:
throw new FileNotFoundException(
    $"[{ViewErrorIds.SqlFileNotFound}] SQL file for view '{viewName}' not found at {sqlPath}", ex);

// In ViewService:
throw new InvalidOperationException(
    $"[{ViewErrorIds.QueryExecutionFailed}] Failed to execute view '{viewName}': {ex.Message}", ex);
```

---

## SUMMARY TABLE

| Issue | File | Severity | Type | Impact |
|-------|------|----------|------|--------|
| **1** | DapperQueryService.cs | CRITICAL | Overly broad exception catching | Hides unrelated errors (OOM, permissions, etc.) |
| **2** | ViewRegistry.cs | CRITICAL | Silent failure on missing views.yaml | App boots without views, fails on first use |
| **3** | ViewRegistry.cs | CRITICAL | Overly broad file I/O exception catching | Loses specific error context (permission, disk full) |
| **4** | ViewService.cs | CRITICAL | Overly broad exception catching + double nesting | Obscures root cause in exception chain |
| **5** | ProductDashboard.razor | HIGH | Poor error message to user | Technical jargon confuses end users |
| **6** | ViewPipelineTests.cs | HIGH | Missing error scenario tests | No coverage for connection failures, SQL errors, type mapping |
| **7** | DapperQueryService.cs | MEDIUM | Unclear connection lifecycle management | Potential connection pool exhaustion under load |
| **8** | All services | MEDIUM | No parameter validation | Null/empty params cause cryptic errors |
| **9** | All services | MEDIUM | Inconsistent error message format | Hard to identify error type or provide support |

---

## IMMEDIATE ACTION ITEMS

### Priority 1 (Fix Before Merge)

1. **Fix DapperQueryService exception handling** - Replace bare `catch (Exception)` with specific catch blocks for SqlException, OperationCanceledException, ArgumentException
2. **Fix ViewRegistry initialization** - Fail fast if views.yaml is missing, or log as ERROR instead of WARNING
3. **Fix ViewRegistry.GetViewSqlAsync** - Replace bare `catch (Exception)` with specific catches for FileNotFoundException, UnauthorizedAccessException, OutOfMemoryException
4. **Fix ViewService exception handling** - Let registry exceptions propagate; only catch Dapper errors specifically

### Priority 2 (Before Production)

5. Add comprehensive error scenario tests (connection failures, SQL syntax errors, type mapping failures)
6. Improve ProductDashboard error messages - differentiate between configuration errors vs transient errors
7. Add parameter validation to all service methods
8. Standardize error message format with error IDs

### Priority 3 (Nice to Have)

9. Implement connection resource management with explicit cleanup
10. Consider adding circuit breaker pattern for database failures
11. Add distributed tracing/correlation IDs

---

## Files Affected by Recommendations

- `/home/jrade/code/devixlabs/DotNetWebApp/Data/Dapper/DapperQueryService.cs`
- `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewRegistry.cs`
- `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewService.cs`
- `/home/jrade/code/devixlabs/DotNetWebApp/Components/Pages/ProductDashboard.razor`
- `/home/jrade/code/devixlabs/DotNetWebApp/tests/DotNetWebApp.Tests/ViewPipelineTests.cs`

---

**Report Generated:** 2026-01-27
**Audit Status:** ⚠️ Issues Found - Requires Remediation Before Merge
