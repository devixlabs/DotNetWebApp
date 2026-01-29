using DotNetWebApp.Models.AppDictionary;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace DdlParser;

// Simple POCO for serializing data.yaml (without Applications field)
public class DataDefinition
{
    public DataModel DataModel { get; set; } = new();
    public ViewsRoot Views { get; set; } = new();
}

public class YamlGenerator
{
    public string Generate(List<TableMetadata> tables)
    {
        var entities = ConvertTablesToEntities(tables);

        // Generate data.yaml with ONLY dataModel and views sections (no applications)
        // Applications are configured separately in appsettings.json and merged by AppsYamlGenerator
        var dataDefinition = new DataDefinition
        {
            DataModel = new DataModel
            {
                Entities = entities
            },
            Views = new ViewsRoot
            {
                Views = new List<View>()
            }
        };

        var serializer = new SerializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        return serializer.Serialize(dataDefinition);
    }

    private List<Entity> ConvertTablesToEntities(List<TableMetadata> tables)
    {
        var entities = new List<Entity>();

        foreach (var table in tables)
        {
            var entity = new Entity
            {
                Name = SingularizeName(table.Name),
                Schema = table.Schema,
                Properties = ConvertColumnsToProperties(table.Columns),
                Relationships = ConvertForeignKeysToRelationships(table.ForeignKeys)
            };
            entities.Add(entity);
        }

        return entities;
    }

    private List<Property> ConvertColumnsToProperties(List<ColumnMetadata> columns)
    {
        var properties = new List<Property>();

        foreach (var column in columns)
        {
            var property = new Property
            {
                Name = column.Name,
                Type = TypeMapper.SqlToYamlType(column.SqlType),
                IsPrimaryKey = column.IsPrimaryKey,
                IsIdentity = column.IsIdentity,
                IsRequired = !column.IsNullable,
                MaxLength = column.MaxLength,
                Precision = column.Precision,
                Scale = column.Scale,
                DefaultValue = column.DefaultValue
            };
            properties.Add(property);
        }

        return properties;
    }

    private List<Relationship> ConvertForeignKeysToRelationships(List<ForeignKeyMetadata> foreignKeys)
    {
        var relationships = new List<Relationship>();

        foreach (var fk in foreignKeys)
        {
            var relationship = new Relationship
            {
                Type = "one-to-many",
                TargetEntity = SingularizeName(fk.ReferencedTable),
                ForeignKey = fk.ColumnName,
                PrincipalKey = fk.ReferencedColumn
            };
            relationships.Add(relationship);
        }

        return relationships;
    }

    private string SingularizeName(string pluralName)
    {
        // Simple pluralization rules (can be expanded as needed)
        if (pluralName.EndsWith("ies", StringComparison.OrdinalIgnoreCase))
        {
            return pluralName.Substring(0, pluralName.Length - 3) + "y";
        }

        if (pluralName.EndsWith("es", StringComparison.OrdinalIgnoreCase))
        {
            return pluralName.Substring(0, pluralName.Length - 2);
        }

        if (pluralName.EndsWith("s", StringComparison.OrdinalIgnoreCase))
        {
            return pluralName.Substring(0, pluralName.Length - 1);
        }

        return pluralName;
    }
}
