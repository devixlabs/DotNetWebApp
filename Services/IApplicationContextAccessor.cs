namespace DotNetWebApp.Services;

public interface IApplicationContextAccessor
{
    /// <summary>
    /// Gets the current application name from the request path.
    /// Returns null if no valid application context is available.
    /// </summary>
    string? ApplicationName { get; }
}
