using DdlParser;
using Xunit;

namespace DdlParser.Tests;

public class TypeMapperTests
{
    [Theory]
    [InlineData("INT", "int")]
    [InlineData("INTEGER", "int")]
    [InlineData("BIGINT", "int")]
    [InlineData("SMALLINT", "int")]
    [InlineData("TINYINT", "int")]
    [InlineData("int", "int")]
    [InlineData("bigint", "int")]
    public void SqlToYamlType_IntegerTypes_ReturnsInt(string sqlType, string expected)
    {
        // Act
        var result = TypeMapper.SqlToYamlType(sqlType);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("VARCHAR", "string")]
    [InlineData("NVARCHAR", "string")]
    [InlineData("CHAR", "string")]
    [InlineData("NCHAR", "string")]
    [InlineData("TEXT", "string")]
    [InlineData("NTEXT", "string")]
    [InlineData("VARBINARY", "string")]
    [InlineData("BINARY", "string")]
    [InlineData("UNIQUEIDENTIFIER", "string")]
    [InlineData("varchar", "string")]
    [InlineData("nvarchar", "string")]
    public void SqlToYamlType_StringTypes_ReturnsString(string sqlType, string expected)
    {
        // Act
        var result = TypeMapper.SqlToYamlType(sqlType);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("DECIMAL", "decimal")]
    [InlineData("NUMERIC", "decimal")]
    [InlineData("MONEY", "decimal")]
    [InlineData("SMALLMONEY", "decimal")]
    [InlineData("FLOAT", "decimal")]
    [InlineData("REAL", "decimal")]
    [InlineData("decimal", "decimal")]
    [InlineData("money", "decimal")]
    public void SqlToYamlType_DecimalTypes_ReturnsDecimal(string sqlType, string expected)
    {
        // Act
        var result = TypeMapper.SqlToYamlType(sqlType);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("DATETIME", "datetime")]
    [InlineData("DATETIME2", "datetime")]
    [InlineData("DATE", "datetime")]
    [InlineData("TIME", "datetime")]
    [InlineData("DATETIMEOFFSET", "datetime")]
    [InlineData("TIMESTAMP", "datetime")]
    [InlineData("SMALLDATETIME", "datetime")]
    [InlineData("datetime", "datetime")]
    [InlineData("datetime2", "datetime")]
    public void SqlToYamlType_DateTimeTypes_ReturnsDateTime(string sqlType, string expected)
    {
        // Act
        var result = TypeMapper.SqlToYamlType(sqlType);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("BIT", "bool")]
    [InlineData("bit", "bool")]
    public void SqlToYamlType_BooleanType_ReturnsBool(string sqlType, string expected)
    {
        // Act
        var result = TypeMapper.SqlToYamlType(sqlType);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("UNKNOWN_TYPE")]
    [InlineData("CUSTOM_TYPE")]
    [InlineData("")]
    public void SqlToYamlType_UnknownType_ReturnsString(string sqlType)
    {
        // Act
        var result = TypeMapper.SqlToYamlType(sqlType);

        // Assert - Unknown types default to string
        Assert.Equal("string", result);
    }

    [Fact]
    public void SqlToYamlType_CaseInsensitive_WorksCorrectly()
    {
        // Arrange & Act
        var upperResult = TypeMapper.SqlToYamlType("VARCHAR");
        var lowerResult = TypeMapper.SqlToYamlType("varchar");
        var mixedResult = TypeMapper.SqlToYamlType("VarChar");

        // Assert
        Assert.Equal("string", upperResult);
        Assert.Equal("string", lowerResult);
        Assert.Equal("string", mixedResult);
    }
}
