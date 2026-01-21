using Microsoft.SqlServer.TransactSql.ScriptDom;

namespace DdlParser;

public class TableMetadata
{
    public string Name { get; set; } = string.Empty;
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
        var parser = new TSql160Parser(initialQuotedIdentifiers: false);

        TSqlFragment fragment;
        IList<ParseError> errors;

        using (var reader = new StringReader(sqlContent))
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
}
