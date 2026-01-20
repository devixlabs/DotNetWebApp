using System;
using System.IO;
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
            if (args.Length == 0)
            {
                Console.WriteLine("Usage: ModelGenerator <path_to_yaml_file>");
                return;
            }
            var yamlFilePath = args[0];
            var yamlContent = File.ReadAllText(yamlFilePath);

            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var appDefinition = deserializer.Deserialize<AppDefinition>(yamlContent);

            var templatePath = Path.Combine(AppContext.BaseDirectory, "EntityTemplate.scriban");
            var templateContent = File.ReadAllText(templatePath);
            var template = Template.Parse(templateContent);

            var outputDir = "../DotNetWebApp/Models/Generated";
            Directory.CreateDirectory(outputDir);

            foreach (var entity in appDefinition.DataModel.Entities)
            {
                var result = template.Render(new { entity });
                var outputPath = Path.Combine(outputDir, $"{entity.Name}.cs");
                File.WriteAllText(outputPath, result);
                Console.WriteLine($"Generated {outputPath}");
            }
        }
    }
}