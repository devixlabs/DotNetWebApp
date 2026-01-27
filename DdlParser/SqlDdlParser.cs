using Microsoft.SqlServer.TransactSql.ScriptDom;

namespace DdlParser;

public class TableMetadata
{
    public string Name { get; set; } = string.Empty;
    public string Schema { get; set; } = string.Empty;
    public List<ColumnMetadata> Columns { get; set; } = new();
    public List<ForeignKeyMetadata> ForeignKeys { get; set; } = new();
}

public class ColumnMetadata
{
    public string Name { get; set; } = string.Empty;
    public string SqlType { get; set; } = string.Empty;
    public int? MaxLength { get; set; }
    public int? Precision { get; set; }
    public int? Scale { get; set; }
    public bool IsNullable { get; set; } = true;
    public bool IsPrimaryKey { get; set; }
    public bool IsIdentity { get; set; }
    public string? DefaultValue { get; set; }
}

public class ForeignKeyMetadata
{
    public string ColumnName { get; set; } = string.Empty;
    public string ReferencedTable { get; set; } = string.Empty;
    public string ReferencedColumn { get; set; } = string.Empty;
}

public class SqlDdlParser
{
    public List<TableMetadata> Parse(string sqlContent)
    {
        // Remove CREATE SCHEMA statements (parser doesn't need them, only CREATE TABLE)
        var processedSql = RemoveCreateSchemaStatements(sqlContent);

        var parser = new TSql160Parser(initialQuotedIdentifiers: false);

        TSqlFragment fragment;
        IList<ParseError> errors;

        using (var reader = new StringReader(processedSql))
        {
            fragment = parser.Parse(reader, out errors);
        }

        if (errors.Count > 0)
        {
            var errorMessages = string.Join("\n", errors.Select(e => $"Line {e.Line}: {e.Message}"));
            throw new InvalidOperationException($"SQL parsing errors:\n{errorMessages}");
        }

        if (fragment is not TSqlScript script)
        {
            throw new InvalidOperationException("Expected TSqlScript fragment");
        }

        var visitor = new CreateTableVisitor();
        fragment.Accept(visitor);

        return visitor.Tables;
    }

    /// <summary>
    /// Removes CREATE SCHEMA statements from SQL content.
    /// These are valid SQL but not needed for DDL table extraction.
    /// </summary>
    private static string RemoveCreateSchemaStatements(string sqlContent)
    {
        // Regex to match: CREATE SCHEMA [schema_name];
        // Handles optional schema name in brackets or plain identifier
        var pattern = @"CREATE\s+SCHEMA\s+(?:\[[\w]+\]|[\w]+)\s*;?";
        return System.Text.RegularExpressions.Regex.Replace(
            sqlContent,
            pattern,
            string.Empty,
            System.Text.RegularExpressions.RegexOptions.IgnoreCase);
    }
}
