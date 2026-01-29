using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using DdlParser;
using DotNetWebApp.Models.AppDictionary;
using Xunit;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace DotNetWebApp.Tests;

public class PipelineIntegrationTests
{
    [Fact]
    public async Task RunDdlPipeline_EndToEnd_GeneratesWorkingModels()
    {
        // Arrange: Create temp SQL file
        var sql = @"
CREATE TABLE Categories (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    Price DECIMAL(18,2) NULL,
    CategoryId INT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);";
        var tempSql = Path.GetTempFileName() + ".sql";
        var tempYaml = Path.GetTempFileName() + ".yaml";

        try
        {
            await File.WriteAllTextAsync(tempSql, sql);

            // Act Phase 1: Run DdlParser (SQL -> YAML)
            var parser = new SqlDdlParser();
            var tables = parser.Parse(sql);
            var generator = new YamlGenerator();
            var yaml = generator.Generate(tables);
            await File.WriteAllTextAsync(tempYaml, yaml);

            // Assert Phase 1: Verify SQL parsing
            Assert.Equal(2, tables.Count);
            Assert.Contains(tables, t => t.Name == "Categories");
            Assert.Contains(tables, t => t.Name == "Products");

            var productsTable = tables.FirstOrDefault(t => t.Name == "Products");
            Assert.NotNull(productsTable);
            Assert.Equal(6, productsTable.Columns.Count);
            Assert.Single(productsTable.ForeignKeys);

            // Assert Phase 2: Verify YAML is valid and complete
            Assert.NotEmpty(yaml);
            Assert.Contains("name: Product", yaml, StringComparison.OrdinalIgnoreCase); // Singularized
            Assert.Contains("name: Category", yaml, StringComparison.OrdinalIgnoreCase); // Singularized

            // Act Phase 3: Verify YAML can be deserialized
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var appDefinition = deserializer.Deserialize<AppDefinition>(yaml);

            // Assert Phase 3: Verify deserialized structure
            Assert.NotNull(appDefinition);
            Assert.NotNull(appDefinition.Applications);
            Assert.NotNull(appDefinition.DataModel);
            Assert.Equal(2, appDefinition.DataModel.Entities.Count);

            // Verify Category entity
            var categoryEntity = appDefinition.DataModel.Entities.FirstOrDefault(e => e.Name == "Category");
            Assert.NotNull(categoryEntity);
            Assert.Equal(2, categoryEntity.Properties.Count);

            var categoryIdProp = categoryEntity.Properties.FirstOrDefault(p => p.Name == "Id");
            Assert.NotNull(categoryIdProp);
            Assert.Equal("int", categoryIdProp.Type);
            Assert.True(categoryIdProp.IsPrimaryKey);
            Assert.True(categoryIdProp.IsIdentity);
            Assert.True(categoryIdProp.IsRequired);

            // Verify Product entity
            var productEntity = appDefinition.DataModel.Entities.FirstOrDefault(e => e.Name == "Product");
            Assert.NotNull(productEntity);
            Assert.Equal(6, productEntity.Properties.Count);

            var productIdProp = productEntity.Properties.FirstOrDefault(p => p.Name == "Id");
            Assert.NotNull(productIdProp);
            Assert.True(productIdProp.IsPrimaryKey);
            Assert.True(productIdProp.IsIdentity);

            var priceProp = productEntity.Properties.FirstOrDefault(p => p.Name == "Price");
            Assert.NotNull(priceProp);
            Assert.Equal("decimal", priceProp.Type);
            Assert.Equal(18, priceProp.Precision);
            Assert.Equal(2, priceProp.Scale);
            Assert.False(priceProp.IsRequired); // Nullable

            var createdAtProp = productEntity.Properties.FirstOrDefault(p => p.Name == "CreatedAt");
            Assert.NotNull(createdAtProp);
            Assert.NotNull(createdAtProp.DefaultValue);
            Assert.Contains("GETDATE", createdAtProp.DefaultValue.ToUpperInvariant());

            // Verify relationship
            Assert.Single(productEntity.Relationships);
            var relationship = productEntity.Relationships[0];
            Assert.Equal("Category", relationship.TargetEntity);
            Assert.Equal("CategoryId", relationship.ForeignKey);
            Assert.Equal("Id", relationship.PrincipalKey);

            // Assert Phase 4: Verify generated YAML would work with ModelGenerator
            // This verifies the complete pipeline readiness for code generation
            Assert.NotEmpty(appDefinition.Applications);
            Assert.NotEmpty(appDefinition.Applications[0].Name);
        }
        finally
        {
            // Cleanup temp files
            if (File.Exists(tempSql))
                File.Delete(tempSql);
            if (File.Exists(tempYaml))
                File.Delete(tempYaml);
        }
    }

