using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public static class EntityNameFormatter
{
    public static string BuildQualifiedName(string? schema, string entityName)
    {
        return string.IsNullOrWhiteSpace(schema)
            ? entityName
            : $"{schema}:{entityName}";
    }

    public static string BuildQualifiedName(EntityMetadata entity)
    {
        return BuildQualifiedName(entity.Definition.Schema, entity.Definition.Name);
    }

    public static string BuildUrlPath(string? schema, string entityName)
    {
        var effectiveSchema = string.IsNullOrWhiteSpace(schema) ? "dbo" : schema;
        return $"{effectiveSchema}/{entityName}";
    }

    public static string BuildUrlPath(EntityMetadata entity)
    {
        return BuildUrlPath(entity.Definition.Schema, entity.Definition.Name);
    }

    public static string QualifiedNameToUrlPath(string qualifiedName)
    {
        if (qualifiedName.Contains(':'))
        {
            return qualifiedName.Replace(':', '/');
        }
        return $"dbo/{qualifiedName}";
    }
}
