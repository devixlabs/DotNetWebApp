using System.Collections.Generic;
using System.Linq;
using DotNetWebApp.Models.AppDictionary;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace YamlMerger;

/// <summary>
/// Service for merging views.yaml content into data.yaml AppDefinition structure.
/// Handles YAML serialization with proper naming conventions.
/// Populates application-level view visibility based on view definitions.
/// </summary>
public class YamlMergeService
{
    /// <summary>
    /// Populates application views arrays based on view definitions.
    /// For each view that lists an application, adds the view name to that app's views array.
    /// </summary>
    public void PopulateApplicationViews(AppDefinition appDefinition)
    {
        if (appDefinition?.Views?.Views == null || appDefinition.Views.Views.Count == 0)
            return;

        if (appDefinition?.Applications == null || appDefinition.Applications.Count == 0)
            return;

        // Initialize empty views arrays for all applications
        foreach (var app in appDefinition.Applications)
        {
            if (app.Views == null)
                app.Views = new();
        }

        // Populate views arrays based on view definitions
        foreach (var view in appDefinition.Views.Views)
        {
            if (view.Applications == null || view.Applications.Count == 0)
                continue;

            foreach (var appName in view.Applications)
            {
                var app = appDefinition.Applications.FirstOrDefault(a =>
                    string.Equals(a.Name, appName, StringComparison.OrdinalIgnoreCase));

                if (app != null && !app.Views.Contains(view.Name, StringComparer.OrdinalIgnoreCase))
                {
                    app.Views.Add(view.Name);
                }
            }
        }
    }

    /// <summary>
    /// Serializes AppDefinition to YAML using camelCase convention (for app.yaml format).
    /// </summary>
    public string SerializeAppDefinition(AppDefinition appDefinition)
    {
        var serializer = new SerializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        return serializer.Serialize(appDefinition);
    }
}
