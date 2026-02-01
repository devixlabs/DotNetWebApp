using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.Json;
using System.Text.Json.Serialization;
using DotNetWebApp.Models.AppDictionary;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;
using YamlMerger;

if (args.Length < 2)
{
    Console.WriteLine("Usage: YamlMerger <data.yaml> <appsettings.json>");
    Console.WriteLine("Merges view definitions from appsettings.json into data.yaml");
    Environment.Exit(1);
}

var dataYamlPath = args[0];
var appSettingsPath = args[1];

try
{
    // Convert to absolute paths for robustness
    var dataYamlAbsPath = Path.GetFullPath(dataYamlPath);
    var appSettingsAbsPath = Path.GetFullPath(appSettingsPath);

    // Validate input files exist
    if (!File.Exists(dataYamlAbsPath))
    {
        Console.Error.WriteLine($"Error: data.yaml not found: {dataYamlAbsPath}");
        Environment.Exit(1);
    }

    if (!File.Exists(appSettingsAbsPath))
    {
        Console.Error.WriteLine($"Error: appsettings.json not found: {appSettingsAbsPath}");
        Environment.Exit(1);
    }

    Console.WriteLine($"Reading data.yaml from: {dataYamlAbsPath}");
    var dataYamlContent = File.ReadAllText(dataYamlAbsPath);

    // Deserialize data.yaml with camelCase convention
    var dataDeserializer = new DeserializerBuilder()
        .WithNamingConvention(CamelCaseNamingConvention.Instance)
        .Build();

    var dataDefinition = dataDeserializer.Deserialize<AppDefinition>(dataYamlContent)
        ?? throw new InvalidOperationException("Failed to deserialize data.yaml");

    Console.WriteLine($"Reading appsettings.json from: {appSettingsAbsPath}");
    var appSettingsContent = File.ReadAllText(appSettingsAbsPath);

    // Deserialize appsettings.json using System.Text.Json (native JSON support)
    // This properly handles camelCase property names in JSON (sqlFile, name, etc.)
    var jsonOptions = new JsonSerializerOptions
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        PropertyNameCaseInsensitive = true
    };

    var appSettingsObj = JsonSerializer.Deserialize<AppSettingsRoot>(appSettingsContent, jsonOptions)
        ?? throw new InvalidOperationException("Failed to deserialize appsettings.json");

    if (appSettingsObj?.ViewDefinitions == null || appSettingsObj.ViewDefinitions.Count == 0)
    {
        Console.WriteLine("Warning: No view definitions found in appsettings.json");
        var emptyMerger = new YamlMergeService();
        emptyMerger.PopulateApplicationViews(dataDefinition);
        var emptyMergedYaml = emptyMerger.SerializeAppDefinition(dataDefinition);
        File.WriteAllText(dataYamlAbsPath, emptyMergedYaml);
        Console.WriteLine("Merged 0 view(s) into data.yaml");
        Environment.Exit(0);
    }

    Console.WriteLine($"Found {appSettingsObj.ViewDefinitions.Count} view definition(s) in appsettings.json");

    // Convert appSettings ViewDefinitions to ViewsDefinition format
    var viewsDefinition = new ViewsDefinition
    {
        Views = appSettingsObj.ViewDefinitions
    };

    // Merge views into data.yaml
    dataDefinition.Views = viewsDefinition;

    // Populate application-level view visibility based on view definitions
    var mergeService = new YamlMergeService();
    mergeService.PopulateApplicationViews(dataDefinition);

    // Serialize merged data back to data.yaml using camelCase convention
    var mergedYaml = mergeService.SerializeAppDefinition(dataDefinition);

    File.WriteAllText(dataYamlAbsPath, mergedYaml);
    Console.WriteLine($"Successfully merged views into data.yaml");
    Console.WriteLine($"Merged {appSettingsObj.ViewDefinitions.Count} view(s) into data.yaml");
}
catch (Exception ex)
{
    Console.Error.WriteLine($"Error: {ex.Message}");
    if (ex.InnerException != null)
    {
        Console.Error.WriteLine($"Details: {ex.InnerException.Message}");
    }
    Environment.Exit(1);
}

/// <summary>
/// Represents the root structure of appsettings.json for deserialization purposes.
/// Only includes ViewDefinitions; other sections are ignored via IgnoreUnmatchedProperties().
/// </summary>
public class AppSettingsRoot
{
    public List<ViewDefinition> ViewDefinitions { get; set; } = new();
}
