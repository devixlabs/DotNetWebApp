using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services;

public sealed class EntityMetadataService : IEntityMetadataService
{
    private readonly IReadOnlyList<EntityMetadata> _entities;
    private readonly Dictionary<string, EntityMetadata> _byQualifiedName;
    private readonly Dictionary<string, List<EntityMetadata>> _byPlainName;
    private readonly IAppDictionaryService _appDictionary;

    public EntityMetadataService(IAppDictionaryService appDictionary)
    {
        _appDictionary = appDictionary;
        var entityDefinitions = appDictionary.AppDefinition.DataModel?.Entities ?? new List<Entity>();
        // Scan the Models assembly instead of the web app assembly to support separated project structure
        var assembly = typeof(EntityMetadata).Assembly;
        var entities = new List<EntityMetadata>(entityDefinitions.Count);

        foreach (var entity in entityDefinitions)
        {
            // Build namespace based on schema: DotNetWebApp.Models.Generated[.Schema].Name
            // Schema must be Pascal-cased to match generated namespace (e.g., "initech" -> "Initech")
            var ns = "DotNetWebApp.Models.Generated";
            if (!string.IsNullOrWhiteSpace(entity.Schema))
            {
                var pascalSchema = char.ToUpperInvariant(entity.Schema[0]) + entity.Schema[1..].ToLowerInvariant();
                ns += $".{pascalSchema}";
            }
            var clrType = assembly.GetType($"{ns}.{entity.Name}");
            entities.Add(new EntityMetadata(entity, clrType));
        }

        _entities = entities;

        // Build dictionaries for efficient lookup
        _byQualifiedName = entities.ToDictionary(
            item => string.IsNullOrWhiteSpace(item.Definition.Schema)
                ? item.Definition.Name
                : $"{item.Definition.Schema}:{item.Definition.Name}",
            StringComparer.OrdinalIgnoreCase);

        // Group by plain name for fallback lookup
        _byPlainName = entities
            .GroupBy(item => item.Definition.Name, StringComparer.OrdinalIgnoreCase)
            .ToDictionary(g => g.Key, g => g.ToList(), StringComparer.OrdinalIgnoreCase);
    }

    public IReadOnlyList<EntityMetadata> Entities => _entities;

    public EntityMetadata? Find(string entityName)
    {
        if (string.IsNullOrWhiteSpace(entityName))
        {
            return null;
        }

        // Try exact match first (handles both plain and schema-qualified names)
        if (_byQualifiedName.TryGetValue(entityName, out var metadata))
        {
            return metadata;
        }

        // If not found and entityName doesn't contain schema qualifier, try plain name lookup
        if (!entityName.Contains(':') && _byPlainName.TryGetValue(entityName, out var candidates))
        {
            // Return first match (prefer non-schema-qualified or first available)
            return candidates.FirstOrDefault(m => string.IsNullOrWhiteSpace(m.Definition.Schema))
                ?? candidates[0];
        }

        return null;
    }

    public IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName)
    {
        var app = _appDictionary.GetApplication(appName);
        if (app == null)
            return Array.Empty<EntityMetadata>();

        if (app.Entities.Count == 0)
            return Array.Empty<EntityMetadata>();

        return _entities
            .Where(e => IsEntityVisibleInApplication(e, app))
            .ToList()
            .AsReadOnly();
    }

    public bool IsEntityVisibleInApplication(EntityMetadata entity, string appName)
    {
        var app = _appDictionary.GetApplication(appName);
        return app != null && IsEntityVisibleInApplication(entity, app);
    }

    private bool IsEntityVisibleInApplication(EntityMetadata entity, ApplicationInfo app)
    {
        var qualifiedName = string.IsNullOrEmpty(entity.Definition.Schema)
            ? entity.Definition.Name
            : $"{entity.Definition.Schema}:{entity.Definition.Name}";

        return app.Entities.Contains(qualifiedName, StringComparer.OrdinalIgnoreCase);
    }
}
