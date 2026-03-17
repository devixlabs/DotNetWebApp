using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using DotNetWebApp.Models.AppDictionary;

namespace ModelGenerator
{
    /// <summary>
    /// Parses SQL SELECT statements to extract column aliases and infer types.
    /// Used by ViewModelGenerator to auto-generate view model properties from SQL files.
    /// </summary>
    public class SqlSelectParser
    {
        /// <summary>
        /// Parses a SQL file and extracts column definitions from the SELECT clause.
        /// </summary>
        /// <param name="sqlFilePath">Path to the SQL file</param>
        /// <returns>List of ViewProperty objects representing the columns</returns>
        public List<ViewProperty> ParseColumns(string sqlFilePath)
        {
            if (!File.Exists(sqlFilePath))
            {
                Console.WriteLine($"Warning: SQL file not found: {sqlFilePath}");
                return new List<ViewProperty>();
            }

            var sql = File.ReadAllText(sqlFilePath);
            return ParseColumnsFromSql(sql);
        }

        /// <summary>
        /// Parses SQL content and extracts column definitions from the SELECT clause.
        /// </summary>
        public List<ViewProperty> ParseColumnsFromSql(string sql)
        {
            var properties = new List<ViewProperty>();

            // Remove comments
            sql = RemoveComments(sql);

            // Extract SELECT...FROM portion
            var selectClause = ExtractSelectClause(sql);
            if (string.IsNullOrWhiteSpace(selectClause))
            {
                Console.WriteLine("Warning: Could not extract SELECT clause from SQL");
                return properties;
            }

            // Split by comma, respecting parentheses
            var columns = SplitColumns(selectClause);

            foreach (var column in columns)
            {
                var property = ParseColumn(column.Trim());
                if (property != null)
                {
                    properties.Add(property);
                }
            }

            return properties;
        }

        private string RemoveComments(string sql)
        {
            // Remove single-line comments (-- ...)
            sql = Regex.Replace(sql, @"--.*$", "", RegexOptions.Multiline);
            // Remove multi-line comments (/* ... */)
            sql = Regex.Replace(sql, @"/\*[\s\S]*?\*/", "", RegexOptions.Multiline);
            return sql;
        }

        private string? ExtractSelectClause(string sql)
        {
            // Match SELECT ... FROM (case-insensitive)
            // Handle SELECT TOP (@n) or SELECT TOP n
            var match = Regex.Match(sql,
                @"\bSELECT\s+(?:TOP\s*\([^)]+\)\s+|TOP\s+\d+\s+|DISTINCT\s+)?([\s\S]+?)\bFROM\b",
                RegexOptions.IgnoreCase);

            return match.Success ? match.Groups[1].Value.Trim() : null;
        }

        private List<string> SplitColumns(string selectClause)
        {
            var columns = new List<string>();
            var current = new System.Text.StringBuilder();
            var parenDepth = 0;

            foreach (var ch in selectClause)
            {
                if (ch == '(') parenDepth++;
                else if (ch == ')') parenDepth--;
                else if (ch == ',' && parenDepth == 0)
                {
                    columns.Add(current.ToString());
                    current.Clear();
                    continue;
                }
                current.Append(ch);
            }

            if (current.Length > 0)
            {
                columns.Add(current.ToString());
            }

            return columns;
        }

        private ViewProperty? ParseColumn(string column)
        {
            if (string.IsNullOrWhiteSpace(column))
                return null;

            // Normalize whitespace
            column = Regex.Replace(column, @"\s+", " ").Trim();

            // Extract alias: "expression AS alias" or just "alias" or "table.column"
            string alias;
            string expression;

            var asMatch = Regex.Match(column, @"(.+?)\s+AS\s+(\[?[\w]+\]?)\s*$", RegexOptions.IgnoreCase);
            if (asMatch.Success)
            {
                expression = asMatch.Groups[1].Value.Trim();
                alias = asMatch.Groups[2].Value.Trim().Trim('[', ']');
            }
            else
            {
                // No AS keyword - use the column name
                expression = column;
                var dotMatch = Regex.Match(column, @"\.(\[?[\w]+\]?)\s*$");
                if (dotMatch.Success)
                {
                    alias = dotMatch.Groups[1].Value.Trim().Trim('[', ']');
                }
                else
                {
                    alias = column.Trim().Trim('[', ']');
                }
            }

            // Skip parameters (e.g., @TopN by itself)
            if (alias.StartsWith("@"))
                return null;

            var type = InferType(expression);

            return new ViewProperty
            {
                Name = alias,
                Type = type.TypeName,
                Nullable = type.IsNullable
            };
        }

