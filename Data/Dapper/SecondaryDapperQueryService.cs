using System.Data;
using Dapper;
using DotNetWebApp.Constants;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Data.Dapper;

/// <summary>
/// Read-only Dapper service for the secondary database (GAIMisc).
/// Uses SecondaryDbContext's connection for queries to gai_scheduler, gai_allocate, etc.
/// Automatically inherits tenant schema from EF Core context.
/// </summary>
public class SecondaryDapperQueryService : IDapperQueryService
{
    private readonly SecondaryDbContext _dbContext;
    private readonly ILogger<SecondaryDapperQueryService> _logger;

    /// <summary>
    /// Initializes a new instance of SecondaryDapperQueryService.
    /// Uses the SecondaryDbContext's connection for all queries.
    /// </summary>
    /// <param name="dbContext">EF Core secondary database context</param>
    /// <param name="logger">Logger instance</param>
    public SecondaryDapperQueryService(SecondaryDbContext dbContext, ILogger<SecondaryDapperQueryService> logger)
    {
        _dbContext = dbContext ?? throw new ArgumentNullException(nameof(dbContext));
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }

    /// <summary>
    /// Executes a query and returns multiple results.
    /// Automatically handles connection state (opens if closed).
    /// </summary>
    public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null)
    {
        // Parameter validation
        if (string.IsNullOrWhiteSpace(sql))
            throw new ArgumentException($"[{ErrorIds.QueryInvalidParameter}] SQL query cannot be null or empty", nameof(sql));

        var connection = _dbContext.Database.GetDbConnection();

        try
        {
            _logger.LogDebug(
                "Executing Dapper query on SECONDARY database (Type: {ResultType}): {Sql}",
                typeof(T).Name,
                TruncateSql(sql));

            // Connection state may be closed; Dapper will handle opening it
            return await connection.QueryAsync<T>(sql, param);
        }
        catch (SqlException ex)
        {
            _logger.LogError(
                ex,
                "[{ErrorId}] SQL Server error executing query on SECONDARY database (Type: {ResultType}, ErrorCode: {ErrorCode}): {Sql}",
                ErrorIds.SqlError,
                typeof(T).Name,
                ex.Number,
                TruncateSql(sql));

            var friendlyMessage = ErrorIds.GetFriendlySqlErrorMessage(ex.Number, ex.Message);
            throw new InvalidOperationException(
                $"[{ErrorIds.SqlError}] {friendlyMessage} (Code: {ex.Number})", ex);
        }
        catch (OperationCanceledException ex)
        {
            _logger.LogError(
                ex,
                "[{ErrorId}] Query timeout for type {ResultType} on SECONDARY database",
                ErrorIds.QueryTimeout,
                typeof(T).Name);

            throw new InvalidOperationException(
                $"[{ErrorIds.QueryTimeout}] Query execution timed out. The database is responding slowly. Please try again.", ex);
        }
        catch (ArgumentException ex)
        {
            // This indicates a bug in SQL or parameter mapping - re-throw unchanged
            _logger.LogError(
                ex,
                "[{ErrorId}] Invalid query or parameters for type {ResultType}: {Sql}",
                ErrorIds.QueryInvalidParameter,
                typeof(T).Name,
                TruncateSql(sql));

            throw;
        }
        catch (OutOfMemoryException ex)
        {
            // Critical condition - log and re-throw unchanged
            _logger.LogCritical(
                ex,
                "[{ErrorId}] Out of memory executing query - result set may be too large (Type: {ResultType})",
                ErrorIds.QueryOutOfMemory,
                typeof(T).Name);

            throw;
        }
        finally
        {
            // Explicitly close the connection if it was opened
            // This ensures connection is returned to pool even on error
            if (connection.State == ConnectionState.Open)
            {
                await connection.CloseAsync();
            }
        }
    }

    /// <summary>
    /// Executes a query and returns a single result or null.
    /// Throws if multiple rows would be returned.
    /// </summary>
    public async Task<T?> QuerySingleAsync<T>(string sql, object? param = null)
    {
        // Parameter validation
        if (string.IsNullOrWhiteSpace(sql))
            throw new ArgumentException($"[{ErrorIds.QueryInvalidParameter}] SQL query cannot be null or empty", nameof(sql));

        var connection = _dbContext.Database.GetDbConnection();

        try
        {
            _logger.LogDebug(
                "Executing Dapper single query on SECONDARY database (Type: {ResultType}): {Sql}",
                typeof(T).Name,
                TruncateSql(sql));

            return await connection.QuerySingleOrDefaultAsync<T>(sql, param);
        }
        catch (SqlException ex)
        {
            _logger.LogError(
                ex,
                "[{ErrorId}] SQL Server error executing single query on SECONDARY database (Type: {ResultType}, ErrorCode: {ErrorCode}): {Sql}",
                ErrorIds.SqlError,
                typeof(T).Name,
                ex.Number,
                TruncateSql(sql));

            var friendlyMessage = ErrorIds.GetFriendlySqlErrorMessage(ex.Number, ex.Message);
            throw new InvalidOperationException(
                $"[{ErrorIds.SqlError}] {friendlyMessage} (Code: {ex.Number})", ex);
        }
        catch (OperationCanceledException ex)
        {
            _logger.LogError(
                ex,
                "[{ErrorId}] Single query timeout for type {ResultType} on SECONDARY database",
                ErrorIds.QueryTimeout,
                typeof(T).Name);

            throw new InvalidOperationException(
                $"[{ErrorIds.QueryTimeout}] Query execution timed out. The database is responding slowly. Please try again.", ex);
        }
        catch (ArgumentException ex)
        {
            // This indicates a bug in SQL or parameter mapping - re-throw unchanged
            _logger.LogError(
                ex,
                "[{ErrorId}] Invalid query or parameters for type {ResultType}: {Sql}",
                ErrorIds.QueryInvalidParameter,
                typeof(T).Name,
                TruncateSql(sql));

            throw;
        }
        catch (OutOfMemoryException ex)
        {
            // Critical condition - log and re-throw unchanged
            _logger.LogCritical(
                ex,
                "[{ErrorId}] Out of memory executing single query - result set may be too large (Type: {ResultType})",
                ErrorIds.QueryOutOfMemory,
                typeof(T).Name);

            throw;
        }
        finally
        {
            // Explicitly close the connection if it was opened
            // This ensures connection is returned to pool even on error
            if (connection.State == ConnectionState.Open)
            {
                await connection.CloseAsync();
            }
        }
    }

    /// <summary>
    /// Truncates long SQL strings for logging.
    /// Prevents log spam while preserving enough context for debugging.
    /// </summary>
    private static string TruncateSql(string sql)
    {
        const int maxLength = 150;
        if (string.IsNullOrEmpty(sql))
            return string.Empty;

        return sql.Length > maxLength ? sql[..maxLength] + "..." : sql;
    }
}
