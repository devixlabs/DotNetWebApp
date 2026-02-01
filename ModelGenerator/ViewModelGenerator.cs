using System;
using System.IO;
using System.Linq;
using DotNetWebApp.Models.AppDictionary;
using Scriban;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace ModelGenerator
{
    /// <summary>
    /// Generates C# view model classes from views.yaml definitions.
    /// Uses partial class pattern: {Name}.generated.cs (overwritten) + {Name}.cs (user-maintained).
    /// </summary>
    public class ViewModelGenerator
    {
        private readonly string _viewsYamlPath;
        private readonly string _outputPath;

        public ViewModelGenerator(string viewsYamlPath, string outputPath)
        {
            _viewsYamlPath = viewsYamlPath;
            _outputPath = outputPath;
        }

        /// <summary>
        /// Generates view models from views.yaml or data.yaml (after merge).
        /// Handles both ViewsDefinition (from views.yaml) and AppDefinition (from data.yaml) structures.
        /// </summary>
        /// <returns>Number of view models generated</returns>
        public int Generate()
        {
            Console.WriteLine($"Loading views from {_viewsYamlPath}");

            if (!File.Exists(_viewsYamlPath))
            {
                Console.WriteLine($"Warning: views.yaml not found at {_viewsYamlPath}. Skipping view generation.");
                return 0;
            }

            // Deserialize YAML - try AppDefinition first (data.yaml after merge), then ViewsDefinition (views.yaml)
            // Use CamelCase naming convention for app.yaml/data.yaml files, underscore for views.yaml
            var yamlContent = File.ReadAllText(_viewsYamlPath);
            ViewsDefinition? viewDefinitions = null;

            // Try AppDefinition structure first (for data.yaml with both entities and views)
            try
            {
                var appDeserializer = new DeserializerBuilder()
                    .WithNamingConvention(CamelCaseNamingConvention.Instance)
                    .Build();

                var appDefinition = appDeserializer.Deserialize<AppDefinition>(yamlContent);
                if (appDefinition?.Views != null)
                {
                    viewDefinitions = appDefinition.Views;
                }
            }
            catch
            {
                // AppDefinition deserialization failed, try ViewsDefinition
            }

            // If AppDefinition didn't work, try ViewsDefinition structure (for views.yaml)
            if (viewDefinitions == null)
            {
                try
                {
                    var viewsDeserializer = new DeserializerBuilder()
                        .WithNamingConvention(UnderscoredNamingConvention.Instance)
                        .Build();

                    viewDefinitions = viewsDeserializer.Deserialize<ViewsDefinition>(yamlContent);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error: Could not deserialize {_viewsYamlPath} as AppDefinition or ViewsDefinition");
                    Console.WriteLine($"Details: {ex.Message}");
                    return 0;
                }
            }

            if (viewDefinitions?.Views == null || !viewDefinitions.Views.Any())
            {
                Console.WriteLine($"Warning: No views found in {_viewsYamlPath}");
                return 0;
            }

            Console.WriteLine($"Generating {viewDefinitions.Views.Count} view models...");

            // Ensure output directory exists
            Directory.CreateDirectory(_outputPath);

            // Load template
            var templatePath = Path.Combine(AppContext.BaseDirectory, "ViewModelTemplate.scriban");
            if (!File.Exists(templatePath))
            {
                throw new FileNotFoundException($"ViewModelTemplate.scriban not found at {templatePath}");
            }

            var templateContent = File.ReadAllText(templatePath);
            var template = Template.Parse(templateContent);

            if (template.HasErrors)
            {
                throw new InvalidOperationException($"Template errors: {string.Join(", ", template.Messages)}");
            }

            var generatedCount = 0;

            foreach (var view in viewDefinitions.Views)
            {
                GenerateViewModel(template, view);
                generatedCount++;
            }

            Console.WriteLine($"View model generation complete. Output: {_outputPath}");
            return generatedCount;
        }

        private void GenerateViewModel(Template template, ViewDefinition view)
        {
            var result = template.Render(new
            {
                View = view,
                GeneratedDate = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss"),
                HasParameters = view.Parameters?.Any() ?? false,
                HasProperties = view.Properties?.Any() ?? false
            });

            // Use .generated.cs suffix for partial class pattern
            var fileName = view.GeneratePartial
                ? $"{view.Name}.generated.cs"
                : $"{view.Name}.cs";

            var outputFile = Path.Combine(_outputPath, fileName);
            File.WriteAllText(outputFile, result);

            Console.WriteLine($"Generated view model: {fileName}");
        }
    }
}
