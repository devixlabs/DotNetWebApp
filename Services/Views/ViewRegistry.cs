using System.Collections.Concurrent;
using System.Security;
using DotNetWebApp.Constants;
using DotNetWebApp.Models.AppDictionary;
using Microsoft.Extensions.Logging;
using YamlDotNet.Core;
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
    private readonly IAppDictionaryService _appDictionary;

    /// <summary>
    /// Initializes a new instance of ViewRegistry.
    /// Loads and caches all view definitions from views.yaml.
    /// </summary>
    /// <param name="viewsYamlPath">Absolute path to views.yaml</param>
    /// <param name="logger">Logger instance</param>
    /// <param name="appDictionary">Application dictionary for app-scoped view filtering</param>
    /// <exception cref="FileNotFoundException">Thrown if views.yaml does not exist (fail fast)</exception>
    /// <exception cref="InvalidOperationException">Thrown if views.yaml is invalid or empty</exception>
    public ViewRegistry(string viewsYamlPath, ILogger<ViewRegistry> logger, IAppDictionaryService appDictionary)
    {
        _logger = logger;
        _appDictionary = appDictionary;
        _views = new Dictionary<string, ViewDefinition>(StringComparer.OrdinalIgnoreCase);
        _sqlCache = new ConcurrentDictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        _sqlBasePath = Path.GetDirectoryName(viewsYamlPath) ?? AppDomain.CurrentDomain.BaseDirectory;

        LoadViews(viewsYamlPath);
    }

    /// <summary>
    /// Loads all views from views.yaml file.
    /// Fails fast if file doesn't exist - this is a critical configuration file.
    /// </summary>
    /// <exception cref="FileNotFoundException">Thrown if views.yaml does not exist</exception>
    /// <exception cref="InvalidOperationException">Thrown if views.yaml is invalid or empty</exception>
    private void LoadViews(string yamlPath)
    {
        // Fail fast if views.yaml is missing - this is a critical configuration file
        if (!File.Exists(yamlPath))
        {
            var errorMessage =
                $"[{ErrorIds.ViewsYamlMissing}] views.yaml not found at {yamlPath}. " +
                "The view registry requires views.yaml to be present at application startup. " +
                "This is a critical configuration file. Check that:\n" +
                $"  1. views.yaml exists in the application root ({yamlPath})\n" +
                "  2. The file was included in the deployment\n" +
                "  3. File permissions allow reading the file";

            _logger.LogCritical("[{ErrorId}] {Message}", ErrorIds.ViewsYamlMissing, errorMessage);
            throw new FileNotFoundException(errorMessage, yamlPath);
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
                var errorMessage =
                    $"[{ErrorIds.ViewsYamlEmpty}] No views found in {yamlPath}. " +
                    "The views.yaml file is empty or has no 'views' section. " +
                    "At least one view must be defined.";

                _logger.LogError("[{ErrorId}] {Message}", ErrorIds.ViewsYamlEmpty, errorMessage);
                throw new InvalidOperationException(errorMessage);
            }

            foreach (var view in viewDef.Views)
            {
                // Validate view name
                if (string.IsNullOrWhiteSpace(view.Name))
                {
                    var errorMessage = $"[{ErrorIds.ViewNameInvalid}] View name cannot be empty in views.yaml";
                    _logger.LogError("[{ErrorId}] {Message}", ErrorIds.ViewNameInvalid, errorMessage);
                    throw new InvalidOperationException(errorMessage);
                }

                // Validate sql_file
                if (string.IsNullOrWhiteSpace(view.SqlFile))
                {
                    var errorMessage = $"[{ErrorIds.ViewSqlFileInvalid}] View '{view.Name}' has empty sql_file in views.yaml";
                    _logger.LogError("[{ErrorId}] {Message}", ErrorIds.ViewSqlFileInvalid, errorMessage);
                    throw new InvalidOperationException(errorMessage);
                }

                _views[view.Name] = view;
                _logger.LogDebug("Registered view: {ViewName} (SQL: {SqlFile})", view.Name, view.SqlFile);
            }

            _logger.LogInformation("Loaded {Count} views into registry", _views.Count);
        }
        catch (YamlException ex)
        {
            var errorMessage =
                $"[{ErrorIds.ViewsYamlParseError}] Failed to parse views.yaml at {yamlPath}: {ex.Message}";

            _logger.LogError(ex, "[{ErrorId}] {Message}", ErrorIds.ViewsYamlParseError, errorMessage);
            throw new InvalidOperationException(errorMessage, ex);
        }
        catch (UnauthorizedAccessException ex)
        {
            var errorMessage =
                $"[{ErrorIds.SqlFilePermissionDenied}] Permission denied reading views.yaml at {yamlPath}. " +
                "Check file permissions.";

            _logger.LogError(ex, "[{ErrorId}] {Message}", ErrorIds.SqlFilePermissionDenied, errorMessage);
            throw new UnauthorizedAccessException(errorMessage, ex);
        }
        catch (IOException ex)
        {
            var errorMessage =
                $"[{ErrorIds.SqlFileReadError}] I/O error reading views.yaml at {yamlPath}: {ex.Message}";

            _logger.LogError(ex, "[{ErrorId}] {Message}", ErrorIds.SqlFileReadError, errorMessage);
            throw new InvalidOperationException(errorMessage, ex);
        }
    }

    /// <summary>
    /// Gets the SQL query for a registered view.
    /// Caches SQL content to avoid repeated file I/O.
    /// </summary>
    /// <exception cref="InvalidOperationException">Thrown if view is not registered</exception>
    /// <exception cref="FileNotFoundException">Thrown if SQL file does not exist</exception>
    /// <exception cref="UnauthorizedAccessException">Thrown if permission denied on SQL file</exception>
    public async Task<string> GetViewSqlAsync(string viewName)
    {
        // Parameter validation
        if (string.IsNullOrWhiteSpace(viewName))
            throw new ArgumentException($"[{ErrorIds.ViewNotFound}] View name cannot be null or empty", nameof(viewName));

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
            var errorMessage =
                $"[{ErrorIds.ViewNotFound}] View '{viewName}' not found in registry. Registered views: {registeredViews}";

            _logger.LogError("[{ErrorId}] {Message}", ErrorIds.ViewNotFound, errorMessage);
            throw new InvalidOperationException(errorMessage);
        }

        // Resolve SQL file path (relative to views.yaml location)
        var sqlPath = Path.IsPathRooted(view.SqlFile)
            ? view.SqlFile
            : Path.Combine(_sqlBasePath, view.SqlFile);

        if (!File.Exists(sqlPath))
        {
            var errorMessage =
                $"[{ErrorIds.SqlFileNotFound}] SQL file for view '{viewName}' not found at {sqlPath}. " +
                "Check that all SQL files referenced in views.yaml exist in the sql/views/ directory.";

            _logger.LogError("[{ErrorId}] {Message}", ErrorIds.SqlFileNotFound, errorMessage);
            throw new FileNotFoundException(errorMessage, sqlPath);
        }

        try
        {
            var sql = await File.ReadAllTextAsync(sqlPath);
            _sqlCache.TryAdd(viewName, sql);
            _logger.LogDebug("Loaded SQL for view {ViewName} from {SqlPath}", viewName, sqlPath);
            return sql;
        }
        catch (FileNotFoundException ex)
        {
            // File was deleted between existence check and read (race condition)
            var errorMessage =
                $"[{ErrorIds.SqlFileNotFound}] SQL file for view '{viewName}' was not found at {sqlPath}. " +
                "The file may have been deleted or moved. Check sql/views/ directory.";

            _logger.LogError(
                ex,
                "[{ErrorId}] SQL file was deleted between existence check and read for view {ViewName}: {SqlPath}",
                ErrorIds.SqlFileNotFound,
                viewName,
                sqlPath);

            throw new FileNotFoundException(errorMessage, sqlPath, ex);
        }
        catch (UnauthorizedAccessException ex)
        {
            var errorMessage =
                $"[{ErrorIds.SqlFilePermissionDenied}] Cannot read SQL file for view '{viewName}' at {sqlPath}. " +
                "Check file permissions. The application process needs read permissions on all SQL files.";

            _logger.LogError(
                ex,
                "[{ErrorId}] Access denied reading SQL file for view {ViewName}: {SqlPath}",
                ErrorIds.SqlFilePermissionDenied,
                viewName,
                sqlPath);

            throw new UnauthorizedAccessException(errorMessage, ex);
        }
        catch (DirectoryNotFoundException ex)
        {
            var errorMessage =
                $"[{ErrorIds.SqlFilePathInvalid}] SQL file path for view '{viewName}' is invalid: {sqlPath}. " +
                "The directory does not exist. Check the sql_file path in views.yaml.";

            _logger.LogError(
                ex,
                "[{ErrorId}] SQL file path directory does not exist for view {ViewName}: {SqlPath}",
                ErrorIds.SqlFilePathInvalid,
                viewName,
                sqlPath);

            throw new InvalidOperationException(errorMessage, ex);
        }
        catch (IOException ex) when (ex.Message.Contains("disk", StringComparison.OrdinalIgnoreCase))
        {
            var errorMessage =
                $"[{ErrorIds.SqlFileDiskError}] Disk error reading SQL file for view '{viewName}'. The disk may be full.";

            _logger.LogCritical(
                ex,
                "[{ErrorId}] Disk error reading SQL file for view {ViewName}",
                ErrorIds.SqlFileDiskError,
                viewName);

            throw new InvalidOperationException(errorMessage, ex);
        }
        catch (OutOfMemoryException ex)
        {
            var errorMessage =
                $"[{ErrorIds.SqlFileTooLarge}] SQL file for view '{viewName}' is too large to load into memory. " +
                "SQL files must be under available heap memory.";

            _logger.LogCritical(
                ex,
                "[{ErrorId}] Out of memory reading SQL file for view {ViewName}. File may be too large: {SqlPath}",
                ErrorIds.SqlFileTooLarge,
                viewName,
                sqlPath);

            throw new InvalidOperationException(errorMessage, ex);
        }
        catch (IOException ex)
        {
            var errorMessage =
                $"[{ErrorIds.SqlFileReadError}] I/O error reading SQL file for view '{viewName}': {ex.Message}";

            _logger.LogError(
                ex,
                "[{ErrorId}] I/O error reading SQL file for view {ViewName}: {SqlPath}",
                ErrorIds.SqlFileReadError,
                viewName,
                sqlPath);

            throw new InvalidOperationException(errorMessage, ex);
        }
    }

    /// <summary>
    /// Gets the view definition metadata.
    /// </summary>
    /// <exception cref="InvalidOperationException">Thrown if view is not registered</exception>
    public ViewDefinition GetViewDefinition(string viewName)
    {
        // Parameter validation
        if (string.IsNullOrWhiteSpace(viewName))
            throw new ArgumentException($"[{ErrorIds.ViewNotFound}] View name cannot be null or empty", nameof(viewName));

        if (!_views.TryGetValue(viewName, out var view))
        {
            var errorMessage = $"[{ErrorIds.ViewNotFound}] View '{viewName}' not found in registry";
            _logger.LogError("[{ErrorId}] {Message}", ErrorIds.ViewNotFound, errorMessage);
            throw new InvalidOperationException(errorMessage);
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

    /// <summary>
    /// Gets all view definitions visible in a specific application.
    /// </summary>
    /// <param name="appName">Name of the application (e.g., "admin", "reporting")</param>
    /// <returns>View definitions that the app is allowed to access</returns>
    public IReadOnlyList<ViewDefinition> GetViewsForApplication(string appName)
    {
        var app = _appDictionary.GetApplication(appName);
        if (app == null)
            return Array.Empty<ViewDefinition>();

        if (app.Views.Count == 0)
            return Array.Empty<ViewDefinition>();

        return _views.Values
            .Where(v => app.Views.Contains(v.Name, StringComparer.OrdinalIgnoreCase))
            .ToList()
            .AsReadOnly();
    }

    /// <summary>
    /// Checks if a view is visible/accessible within a specific application.
    /// </summary>
    /// <param name="viewName">Name of the view</param>
    /// <param name="appName">Name of the application</param>
    /// <returns>True if the view is visible in the app; false otherwise</returns>
    public bool IsViewVisibleInApplication(string viewName, string appName)
    {
        if (string.IsNullOrWhiteSpace(viewName) || string.IsNullOrWhiteSpace(appName))
            return false;

        var app = _appDictionary.GetApplication(appName);
        if (app == null || app.Views.Count == 0)
            return false;

        return app.Views.Contains(viewName, StringComparer.OrdinalIgnoreCase);
    }
}
