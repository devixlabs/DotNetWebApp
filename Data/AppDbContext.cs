using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Reflection;

namespace DotNetWebApp.Data
{
    public class AppDbContext : DbContext
    {
        private readonly DatabaseMappingOptions _mappingOptions;

        public AppDbContext(
            DbContextOptions<AppDbContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor,
            IOptions<DatabaseMappingOptions> mappingOptions) : base(options)
        {
            Schema = tenantSchemaAccessor.Schema;
            _mappingOptions = mappingOptions.Value;
        }

        public string Schema { get; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            // Dynamically register all entities in the Generated namespace (including schema-specific subdirectories)
            // Scan the Models assembly instead of the executing assembly to support separated project structure
            var modelsAssembly = typeof(EntityMetadata).Assembly;
            var entityTypes = modelsAssembly.GetTypes()
                .Where(t => t.IsClass && t.Namespace != null && t.Namespace.StartsWith("DotNetWebApp.Models.Generated"));

            foreach (var type in entityTypes)
            {
                var entity = modelBuilder.Entity(type);

                // Extract schema from [Table] attribute if present
                var tableAttr = type.GetCustomAttribute<TableAttribute>();

                // Use table name from [Table] attribute if available, otherwise derive from class name
                // NOTE: The ModelGenerator generates [Table] names with PascalCase (e.g., "Dmbill"),
                // but schema.sql uses lowercase (e.g., "dmbill"). Convert to lowercase for consistency.
                var tableName = (tableAttr?.Name ?? type.Name).ToLower();
                var tableSchema = tableAttr?.Schema;

                // Apply table name and schema (schema takes precedence from attribute)
                // Map database names to actual schema names via configuration
                var effectiveSchema = _mappingOptions.GetEffectiveSchema(tableSchema);

                if (!string.IsNullOrWhiteSpace(effectiveSchema))
                {
                    entity.ToTable(tableName, effectiveSchema);
                }
                else
                {
                    entity.ToTable(tableName);
                }

                // Configure keyless entities (tables with no primary key defined)
                var hasKeyProperties = type.GetProperties()
                    .Any(p => p.GetCustomAttribute<System.ComponentModel.DataAnnotations.KeyAttribute>() != null);

                if (!hasKeyProperties && type.GetCustomAttribute<Microsoft.EntityFrameworkCore.PrimaryKeyAttribute>() == null)
                {
                    entity.HasNoKey();
                }
            }

            // Configure webapp_lock identity column (gl_index)
            // The table has a composite primary key with an identity column, which requires explicit configuration
            var webappLockType = entityTypes.FirstOrDefault(t => t.Name == "Webapp_lock");
            if (webappLockType != null)
            {
                modelBuilder.Entity(webappLockType)
                    .Property("gl_index")
                    .ValueGeneratedOnAdd();
            }
        }

    }
}
