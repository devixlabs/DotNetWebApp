using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Reflection;

namespace DotNetWebApp.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(
            DbContextOptions<AppDbContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor) : base(options)
        {
            Schema = tenantSchemaAccessor.Schema;
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
                if (!string.IsNullOrWhiteSpace(tableSchema))
                {
                    entity.ToTable(tableName, tableSchema);
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

            // Handle DDL parser limitations with composite foreign keys
            // The acuity_form_values table has a composite FK (form_id, appointment_id) that references
            // acuity_forms (id, appointment_id), but the generated code only recognizes form_id.
            // Remove the navigation property so EF Core doesn't try to enforce the incomplete FK relationship.
            var acuityFormValuType = entityTypes.FirstOrDefault(t => t.Name == "Acuity_form_valu");
            if (acuityFormValuType != null)
            {
                modelBuilder.Entity(acuityFormValuType).Ignore("Acuity_form");
            }
        }

    }
}
