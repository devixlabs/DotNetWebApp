using DotNetWebApp.Models.AppDictionary;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace AppsYamlGenerator;

/// <summary>
/// Merges appsettings.json Applications section with data.yaml DataModel to produce apps.yaml
/// </summary>
public class AppsYamlMerger
{
    public string MergeApplicationsWithDataModel(
        List<ApplicationInfo> applications,
        DataModel dataModel,
        ViewsRoot? views = null)
    {
        // Create the merged AppDefinition
        var appDefinition = new AppDefinition
        {
            Applications = applications,
            DataModel = dataModel,
            Views = views ?? new ViewsRoot { Views = new List<View>() }
        };

        // Serialize with camelCase convention
        var serializer = new SerializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        return serializer.Serialize(appDefinition);
    }
}
