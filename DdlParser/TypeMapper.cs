namespace DdlParser;

public static class TypeMapper
{
    public static string SqlToYamlType(string sqlType)
    {
        return sqlType.ToLowerInvariant() switch
        {
            // Integer types
            "int" => "int",
            "integer" => "int",
            "bigint" => "int",
            "smallint" => "int",
            "tinyint" => "int",

            // String types
            "varchar" => "string",
            "nvarchar" => "string",
            "char" => "string",
            "nchar" => "string",
            "text" => "string",
            "ntext" => "string",
            "varbinary" => "string",
            "binary" => "string",

            // Decimal types
            "decimal" => "decimal",
            "numeric" => "decimal",
            "money" => "decimal",
            "smallmoney" => "decimal",

            // Float/Double types
            "float" => "decimal",
            "real" => "decimal",

            // DateTime types
            "datetime" => "datetime",
            "datetime2" => "datetime",
            "date" => "datetime",
            "time" => "datetime",
            "datetimeoffset" => "datetime",
            "timestamp" => "datetime",
            "smalldatetime" => "datetime",

            // Boolean type
            "bit" => "bool",

            // GUID
            "uniqueidentifier" => "string",

            // Default fallback
            _ => "string"
        };
    }
}
