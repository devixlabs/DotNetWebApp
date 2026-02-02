namespace DotNetWebApp.Data
{
    /// <summary>
    /// Configuration options for database and schema mappings.
    /// Allows database names (like GAI, GAIMisc) to be mapped to actual schema names (like dbo).
    /// </summary>
    public class DatabaseMappingOptions
    {
        public const string SectionName = "DatabaseMapping";

        /// <summary>
        /// Maps schema names from [Table] attributes to actual database schema names.
        /// Key: Schema name in generated code (e.g., "GAI")
        /// Value: Actual schema name in database (e.g., "dbo")
        /// </summary>
        public Dictionary<string, string> SchemaMappings { get; set; } = new();

        /// <summary>
        /// Namespace pattern to identify entities that belong to the secondary database.
        /// Entities with this pattern in their namespace will use SecondaryDbContext.
        /// </summary>
        public string SecondaryNamespacePattern { get; set; } = string.Empty;

        /// <summary>
        /// Gets the effective schema for a given schema name from [Table] attribute.
        /// Returns the mapped schema if a mapping exists, otherwise returns the original.
        /// </summary>
        public string GetEffectiveSchema(string? tableSchema)
        {
            if (string.IsNullOrWhiteSpace(tableSchema))
            {
                return tableSchema ?? string.Empty;
            }

            return SchemaMappings.TryGetValue(tableSchema, out var mappedSchema)
                ? mappedSchema
                : tableSchema;
        }

        /// <summary>
        /// Determines if an entity type belongs to the secondary database based on namespace.
        /// </summary>
        public bool IsSecondaryDatabase(Type entityType)
        {
            if (string.IsNullOrWhiteSpace(SecondaryNamespacePattern))
            {
                return false;
            }

            return entityType.Namespace != null && entityType.Namespace.Contains(SecondaryNamespacePattern);
        }
    }
}
