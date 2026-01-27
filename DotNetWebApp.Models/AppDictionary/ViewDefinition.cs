using YamlDotNet.Serialization;

#nullable disable

namespace DotNetWebApp.Models.AppDictionary
{
    /// <summary>
    /// Root container for views.yaml file.
    /// Defines SQL views that map to Dapper DTOs.
    /// </summary>
    public class ViewsDefinition
    {
        /// <summary>
        /// List of SQL view definitions.
        /// </summary>
        public List<ViewDefinition> Views { get; set; } = new();
    }

    /// <summary>
    /// Defines a SQL view for code generation.
    /// Each view maps to a generated C# class and SQL file.
    /// </summary>
    public class ViewDefinition
    {
        /// <summary>
        /// View name, used as the C# class name.
        /// Example: "ProductSalesView"
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Human-readable description of the view.
        /// Used in XML documentation comments.
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// Path to the SQL file containing the SELECT query.
        /// Relative to the views.yaml location.
        /// Example: "sql/views/ProductSalesView.sql"
        /// </summary>
        [YamlMember(Alias = "sql_file")]
        public string SqlFile { get; set; }

        /// <summary>
        /// Whether to generate as partial class (default: true).
        /// Enables user extensions in separate {Name}.cs file.
        /// </summary>
        [YamlMember(Alias = "generate_partial")]
        public bool GeneratePartial { get; set; } = true;

        /// <summary>
        /// SQL query parameters (e.g., @TopN, @CategoryId).
        /// </summary>
        public List<ViewParameter> Parameters { get; set; }

        /// <summary>
        /// Properties/columns returned by the query.
        /// </summary>
        public List<ViewProperty> Properties { get; set; } = new();
    }

    /// <summary>
    /// Defines a parameter for a SQL view query.
    /// Parameters are passed to Dapper when executing the view.
    /// </summary>
    public class ViewParameter
    {
        /// <summary>
        /// Parameter name (without @ prefix).
        /// Example: "TopN" for @TopN in SQL.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// YAML type name (int, string, decimal, datetime, etc.).
        /// See TypeMapper for SQL to YAML mappings.
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// Whether the parameter is nullable/optional.
        /// </summary>
        public bool Nullable { get; set; }

        /// <summary>
        /// Default value if not provided.
        /// Example: "10" for an int parameter.
        /// </summary>
        public string Default { get; set; }

        /// <summary>
        /// Validation rules for the parameter.
        /// Generates DataAnnotations on the parameter class.
        /// </summary>
        public ValidationConfig Validation { get; set; }
    }

    /// <summary>
    /// Defines a property/column in a view model.
    /// Maps to a generated C# property with optional validation.
    /// </summary>
    public class ViewProperty
    {
        /// <summary>
        /// Property name, matches the SQL column alias.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// YAML type name (int, string, decimal, datetime, etc.).
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        /// Whether the property can be null.
        /// Affects nullable suffix on value types.
        /// </summary>
        public bool Nullable { get; set; }

        /// <summary>
        /// Maximum string length (for varchar/nvarchar columns).
        /// Generates [MaxLength] attribute.
        /// </summary>
        [YamlMember(Alias = "max_length")]
        public int? MaxLength { get; set; }

        /// <summary>
        /// Validation rules for the property.
        /// Generates DataAnnotations on the property.
        /// </summary>
        public ValidationConfig Validation { get; set; }
    }

    /// <summary>
    /// Validation configuration for properties and parameters.
    /// Generates DataAnnotations (Required, Range, MaxLength).
    /// </summary>
    public class ValidationConfig
    {
        /// <summary>
        /// Whether the value is required (non-null).
        /// Generates [Required] attribute.
        /// </summary>
        public bool Required { get; set; }

        /// <summary>
        /// Numeric range as [min, max] array.
        /// Generates [Range(min, max)] attribute.
        /// Example: [1, 1000]
        /// </summary>
        public List<object> Range { get; set; }

        /// <summary>
        /// Maximum string length.
        /// Generates [MaxLength(n)] attribute.
        /// </summary>
        [YamlMember(Alias = "max_length")]
        public int? MaxLength { get; set; }

        /// <summary>
        /// Minimum string length.
        /// Generates [MinLength(n)] attribute.
        /// </summary>
        [YamlMember(Alias = "min_length")]
        public int? MinLength { get; set; }

        /// <summary>
        /// Regular expression pattern for validation.
        /// Generates [RegularExpression] attribute.
        /// </summary>
        public string Pattern { get; set; }

        /// <summary>
        /// Custom error message for validation failures.
        /// </summary>
        [YamlMember(Alias = "error_message")]
        public string ErrorMessage { get; set; }
    }
}
