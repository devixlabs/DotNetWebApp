using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface IEntityMetadataService
{
    IReadOnlyList<EntityMetadata> Entities { get; }
    EntityMetadata? Find(string entityName);
}
