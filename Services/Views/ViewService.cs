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
    /// </summary>
    public async Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null)
    {
        try
        {
            var sql = await _registry.GetViewSqlAsync(viewName);
            _logger.LogInformation(
                "Executing view: {ViewName} (Type: {ResultType})",
                viewName,
                typeof(T).Name);

            return await _dapper.QueryAsync<T>(sql, parameters);
        }
        catch (Exception ex)
        {
            _logger.LogError(
                ex,
                "Failed to execute view: {ViewName} (Type: {ResultType})",
                viewName,
                typeof(T).Name);

            throw new InvalidOperationException(
                $"Failed to execute view '{viewName}': {ex.Message}", ex);
        }
    }

    /// <summary>
    /// Executes a registered view and returns a single result or null.
    /// </summary>
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
        catch (Exception ex)
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
}
