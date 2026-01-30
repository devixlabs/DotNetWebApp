using DotNetWebApp.Models.AppDictionary;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;
using YamlMerger;

namespace AppsYamlGenerator;

/// <summary>
/// Merges appsettings.json Applications section with data.yaml DataModel to produce app.yaml (final runtime configuration)
/// Populates application-level view visibility based on view definitions.
/// </summary>
public class AppsYamlMerger
{
    public string MergeApplicationsWithDataModel(
        List<ApplicationInfo> applications,
        DataModel dataModel,
        ViewsDefinition? views = null)
    {
        // Create the merged AppDefinition
        var appDefinition = new AppDefinition
        {
            Applications = applications,
            DataModel = dataModel,
            Views = views ?? new ViewsDefinition { Views = new List<ViewDefinition>() }
        };

        // Populate application-level view visibility based on view definitions
        var merger = new YamlMergeService();
        merger.PopulateApplicationViews(appDefinition);

        // Serialize with camelCase convention
        var serializer = new SerializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        return serializer.Serialize(appDefinition);
    }
}
