using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services;

public sealed class EntityMetadataService : IEntityMetadataService
{
    private readonly IReadOnlyList<EntityMetadata> _entities;
    private readonly Dictionary<string, EntityMetadata> _byName;

    public EntityMetadataService(IAppDictionaryService appDictionary)
    {
        var entityDefinitions = appDictionary.AppDefinition.DataModel?.Entities ?? new List<Entity>();
        // Scan the Models assembly instead of the web app assembly to support separated project structure
        var assembly = typeof(EntityMetadata).Assembly;
        var entities = new List<EntityMetadata>(entityDefinitions.Count);

        foreach (var entity in entityDefinitions)
        {
            var clrType = assembly.GetType($"DotNetWebApp.Models.Generated.{entity.Name}");
            entities.Add(new EntityMetadata(entity, clrType));
        }

        _entities = entities;
        _byName = entities.ToDictionary(item => item.Definition.Name, StringComparer.OrdinalIgnoreCase);
    }

    public IReadOnlyList<EntityMetadata> Entities => _entities;

    public EntityMetadata? Find(string entityName)
    {
        if (string.IsNullOrWhiteSpace(entityName))
        {
            return null;
        }

        return _byName.TryGetValue(entityName, out var metadata) ? metadata : null;
    }
}
