using DdlParser;
using Xunit;

namespace DdlParser.Tests;

/// <summary>
/// Tests for TypeMapper SQL Server to YAML type conversion.
/// Updated to reflect comprehensive 30+ type mappings (2026-01-27).
/// </summary>
public class TypeMapperTests
{
    #region Integer Types (sized appropriately for CLR)

    [Theory]
    [InlineData("INT", "int")]
    [InlineData("INTEGER", "int")]
    [InlineData("int", "int")]
    public void SqlToYamlType_IntTypes_ReturnsInt(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("BIGINT", "long")]
    [InlineData("bigint", "long")]
    public void SqlToYamlType_BigIntType_ReturnsLong(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("SMALLINT", "short")]
    [InlineData("smallint", "short")]
    public void SqlToYamlType_SmallIntType_ReturnsShort(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("TINYINT", "byte")]
    [InlineData("tinyint", "byte")]
    public void SqlToYamlType_TinyIntType_ReturnsByte(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region String Types

    [Theory]
    [InlineData("VARCHAR", "string")]
    [InlineData("NVARCHAR", "string")]
    [InlineData("CHAR", "string")]
    [InlineData("NCHAR", "string")]
    [InlineData("TEXT", "string")]
    [InlineData("NTEXT", "string")]
    [InlineData("XML", "string")]
    [InlineData("varchar", "string")]
    [InlineData("nvarchar", "string")]
    public void SqlToYamlType_StringTypes_ReturnsString(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region Binary Types

    [Theory]
    [InlineData("VARBINARY", "bytes")]
    [InlineData("BINARY", "bytes")]
    [InlineData("IMAGE", "bytes")]
    [InlineData("varbinary", "bytes")]
    [InlineData("binary", "bytes")]
    public void SqlToYamlType_BinaryTypes_ReturnsBytes(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("TIMESTAMP", "bytes")]
    [InlineData("ROWVERSION", "bytes")]
    [InlineData("timestamp", "bytes")]
    public void SqlToYamlType_RowVersionTypes_ReturnsBytes(string sqlType, string expected)
    {
        // SQL Server TIMESTAMP is actually a row version marker, not a datetime
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region Decimal/Numeric Types

    [Theory]
    [InlineData("DECIMAL", "decimal")]
    [InlineData("NUMERIC", "decimal")]
    [InlineData("MONEY", "decimal")]
    [InlineData("SMALLMONEY", "decimal")]
    [InlineData("decimal", "decimal")]
    [InlineData("money", "decimal")]
    public void SqlToYamlType_DecimalTypes_ReturnsDecimal(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region Floating-Point Types

    [Theory]
    [InlineData("FLOAT", "double")]
    [InlineData("float", "double")]
    public void SqlToYamlType_FloatType_ReturnsDouble(string sqlType, string expected)
    {
        // SQL FLOAT(53) maps to C# double
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("REAL", "float")]
    [InlineData("real", "float")]
    public void SqlToYamlType_RealType_ReturnsFloat(string sqlType, string expected)
    {
        // SQL REAL maps to C# float (single precision)
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region Date/Time Types

    [Theory]
    [InlineData("DATETIME", "datetime")]
    [InlineData("DATETIME2", "datetime")]
    [InlineData("DATE", "datetime")]
    [InlineData("SMALLDATETIME", "datetime")]
    [InlineData("datetime", "datetime")]
    [InlineData("datetime2", "datetime")]
    public void SqlToYamlType_DateTimeTypes_ReturnsDateTime(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("TIME", "timespan")]
    [InlineData("time", "timespan")]
    public void SqlToYamlType_TimeType_ReturnsTimeSpan(string sqlType, string expected)
    {
        // SQL TIME maps to C# TimeSpan
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData("DATETIMEOFFSET", "datetimeoffset")]
    [InlineData("datetimeoffset", "datetimeoffset")]
    public void SqlToYamlType_DateTimeOffsetType_ReturnsDateTimeOffset(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region Boolean Type

    [Theory]
    [InlineData("BIT", "bool")]
    [InlineData("bit", "bool")]
    public void SqlToYamlType_BooleanType_ReturnsBool(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region GUID Type

    [Theory]
    [InlineData("UNIQUEIDENTIFIER", "guid")]
    [InlineData("uniqueidentifier", "guid")]
    public void SqlToYamlType_GuidType_ReturnsGuid(string sqlType, string expected)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region Special SQL Server Types (fallback to string)

    [Theory]
    [InlineData("GEOGRAPHY", "string")]
    [InlineData("GEOMETRY", "string")]
    [InlineData("HIERARCHYID", "string")]
    [InlineData("SQL_VARIANT", "string")]
    [InlineData("geography", "string")]
    [InlineData("geometry", "string")]
    public void SqlToYamlType_SpecialTypes_ReturnsString(string sqlType, string expected)
    {
        // Special SQL Server types fall back to string for safety
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region Unknown/Default Types

    [Theory]
    [InlineData("UNKNOWN_TYPE")]
    [InlineData("CUSTOM_TYPE")]
    [InlineData("")]
    public void SqlToYamlType_UnknownType_ReturnsString(string sqlType)
    {
        var result = TypeMapper.SqlToYamlType(sqlType);
        Assert.Equal("string", result);
    }

    #endregion

    #region Case Insensitivity

    [Fact]
    public void SqlToYamlType_CaseInsensitive_WorksCorrectly()
    {
        var upperResult = TypeMapper.SqlToYamlType("VARCHAR");
        var lowerResult = TypeMapper.SqlToYamlType("varchar");
        var mixedResult = TypeMapper.SqlToYamlType("VarChar");

        Assert.Equal("string", upperResult);
        Assert.Equal("string", lowerResult);
        Assert.Equal("string", mixedResult);
    }

    #endregion

    #region YamlToClrType Tests

    [Theory]
    [InlineData("int", false, "int")]
    [InlineData("int", true, "int?")]
    [InlineData("long", false, "long")]
    [InlineData("long", true, "long?")]
    [InlineData("short", false, "short")]
    [InlineData("byte", false, "byte")]
    [InlineData("decimal", false, "decimal")]
    [InlineData("decimal", true, "decimal?")]
    [InlineData("float", false, "float")]
    [InlineData("double", false, "double")]
    [InlineData("datetime", false, "DateTime")]
    [InlineData("datetime", true, "DateTime?")]
    [InlineData("datetimeoffset", false, "DateTimeOffset")]
    [InlineData("timespan", false, "TimeSpan")]
    [InlineData("bool", false, "bool")]
    [InlineData("bool", true, "bool?")]
    [InlineData("guid", false, "Guid")]
    [InlineData("guid", true, "Guid?")]
    [InlineData("string", false, "string")]
    [InlineData("string", true, "string")]  // string doesn't get nullable suffix
    [InlineData("bytes", false, "byte[]")]
    [InlineData("bytes", true, "byte[]")]   // byte[] doesn't get nullable suffix
    public void YamlToClrType_ReturnsCorrectClrType(string yamlType, bool isNullable, string expected)
    {
        var result = TypeMapper.YamlToClrType(yamlType, isNullable);
        Assert.Equal(expected, result);
    }

    #endregion

    #region IsValueType Tests

    [Theory]
    [InlineData("int", true)]
    [InlineData("long", true)]
    [InlineData("decimal", true)]
    [InlineData("datetime", true)]
    [InlineData("bool", true)]
    [InlineData("guid", true)]
    [InlineData("string", false)]
    [InlineData("bytes", false)]
    public void IsValueType_ReturnsCorrectResult(string yamlType, bool expected)
    {
        var result = TypeMapper.IsValueType(yamlType);
        Assert.Equal(expected, result);
    }

    #endregion

    #region YamlToDbType Tests

    [Theory]
    [InlineData("int", "DbType.Int32")]
    [InlineData("long", "DbType.Int64")]
    [InlineData("short", "DbType.Int16")]
    [InlineData("byte", "DbType.Byte")]
    [InlineData("decimal", "DbType.Decimal")]
    [InlineData("float", "DbType.Single")]
    [InlineData("double", "DbType.Double")]
    [InlineData("datetime", "DbType.DateTime2")]
    [InlineData("datetimeoffset", "DbType.DateTimeOffset")]
    [InlineData("timespan", "DbType.Time")]
    [InlineData("bool", "DbType.Boolean")]
    [InlineData("guid", "DbType.Guid")]
    [InlineData("bytes", "DbType.Binary")]
    [InlineData("string", "DbType.String")]
    public void YamlToDbType_ReturnsCorrectDbType(string yamlType, string expected)
    {
        var result = TypeMapper.YamlToDbType(yamlType);
        Assert.Equal(expected, result);
    }

    #endregion
}
