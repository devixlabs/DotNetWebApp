namespace DdlParser;

/// <summary>
/// Maps SQL Server data types to YAML type names used in app.yaml and views.yaml.
/// These YAML types are then used by code generators to produce C# types.
///
/// Type mapping reference (30+ SQL Server types):
/// - Integer types: int, bigint (long), smallint (short), tinyint (byte)
/// - Decimal types: decimal, numeric, money, smallmoney, float, real
/// - Date/Time types: datetime, datetime2, date, time (TimeSpan), datetimeoffset, smalldatetime
/// - String types: varchar, nvarchar, char, nchar, text, ntext, xml
/// - Binary types: varbinary, binary, image (byte[])
/// - Boolean type: bit
/// - GUID type: uniqueidentifier (Guid)
/// - Special types: geography, geometry, hierarchyid, sql_variant (string fallback)
/// </summary>
public static class TypeMapper
{
    /// <summary>
    /// Converts SQL Server data type to YAML type name.
    /// YAML types map to C# types: int→int, long→long, short→short, byte→byte,
    /// decimal→decimal, float→float, double→double, datetime→DateTime,
    /// datetimeoffset→DateTimeOffset, timespan→TimeSpan, bool→bool,
    /// guid→Guid, bytes→byte[], string→string
    /// </summary>
    /// <param name="sqlType">SQL Server data type name (case-insensitive)</param>
    /// <returns>YAML type name for code generation</returns>
    public static string SqlToYamlType(string sqlType)
    {
        return sqlType.ToLowerInvariant() switch
        {
            // Integer types (sized appropriately for CLR)
            "int" or "integer" => "int",
            "bigint" => "long",
            "smallint" => "short",
            "tinyint" => "byte",

            // Decimal/Numeric types (high precision)
            "decimal" or "numeric" => "decimal",
            "money" or "smallmoney" => "decimal",

            // Floating-point types
            "float" => "double",       // SQL float(53) = C# double
            "real" => "float",         // SQL real = C# float (single precision)

            // Date/Time types
            "datetime" or "datetime2" or "smalldatetime" => "datetime",
            "date" => "datetime",      // Date-only, but DateTime in C#
            "time" => "timespan",      // Time-only → TimeSpan
            "datetimeoffset" => "datetimeoffset",
            "timestamp" or "rowversion" => "bytes", // SQL timestamp is actually row versioning

            // String types
            "varchar" or "nvarchar" => "string",
            "char" or "nchar" => "string",
            "text" or "ntext" => "string",
            "xml" => "string",         // XML stored/manipulated as string

            // Binary types
            "varbinary" or "binary" => "bytes",
            "image" => "bytes",        // Deprecated but still used

            // Boolean type
            "bit" => "bool",

            // GUID type
            "uniqueidentifier" => "guid",

            // SQL Server spatial types (require Microsoft.SqlServer.Types)
            // Map to string for YAML; actual CLR type depends on generator
            "geography" => "string",
            "geometry" => "string",

            // Hierarchical data type
            "hierarchyid" => "string",

            // Variant type (stores various SQL types)
            "sql_variant" => "string",

            // Default fallback for unknown types
            _ => "string"
        };
    }

    /// <summary>
    /// Gets the C# CLR type name for a YAML type.
    /// Used by code generators to produce strongly-typed properties.
    /// </summary>
    /// <param name="yamlType">YAML type name from app.yaml or views.yaml</param>
    /// <param name="isNullable">Whether the property should be nullable</param>
    /// <returns>C# type name (e.g., "int", "DateTime?", "byte[]")</returns>
    public static string YamlToClrType(string yamlType, bool isNullable = false)
    {
        var baseType = yamlType.ToLowerInvariant() switch
        {
            "int" => "int",
            "long" => "long",
            "short" => "short",
            "byte" => "byte",
            "decimal" => "decimal",
            "float" => "float",
            "double" => "double",
            "datetime" => "DateTime",
            "datetimeoffset" => "DateTimeOffset",
            "timespan" => "TimeSpan",
            "bool" => "bool",
            "guid" => "Guid",
            "bytes" => "byte[]",
            "string" => "string",
            _ => "string"
        };

        // Value types get nullable suffix; reference types (string, byte[]) don't need it
        var isValueType = baseType is not ("string" or "byte[]");

        if (isNullable && isValueType)
        {
            return $"{baseType}?";
        }

        return baseType;
    }

    /// <summary>
    /// Determines if a YAML type represents a value type (struct) in C#.
    /// Value types require nullable syntax (int?) for optional properties.
    /// </summary>
    /// <param name="yamlType">YAML type name</param>
    /// <returns>True if the type is a C# value type</returns>
    public static bool IsValueType(string yamlType)
    {
        return yamlType.ToLowerInvariant() switch
        {
            "string" or "bytes" => false,
            _ => true
        };
    }

    /// <summary>
    /// Gets the System.Data.DbType enum value for a YAML type.
    /// Used by Dapper for parameter type hints.
    /// </summary>
    /// <param name="yamlType">YAML type name</param>
    /// <returns>DbType enum member name (e.g., "DbType.Int32")</returns>
    public static string YamlToDbType(string yamlType)
    {
        return yamlType.ToLowerInvariant() switch
        {
            "int" => "DbType.Int32",
            "long" => "DbType.Int64",
            "short" => "DbType.Int16",
            "byte" => "DbType.Byte",
            "decimal" => "DbType.Decimal",
            "float" => "DbType.Single",
            "double" => "DbType.Double",
            "datetime" => "DbType.DateTime2",
            "datetimeoffset" => "DbType.DateTimeOffset",
            "timespan" => "DbType.Time",
            "bool" => "DbType.Boolean",
            "guid" => "DbType.Guid",
            "bytes" => "DbType.Binary",
            "string" => "DbType.String",
            _ => "DbType.String"
        };
    }
}
