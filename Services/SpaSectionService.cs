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
    private readonly IAppDictionaryService _appDictionary;
    private readonly IEntityMetadataService _entityMetadataService;
    private readonly IOptions<AppCustomizationOptions> _options;

    public SpaSectionService(
        NavigationManager navigationManager,
        IOptions<AppCustomizationOptions> options,
        IAppDictionaryService appDictionary,
        IEntityMetadataService entityMetadataService)
    {
        _navigationManager = navigationManager;
        _appDictionary = appDictionary;
        _entityMetadataService = entityMetadataService;
        _options = options;

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

                var routeSegment = EntityNameFormatter.BuildUrlPath(entity.Schema, entity.Name);
                var entityName = EntityNameFormatter.BuildQualifiedName(entity.Schema, entity.Name);

                var label = string.IsNullOrWhiteSpace(entity.Schema)
                    ? entity.Name
                    : $"{entity.Name} ({entity.Schema})";
                sections.Add(new(SpaSection.Entity, label, label, routeSegment, entityName));
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

    public IReadOnlyList<SpaSectionInfo> GetSectionsForApplication(string appName)
    {
        var sections = new List<SpaSectionInfo>();

        // Get application to read per-app SPA section labels
        var app = _appDictionary.GetApplication(appName);
        var appSpaSections = app?.SpaSections;

        // Get global fallback labels from options
        var globalLabels = _options.Value.SpaSections;

        // Use app-specific labels if available, otherwise fall back to global config
        var dashboardNav = appSpaSections?.DashboardNav ?? globalLabels.DashboardNav;
        var dashboardTitle = appSpaSections?.DashboardTitle ?? globalLabels.DashboardTitle;
        var settingsNav = appSpaSections?.SettingsNav ?? globalLabels.SettingsNav;
        var settingsTitle = appSpaSections?.SettingsTitle ?? globalLabels.SettingsTitle;

        // Dashboard section (always present)
        sections.Add(new SpaSectionInfo(
            Section: SpaSection.Dashboard,
            NavLabel: dashboardNav,
            Title: dashboardTitle,
            RouteSegment: "dashboard"));

        // Entity sections filtered by app
        var entities = _entityMetadataService.GetEntitiesForApplication(appName);
        foreach (var entity in entities)
        {
            sections.Add(new SpaSectionInfo(
                Section: SpaSection.Entity,
                NavLabel: entity.Definition.Name,
                Title: entity.Definition.Name,
                RouteSegment: EntityNameFormatter.BuildUrlPath(entity),
                EntityName: EntityNameFormatter.BuildQualifiedName(entity)));
        }

        // Settings section (only if app has entities)
        if (app?.Entities.Any() == true)
        {
            sections.Add(new SpaSectionInfo(
                Section: SpaSection.Settings,
                NavLabel: settingsNav,
                Title: settingsTitle,
                RouteSegment: "settings"));
        }

        return sections.AsReadOnly();
    }

}
