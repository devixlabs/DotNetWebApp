using DdlParser;
using DotNetWebApp.Models.AppDictionary;
using Xunit;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace DdlParser.Tests;

public class YamlGeneratorTests
{
    [Fact]
    public void Generate_SimpleEntity_ProducesValidYaml()
    {
        // Arrange
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Product",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata
                    {
                        Name = "Id",
                        SqlType = "INT",
                        IsNullable = false,
                        IsPrimaryKey = true,
                        IsIdentity = true
                    },
                    new ColumnMetadata
                    {
                        Name = "Name",
                        SqlType = "NVARCHAR",
                        MaxLength = 100,
                        IsNullable = false
                    }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.NotEmpty(yaml);
        Assert.Contains("name: Product", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("name: Id", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("name: Name", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("isPrimaryKey: true", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("isIdentity: true", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void Generate_EntityWithRelationships_IncludesForeignKeys()
    {
        // Arrange
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Category",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false }
                }
            },
            new TableMetadata
            {
                Name = "Product",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false },
                    new ColumnMetadata { Name = "CategoryId", SqlType = "INT", IsNullable = true }
                },
                ForeignKeys = new List<ForeignKeyMetadata>
                {
                    new ForeignKeyMetadata
                    {
                        ColumnName = "CategoryId",
                        ReferencedTable = "Category",
                        ReferencedColumn = "Id"
                    }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.Contains("relationships:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("targetEntity: Category", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("foreignKey: CategoryId", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void Generate_MultipleEntities_OrdersCorrectly()
    {
        // Arrange
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "ZebraTable",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsNullable = false }
                }
            },
            new TableMetadata
            {
                Name = "AppleTable",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsNullable = false }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.NotEmpty(yaml);
        Assert.Contains("name: ZebraTable", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("name: AppleTable", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void Generate_EmptyTableList_ReturnsMinimalYaml()
    {
        // Arrange
        var tables = new List<TableMetadata>();
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.NotEmpty(yaml);
        Assert.Contains("app:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("dataModel:", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void Generated_Yaml_CanBeDeserialized()
    {
        // Arrange
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Product",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata
                    {
                        Name = "Id",
                        SqlType = "INT",
                        IsNullable = false,
                        IsPrimaryKey = true,
                        IsIdentity = true
                    },
                    new ColumnMetadata
                    {
                        Name = "Name",
                        SqlType = "NVARCHAR",
                        MaxLength = 100,
                        IsNullable = false
                    },
                    new ColumnMetadata
                    {
                        Name = "Price",
                        SqlType = "DECIMAL",
                        Precision = 18,
                        Scale = 2,
                        IsNullable = true
                    }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert - Verify round-trip deserialization
        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        var appDefinition = deserializer.Deserialize<AppDefinition>(yaml);

        Assert.NotNull(appDefinition);
        Assert.NotNull(appDefinition.DataModel);
        Assert.Single(appDefinition.DataModel.Entities);

        var entity = appDefinition.DataModel.Entities[0];
        Assert.Equal("Product", entity.Name);
        Assert.Equal(3, entity.Properties.Count);

        var idProp = entity.Properties.FirstOrDefault(p => p.Name == "Id");
        Assert.NotNull(idProp);
        Assert.True(idProp.IsPrimaryKey);
        Assert.True(idProp.IsIdentity);

        var priceProp = entity.Properties.FirstOrDefault(p => p.Name == "Price");
        Assert.NotNull(priceProp);
        Assert.Equal(18, priceProp.Precision);
        Assert.Equal(2, priceProp.Scale);
    }

    [Fact]
    public void Generate_DecimalWithPrecisionScale_PreservesParameters()
    {
        // Arrange
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Product",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata
                    {
                        Name = "Id",
                        SqlType = "INT",
                        IsPrimaryKey = true,
                        IsNullable = false
                    },
                    new ColumnMetadata
                    {
                        Name = "Price",
                        SqlType = "DECIMAL",
                        Precision = 18,
                        Scale = 2,
                        IsNullable = false
                    }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.Contains("precision: 18", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("scale: 2", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void Generate_StringWithMaxLength_PreservesMaxLength()
    {
        // Arrange
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Product",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata
                    {
                        Name = "Id",
                        SqlType = "INT",
                        IsPrimaryKey = true,
                        IsNullable = false
                    },
                    new ColumnMetadata
                    {
                        Name = "Name",
                        SqlType = "NVARCHAR",
                        MaxLength = 100,
                        IsNullable = false
                    }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.Contains("maxLength: 100", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void Generate_ColumnWithDefaultValue_IncludesDefaultValue()
    {
        // Arrange
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Order",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata
                    {
                        Name = "Id",
                        SqlType = "INT",
                        IsPrimaryKey = true,
                        IsNullable = false
                    },
                    new ColumnMetadata
                    {
                        Name = "CreatedAt",
                        SqlType = "DATETIME2",
                        IsNullable = true,
                        DefaultValue = "GETDATE()"
                    }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.Contains("defaultValue:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("GETDATE", yaml, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void Generate_ComplexSchema_ProducesCompleteYaml()
    {
        // Arrange - Full schema from the project's schema.sql
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Categories",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false },
                    new ColumnMetadata { Name = "Name", SqlType = "NVARCHAR", MaxLength = 50, IsNullable = false }
                }
            },
            new TableMetadata
            {
                Name = "Products",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false },
                    new ColumnMetadata { Name = "Name", SqlType = "NVARCHAR", MaxLength = 100, IsNullable = false },
                    new ColumnMetadata { Name = "Description", SqlType = "NVARCHAR", MaxLength = 500, IsNullable = true },
                    new ColumnMetadata { Name = "Price", SqlType = "DECIMAL", Precision = 18, Scale = 2, IsNullable = true },
                    new ColumnMetadata { Name = "CategoryId", SqlType = "INT", IsNullable = true },
                    new ColumnMetadata { Name = "CreatedAt", SqlType = "DATETIME2", IsNullable = true, DefaultValue = "GETDATE()" }
                },
                ForeignKeys = new List<ForeignKeyMetadata>
                {
                    new ForeignKeyMetadata { ColumnName = "CategoryId", ReferencedTable = "Categories", ReferencedColumn = "Id" }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert - Verify deserialization of complex schema
        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        var appDefinition = deserializer.Deserialize<AppDefinition>(yaml);

        Assert.Equal(2, appDefinition.DataModel.Entities.Count);

        // YamlGenerator singularizes table names (Products -> Product)
        var productsEntity = appDefinition.DataModel.Entities.FirstOrDefault(e => e.Name == "Product");
        Assert.NotNull(productsEntity);
        Assert.Equal(6, productsEntity.Properties.Count);
        Assert.Single(productsEntity.Relationships);

        var relationship = productsEntity.Relationships[0];
        Assert.Equal("Category", relationship.TargetEntity); // Singularized
        Assert.Equal("CategoryId", relationship.ForeignKey);
    }

    [Fact]
    public void Generate_EntitiesWithSchema_PreservesSchemaInYaml()
    {
        // Arrange - Tables with schema prefix
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Category",
                Schema = "acme",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false }
                }
            },
            new TableMetadata
            {
                Name = "Product",
                Schema = "acme",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false },
                    new ColumnMetadata { Name = "CategoryId", SqlType = "INT", IsNullable = true }
                },
                ForeignKeys = new List<ForeignKeyMetadata>
                {
                    new ForeignKeyMetadata { ColumnName = "CategoryId", ReferencedTable = "Category", ReferencedColumn = "Id" }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert - Verify schema appears in YAML
        Assert.Contains("schema: acme", yaml, StringComparison.OrdinalIgnoreCase);

        // Verify deserialization preserves schema
        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        var appDefinition = deserializer.Deserialize<AppDefinition>(yaml);
        var category = appDefinition.DataModel.Entities.FirstOrDefault(e => e.Name == "Category");
        Assert.NotNull(category);
        Assert.Equal("acme", category.Schema);

        var product = appDefinition.DataModel.Entities.FirstOrDefault(e => e.Name == "Product");
        Assert.NotNull(product);
        Assert.Equal("acme", product.Schema);
    }

    [Fact]
    public void Generate_MixedSchemas_PreservesAllSchemas()
    {
        // Arrange - Tables in different schemas
        var tables = new List<TableMetadata>
        {
            new TableMetadata
            {
                Name = "Product",
                Schema = "acme",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false }
                }
            },
            new TableMetadata
            {
                Name = "User",
                Schema = "tenant1",
                Columns = new List<ColumnMetadata>
                {
                    new ColumnMetadata { Name = "Id", SqlType = "INT", IsPrimaryKey = true, IsIdentity = true, IsNullable = false }
                }
            }
        };
        var generator = new YamlGenerator();

        // Act
        var yaml = generator.Generate(tables);

        // Assert
        Assert.Contains("schema: acme", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("schema: tenant1", yaml, StringComparison.OrdinalIgnoreCase);

        // Verify deserialization
        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        var appDefinition = deserializer.Deserialize<AppDefinition>(yaml);
        Assert.Equal(2, appDefinition.DataModel.Entities.Count);
        Assert.Contains(appDefinition.DataModel.Entities, e => e.Schema == "acme");
        Assert.Contains(appDefinition.DataModel.Entities, e => e.Schema == "tenant1");
    }
}