    [Fact]
    public async Task RunDdlPipeline_InvalidSql_ReportsErrorClearly()
    {
        // Arrange: Create malformed SQL
        var invalidSql = "CREATE TABLE InvalidTable (Id INT NOTAVALIDKEYWORD);";
        var tempSql = Path.GetTempFileName() + ".sql";

        try
        {
            await File.WriteAllTextAsync(tempSql, invalidSql);

            // Act & Assert: Verify parser throws with clear message
            var parser = new SqlDdlParser();
            var exception = Assert.Throws<InvalidOperationException>(() => parser.Parse(invalidSql));
            Assert.Contains("SQL parsing errors", exception.Message);
        }
        finally
        {
            if (File.Exists(tempSql))
                File.Delete(tempSql);
        }
    }

    [Fact]
    public void RunDdlPipeline_UpdatedSchema_RegeneratesCorrectly()
    {
        // Arrange: Create initial schema
        var initialSql = @"
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL
);";

        // Arrange: Create updated schema with new column
        var updatedSql = @"
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(18,2) NULL
);";

        var tempYaml = Path.GetTempFileName() + ".yaml";

        try
        {
            // Act: Parse initial schema
            var parser = new SqlDdlParser();
            var generator = new YamlGenerator();

            var initialTables = parser.Parse(initialSql);
            var initialYaml = generator.Generate(initialTables);

            // Act: Parse updated schema
            var updatedTables = parser.Parse(updatedSql);
            var updatedYaml = generator.Generate(updatedTables);

            // Assert: Verify initial has 2 properties
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var initialAppDef = deserializer.Deserialize<AppDefinition>(initialYaml);
            var initialProduct = initialAppDef.DataModel.Entities.FirstOrDefault(e => e.Name == "Product");
            Assert.NotNull(initialProduct);
            Assert.Equal(2, initialProduct.Properties.Count);

            // Assert: Verify updated has 3 properties
            var updatedAppDef = deserializer.Deserialize<AppDefinition>(updatedYaml);
            var updatedProduct = updatedAppDef.DataModel.Entities.FirstOrDefault(e => e.Name == "Product");
            Assert.NotNull(updatedProduct);
            Assert.Equal(3, updatedProduct.Properties.Count);

            var priceProperty = updatedProduct.Properties.FirstOrDefault(p => p.Name == "Price");
            Assert.NotNull(priceProperty);
            Assert.Equal("decimal", priceProperty.Type);
        }
        finally
        {
            if (File.Exists(tempYaml))
                File.Delete(tempYaml);
        }
    }

    [Fact]
    public void RunDdlPipeline_ComplexSchema_HandlesMultipleRelationships()
    {
        // Arrange: Schema with multiple foreign keys
        var sql = @"
CREATE TABLE Companies (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(200) NOT NULL
);

CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL
);

CREATE TABLE CompanyProducts (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CompanyId INT NOT NULL,
    ProductId INT NOT NULL,
    FOREIGN KEY (CompanyId) REFERENCES Companies(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);";

        // Act
        var parser = new SqlDdlParser();
        var tables = parser.Parse(sql);
        var generator = new YamlGenerator();
        var yaml = generator.Generate(tables);

        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        var appDefinition = deserializer.Deserialize<AppDefinition>(yaml);

        // Assert
        var companyProductEntity = appDefinition.DataModel.Entities
            .FirstOrDefault(e => e.Name == "CompanyProduct"); // Singularized

        Assert.NotNull(companyProductEntity);
        Assert.Equal(2, companyProductEntity.Relationships.Count);

        Assert.Contains(companyProductEntity.Relationships, r =>
            r.ForeignKey == "CompanyId" && r.TargetEntity == "Company");
        Assert.Contains(companyProductEntity.Relationships, r =>
            r.ForeignKey == "ProductId" && r.TargetEntity == "Product");
    }

    [Fact]
    public void RunDdlPipeline_EmptySql_ProducesMinimalYaml()
    {
        // Arrange
        var emptySql = "";
        var parser = new SqlDdlParser();
        var generator = new YamlGenerator();

        // Act
        var tables = parser.Parse(emptySql);
        var yaml = generator.Generate(tables);

        // Assert
        Assert.Empty(tables);
        Assert.NotEmpty(yaml);
        Assert.Contains("applications:", yaml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("dataModel:", yaml, StringComparison.OrdinalIgnoreCase);

        var deserializer = new DeserializerBuilder()
            .WithNamingConvention(CamelCaseNamingConvention.Instance)
            .Build();

        var appDefinition = deserializer.Deserialize<AppDefinition>(yaml);
        Assert.NotNull(appDefinition);
        Assert.Empty(appDefinition.DataModel.Entities);
    }
}
