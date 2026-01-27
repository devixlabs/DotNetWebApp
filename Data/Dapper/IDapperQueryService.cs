namespace DotNetWebApp.Data.Dapper;

/// <summary>
/// Read-only Dapper query service for executing complex SQL queries.
/// Provides an abstraction for raw SQL queries while sharing EF Core's database connection.
/// Automatically inherits tenant schema from EF Core's Finbuckle.MultiTenant configuration.
/// </summary>
public interface IDapperQueryService
{
    /// <summary>
    /// Executes a SQL query and returns multiple results.
    /// Supports parameterized queries to prevent SQL injection.
    /// </summary>
    /// <typeparam name="T">Type to map query results to</typeparam>
    /// <param name="sql">SQL query text</param>
    /// <param name="param">Query parameters (can be anonymous object or DynamicParameters)</param>
    /// <returns>Enumerable of results</returns>
    /// <exception cref="InvalidOperationException">Thrown if query execution fails</exception>
    Task<IEnumerable<T>> QueryAsync<T>(string sql, object? param = null);

    /// <summary>
    /// Executes a SQL query and returns a single result or null.
    /// Useful for aggregate queries or lookups by ID.
    /// </summary>
    /// <typeparam name="T">Type to map query result to</typeparam>
    /// <param name="sql">SQL query text</param>
    /// <param name="param">Query parameters (can be anonymous object or DynamicParameters)</param>
    /// <returns>Single result or null if no rows found</returns>
    /// <exception cref="InvalidOperationException">Thrown if query execution fails or multiple rows returned</exception>
    Task<T?> QuerySingleAsync<T>(string sql, object? param = null);
}
