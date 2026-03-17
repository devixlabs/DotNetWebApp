using ModelGenerator;
using Xunit;

namespace ModelGenerator.Tests
{
    public class SqlSelectParserTests
    {
        private readonly SqlSelectParser _parser = new();

        [Fact]
        public void ParseColumnsFromSql_SimpleSelect_ExtractsAliases()
        {
            var sql = @"
                SELECT
                    p.id AS ProductId,
                    p.name AS ProductName
                FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Equal(2, columns.Count);
            Assert.Equal("ProductId", columns[0].Name);
            Assert.Equal("ProductName", columns[1].Name);
        }

        [Fact]
        public void ParseColumnsFromSql_WithTopN_ExtractsColumns()
        {
            var sql = @"
                SELECT TOP (@TopN)
                    p.pr_id AS ProductId,
                    p.pr_descrip AS ProductName
                FROM dbo.dmprod p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Equal(2, columns.Count);
            Assert.Equal("ProductId", columns[0].Name);
            Assert.Equal("ProductName", columns[1].Name);
        }

        [Fact]
        public void ParseColumnsFromSql_IdColumn_InfersInt()
        {
            var sql = "SELECT p.pr_id AS ProductId FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("int", columns[0].Type);
            Assert.False(columns[0].Nullable);
        }

        [Fact]
        public void ParseColumnsFromSql_PriceColumn_InfersDecimal()
        {
            var sql = "SELECT p.pr_lispric AS Price FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("decimal", columns[0].Type);
            Assert.True(columns[0].Nullable);
        }

        [Fact]
        public void ParseColumnsFromSql_CountFunction_InfersInt()
        {
            var sql = "SELECT COUNT(*) AS TotalCount FROM Products";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("int", columns[0].Type);
        }

        [Fact]
        public void ParseColumnsFromSql_CoalesceCount_InfersInt()
        {
            var sql = "SELECT COALESCE(COUNT(id), 0) AS VendorCount FROM Vendors";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("int", columns[0].Type);
            Assert.False(columns[0].Nullable);
        }

        [Fact]
        public void ParseColumnsFromSql_Multiplication_InfersDecimal()
        {
            var sql = "SELECT COUNT(id) * price AS TotalValue FROM Products";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("decimal", columns[0].Type);
        }

        [Fact]
        public void ParseColumnsFromSql_CoalesceWithMultiplication_InfersDecimal()
        {
            var sql = "SELECT COALESCE(COUNT(id) * p.price, 0) AS TotalValue FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("decimal", columns[0].Type);
        }

        [Fact]
        public void ParseColumnsFromSql_StringColumn_InfersString()
        {
            var sql = "SELECT p.name AS ProductName FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("string", columns[0].Type);
            Assert.True(columns[0].Nullable);
        }

        [Fact]
        public void ParseColumnsFromSql_NoAsKeyword_UsesColumnName()
        {
            var sql = "SELECT p.product_name FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("product_name", columns[0].Name);
        }

        [Fact]
        public void ParseColumnsFromSql_RemovesComments()
        {
            var sql = @"
                -- This is a comment
                SELECT
                    p.id AS ProductId /* inline comment */
                FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("ProductId", columns[0].Name);
        }

        [Fact]
        public void ParseColumnsFromSql_NestedParentheses_HandlesCorrectly()
        {
            var sql = @"
                SELECT
                    COALESCE(SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END), 0) AS ActiveCount,
                    p.name AS ProductName
                FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Equal(2, columns.Count);
            Assert.Equal("ActiveCount", columns[0].Name);
            Assert.Equal("ProductName", columns[1].Name);
        }

        [Fact]
        public void ParseColumnsFromSql_BracketedNames_TrimsBrackets()
        {
            var sql = "SELECT [p].[product_id] AS [ProductId] FROM [Products] [p]";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("ProductId", columns[0].Name);
        }

        [Fact]
        public void ParseColumnsFromSql_EmptySql_ReturnsEmptyList()
        {
            var columns = _parser.ParseColumnsFromSql("");

            Assert.Empty(columns);
        }

        [Fact]
        public void ParseColumnsFromSql_NoFromClause_ReturnsEmptyList()
        {
            var sql = "SELECT 1 + 1";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Empty(columns);
        }

        [Fact]
        public void ParseColumnsFromSql_DateColumn_InfersDateTime()
        {
            var sql = "SELECT p.created_date AS CreatedDate FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("datetime", columns[0].Type);
        }

        [Fact]
        public void ParseColumnsFromSql_BooleanPattern_InfersBool()
        {
            var sql = "SELECT p.is_active AS IsActive FROM Products p";

            var columns = _parser.ParseColumnsFromSql(sql);

            Assert.Single(columns);
            Assert.Equal("bool", columns[0].Type);
        }
    }
}
