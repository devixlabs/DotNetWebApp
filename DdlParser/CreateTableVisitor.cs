using Microsoft.SqlServer.TransactSql.ScriptDom;

namespace DdlParser;

public class CreateTableVisitor : TSqlFragmentVisitor
{
    public List<TableMetadata> Tables { get; } = new();

    public override void Visit(CreateTableStatement node)
    {
        // Get table name and schema from SchemaObjectName
        var tableName = GetIdentifierValue(node.SchemaObjectName) ?? "UnknownTable";
        var schema = GetSchemaName(node.SchemaObjectName) ?? string.Empty;
        var table = new TableMetadata { Name = tableName, Schema = schema };

        // Extract columns
        if (node.Definition?.ColumnDefinitions != null)
        {
            foreach (var columnDef in node.Definition.ColumnDefinitions)
            {
                var column = ExtractColumn(columnDef);
                if (column != null)
                {
                    table.Columns.Add(column);
                }
            }
        }

        // Extract table-level constraints (PRIMARY KEY, FOREIGN KEY)
        if (node.Definition?.TableConstraints != null)
        {
            var primaryKeyColumns = new HashSet<string>();

            foreach (var constraint in node.Definition.TableConstraints)
            {
                // Handle primary key constraints
                if (constraint is UniqueConstraintDefinition uniqueConstraint)
                {
                    if (uniqueConstraint.IsPrimaryKey)
                    {
                        foreach (var col in uniqueConstraint.Columns)
                        {
                            var colName = GetColumnWithSortOrderName(col);
                            if (colName != null)
                            {
                                primaryKeyColumns.Add(colName);
                            }
                        }
                    }
                }
                // Handle foreign key constraints
                else if (constraint is ForeignKeyConstraintDefinition fkConstraint)
                {
                    ExtractForeignKey(table, fkConstraint);
                }
            }

            // Mark primary key columns
            foreach (var col in table.Columns)
            {
                if (primaryKeyColumns.Contains(col.Name))
                {
                    col.IsPrimaryKey = true;
                }
            }
        }

        Tables.Add(table);
        base.Visit(node);
    }

    private ColumnMetadata? ExtractColumn(ColumnDefinition columnDef)
    {
        var columnName = GetIdentifierValue(columnDef.ColumnIdentifier) ?? "UnknownColumn";
        var column = new ColumnMetadata { Name = columnName };

        // Extract data type
        if (columnDef.DataType != null)
        {
            column.SqlType = GetIdentifierValue(columnDef.DataType) ?? "unknown";

            // Try to extract type parameters
            if (columnDef.DataType is SqlDataTypeReference sqlDataType)
            {
                ExtractTypeParameters(column, sqlDataType);
            }
        }

        // Extract nullability
        column.IsNullable = true;
        if (columnDef.Constraints != null)
        {
            foreach (var constraint in columnDef.Constraints)
            {
                if (constraint is NullableConstraintDefinition nullConstraint)
                {
                    column.IsNullable = nullConstraint.Nullable;
                    break;
                }
            }
        }

        // Extract IDENTITY
        if (columnDef.IdentityOptions != null)
        {
            column.IsIdentity = true;
        }

        // Extract DEFAULT value
        if (columnDef.DefaultConstraint != null)
        {
            column.DefaultValue = ExtractDefaultValue(columnDef.DefaultConstraint);
        }

        // Check for PRIMARY KEY constraint on column itself
        if (columnDef.Constraints != null)
        {
            foreach (var constraint in columnDef.Constraints)
            {
                if (constraint is UniqueConstraintDefinition uniqueConstraint && uniqueConstraint.IsPrimaryKey)
                {
                    column.IsPrimaryKey = true;
                    break;
                }
            }
        }

        return column;
    }

    private void ExtractTypeParameters(ColumnMetadata column, SqlDataTypeReference sqlDataType)
    {
        var typeName = column.SqlType.ToLowerInvariant();

        // Extract parameters based on type
        if ((typeName == "varchar" || typeName == "nvarchar" ||
             typeName == "char" || typeName == "nchar") &&
            sqlDataType.Parameters.Count > 0)
        {
            var lengthValue = ExtractLiteralValue(sqlDataType.Parameters[0]);
            if (lengthValue != null && int.TryParse(lengthValue, out var maxLength))
            {
                column.MaxLength = maxLength;
            }
        }
        else if ((typeName == "decimal" || typeName == "numeric") &&
                 sqlDataType.Parameters.Count >= 1)
        {
            var precisionValue = ExtractLiteralValue(sqlDataType.Parameters[0]);
            if (precisionValue != null && int.TryParse(precisionValue, out var precision))
            {
                column.Precision = precision;

                if (sqlDataType.Parameters.Count > 1)
                {
                    var scaleValue = ExtractLiteralValue(sqlDataType.Parameters[1]);
                    if (scaleValue != null && int.TryParse(scaleValue, out var scale))
                    {
                        column.Scale = scale;
                    }
                }
            }
        }
    }

