using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using DotNetWebApp.Models.AppDictionary;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;
using YamlMerger;

if (args.Length < 2)
{
    Console.WriteLine("Usage: YamlMerger <data.yaml> <views.yaml>");
    Console.WriteLine("Merges views.yaml into data.yaml, converting snake_case to camelCase");
    Environment.Exit(1);
}

var dataYamlPath = args[0];
var viewsYamlPath = args[1];

try
{
    // Convert to absolute paths for robustness
    var dataYamlAbsPath = Path.GetFullPath(dataYamlPath);
    var viewsYamlAbsPath = Path.GetFullPath(viewsYamlPath);

    // Validate input files exist
    if (!File.Exists(dataYamlAbsPath))
    {
        Console.Error.WriteLine($"Error: data.yaml not found: {dataYamlAbsPath}");
        Environment.Exit(1);
    }

    if (!File.Exists(viewsYamlAbsPath))
    {
        Console.Error.WriteLine($"Error: views.yaml not found: {viewsYamlAbsPath}");
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

    Console.WriteLine($"Reading views.yaml from: {viewsYamlAbsPath}");
    var viewsYamlContent = File.ReadAllText(viewsYamlAbsPath);

    // Deserialize views.yaml with snake_case convention (as defined in views.yaml)
    var viewsDeserializer = new DeserializerBuilder()
        .WithNamingConvention(UnderscoredNamingConvention.Instance)
        .Build();

    var viewsDefinition = viewsDeserializer.Deserialize<ViewsDefinition>(viewsYamlContent);

    if (viewsDefinition?.Views == null || viewsDefinition.Views.Count == 0)
    {
        Console.Error.WriteLine("Error: No views found in views.yaml");
        Environment.Exit(1);
    }

    Console.WriteLine($"Found {viewsDefinition.Views.Count} view(s) in views.yaml");

    // Merge views into data.yaml
    // Views are already in ViewsDefinition format from views.yaml
    dataDefinition.Views = viewsDefinition;

    // Populate application-level view visibility based on view definitions
    var merger = new YamlMergeService();
    merger.PopulateApplicationViews(dataDefinition);

    // Serialize merged data back to data.yaml using camelCase convention
    var mergedYaml = merger.SerializeAppDefinition(dataDefinition);

    File.WriteAllText(dataYamlAbsPath, mergedYaml);
    Console.WriteLine($"Successfully merged views into data.yaml");
    Console.WriteLine($"Merged {viewsDefinition.Views.Count} view(s) into data.yaml");
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
