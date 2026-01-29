using AppsYamlGenerator;
using DotNetWebApp.Models.AppDictionary;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

if (args.Length < 3)
{
    Console.WriteLine("Usage: AppsYamlGenerator <appsettings.json> <data.yaml> <output_apps.yaml>");
    Console.WriteLine("Example: AppsYamlGenerator appsettings.json data.yaml apps.yaml");
    Environment.Exit(1);
}

var appSettingsFile = args[0];
var dataYamlFile = args[1];
var outputFile = args[2];

try
{
    // Convert relative paths to absolute paths for robustness
    var appSettingsAbsPath = Path.GetFullPath(appSettingsFile);
    var dataYamlAbsPath = Path.GetFullPath(dataYamlFile);
    var outputAbsPath = Path.GetFullPath(outputFile);

    // Validate input files exist
    if (!File.Exists(appSettingsAbsPath))
    {
        Console.Error.WriteLine($"Error: appsettings.json not found: {appSettingsAbsPath}");
        Environment.Exit(1);
    }

    if (!File.Exists(dataYamlAbsPath))
    {
        Console.Error.WriteLine($"Error: data.yaml not found: {dataYamlAbsPath}");
        Environment.Exit(1);
    }

    // Read appsettings.json and extract Applications section
    Console.WriteLine($"Reading appsettings.json: {appSettingsAbsPath}");
    var config = new ConfigurationBuilder()
        .AddJsonFile(appSettingsAbsPath)
        .Build();

    var applicationsSection = config.GetSection("Applications");
    var applications = new List<ApplicationInfo>();

    if (applicationsSection.Exists())
    {
        applicationsSection.Bind(applications);
        Console.WriteLine($"Found {applications.Count} application(s) in appsettings.json");
    }
    else
    {
        Console.WriteLine("Warning: No Applications section found in appsettings.json");
    }

    // Read data.yaml and extract DataModel section
    Console.WriteLine($"Reading data.yaml: {dataYamlAbsPath}");
    var dataYamlContent = File.ReadAllText(dataYamlAbsPath);

    var deserializer = new DeserializerBuilder()
        .WithNamingConvention(CamelCaseNamingConvention.Instance)
        .Build();

    var dataDefinition = deserializer.Deserialize<AppDefinition>(dataYamlContent);

    if (dataDefinition?.DataModel?.Entities == null || dataDefinition.DataModel.Entities.Count == 0)
    {
        Console.Error.WriteLine("Error: No entities found in data.yaml DataModel");
        Environment.Exit(1);
    }

    Console.WriteLine($"Found {dataDefinition.DataModel.Entities.Count} entity(ies) in data.yaml");

    var dataModel = dataDefinition.DataModel;
    var views = dataDefinition.Views ?? new ViewsRoot { Views = new List<View>() };

    // Merge applications with data model
    Console.WriteLine("Merging Applications with DataModel...");
    var merger = new AppsYamlMerger();
    var mergedYaml = merger.MergeApplicationsWithDataModel(applications, dataModel, views);

    // Write output file
    var outputDir = Path.GetDirectoryName(outputAbsPath);
    if (!string.IsNullOrEmpty(outputDir) && !Directory.Exists(outputDir))
    {
        Directory.CreateDirectory(outputDir);
    }

    File.WriteAllText(outputAbsPath, mergedYaml);
    Console.WriteLine($"Successfully wrote merged YAML to: {outputAbsPath}");
}
catch (Exception ex)
{
    Console.Error.WriteLine($"Error: {ex.Message}");
    if (!string.IsNullOrEmpty(ex.InnerException?.Message))
    {
        Console.Error.WriteLine($"Details: {ex.InnerException.Message}");
    }
    Environment.Exit(1);
}
