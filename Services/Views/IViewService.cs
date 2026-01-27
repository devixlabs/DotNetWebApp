namespace DotNetWebApp.Services.Views;

/// <summary>
/// Service for executing registered SQL views with Dapper.
/// Bridges IViewRegistry (view metadata and SQL) with IDapperQueryService (SQL execution).
/// Scoped service: one instance per HTTP request.
/// </summary>
public interface IViewService
{
    /// <summary>
    /// Executes a registered view and returns multiple results.
    /// Retrieves SQL from IViewRegistry and executes with IDapperQueryService.
    /// </summary>
    /// <typeparam name="T">View model type (should match generated view model class)</typeparam>
    /// <param name="viewName">Name of the registered view (e.g., "ProductSalesView")</param>
    /// <param name="parameters">Query parameters (optional, can be anonymous object or DynamicParameters)</param>
    /// <returns>Enumerable of view model instances</returns>
    /// <exception cref="InvalidOperationException">Thrown if view not found or execution fails</exception>
    Task<IEnumerable<T>> ExecuteViewAsync<T>(string viewName, object? parameters = null);

    /// <summary>
    /// Executes a registered view and returns a single result or null.
    /// Useful for scalar queries or single-row views.
    /// </summary>
    /// <typeparam name="T">View model type</typeparam>
    /// <param name="viewName">Name of the registered view</param>
    /// <param name="parameters">Query parameters (optional)</param>
    /// <returns>Single view model instance or null if no rows found</returns>
    /// <exception cref="InvalidOperationException">Thrown if view not found or execution fails</exception>
    Task<T?> ExecuteViewSingleAsync<T>(string viewName, object? parameters = null);
}
