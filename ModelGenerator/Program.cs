using System;
using System.IO;
using System.Linq;
using DotNetWebApp.Models.AppDictionary;
using Scriban;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace ModelGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            // Check for --mode argument
            var modeArg = args.FirstOrDefault(a => a.StartsWith("--mode="));
            var mode = modeArg?.Split('=').ElementAtOrDefault(1) ?? "entities";

            if (mode == "views")
            {
                RunViewGeneration(args);
            }
            else
            {
                RunEntityGeneration(args);
            }
        }

        /// <summary>
        /// Generate entity models from data.yaml (existing behavior)
        /// </summary>
        static void RunEntityGeneration(string[] args)
        {
            // Filter out mode argument
            var filteredArgs = args.Where(a => !a.StartsWith("--mode=")).ToArray();

            if (filteredArgs.Length == 0)
            {
                Console.WriteLine("Usage: ModelGenerator <path_to_data_yaml>");
                Console.WriteLine("       ModelGenerator --mode=views --views-yaml=<path> --output-dir=<path>");
                Console.WriteLine("Example: ModelGenerator data.yaml");
                return;
            }

            var yamlFilePath = filteredArgs[0];
            var yamlContent = File.ReadAllText(yamlFilePath);

            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var appDefinition = deserializer.Deserialize<AppDefinition>(yamlContent);

            var templatePath = Path.Combine(AppContext.BaseDirectory, "EntityTemplate.scriban");
            var templateContent = File.ReadAllText(templatePath);
            var template = Template.Parse(templateContent);

            var outputDir = "../DotNetWebApp.Models/Generated";
            Directory.CreateDirectory(outputDir);

            foreach (var entity in appDefinition.DataModel.Entities)
            {
                var result = template.Render(new { entity });

                // Create schema-specific subdirectory if schema is defined
                var entityOutputDir = outputDir;
                if (!string.IsNullOrEmpty(entity.Schema))
                {
                    // Capitalize schema name for directory (e.g., "acme" -> "Acme")
                    var schemaDir = char.ToUpper(entity.Schema[0]) + entity.Schema.Substring(1);
                    entityOutputDir = Path.Combine(outputDir, schemaDir);
                    Directory.CreateDirectory(entityOutputDir);
                }

                var outputPath = Path.Combine(entityOutputDir, $"{entity.Name}.cs");
                File.WriteAllText(outputPath, result);
                Console.WriteLine($"Generated {outputPath}");
            }
        }

        /// <summary>
        /// Generate view models from views.yaml (new Phase 2 behavior)
        /// </summary>
        static void RunViewGeneration(string[] args)
        {
            // Parse arguments
            var viewsYamlArg = args.FirstOrDefault(a => a.StartsWith("--views-yaml="));
            var outputDirArg = args.FirstOrDefault(a => a.StartsWith("--output-dir="));

            var viewsYamlPath = viewsYamlArg?.Split('=').ElementAtOrDefault(1) ?? "views.yaml";
            var outputDir = outputDirArg?.Split('=').ElementAtOrDefault(1) ?? "../DotNetWebApp.Models/ViewModels";

            Console.WriteLine("Running view model generation...");
            Console.WriteLine($"  views.yaml: {viewsYamlPath}");
            Console.WriteLine($"  Output dir: {outputDir}");

            var generator = new ViewModelGenerator(viewsYamlPath, outputDir);
            var count = generator.Generate();

            Console.WriteLine($"Generated {count} view model(s).");
        }
    }
}
