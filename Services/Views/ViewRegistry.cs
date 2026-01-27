using System.Collections.Concurrent;
using DotNetWebApp.Models.AppDictionary;
using Microsoft.Extensions.Logging;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace DotNetWebApp.Services.Views;

/// <summary>
/// Singleton service that loads and caches SQL view definitions from views.yaml.
/// Resolves SQL file paths relative to views.yaml location.
/// Automatically caches SQL content to avoid repeated disk I/O.
/// </summary>
public class ViewRegistry : IViewRegistry
{
    private readonly Dictionary<string, ViewDefinition> _views;
    private readonly ConcurrentDictionary<string, string> _sqlCache;
    private readonly string _sqlBasePath;
    private readonly ILogger<ViewRegistry> _logger;

    /// <summary>
    /// Initializes a new instance of ViewRegistry.
    /// Loads and caches all view definitions from views.yaml.
    /// </summary>
    /// <param name="viewsYamlPath">Absolute path to views.yaml</param>
    /// <param name="logger">Logger instance</param>
    public ViewRegistry(string viewsYamlPath, ILogger<ViewRegistry> logger)
    {
        _logger = logger;
        _views = new Dictionary<string, ViewDefinition>(StringComparer.OrdinalIgnoreCase);
        _sqlCache = new ConcurrentDictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        _sqlBasePath = Path.GetDirectoryName(viewsYamlPath) ?? AppDomain.CurrentDomain.BaseDirectory;

        LoadViews(viewsYamlPath);
    }

    /// <summary>
    /// Loads all views from views.yaml file.
    /// Logs warnings if file doesn't exist but continues gracefully.
    /// </summary>
    private void LoadViews(string yamlPath)
    {
        if (!File.Exists(yamlPath))
        {
            _logger.LogWarning("views.yaml not found at {Path}. No views registered.", yamlPath);
            return;
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
                return;
            }

            foreach (var view in viewDef.Views)
            {
                _views[view.Name] = view;
                _logger.LogDebug("Registered view: {ViewName} (SQL: {SqlFile})", view.Name, view.SqlFile);
            }

            _logger.LogInformation("Loaded {Count} views into registry", _views.Count);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to load views from {Path}", yamlPath);
            throw;
        }
    }

    /// <summary>
    /// Gets the SQL query for a registered view.
    /// Caches SQL content to avoid repeated file I/O.
    /// </summary>
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
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to load SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
            throw new InvalidOperationException(
                $"Failed to load SQL for view '{viewName}': {ex.Message}", ex);
        }
    }

    /// <summary>
    /// Gets the view definition metadata.
    /// </summary>
    public ViewDefinition GetViewDefinition(string viewName)
    {
        if (!_views.TryGetValue(viewName, out var view))
        {
            throw new InvalidOperationException(
                $"View '{viewName}' not found in registry");
        }

        return view;
    }

    /// <summary>
    /// Gets all registered view names.
    /// </summary>
    public IEnumerable<string> GetAllViewNames()
    {
        return _views.Keys;
    }
}