        private (string TypeName, bool IsNullable) InferType(string expression)
        {
            expression = expression.ToUpperInvariant();

            // Multiplication in expression typically returns decimal (check first)
            // Exclude COUNT(*) and similar aggregate(*) patterns
            if (expression.Contains("*") &&
                !Regex.IsMatch(expression, @"^\s*\d+\s*$") &&
                !Regex.IsMatch(expression, @"\(\s*\*\s*\)"))
                return ("decimal", true);

            // COUNT, SUM of integers (after multiplication check)
            if (Regex.IsMatch(expression, @"\bCOUNT\s*\("))
                return ("int", false);

            // SUM, AVG typically return decimal
            if (Regex.IsMatch(expression, @"\b(SUM|AVG)\s*\("))
                return ("decimal", true);

            // COALESCE wrapping COUNT without multiplication
            if (Regex.IsMatch(expression, @"\bCOALESCE\s*\(\s*COUNT[^*]+\)$"))
                return ("int", false);

            // COALESCE with 0 default suggests non-nullable numeric
            if (Regex.IsMatch(expression, @"\bCOALESCE\s*\([^,]+,\s*0\s*\)"))
                return ("decimal", false);

            // Date functions
            if (Regex.IsMatch(expression, @"\b(GETDATE|GETUTCDATE|SYSDATETIME|CURRENT_TIMESTAMP)\s*\("))
                return ("datetime", false);

            // CAST/CONVERT hints
            var castMatch = Regex.Match(expression, @"\b(CAST|CONVERT)\s*\([^,]+,?\s*(INT|BIGINT|SMALLINT|TINYINT|DECIMAL|NUMERIC|FLOAT|REAL|MONEY|DATETIME|DATE|BIT|VARCHAR|NVARCHAR|CHAR|NCHAR)");
            if (castMatch.Success)
            {
                return MapSqlType(castMatch.Groups[2].Value);
            }

            // Column name hints (common patterns)
            // Match _id at end of identifier (e.g., pr_id, pr_prunid)
            if (Regex.IsMatch(expression, @"[._]id\b", RegexOptions.IgnoreCase))
                return ("int", false);

            // Match price/cost patterns including partial matches (e.g., pr_lispric, cost_total)
            if (Regex.IsMatch(expression, @"(price|pric|cost|amount|total|factor|value)\b", RegexOptions.IgnoreCase))
                return ("decimal", true);

            // Match count/quantity patterns
            if (Regex.IsMatch(expression, @"(count|qty|quantity|num)\b", RegexOptions.IgnoreCase))
                return ("int", true);

            // Match date/time patterns
            if (Regex.IsMatch(expression, @"(date|time|created|updated|modified)\b", RegexOptions.IgnoreCase))
                return ("datetime", true);

            // Match boolean patterns
            if (Regex.IsMatch(expression, @"(is_|has_|can_|active|enabled|flag)\b", RegexOptions.IgnoreCase))
                return ("bool", true);

            // Default to nullable string (safest for unknown types)
            return ("string", true);
        }

        private (string TypeName, bool IsNullable) MapSqlType(string sqlType)
        {
            return sqlType.ToUpperInvariant() switch
            {
                "INT" => ("int", false),
                "BIGINT" => ("long", false),
                "SMALLINT" => ("short", false),
                "TINYINT" => ("byte", false),
                "DECIMAL" or "NUMERIC" or "MONEY" => ("decimal", true),
                "FLOAT" => ("double", true),
                "REAL" => ("float", true),
                "DATETIME" or "DATE" or "DATETIME2" => ("datetime", true),
                "BIT" => ("bool", false),
                "VARCHAR" or "NVARCHAR" or "CHAR" or "NCHAR" => ("string", true),
                _ => ("string", true)
            };
        }
    }
}
