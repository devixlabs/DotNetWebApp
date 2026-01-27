using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services.Views;

/// <summary>
/// Registry for SQL view definitions loaded from views.yaml.
/// Provides access to view metadata and SQL query text.
/// Singleton service, loaded once at application startup.
/// </summary>
public interface IViewRegistry
{
    /// <summary>
    /// Gets the SQL query text for a registered view.
    /// </summary>
    /// <param name="viewName">Name of the view (e.g., "ProductSalesView")</param>
    /// <returns>SQL query text loaded from the corresponding .sql file</returns>
    /// <exception cref="InvalidOperationException">Thrown if view not found or SQL file missing</exception>
    Task<string> GetViewSqlAsync(string viewName);

    /// <summary>
    /// Gets the view definition metadata (properties, parameters, etc.).
    /// </summary>
    /// <param name="viewName">Name of the view</param>
    /// <returns>View definition from views.yaml</returns>
    /// <exception cref="InvalidOperationException">Thrown if view not found</exception>
    ViewDefinition GetViewDefinition(string viewName);

    /// <summary>
    /// Gets all registered view names.
    /// </summary>
    /// <returns>Enumerable of view names</returns>
    IEnumerable<string> GetAllViewNames();
}
