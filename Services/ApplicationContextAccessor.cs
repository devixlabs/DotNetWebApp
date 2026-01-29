namespace DotNetWebApp.Services;

public class ApplicationContextAccessor : IApplicationContextAccessor
{
    private static readonly HashSet<string> StaticPathPrefixes = new(StringComparer.OrdinalIgnoreCase)
    {
        "css", "js", "lib", "images", "_framework", "_blazor", "api"
    };

    private readonly IHttpContextAccessor _httpContextAccessor;
    private readonly IAppDictionaryService _appDictionary;
    private string? _cachedApplicationName;
    private bool _cacheInitialized;

    public ApplicationContextAccessor(
        IHttpContextAccessor httpContextAccessor,
        IAppDictionaryService appDictionary)
    {
        _httpContextAccessor = httpContextAccessor;
        _appDictionary = appDictionary;
    }

    public string? ApplicationName
    {
        get
        {
            if (_cacheInitialized)
                return _cachedApplicationName;

            var httpContext = _httpContextAccessor.HttpContext;
            if (httpContext == null)
            {
                _cachedApplicationName = null;
            }
            else
            {
                var path = httpContext.Request.Path.Value ?? "";
                _cachedApplicationName = ExtractApplicationNameFromPath(path);
            }

            _cacheInitialized = true;
            return _cachedApplicationName;
        }
    }

    private string? ExtractApplicationNameFromPath(string path)
    {
        var segments = path.TrimStart('/').Split('/', StringSplitOptions.RemoveEmptyEntries);

        if (segments.Length == 0)
            return null;

        var firstSegment = segments[0];

        if (StaticPathPrefixes.Contains(firstSegment))
            return null;

        var app = _appDictionary.GetApplication(firstSegment);
        return app?.Name;
    }
}
