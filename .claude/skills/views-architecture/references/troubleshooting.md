# Troubleshooting: Error Catalog & Solutions

Comprehensive error catalog with step-by-step solutions for view pipeline issues.

---

## Error: VIEW_NOT_FOUND

**Exception Type:** `InvalidOperationException`

**Symptom:**
```
InvalidOperationException: [VIEW_NOT_FOUND] View 'ProductSalesView' not found in registry
```

**Root Causes:**

1. View name not in `appsettings.json` ViewDefinitions
2. View name has different capitalization
3. Pipeline not run after adding ViewDefinition
4. Application not restarted after pipeline run

**Solution:**

1. **Verify ViewDefinition exists in appsettings.json:**
   ```bash
   grep -A 5 "ProductSalesView" appsettings.json
   ```
   If not found, add it to `"ViewDefinitions"` array

2. **Run pipeline:**
   ```bash
   make run-ddl-pipeline
   ```
   This generates view models and updates app.yaml

3. **Restart application:**
   ```bash
   make stop-dev  # If running in dev mode
   make dev       # Restart
   ```
   IViewRegistry is a singleton, loaded only at startup

4. **Check app.yaml was updated:**
   ```bash
   grep -i "ProductSalesView" app.yaml
   ```
   Should show view definition with sql_file, parameters, properties

5. **Verify view name capitalization:**
   ```csharp
   // Exact match required (but case-insensitive internally)
   var results = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");
   ```

**Prevention:**
- Run `make run-ddl-pipeline` immediately after modifying appsettings.json ViewDefinitions
- Don't manually edit app.yaml (it's generated)
- Restart application after pipeline runs

---

## Error: SQL_FILE_NOT_FOUND

**Exception Type:** `FileNotFoundException`

**Symptom:**
```
FileNotFoundException: Could not find file 'sql/views/ProductSalesView.sql'
```

**Root Causes:**

1. SQL file path in ViewDefinition doesn't match actual file location
2. File deleted but ViewDefinition still references it
3. Path has typo (case-sensitive on Linux)
4. Working directory is wrong

**Solution:**

1. **Check file exists:**
   ```bash
   ls -la sql/views/ProductSalesView.sql
   ```

2. **If missing, create it:**
   ```bash
   touch sql/views/ProductSalesView.sql
   # Add SQL SELECT query
   ```

3. **Verify path in ViewDefinition matches actual file:**
   ```bash
   # In appsettings.json
   "SqlFile": "sql/views/ProductSalesView.sql"  # Relative to project root
   ```

4. **Check path capitalization (Linux is case-sensitive):**
   ```bash
   # List actual files
   ls -la sql/views/
   # Verify capitalization matches SqlFile path exactly
   ```

5. **Verify project root is correct:**
   ```bash
   pwd  # Should be /home/jrade/code/devixlabs/DotNetWebApp
   ls -la sql/views/
   ```

**Prevention:**
- Use lowercase with underscores for SQL file names: `product_sales_view.sql`
- Match file names exactly in ViewDefinition `SqlFile` field
- Keep all SQL views in `sql/views/` directory

---

## Error: SQL_FILE_PERMISSION_DENIED

**Exception Type:** `UnauthorizedAccessException`

**Symptom:**
```
UnauthorizedAccessException: Access to the path 'sql/views/ProductSalesView.sql' is denied
```

**Root Causes:**

1. File has wrong permissions (not readable by application user)
2. Running as different user without read permissions
3. File is locked by another process

**Solution:**

1. **Check file permissions:**
   ```bash
   ls -la sql/views/ProductSalesView.sql
   # Should show: -rw-rw-r-- or -rw-r--r--
   ```

2. **Fix permissions if needed:**
   ```bash
   chmod 644 sql/views/ProductSalesView.sql
   ```

3. **Check directory permissions:**
   ```bash
   ls -la sql/views/
   # Should show: drwxrwxr-x or drwxr-xr-x
   chmod 755 sql/views/
   ```

4. **If file is locked, check what has it open:**
   ```bash
   lsof sql/views/ProductSalesView.sql
   # Kill process if needed: kill -9 <PID>
   ```

5. **Verify current user:**
   ```bash
   whoami
   # Application runs as this user, needs read permission
   ```

**Prevention:**
- Keep SQL files world-readable: `chmod 644`
- Don't lock files in editors while application is running
- Use consistent file permissions across all files

---

## Error: QUERY_TIMEOUT

**Exception Type:** `OperationCanceledException`

**Symptom:**
```
OperationCanceledException: The operation has timed out
```

**Root Causes:**

1. SQL query is inefficient (missing indexes, bad JOIN)
2. Database connection timeout set too low
3. Database is slow/overloaded
4. SQL deadlock with other queries

**Solution:**