    private string? ExtractLiteralValue(ScalarExpression expr)
    {
        return expr switch
        {
            IntegerLiteral intLit => intLit.Value,
            NumericLiteral numLit => numLit.Value,
            StringLiteral strLit => strLit.Value,
            _ => null
        };
    }

    private string? ExtractDefaultValue(DefaultConstraintDefinition defaultConstraint)
    {
        if (defaultConstraint.Expression == null)
            return null;

        return defaultConstraint.Expression switch
        {
            IntegerLiteral intLit => intLit.Value,
            NumericLiteral numLit => numLit.Value,
            StringLiteral strLit => strLit.Value,
            FunctionCall funcCall => funcCall.FunctionName.Value,
            _ => null
        };
    }

    private void ExtractForeignKey(TableMetadata table, ForeignKeyConstraintDefinition fkConstraint)
    {
        if (fkConstraint.Columns.Count == 0)
            return;

        // Get the foreign key column name
        var firstColumn = fkConstraint.Columns[0];
        string? fkColumnName = ExtractColumnName(firstColumn);

        if (fkColumnName == null)
            return;

        // Get the referenced table name
        var refTableName = GetIdentifierValue(fkConstraint.ReferenceTableName);
        if (refTableName == null)
            return;

        // Get the referenced column name
        string refColumnName = "Id";
        if (fkConstraint.ReferencedTableColumns.Count > 0)
        {
            refColumnName = GetIdentifierValue(fkConstraint.ReferencedTableColumns[0]) ?? "Id";
        }

        var fk = new ForeignKeyMetadata
        {
            ColumnName = fkColumnName,
            ReferencedTable = refTableName,
            ReferencedColumn = refColumnName
        };

        table.ForeignKeys.Add(fk);
    }

    private string? ExtractColumnName(object? columnObj)
    {
        if (columnObj == null)
            return null;

        // Check if it's a ColumnReferenceExpression
        if (columnObj is ColumnReferenceExpression colRef)
        {
            if (colRef.MultiPartIdentifier?.Identifiers.Count > 0)
            {
                var identifiers = colRef.MultiPartIdentifier.Identifiers;
                return identifiers[identifiers.Count - 1].Value;
            }
        }

        // Check if it's an Identifier
        if (columnObj is Identifier identifier)
        {
            return identifier.Value;
        }

        // Try reflection for Name property
        try
        {
            var nameProperty = columnObj.GetType().GetProperty("Name");
            if (nameProperty != null && nameProperty.GetValue(columnObj) is Identifier nameId)
            {
                return nameId.Value;
            }
        }
        catch
        {
            // Continue
        }

        return null;
    }

    private string? GetIdentifierValue(Identifier? identifier)
    {
        if (identifier == null)
            return null;

        return identifier.Value;
    }

    private string? GetIdentifierValue(SchemaObjectName? schemaObjectName)
    {
        if (schemaObjectName == null)
            return null;

        // Try the most common properties
        try
        {
            if (schemaObjectName.Identifiers != null && schemaObjectName.Identifiers.Count > 0)
            {
                // For schema.table format, get the last identifier (table name)
                var lastId = schemaObjectName.Identifiers[schemaObjectName.Identifiers.Count - 1];
                return lastId.Value;
            }
        }
        catch
        {
            // Fall through to try other properties
        }

        // Alternative: try Name property
        try
        {
            var nameProperty = typeof(SchemaObjectName).GetProperty("Name");
            if (nameProperty != null)
            {
                if (nameProperty.GetValue(schemaObjectName) is Identifier nameId)
                {
                    return nameId.Value;
                }
            }
        }
        catch
        {
            // Continue
        }

        return null;
    }

    private string? GetIdentifierValue(DataTypeReference? dataType)
    {
        if (dataType == null)
            return null;

        // For SqlDataTypeReference, get the Name
        if (dataType is SqlDataTypeReference sqlDataType)
        {
            return GetIdentifierValue(sqlDataType.Name);
        }

        // Try generic approach for other types
        try
        {
            var nameProperty = dataType.GetType().GetProperty("Name");
            if (nameProperty != null && nameProperty.GetValue(dataType) is Identifier nameId)
            {
                return nameId.Value;
            }
        }
        catch
        {
            // Continue
        }

        return null;
    }

    private string? GetColumnWithSortOrderName(ColumnWithSortOrder col)
    {
        if (col == null)
            return null;

        return ExtractColumnName(col.Column);
    }

    private string? GetSchemaName(SchemaObjectName? schemaObjectName)
    {
        if (schemaObjectName == null)
            return null;

        try
        {
            // SchemaObjectName with format "schema.table" has multiple identifiers
            // Index 0 = schema, Index 1 = table
            if (schemaObjectName.Identifiers != null && schemaObjectName.Identifiers.Count > 1)
            {
                return schemaObjectName.Identifiers[0].Value;
            }
        }
        catch
        {
            // Continue - no schema specified
        }

        // No schema specified, return null
        return null;
    }
}
