using DdlParser;
using Xunit;

namespace DdlParser.Tests;

public class SqlDdlParserTests
{
    [Fact]
    public void Parse_SimpleTable_ReturnsTableMetadata()
    {
        // Arrange
        var sql = @"
            CREATE TABLE Products (
                Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
                Name NVARCHAR(100) NOT NULL
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        Assert.Single(tables);
        var table = tables[0];
        Assert.Equal("Products", table.Name);
        Assert.Equal(2, table.Columns.Count);

        var idColumn = table.Columns.FirstOrDefault(c => c.Name == "Id");
        Assert.NotNull(idColumn);
        Assert.Equal("INT", idColumn.SqlType.ToUpperInvariant());
        Assert.True(idColumn.IsPrimaryKey);
        Assert.True(idColumn.IsIdentity);
        Assert.False(idColumn.IsNullable);

        var nameColumn = table.Columns.FirstOrDefault(c => c.Name == "Name");
        Assert.NotNull(nameColumn);
        Assert.Equal("NVARCHAR", nameColumn.SqlType.ToUpperInvariant());
        Assert.Equal(100, nameColumn.MaxLength);
        Assert.False(nameColumn.IsNullable);
    }

    [Fact]
    public void Parse_TableWithForeignKeys_ExtractsRelationships()
    {
        // Arrange
        var sql = @"
            CREATE TABLE Categories (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(50) NOT NULL
            );

            CREATE TABLE Products (
                Id INT PRIMARY KEY IDENTITY(1,1),
                CategoryId INT NULL,
                FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        Assert.Equal(2, tables.Count);

        var productsTable = tables.FirstOrDefault(t => t.Name == "Products");
        Assert.NotNull(productsTable);
        Assert.Single(productsTable.ForeignKeys);

        var fk = productsTable.ForeignKeys[0];
        Assert.Equal("CategoryId", fk.ColumnName);
        Assert.Equal("Categories", fk.ReferencedTable);
        Assert.Equal("Id", fk.ReferencedColumn);
    }

    [Fact]
    public void Parse_IdentityColumn_SetsIsIdentityTrue()
    {
        // Arrange
        var sql = @"
            CREATE TABLE TestTable (
                Id INT IDENTITY(1,1) PRIMARY KEY,
                Code NVARCHAR(10) NOT NULL
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        var table = tables[0];
        var idColumn = table.Columns.FirstOrDefault(c => c.Name == "Id");
        Assert.NotNull(idColumn);
        Assert.True(idColumn.IsIdentity);
    }

    [Fact]
    public void Parse_DefaultValue_ExtractsDefaultValue()
    {
        // Arrange
        var sql = @"
            CREATE TABLE Orders (
                Id INT PRIMARY KEY IDENTITY(1,1),
                CreatedAt DATETIME2 NULL DEFAULT GETDATE()
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        var table = tables[0];
        var createdAtColumn = table.Columns.FirstOrDefault(c => c.Name == "CreatedAt");
        Assert.NotNull(createdAtColumn);
        Assert.NotNull(createdAtColumn.DefaultValue);
        Assert.Contains("GETDATE", createdAtColumn.DefaultValue.ToUpperInvariant());
    }

    [Fact]
    public void Parse_NullableColumn_SetsIsNullableTrue()
    {
        // Arrange
        var sql = @"
            CREATE TABLE TestTable (
                Id INT PRIMARY KEY,
                OptionalField NVARCHAR(100) NULL,
                RequiredField NVARCHAR(100) NOT NULL
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        var table = tables[0];

        var optionalField = table.Columns.FirstOrDefault(c => c.Name == "OptionalField");
        Assert.NotNull(optionalField);
        Assert.True(optionalField.IsNullable);

        var requiredField = table.Columns.FirstOrDefault(c => c.Name == "RequiredField");
        Assert.NotNull(requiredField);
        Assert.False(requiredField.IsNullable);
    }

    [Fact]
    public void Parse_DecimalWithPrecisionScale_ExtractsParameters()
    {
        // Arrange
        var sql = @"
            CREATE TABLE Products (
                Id INT PRIMARY KEY,
                Price DECIMAL(18,2) NOT NULL
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        var table = tables[0];
        var priceColumn = table.Columns.FirstOrDefault(c => c.Name == "Price");
        Assert.NotNull(priceColumn);
        Assert.Equal("DECIMAL", priceColumn.SqlType.ToUpperInvariant());
        Assert.Equal(18, priceColumn.Precision);
        Assert.Equal(2, priceColumn.Scale);
    }

    [Fact]
    public void Parse_MultipleTablesInOneScript_ReturnsAllTables()
    {
        // Arrange
        var sql = @"
            CREATE TABLE Categories (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(50) NOT NULL
            );

            CREATE TABLE Products (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(100) NOT NULL
            );

            CREATE TABLE Orders (
                Id INT PRIMARY KEY IDENTITY(1,1),
                OrderDate DATETIME2 NOT NULL
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        Assert.Equal(3, tables.Count);
        Assert.Contains(tables, t => t.Name == "Categories");
        Assert.Contains(tables, t => t.Name == "Products");
        Assert.Contains(tables, t => t.Name == "Orders");
    }

    [Fact]
    public void Parse_MalformedSql_ThrowsInvalidOperationException()
    {
        // Arrange
        var sql = "CREATE TABLE InvalidTable (Id INT NOTAVALIDKEYWORD);";
        var parser = new SqlDdlParser();

        // Act & Assert
        var exception = Assert.Throws<InvalidOperationException>(() => parser.Parse(sql));
        Assert.Contains("SQL parsing errors", exception.Message);
    }

    [Fact]
    public void Parse_EmptyString_ReturnsEmptyList()
    {
        // Arrange
        var sql = "";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        Assert.Empty(tables);
    }

    [Fact]
    public void Parse_TableWithMultipleForeignKeys_ExtractsAllRelationships()
    {
        // Arrange
        var sql = @"
            CREATE TABLE Companies (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(200) NOT NULL
            );

            CREATE TABLE Products (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(100) NOT NULL
            );

            CREATE TABLE CompanyProducts (
                Id INT PRIMARY KEY IDENTITY(1,1),
                CompanyId INT NOT NULL,
                ProductId INT NOT NULL,
                FOREIGN KEY (CompanyId) REFERENCES Companies(Id),
                FOREIGN KEY (ProductId) REFERENCES Products(Id)
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        var companyProductsTable = tables.FirstOrDefault(t => t.Name == "CompanyProducts");
        Assert.NotNull(companyProductsTable);
        Assert.Equal(2, companyProductsTable.ForeignKeys.Count);

        Assert.Contains(companyProductsTable.ForeignKeys, fk =>
            fk.ColumnName == "CompanyId" && fk.ReferencedTable == "Companies");
        Assert.Contains(companyProductsTable.ForeignKeys, fk =>
            fk.ColumnName == "ProductId" && fk.ReferencedTable == "Products");
    }

    [Fact]
    public void Parse_TableLevelPrimaryKey_MarksPrimaryKeyColumns()
    {
        // Arrange
        var sql = @"
            CREATE TABLE TestTable (
                Id INT NOT NULL,
                Code NVARCHAR(10) NOT NULL,
                PRIMARY KEY (Id)
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        var table = tables[0];
        var idColumn = table.Columns.FirstOrDefault(c => c.Name == "Id");
        Assert.NotNull(idColumn);
        Assert.True(idColumn.IsPrimaryKey);

        var codeColumn = table.Columns.FirstOrDefault(c => c.Name == "Code");
        Assert.NotNull(codeColumn);
        Assert.False(codeColumn.IsPrimaryKey);
    }

    [Fact]
    public void Parse_VariousDataTypes_ParsesCorrectly()
    {
        // Arrange
        var sql = @"
            CREATE TABLE DataTypeTest (
                IntField INT,
                BigIntField BIGINT,
                VarcharField VARCHAR(255),
                NVarcharField NVARCHAR(MAX),
                DateField DATE,
                DateTime2Field DATETIME2,
                BitField BIT,
                DecimalField DECIMAL(10,5),
                MoneyField MONEY
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        var table = tables[0];
        Assert.Equal(9, table.Columns.Count);

        Assert.Contains(table.Columns, c => c.Name == "IntField" && c.SqlType.ToUpperInvariant() == "INT");
        Assert.Contains(table.Columns, c => c.Name == "BigIntField" && c.SqlType.ToUpperInvariant() == "BIGINT");
        Assert.Contains(table.Columns, c => c.Name == "VarcharField" && c.SqlType.ToUpperInvariant() == "VARCHAR");
        Assert.Contains(table.Columns, c => c.Name == "DateField" && c.SqlType.ToUpperInvariant() == "DATE");
        Assert.Contains(table.Columns, c => c.Name == "BitField" && c.SqlType.ToUpperInvariant() == "BIT");
        Assert.Contains(table.Columns, c => c.Name == "MoneyField" && c.SqlType.ToUpperInvariant() == "MONEY");
    }

    [Fact]
    public void Parse_WithCreateSchema_IgnoresSchemaAndExtractsTables()
    {
        // Arrange - Multiple schemas with tables
        var sql = @"
            CREATE SCHEMA acme;

            CREATE TABLE acme.Categories (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(50) NOT NULL
            );

            CREATE TABLE acme.Products (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(100) NOT NULL,
                CategoryId INT NULL,
                FOREIGN KEY (CategoryId) REFERENCES acme.Categories(Id)
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        Assert.Equal(2, tables.Count);

        // Verify tables are extracted (schema prefix ignored)
        Assert.Contains(tables, t => t.Name == "Categories");
        Assert.Contains(tables, t => t.Name == "Products");

        var productsTable = tables.FirstOrDefault(t => t.Name == "Products");
        Assert.NotNull(productsTable);
        Assert.Single(productsTable.ForeignKeys);
    }

    [Fact]
    public void Parse_WithBracketedSchema_IgnoresSchemaAndExtractsTables()
    {
        // Arrange - Schema name in brackets
        var sql = @"
            CREATE SCHEMA [tenant1];

            CREATE TABLE [tenant1].Users (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Email NVARCHAR(255) NOT NULL
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        Assert.Single(tables);
        Assert.Equal("Users", tables[0].Name);
    }

    [Fact]
    public void Parse_MultipleSchemas_ExtractsTablesFromAll()
    {
        // Arrange - Multiple schema definitions
        var sql = @"
            CREATE SCHEMA acme;
            CREATE SCHEMA tenant1;

            CREATE TABLE acme.Products (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(100) NOT NULL
            );

            CREATE TABLE tenant1.Products (
                Id INT PRIMARY KEY IDENTITY(1,1),
                Name NVARCHAR(100) NOT NULL
            );";
        var parser = new SqlDdlParser();

        // Act
        var tables = parser.Parse(sql);

        // Assert
        Assert.Equal(2, tables.Count);
        Assert.All(tables, t => Assert.Equal("Products", t.Name));
    }
}