1. **Enable SQL query logging to see the SQL:**
   ```csharp
   // In Blazor component catch block
   Logger.LogWarning("Query timeout. SQL was: {SQL}", sql);
   ```

2. **Test SQL directly in SSMS:**
   ```bash
   # Open SQL Server Management Studio
   # Run the SELECT query from sql/views/ProductSalesView.sql
   # Check execution plan for missing indexes
   ```

3. **Check database is responsive:**
   ```bash
   # From command line
   sqlcmd -S localhost -U sa -P YourPassword -Q "SELECT 1"
   ```

4. **Increase timeout (last resort):**
   ```csharp
   // In appsettings.json
   "ConnectionStrings": {
       "DefaultConnection": "Server=...;Timeout=60"  // Increased from 30
   }
   ```

5. **Optimize the SQL query:**
   - Add indexes: `CREATE INDEX idx_products_categoryid ON Products(CategoryId)`
   - Avoid SELECT *: List only needed columns
   - Check for missing JOINs causing Cartesian products
   - Use WHERE filters before JOINs

6. **Check for deadlocks:**
   ```sql
   -- Run in SQL Server
   SELECT * FROM sys.dm_tran_locks
   ```

**Prevention:**
- Test SQL performance in SSMS before adding to project
- Create appropriate indexes for filtered columns
- Monitor slow queries in production
- Use TIMEOUT parameter to fail fast rather than hang

---

## Error: SQL_ERROR

**Exception Type:** `SqlException`

**Symptom (Generic):**
```
SqlException: A database error occurred
```

**Subtypes:**

### Deadlock
```
SqlException: Transaction (Process ID 52) was deadlocked on lock resources
```

