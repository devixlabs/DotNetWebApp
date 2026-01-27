using Dapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Data.Dapper;

/// <summary>
/// Read-only Dapper service that shares EF Core's database connection.
/// Automatically inherits tenant schema from EF Core context.
/// Provides raw SQL query execution while maintaining connection pooling and multi-tenancy support.
/// </summary>
public class DapperQueryService : IDapperQueryService
{
    private readonly AppDbContext _dbContext;
    private readonly ILogger<DapperQueryService> _logger;

    /// <summary>
    /// Initializes a new instance of DapperQueryService.
    /// Uses the AppDbContext's connection for all queries.
    /// </summary>
    /// <param name="dbContext">EF Core database context</param>
    /// <param name="logger">Logger instance</param>
    public DapperQueryService(AppDbContext dbContext, ILogger<DapperQueryService> logger)
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
        catch (Exception ex)
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

    /// <summary>
    /// Executes a query and returns a single result or null.
    /// Throws if multiple rows would be returned.
    /// </summary>
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
        catch (Exception ex)
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
