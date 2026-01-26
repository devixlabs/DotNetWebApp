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
            var yamlContent = File.ReadAllText(yamlFilePath);

            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            AppDefinition = deserializer.Deserialize<AppDefinition>(yamlContent);
        }
    }
}
