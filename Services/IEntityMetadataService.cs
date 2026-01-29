using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services;

public interface IEntityMetadataService
{
    IReadOnlyList<EntityMetadata> Entities { get; }
    EntityMetadata? Find(string entityName);
    IReadOnlyList<EntityMetadata> GetEntitiesForApplication(string appName);
    bool IsEntityVisibleInApplication(EntityMetadata entity, string appName);
}
