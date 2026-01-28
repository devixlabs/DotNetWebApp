using DotNetWebApp.Constants;
using DotNetWebApp.Data.Dapper;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Services.Views;

/// <summary>
/// Service that executes SQL views via Dapper using the view registry.
/// Coordinates IViewRegistry (metadata/SQL) and IDapperQueryService (execution).
/// Scoped service: one instance per HTTP request.
/// </summary>
public class ViewService : IViewService
{
    private readonly IDapperQueryService _dapper;
    private readonly IViewRegistry _registry;
    private readonly ILogger<ViewService> _logger;

    /// <summary>
    /// Initializes a new instance of ViewService.
    /// </summary>
    /// <param name="dapper">Dapper query service for SQL execution</param>
    /// <param name="registry">View registry for metadata and SQL retrieval</param>
    /// <param name="logger">Logger instance</param>
    public ViewService(
        IDapperQueryService dapper,
        IViewRegistry registry,
        ILogger<ViewService> logger)
    {
        _dapper = dapper ?? throw new ArgumentNullException(nameof(dapper));
        _registry = registry ?? throw new ArgumentNullException(nameof(registry));
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }

    /// <summary>
    /// Executes a registered view and returns multiple results.
    /// Registry errors (view not found, SQL file missing) propagate directly.
    /// Only Dapper execution errors are caught and logged at this level.
    /// </summary>
    /// <exception cref="ArgumentException">Thrown if viewName is null or empty</exception>
    /// <exception cref="InvalidOperationException">Thrown if view not found or query execution fails</exception>
    /// <exception cref="FileNotFoundException">Thrown if SQL file is missing</exception>
    /// <exception cref="UnauthorizedAccessException">Thrown if permission denied on SQL file</exception>
    public async Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null)
    {
        // Parameter validation
        if (string.IsNullOrWhiteSpace(viewName))
            throw new ArgumentException($"[{ErrorIds.ViewNotFound}] View name cannot be null or empty", nameof(viewName));

        // Let registry errors propagate directly - they have specific, actionable error messages
        // These include: view not found, SQL file missing, permission denied, etc.
        var sql = await _registry.GetViewSqlAsync(viewName);

        try
        {
            _logger.LogInformation(
                "Executing view: {ViewName} (Type: {ResultType})",
                viewName,
                typeof(T).Name);

            return await _dapper.QueryAsync<T>(sql, parameters);
        }
        catch (InvalidOperationException ex) when (ex.Message.Contains(ErrorIds.SqlError) ||
                                                    ex.Message.Contains(ErrorIds.QueryTimeout) ||
                                                    ex.Message.Contains("Query execution"))
        {
            // DapperQueryService already wrapped and logged the SQL execution error
            // Just log at this level and re-throw - don't double-wrap
            _logger.LogError(
                ex,
                "[{ErrorId}] View execution failed: {ViewName} (Type: {ResultType})",
                ErrorIds.ViewExecutionFailed,
                viewName,
                typeof(T).Name);

            throw;
        }
        catch (ArgumentException ex)
        {
            // Invalid parameters - re-throw unchanged
            _logger.LogError(
                ex,
                "[{ErrorId}] Invalid parameters for view {ViewName}",
                ErrorIds.QueryInvalidParameter,
                viewName);

            throw;
        }
        catch (OutOfMemoryException ex)
        {
            // Critical condition - log and re-throw unchanged
            _logger.LogCritical(
                ex,
                "[{ErrorId}] Out of memory executing view {ViewName}",
                ErrorIds.QueryOutOfMemory,
                viewName);

            throw;
        }
        catch (Exception ex)
        {
            // Unexpected errors - log as critical and re-throw unchanged
            // Don't wrap - caller needs to know this is an unexpected error type
            _logger.LogCritical(
                ex,
                "[{ErrorId}] Unexpected error executing view {ViewName} (Type: {ResultType})",
                ErrorIds.ViewExecutionFailed,
                viewName,
                typeof(T).Name);

            throw;
        }
    }

    /// <summary>
    /// Executes a registered view and returns a single result or null.
    /// Registry errors (view not found, SQL file missing) propagate directly.
    /// Only Dapper execution errors are caught and logged at this level.
    /// </summary>
    /// <exception cref="ArgumentException">Thrown if viewName is null or empty</exception>
    /// <exception cref="InvalidOperationException">Thrown if view not found or query execution fails</exception>
    /// <exception cref="FileNotFoundException">Thrown if SQL file is missing</exception>
    /// <exception cref="UnauthorizedAccessException">Thrown if permission denied on SQL file</exception>
    public async Task<T?> ExecuteViewSingleAsync<T>(string viewName, object? parameters = null)
    {
        // Parameter validation
        if (string.IsNullOrWhiteSpace(viewName))
            throw new ArgumentException($"[{ErrorIds.ViewNotFound}] View name cannot be null or empty", nameof(viewName));

        // Let registry errors propagate directly - they have specific, actionable error messages
        var sql = await _registry.GetViewSqlAsync(viewName);

        try
        {
            _logger.LogInformation(
                "Executing view (single): {ViewName} (Type: {ResultType})",
                viewName,
                typeof(T).Name);

            return await _dapper.QuerySingleAsync<T>(sql, parameters);
        }
        catch (InvalidOperationException ex) when (ex.Message.Contains(ErrorIds.SqlError) ||
                                                    ex.Message.Contains(ErrorIds.QueryTimeout) ||
                                                    ex.Message.Contains("Single query execution"))
        {
            // DapperQueryService already wrapped and logged the SQL execution error
            // Just log at this level and re-throw - don't double-wrap
            _logger.LogError(
                ex,
                "[{ErrorId}] Single view execution failed: {ViewName} (Type: {ResultType})",
                ErrorIds.ViewExecutionFailed,
                viewName,
                typeof(T).Name);

            throw;
        }
        catch (ArgumentException ex)
        {
            // Invalid parameters - re-throw unchanged
            _logger.LogError(
                ex,
                "[{ErrorId}] Invalid parameters for view (single) {ViewName}",
                ErrorIds.QueryInvalidParameter,
                viewName);

            throw;
        }
        catch (OutOfMemoryException ex)
        {
            // Critical condition - log and re-throw unchanged
            _logger.LogCritical(
                ex,
                "[{ErrorId}] Out of memory executing view (single) {ViewName}",
                ErrorIds.QueryOutOfMemory,
                viewName);

            throw;
        }
        catch (Exception ex)
        {
            // Unexpected errors - log as critical and re-throw unchanged
            _logger.LogCritical(
                ex,
                "[{ErrorId}] Unexpected error executing view (single) {ViewName} (Type: {ResultType})",
                ErrorIds.ViewExecutionFailed,
                viewName,
                typeof(T).Name);

            throw;
        }
    }
}
