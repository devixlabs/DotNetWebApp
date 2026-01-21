using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Models;

public sealed record EntityMetadata(Entity Definition, Type? ClrType);