**Solution:**
1. Check if multiple views are updating same tables (they shouldn't - views are read-only)
2. Reduce transaction scope if using transactions
3. Use `WITH (NOLOCK)` hint in SQL if reading stale data is acceptable:
   ```sql
   SELECT * FROM Products WITH (NOLOCK) WHERE Id = @Id
   ```

### Constraint Violation
```
SqlException: The FOREIGN KEY constraint failed
```

**Solution:**
1. Check SQL view doesn't try to INSERT/UPDATE/DELETE (views are read-only)
2. Verify referenced table exists
3. Check column exists and is correct type

### Column Not Found
```
SqlException: Invalid column name 'TotalRevenue'
```

**Solution:**
1. Check SQL aliases match ViewDefinition property names
2. Both are case-insensitive but names must match
3. Verify column is in SELECT clause with correct alias

### Index Corruption
```
SqlException: Corrupted index
```

**Solution:**
```sql
-- In SQL Server Management Studio
DBCC CHECKDB (YourDatabaseName);
DBCC DROPCLEANBUFFERS;
```

---

## Error: QUERY_INVALID_PARAMETER

**Exception Type:** `InvalidOperationException`

**Symptom:**
```
InvalidOperationException: Parameter @TopN of type 'string' cannot be converted to 'int'
```

**Root Causes:**

1. Parameter type mismatch (passing string to int parameter)
2. Parameter validation failed (value out of range)
3. NULL passed to non-nullable parameter

**Solution:**

1. **Check parameter type in ViewDefinition:**
   ```json
   "Parameters": [
     {
       "Name": "TopN",
       "Type": "int",           // Expect integer
       "Nullable": false        // Cannot be null
     }
   ]
   ```

2. **Validate before calling view:**
   ```csharp
   if (topN < 1 || topN > 1000)
       throw new ArgumentException("TopN must be 1-1000");

   var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
       "ProductSalesView",
       new { TopN = topN });  // Passing int, not string
   ```

3. **Check parameter is not null if nullable=false:**
   ```csharp
   if (categoryId == null && !viewDefinition.Parameters
       .Single(p => p.Name == "CategoryId").Nullable)
   {
       throw new ArgumentNullException("CategoryId cannot be null");
   }
   ```

4. **Parse string parameters explicitly:**
   ```csharp
   // User enters "50" as string
   if (!int.TryParse(userInput, out var topN))
       throw new ArgumentException("Invalid TopN value");

   var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
       "ProductSalesView",
       new { TopN = topN });  // Now it's int
   ```

**Prevention:**
- Always validate user input before passing to views
- Use typed inputs (RadzenNumeric for int, not RadzenTextBox)
- Document parameter ranges in ViewDefinition validation

---

## Error: Type Resolution Failure (Multi-Schema)

**Exception Type:** `InvalidOperationException` or `NullReferenceException`

**Symptom:**
```
Type.GetType("DotNetWebApp.Models.ViewModels.ProductSalesView") returned null
```

**Root Cause:** In multi-schema scenarios, view models are in schema-qualified namespaces:
- `DotNetWebApp.Models.ViewModels.Acme.ProductSalesView`
- `DotNetWebApp.Models.ViewModels.Initech.ProductSalesView`

Generic reflection lookup fails without schema namespace.

**Solution:**

1. **Check if view is in multiple schemas:**
   ```bash
   grep -r "ProductSalesView" DotNetWebApp.Models/ViewModels/
   # Should show: Acme/ProductSalesView.cs and Initech/ProductSalesView.cs
   ```

2. **Update type resolution to use schema namespace:**
   ```csharp
   // ❌ WRONG
   var typeName = $"DotNetWebApp.Models.ViewModels.{ViewName}";

   // ✅ CORRECT
   var typeName = $"DotNetWebApp.Models.ViewModels.{SchemaName}.{ViewName}";
   var type = Type.GetType(typeName);
   ```

3. **If single-schema only, use simple resolution:**
   ```csharp
   var type = Type.GetType($"DotNetWebApp.Models.ViewModels.{ViewName}");
   ```

**Prevention:**
- For multi-schema projects, always use schema-qualified type names
- Document schema structure in project README
- Add unit test for type resolution in multi-schema scenarios

---

## Error: VIEW_EXECUTION_FAILED

**Generic Catch-All Exception**

**Symptom:**
```
[VIEW_EXECUTION_FAILED] Error executing view
```

**Root Causes:** Anything not covered by specific error IDs

**Solution:**

1. **Check exception message for details:**
   ```csharp
   catch (Exception ex)
   {
       Logger.LogError(ex, "[{ErrorId}] {Message}", ErrorIds.ViewExecutionFailed, ex.Message);
       // Log full exception to see stack trace
   }
   ```

2. **Enable debug logging:**
   In `appsettings.Development.json`:
   ```json
   "Logging": {
       "LogLevel": {
           "DotNetWebApp.Services.Views": "Debug"
       }
   }
   ```

3. **Check application logs:**
   ```bash
   tail -f ~/.logs/dotnetwebapp.log | grep ERROR
   ```

4. **Test view in isolation:**
   ```csharp
   // Unit test the view
   [Fact]
   public async Task ProductSalesView_Returns_Results()
   {
       var results = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");
       Assert.NotEmpty(results);
   }
   ```

---

## Debugging Workflow

**Step 1: Identify error ID**
- Check exception message for error ID prefix: `[VIEW_NOT_FOUND]`, etc.
- Refer to error sections above

**Step 2: Check logs**
```bash
# Get detailed logs from application
tail -n 50 /path/to/application.log | grep -A 10 "ERROR"
```

**Step 3: Test in isolation**
```bash
# Test SQL directly
sqlcmd -S localhost -U sa -Q "SELECT TOP 10 * FROM Products"

# Test view exists
curl http://localhost:5000/api/admin/views/ProductSalesView
```

**Step 4: Enable SQL logging**
```json
{
  "Logging": {
    "LogLevel": {
      "Microsoft.EntityFrameworkCore.Database.Command": "Debug"
    }
  }
}
```

**Step 5: Check app.yaml**
```bash
grep -A 20 "ProductSalesView" app.yaml
# Verify view definition is present and correct
```

**Step 6: Test after fixes**
```bash
make stop-dev
make dev
# Re-test in browser
```

---

## Common Issues Summary

| Issue | Check | Fix |
|-------|-------|-----|
| View not found | appsettings.json | Run `make run-ddl-pipeline`, restart app |
| SQL file not found | sql/views/ directory | Create file, verify path matches ViewDefinition |
| Timeout | SQL performance | Add indexes, optimize query in SSMS |
| Type resolution fails | Multi-schema | Use schema-qualified namespace in type lookup |
| Permission denied | File permissions | `chmod 644` SQL files |
| Stale data | View definition | Update ViewDefinition in appsettings.json |
| Parameter validation | Type mismatch | Validate user input before passing to view |

---

## How to Ask for Help

When reporting view issues, include:

1. **Error ID:** `[VIEW_NOT_FOUND]`, `[SQL_ERROR]`, etc.
2. **Full exception message:** Copy-paste the complete error
3. **Stack trace:** From application logs
4. **What you're trying to do:** "I'm trying to add a new view named ProductSalesView"
5. **Steps you've already tried:** "I've run `make run-ddl-pipeline` and restarted the app"
6. **appsettings.json ViewDefinition:** The definition you added
7. **SQL query:** The SELECT statement from the .sql file

Example:

```
ERROR: [VIEW_NOT_FOUND] View 'ProductSalesView' not found in registry

Exception: InvalidOperationException
Stack: at ViewRegistry.GetViewDefinition("ProductSalesView")
       at ViewService.ExecuteViewAsync<ProductSalesView>()

Steps tried:
- Confirmed ProductSalesView in appsettings.json ViewDefinitions
- Ran make run-ddl-pipeline
- Restarted application with make dev

app.yaml shows: (paste snippet)
SQL file at: sql/views/ProductSalesView.sql (confirmed exists)
```
