using DotNetWebApp.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.Extensions.Options;

namespace DotNetWebApp.Services;

public sealed class SpaSectionService : ISpaSectionService
{
    private readonly NavigationManager _navigationManager;
    private readonly IReadOnlyList<SpaSectionInfo> _sections;
    private readonly Dictionary<SpaSection, SpaSectionInfo> _staticSections;
    private readonly Dictionary<string, SpaSectionInfo> _byRouteSegment;

    public SpaSectionService(
        NavigationManager navigationManager,
        IOptions<AppCustomizationOptions> options,
        IAppDictionaryService appDictionary)
    {
        _navigationManager = navigationManager;

        var labels = options.Value.SpaSections;
        var sections = new List<SpaSectionInfo>();

        if (options.Value.EnableSpaExample)
        {
            sections.Add(new(SpaSection.Dashboard, labels.DashboardNav, labels.DashboardTitle, "dashboard"));

            foreach (var entity in appDictionary.AppDefinition.DataModel.Entities)
            {
                if (string.IsNullOrWhiteSpace(entity.Name))
                {
                    continue;
                }

                var label = entity.Name;
                sections.Add(new(SpaSection.Entity, label, label, entity.Name, entity.Name));
            }

            sections.Add(new(SpaSection.Settings, labels.SettingsNav, labels.SettingsTitle, "settings"));
        }

        _sections = sections;
        _staticSections = sections
            .Where(section => section.Section != SpaSection.Entity)
            .ToDictionary(section => section.Section);
        _byRouteSegment = sections.ToDictionary(section => section.RouteSegment, StringComparer.OrdinalIgnoreCase);
    }

    public SpaSectionInfo? DefaultSection => _sections.FirstOrDefault();
    public IReadOnlyList<SpaSectionInfo> Sections => _sections;

    public SpaSectionInfo? FromUri(string uri)
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

    public SpaSectionInfo? FromRouteSegment(string? segment)
    {
        if (string.IsNullOrWhiteSpace(segment))
        {
            return null;
        }

        return _byRouteSegment.TryGetValue(segment, out var section) ? section : null;
    }

    public SpaSectionInfo? GetInfo(SpaSection section)
    {
        return _staticSections.TryGetValue(section, out var info) ? info : null;
    }

    public void NavigateTo(SpaSectionInfo section, bool replace = true)
    {
        var path = DefaultSection != null && section == DefaultSection
            ? "app"
            : $"app/{section.RouteSegment}";
        _navigationManager.NavigateTo(path, replace: replace);
    }
}
