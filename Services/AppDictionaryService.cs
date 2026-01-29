using DotNetWebApp.Models.AppDictionary;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace DotNetWebApp.Services
{
    public class AppDictionaryService : IAppDictionaryService
    {
        public AppDefinition AppDefinition { get; }

        public AppDictionaryService(string yamlFilePath)
        {
            if (!File.Exists(yamlFilePath))
                throw new FileNotFoundException($"apps.yaml not found at {yamlFilePath}");

            var yamlContent = File.ReadAllText(yamlFilePath);

            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            AppDefinition = deserializer.Deserialize<AppDefinition>(yamlContent)
                ?? throw new InvalidOperationException("Failed to deserialize apps.yaml");

            if (!AppDefinition.Applications.Any())
                throw new InvalidOperationException("apps.yaml must define at least one application");
        }

        public IReadOnlyList<ApplicationInfo> GetAllApplications()
        {
            return AppDefinition.Applications.AsReadOnly();
        }

        public ApplicationInfo? GetApplication(string appName)
        {
            return AppDefinition.Applications.FirstOrDefault(a =>
                a.Name.Equals(appName, StringComparison.OrdinalIgnoreCase));
        }
    }
}
