# Error Handling Audit - Detailed Code Analysis

**Branch:** refactor_phase_2 (PR #7)
**Date:** 2026-01-27

---

## CRITICAL ISSUE #1: Overly Broad Exception Catching in DapperQueryService

### Current Code (PROBLEMATIC)

**File:** `/home/jrade/code/devixlabs/DotNetWebApp/Data/Dapper/DapperQueryService.cs`

```csharp
// Lines 33-60: QueryAsync Method
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

        // Connection state may be closed; Dapper will handle opening it
        return await connection.QueryAsync<T>(sql, param);
    }
    catch (Exception ex)  // ❌ PROBLEM: Catches ALL exceptions
    {
        _logger.LogError(
            ex,
            "Dapper query failed (Schema: {Schema}, Type: {ResultType}): {Sql}",
            _dbContext.Schema ?? "default",
            typeof(T).Name,
            TruncateSql(sql));

        throw new InvalidOperationException(
            $"Query execution failed for type {typeof(T).Name}: {ex.Message}", ex);
    }
}

// Lines 66-92: QuerySingleAsync Method (Same Problem)
public async Task<T?> QuerySingleAsync<T>(string sql, object? param = null)
{
    var connection = _dbContext.Database.GetDbConnection();

    try
    {
        _logger.LogDebug(
            "Executing Dapper single query (Schema: {Schema}, Type: {ResultType}): {Sql}",
            _dbContext.Schema ?? "default",
            typeof(T).Name,
            TruncateSql(sql));

        return await connection.QuerySingleOrDefaultAsync<T>(sql, param);
    }
    catch (Exception ex)  // ❌ PROBLEM: Catches ALL exceptions
    {
        _logger.LogError(
            ex,
            "Dapper single query failed (Schema: {Schema}, Type: {ResultType}): {Sql}",
            _dbContext.Schema ?? "default",
            typeof(T).Name,
            TruncateSql(sql));

        throw new InvalidOperationException(
            $"Single query execution failed for type {typeof(T).Name}: {ex.Message}", ex);
    }
}
```

### What Gets Hidden?

When this catch block executes, it silently suppresses these distinct error types:

```
Exception Type              What It Means                      User Sees Now
─────────────────────────────────────────────────────────────────────────────
SqlException (Timeout)      Database too slow to respond       "Query execution failed" ❌
SqlException (Permission)   User lacks query permissions       "Query execution failed" ❌
ArgumentException           Invalid SQL parameter names        "Query execution failed" ❌
OutOfMemoryException        App ran out of memory             "Query execution failed" ❌
StackOverflowException      Infinite recursion (rare)         "Query execution failed" ❌
NullReferenceException      Bug in Dapper/parameter code      "Query execution failed" ❌
TypeLoadException           Missing type definition            "Query execution failed" ❌
OperationCanceledException  Query timeout/cancellation         "Query execution failed" ❌
AggregateException          Multiple async failures            "Query execution failed" ❌
```

### Test Scenario Demonstrating the Problem

```csharp
[Fact]
public async Task QueryAsync_WithTimeoutError_WrapsAndHidesSpecificError()
{
    // Arrange: Simulate a SQL timeout (specific, meaningful error)
    var mockConnection = new Mock<DbConnection>();
    var sqlTimeout = new SqlException("Execution Timeout Expired", new[] {
        new SqlError(229, 0, 11, "SERVER", "Execution Timeout Expired", "", 1, -2)
    }, "-2");

    mockConnection
        .Setup(c => c.QueryAsync<TestData>(It.IsAny<string>(), It.IsAny<object>()))
        .ThrowsAsync(sqlTimeout);

    var mockDbContext = new Mock<AppDbContext>();
    mockDbContext.Setup(x => x.Database.GetDbConnection()).Returns(mockConnection.Object);

    var service = new DapperQueryService(mockDbContext.Object, _logger);

    // Act
    var ex = await Assert.ThrowsAsync<InvalidOperationException>(
        () => service.QueryAsync<TestData>("SELECT * FROM veryslowquery", null));

    // Assert
    // PROBLEM: Original error details are lost
    Assert.Equal("Query execution failed for type TestData: Execution Timeout Expired", ex.Message);
    // ❌ User doesn't know this is a TIMEOUT (could be permission, could be syntax error)
    // ❌ User doesn't know the error code is -2 (which means timeout)
    // ❌ The original SqlException is buried in ex.InnerException
}
```

### Corrected Code (RECOMMENDED)

```csharp
using Microsoft.Data.SqlClient;

public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
{
    if (string.IsNullOrWhiteSpace(sql))
        throw new ArgumentException("SQL query cannot be null or empty", nameof(sql));

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
    // SPECIFIC CATCH: SQL Server errors with detailed logging
    catch (SqlException ex)
    {
        _logger.LogError(
            ex,
            "SQL Server error executing query (Schema: {Schema}, Type: {ResultType}, ErrorCode: {ErrorCode}): {Sql}",
            _dbContext.Schema ?? "default",
            typeof(T).Name,
            ex.Number,  // Error code provides context
            TruncateSql(sql));

        var friendlyMessage = GetFriendlySqlErrorMessage(ex.Number, ex.Message);
        throw new InvalidOperationException(
            $"SQL error: {friendlyMessage} (Code: {ex.Number})", ex);
    }
    // SPECIFIC CATCH: Query timeout (common and user-friendly message)
    catch (OperationCanceledException ex)
    {
        _logger.LogError(
            ex,
            "Query timeout for type {ResultType}",
            typeof(T).Name);

        throw new InvalidOperationException(
            "Query execution timed out. The database is responding slowly. Please try again.", ex);
    }
    // SPECIFIC CATCH: Invalid parameters or SQL syntax
    catch (ArgumentException ex)
    {
        _logger.LogError(
            ex,
            "Invalid query parameter for type {ResultType}: {Sql}",
            typeof(T).Name,
            TruncateSql(sql));

        throw;  // Re-throw unchanged - caller needs to fix their SQL/params
    }
    // SPECIFIC CATCH: Out of memory - critical condition
    catch (OutOfMemoryException ex)
    {
        _logger.LogCritical(
            ex,
            "Out of memory executing query - result set may be too large");

        throw;  // Re-throw unchanged - this is critical
    }
}

private string GetFriendlySqlErrorMessage(int errorCode, string originalMessage)
{
    return errorCode switch
    {
        -2 => "Connection timeout - database is not responding",
        -1 => "Network error communicating with database",
        15007 => "Insufficient permissions - your user account cannot execute this query",
        207 => "Invalid column name in query",
        208 => "Invalid table name in query",
        1205 => "Database deadlock detected - please retry",
        18456 => "Login failed - check your database credentials",
        64 => "Database communication error",
        _ => $"Database error: {originalMessage}"
    };
}
```

---

## CRITICAL ISSUE #2: Silent Failure in ViewRegistry Initialization

### Current Code (PROBLEMATIC)

**File:** `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewRegistry.cs`

```csharp
// Lines 41-79
private void LoadViews(string yamlPath)
{
    // ❌ PROBLEM: Missing file is treated as non-fatal
    if (!File.Exists(yamlPath))
    {
        _logger.LogWarning("views.yaml not found at {Path}. No views registered.", yamlPath);
        return;  // Silently continues - service is initialized but empty!
    }

    _logger.LogInformation("Loading views registry from {Path}", yamlPath);

    try
    {
        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(UnderscoredNamingConvention.Instance)
            .Build();

        var yamlContent = File.ReadAllText(yamlPath);
        var viewDef = deserializer.Deserialize<ViewsDefinition>(yamlContent);

        if (viewDef?.Views == null || viewDef.Views.Count == 0)
        {
            _logger.LogWarning("No views found in {Path}", yamlPath);
            return;  // Another silent return
        }

        foreach (var view in viewDef.Views)
        {
            _views[view.Name] = view;
            _logger.LogDebug("Registered view: {ViewName} (SQL: {SqlFile})", view.Name, view.SqlFile);
        }

        _logger.LogInformation("Loaded {Count} views into registry", _views.Count);
    }
    catch (Exception ex)  // ✓ This part is good - throws on parse error
    {
        _logger.LogError(ex, "Failed to load views from {Path}", yamlPath);
        throw;
    }
}

// Called from constructor
public ViewRegistry(string viewsYamlPath, ILogger<ViewRegistry> logger)
{
    _logger = logger;
    _views = new Dictionary<string, ViewDefinition>(StringComparer.OrdinalIgnoreCase);
    _sqlCache = new ConcurrentDictionary<string, string>(StringComparer.OrdinalIgnoreCase);
    _sqlBasePath = Path.GetDirectoryName(viewsYamlPath) ?? AppDomain.CurrentDomain.BaseDirectory;

    LoadViews(viewsYamlPath);  // If views.yaml doesn't exist, this returns silently!
}
```

### The Silent Failure Scenario

```csharp
// In Program.cs dependency injection setup:
builder.Services.AddSingleton<IViewRegistry>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var viewsYamlPath = Path.Combine(env.ContentRootPath, "views.yaml");
    var logger = sp.GetRequiredService<ILogger<ViewRegistry>>();
    return new ViewRegistry(viewsYamlPath, logger);  // ← If views.yaml is missing:
                                                      // - ViewRegistry initializes successfully ✓
                                                      // - No exception is thrown ✓
                                                      // - Application boots normally ✓
                                                      // - BUT GetAllViewNames() returns empty list
});

// Hours later, user tries to access dashboard:
var sql = await viewRegistry.GetViewSqlAsync("ProductSalesView");
// FAILURE: Throws "View 'ProductSalesView' not found in registry. Registered views: "
//          User has NO IDEA that views.yaml was never loaded
```

### Test Demonstrating the Problem

```csharp
[Fact]
public void ViewRegistry_WithMissingYamlFile_InitializesButIsEmpty()
{
    // Arrange
    var nonExistentPath = "/path/that/does/not/exist/views.yaml";
    var logger = new NullLogger<ViewRegistry>();

    // Act - No exception thrown!
    var registry = new ViewRegistry(nonExistentPath, logger);

    // Assert - Service initialized but unusable
    Assert.Empty(registry.GetAllViewNames());

    // Problem: How does deployer know views are missing?
    // The application booted successfully with a critical missing file!
}

[Fact]
public async Task ViewService_WithMissingViews_FailsOnFirstUse()
{
    // Arrange
    var registry = new ViewRegistry("/missing/views.yaml", _logger);
    var mockDapper = new Mock<IDapperQueryService>();
    var service = new ViewService(mockDapper.Object, registry, _logger);

    // Act & Assert - Fails only when used
    var ex = await Assert.ThrowsAsync<InvalidOperationException>(
        () => service.ExecuteViewAsync<TestData>("ProductSalesView"));

    // The error is cryptic - "View 'ProductSalesView' not found"
    // Doesn't tell user that views.yaml was never loaded during startup!
    Assert.Contains("not found in registry", ex.Message);
}
```

### Corrected Code (RECOMMENDED)

```csharp
// Option 1: STRICT (Fail fast on startup if views.yaml missing)
private void LoadViews(string yamlPath)
{
    if (!File.Exists(yamlPath))
    {
        throw new FileNotFoundException(
            $"views.yaml not found at {yamlPath}. " +
            $"The view registry requires views.yaml to be present at application startup. " +
            $"This is a critical configuration file. " +
            $"Check that:\n" +
            $"  1. views.yaml is in the application root ({yamlPath})\n" +
            $"  2. The file was included in the deployment\n" +
            $"  3. File permissions allow reading the file");
    }

    _logger.LogInformation("Loading views registry from {Path}", yamlPath);

    try
    {
        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(UnderscoredNamingConvention.Instance)
            .Build();

        var yamlContent = File.ReadAllText(yamlPath);
        var viewDef = deserializer.Deserialize<ViewsDefinition>(yamlContent);

        if (viewDef?.Views == null || viewDef.Views.Count == 0)
        {
            throw new InvalidOperationException(
                $"No views found in {yamlPath}. " +
                "The views.yaml file is empty or has no 'views' section. " +
                "At least one view must be defined.");
        }

        foreach (var view in viewDef.Views)
        {
            if (string.IsNullOrWhiteSpace(view.Name))
                throw new InvalidOperationException("View name cannot be empty in views.yaml");

            if (string.IsNullOrWhiteSpace(view.SqlFile))
                throw new InvalidOperationException($"View '{view.Name}' has empty sql_file in views.yaml");

            _views[view.Name] = view;
            _logger.LogDebug("Registered view: {ViewName} (SQL: {SqlFile})", view.Name, view.SqlFile);
        }

        _logger.LogInformation("Loaded {Count} views into registry", _views.Count);
    }
    catch (Exception ex) when (!(ex is FileNotFoundException))
    {
        _logger.LogError(ex, "Failed to load views from {Path}", yamlPath);
        throw new InvalidOperationException(
            $"Failed to load views.yaml from {yamlPath}: {ex.Message}",
            ex);
    }
}

// Option 2: GRACEFUL (Optional views with clear logging)
private void LoadViews(string yamlPath)
{
    if (!File.Exists(yamlPath))
    {
        // Log as ERROR, not WARNING - this is important!
        _logger.LogError(
            "views.yaml not found at {Path}. " +
            "View functionality is DISABLED. " +
            "All view execution will fail with 'view not found' errors. " +
            "To enable views, create views.yaml in the application root.",
            yamlPath);
        return;
    }

    // ... rest of method with same error handling as Option 1
}
```

---

## CRITICAL ISSUE #3: Overly Broad File I/O Exception Catching

### Current Code (PROBLEMATIC)

**File:** `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewRegistry.cs`

```csharp
// Lines 85-126
public async Task<string> GetViewSqlAsync(string viewName)
{
    // Check cache first
    if (_sqlCache.TryGetValue(viewName, out var cachedSql))
    {
        _logger.LogDebug("Using cached SQL for view {ViewName}", viewName);
        return cachedSql;
    }

    // Get view definition
    if (!_views.TryGetValue(viewName, out var view))
    {
        var registeredViews = string.Join(", ", _views.Keys);
        throw new InvalidOperationException(
            $"View '{viewName}' not found in registry. Registered views: {registeredViews}");
    }

    // Resolve SQL file path (relative to views.yaml location)
    var sqlPath = Path.IsPathRooted(view.SqlFile)
        ? view.SqlFile
        : Path.Combine(_sqlBasePath, view.SqlFile);

    if (!File.Exists(sqlPath))
    {
        throw new FileNotFoundException(
            $"SQL file not found for view '{viewName}': {sqlPath}");
    }

    try
    {
        var sql = await File.ReadAllTextAsync(sqlPath);
        _sqlCache.TryAdd(viewName, sql);
        _logger.LogDebug("Loaded SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
        return sql;
    }
    catch (Exception ex)  // ❌ PROBLEM: Catches ALL file I/O errors the same way
    {
        _logger.LogError(ex, "Failed to load SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
        throw new InvalidOperationException(
            $"Failed to load SQL for view '{viewName}': {ex.Message}", ex);
    }
}
```

### What Gets Hidden?

```
Exception Type              What It Really Means              User Sees Now
────────────────────────────────────────────────────────────────────────────
FileNotFoundException       File was deleted between check    "Failed to load SQL" ❌
UnauthorizedAccessException Permission denied on file        "Failed to load SQL" ❌
DirectoryNotFoundException  Path doesn't exist                "Failed to load SQL" ❌
IOException (disk full)     No space to read file             "Failed to load SQL" ❌
IOException (file locked)   Another process is using file    "Failed to load SQL" ❌
OutOfMemoryException        File too large for memory         "Failed to load SQL" ❌
```

### Corrected Code (RECOMMENDED)

```csharp
public async Task<string> GetViewSqlAsync(string viewName)
{
    if (string.IsNullOrWhiteSpace(viewName))
        throw new ArgumentException("View name cannot be null or empty", nameof(viewName));

    // Check cache first
    if (_sqlCache.TryGetValue(viewName, out var cachedSql))
    {
        _logger.LogDebug("Using cached SQL for view {ViewName}", viewName);
        return cachedSql;
    }

    // Get view definition
    if (!_views.TryGetValue(viewName, out var view))
    {
        var registeredViews = string.Join(", ", _views.Keys);
        throw new InvalidOperationException(
            $"View '{viewName}' not found in registry. Registered views: {registeredViews}");
    }

    // Resolve SQL file path
    var sqlPath = Path.IsPathRooted(view.SqlFile)
        ? view.SqlFile
        : Path.Combine(_sqlBasePath, view.SqlFile);

    if (!File.Exists(sqlPath))
    {
        throw new FileNotFoundException(
            $"SQL file not found for view '{viewName}': {sqlPath}");
    }

    try
    {
        var sql = await File.ReadAllTextAsync(sqlPath);
        _sqlCache.TryAdd(viewName, sql);
        _logger.LogDebug("Loaded SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
        return sql;
    }
    // SPECIFIC CATCH: File no longer exists (race condition)
    catch (FileNotFoundException ex)
    {
        _logger.LogError(
            ex,
            "SQL file was deleted between existence check and read for view {ViewName}: {SqlPath}",
            viewName,
            sqlPath);

        throw new FileNotFoundException(
            $"SQL file for view '{viewName}' was not found at {sqlPath}. " +
            "The file may have been deleted or moved. Check sql/views/ directory.",
            ex);
    }
    // SPECIFIC CATCH: Permission denied
    catch (UnauthorizedAccessException ex)
    {
        _logger.LogError(
            ex,
            "Access denied reading SQL file for view {ViewName}: {SqlPath}",
            viewName,
            sqlPath);

        throw new UnauthorizedAccessException(
            $"Cannot read SQL file for view '{viewName}' at {sqlPath}. " +
            "Check file permissions. The application process needs read permissions on all SQL files.",
            ex);
    }
    // SPECIFIC CATCH: Path doesn't exist
    catch (DirectoryNotFoundException ex)
    {
        _logger.LogError(
            ex,
            "SQL file path directory does not exist for view {ViewName}: {SqlPath}",
            viewName,
            sqlPath);

        throw new InvalidOperationException(
            $"SQL file path for view '{viewName}' is invalid: {sqlPath}. " +
            "The directory does not exist. Check the sql_file path in views.yaml.",
            ex);
    }
    // SPECIFIC CATCH: Disk full or other I/O error
    catch (IOException ex) when (ex.Message.Contains("disk", StringComparison.OrdinalIgnoreCase))
    {
        _logger.LogCritical(
            ex,
            "Disk error reading SQL file for view {ViewName}",
            viewName);

        throw new InvalidOperationException(
            $"Disk error reading SQL file for view '{viewName}'. The disk may be full.",
            ex);
    }
    // SPECIFIC CATCH: Out of memory (file too large)
    catch (OutOfMemoryException ex)
    {
        _logger.LogCritical(
            ex,
            "Out of memory reading SQL file for view {ViewName}. File may be too large: {SqlPath}",
            viewName,
            sqlPath);

        throw new InvalidOperationException(
            $"SQL file for view '{viewName}' is too large to load into memory. " +
            "SQL files must be under available heap memory.",
            ex);
    }
    // CATCH-ALL for unexpected errors
    catch (IOException ex)
    {
        _logger.LogError(
            ex,
            "I/O error reading SQL file for view {ViewName}: {SqlPath}",
            viewName,
            sqlPath);

        throw new InvalidOperationException(
            $"I/O error reading SQL file for view '{viewName}': {ex.Message}",
            ex);
    }
}
```

---

## CRITICAL ISSUE #4: Overly Broad Exception Catching in ViewService

### Current Code (PROBLEMATIC)

**File:** `/home/jrade/code/devixlabs/DotNetWebApp/Services/Views/ViewService.cs`

```csharp
// Lines 36-59
public async Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null)
{
    try
    {
        var sql = await _registry.GetViewSqlAsync(viewName);  // Can throw multiple error types
        _logger.LogInformation(
            "Executing view: {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        return await _dapper.QueryAsync<T>(sql, parameters);  // Can throw different errors
    }
    catch (Exception ex)  // ❌ PROBLEM: Catches both registry AND dapper errors
    {
        _logger.LogError(
            ex,
            "Failed to execute view: {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        throw new InvalidOperationException(
            $"Failed to execute view '{viewName}': {ex.Message}", ex);  // Double wrapping!
    }
}

// Lines 64-87
public async Task<T?> ExecuteViewSingleAsync<T>(string viewName, object? parameters = null)
{
    try
    {
        var sql = await _registry.GetViewSqlAsync(viewName);
        _logger.LogInformation(
            "Executing view (single): {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        return await _dapper.QuerySingleAsync<T>(sql, parameters);
    }
    catch (Exception ex)  // ❌ SAME PROBLEM
    {
        _logger.LogError(
            ex,
            "Failed to execute view (single): {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        throw new InvalidOperationException(
            $"Failed to execute view '{viewName}': {ex.Message}", ex);
    }
}
```

### Exception Nesting Problem

When an error occurs, it gets wrapped multiple times:

```
Layer 1 (Original):           SqlException("Timeout expired")
                              ↓
Layer 2 (DapperQueryService): InvalidOperationException("Query execution failed...", ex: SqlException)
                              ↓
Layer 3 (ViewService):        InvalidOperationException("Failed to execute view...", ex: InvalidOperationException)
                              ↓
Layer 4 (ProductDashboard):   Catches Exception and shows generic message

Result: Original SqlException is 4 levels deep in InnerException chain!
        User message is generic and unhelpful.
```

### Test Demonstrating the Problem

```csharp
[Fact]
public async Task ViewService_WithSqlTimeout_Wraps_Then_WrapsAgain()
{
    // Arrange: SQL timeout error
    var mockDapper = new Mock<IDapperQueryService>();
    var sqlTimeout = new SqlException("Execution Timeout Expired",
        new[] { new SqlError(229, 0, 11, "SERVER", "Timeout", "", 1, -2) }, "-2");
    var dapperWrapped = new InvalidOperationException(
        "Query execution failed for type TestData: Execution Timeout Expired", sqlTimeout);

    mockDapper
        .Setup(d => d.QueryAsync<TestData>(It.IsAny<string>(), It.IsAny<object>()))
        .ThrowsAsync(dapperWrapped);

    var registry = new ViewRegistry(_viewsYamlPath, _loggerViewRegistry);
    var service = new ViewService(mockDapper.Object, registry, _loggerViewService);

    // Act
    var ex = await Assert.ThrowsAsync<InvalidOperationException>(
        () => service.ExecuteViewAsync<TestData>("TestView"));

    // Assert: Error is double-wrapped
    Assert.Equal("Failed to execute view 'TestView': Query execution failed...", ex.Message);
    Assert.NotNull(ex.InnerException);
    Assert.IsType<InvalidOperationException>(ex.InnerException);
    Assert.Equal("Query execution failed for type TestData: Execution Timeout Expired",
        ex.InnerException.Message);

    // The original SqlException is buried another level deeper!
    var originalError = ex.InnerException.InnerException as SqlException;
    Assert.NotNull(originalError);
    Assert.Equal("Execution Timeout Expired", originalError.Message);

    // ❌ User sees only the outer message "Failed to execute view"
    // ❌ Doesn't know it's a timeout
    // ❌ Doesn't know error code is -2
}
```

### Corrected Code (RECOMMENDED)

```csharp
public async Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null)
{
    if (string.IsNullOrWhiteSpace(viewName))
        throw new ArgumentException("View name cannot be null or empty", nameof(viewName));

    // Let registry errors propagate directly - they have specific error messages
    var sql = await _registry.GetViewSqlAsync(viewName);  // May throw:
    // - InvalidOperationException: view not found
    // - FileNotFoundException: SQL file missing
    // - UnauthorizedAccessException: no permission to read file

    try
    {
        _logger.LogInformation(
            "Executing view: {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        return await _dapper.QueryAsync<T>(sql, parameters);
    }
    // Only catch expected Dapper execution errors - don't wrap, let them propagate
    catch (InvalidOperationException ex) when (ex.Message.Contains("Query execution failed"))
    {
        // DapperQueryService already wrapped and logged the error
        // Just re-throw to let ProductDashboard see the Dapper error message
        _logger.LogError(
            ex,
            "View execution failed: {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        throw;  // Don't wrap again - let caller see DapperQueryService's error
    }
    // Unexpected errors - log and re-throw
    catch (Exception ex)
    {
        _logger.LogCritical(
            ex,
            "Unexpected error executing view {ViewName}",
            viewName);

        throw;  // Don't wrap - caller needs to know this is unexpected
    }
}

public async Task<T?> ExecuteViewSingleAsync<T>(string viewName, object? parameters = null)
{
    if (string.IsNullOrWhiteSpace(viewName))
        throw new ArgumentException("View name cannot be null or empty", nameof(viewName));

    // Let registry errors propagate directly
    var sql = await _registry.GetViewSqlAsync(viewName);

    try
    {
        _logger.LogInformation(
            "Executing view (single): {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        return await _dapper.QuerySingleAsync<T>(sql, parameters);
    }
    catch (InvalidOperationException ex) when (ex.Message.Contains("Single query execution failed"))
    {
        _logger.LogError(
            ex,
            "Single view execution failed: {ViewName} (Type: {ResultType})",
            viewName,
            typeof(T).Name);

        throw;  // Don't wrap
    }
    catch (Exception ex)
    {
        _logger.LogCritical(
            ex,
            "Unexpected error executing view (single) {ViewName}",
            viewName);

        throw;  // Don't wrap
    }
}
```

---

## Summary: Exception Flow Before and After Fixes

### BEFORE (Current - Problematic):

```
User Action: Load ProductDashboard
     ↓
ProductDashboard.LoadDashboardDataAsync()
     ↓
ViewService.ExecuteViewAsync("ProductSalesView")
     ↓
ViewRegistry.GetViewSqlAsync("ProductSalesView")
     ↓
File.ReadAllTextAsync() throws UnauthorizedAccessException (file permission issue)
     ↓
catch (Exception ex) → wrap in InvalidOperationException("Failed to load SQL...")
     ↓
ViewService.ExecuteViewAsync catches this
     ↓
catch (Exception ex) → wrap again in InvalidOperationException("Failed to execute view...")
     ↓
ProductDashboard catches this
     ↓
errorMessage = $"Failed to load dashboard: {ex.Message}"
     ↓
User Sees: "Failed to load dashboard: Failed to execute view 'ProductSalesView'..."
❌ User has NO IDEA this is a permission problem!
```

### AFTER (Fixed - Clear Error Path):

```
User Action: Load ProductDashboard
     ↓
ProductDashboard.LoadDashboardDataAsync()
     ↓
ViewService.ExecuteViewAsync("ProductSalesView")
     ↓
ViewRegistry.GetViewSqlAsync("ProductSalesView")
     ↓
File.ReadAllTextAsync() throws UnauthorizedAccessException
     ↓
catch (UnauthorizedAccessException ex) → wrap in UnauthorizedAccessException(
    "Cannot read SQL file... Check file permissions...", ex)
     ↓
ViewService doesn't catch UnauthorizedAccessException → it propagates
     ↓
ProductDashboard catches UnauthorizedAccessException
     ↓
    if (ex is UnauthorizedAccessException)
        errorMessage = "Dashboard configuration error: file permissions. Contact admin."
     ↓
User Sees: Clear, actionable message about permission issue
✓ User and admin know exactly what's wrong!
```

---

**Next:** Implement these fixes and run comprehensive tests before merging PR #7.
