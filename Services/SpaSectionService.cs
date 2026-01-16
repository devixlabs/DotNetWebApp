using DotNetWebApp.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.Extensions.Options;

namespace DotNetWebApp.Services;

public sealed class SpaSectionService : ISpaSectionService
{
    private readonly NavigationManager _navigationManager;
    private readonly IReadOnlyList<SpaSectionInfo> _sections;
    private readonly Dictionary<SpaSection, SpaSectionInfo> _bySection;
    private readonly Dictionary<string, SpaSection> _byRouteSegment;

    public SpaSectionService(NavigationManager navigationManager, IOptions<AppCustomizationOptions> options)
    {
        _navigationManager = navigationManager;

        var labels = options.Value.SpaSections;
        _sections = new List<SpaSectionInfo>
        {
            new(SpaSection.Dashboard, labels.DashboardNav, labels.DashboardTitle, "dashboard"),
            new(SpaSection.Products, labels.ProductsNav, labels.ProductsTitle, "products"),
            new(SpaSection.Settings, labels.SettingsNav, labels.SettingsTitle, "settings")
        };

        _bySection = _sections.ToDictionary(section => section.Section);
        _byRouteSegment = _sections.ToDictionary(section => section.RouteSegment, section => section.Section, StringComparer.OrdinalIgnoreCase);
    }

    public SpaSection DefaultSection => SpaSection.Dashboard;
    public IReadOnlyList<SpaSectionInfo> Sections => _sections;

    public SpaSection? FromUri(string uri)
    {
        var relativePath = _navigationManager.ToBaseRelativePath(uri);
        if (string.IsNullOrWhiteSpace(relativePath))
        {
            return null;
        }

        var path = relativePath.Split('?', '#')[0].Trim('/');
        if (string.Equals(path, "app", StringComparison.OrdinalIgnoreCase))
        {
            return DefaultSection;
        }

        if (path.StartsWith("app/", StringComparison.OrdinalIgnoreCase))
        {
            var segment = path["app/".Length..];
            return FromRouteSegment(segment);
        }

        return null;
    }

    public SpaSection? FromRouteSegment(string? segment)
    {
        if (string.IsNullOrWhiteSpace(segment))
        {
            return null;
        }

        return _byRouteSegment.TryGetValue(segment, out var section) ? section : null;
    }

    public SpaSectionInfo GetInfo(SpaSection section)
    {
        return _bySection[section];
    }

    public void NavigateTo(SpaSection section, bool replace = true)
    {
        var routeSegment = _bySection[section].RouteSegment;
        var path = section == DefaultSection ? "app" : $"app/{routeSegment}";
        _navigationManager.NavigateTo(path, replace: replace);
    }
}
