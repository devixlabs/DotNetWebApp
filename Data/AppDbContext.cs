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
                var tableName = ToPlural(type.Name);
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
            }
        }

        private static string ToPlural(string name)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                return name;
            }

            if (name.EndsWith("y", StringComparison.OrdinalIgnoreCase) && name.Length > 1)
            {
                var beforeY = name[name.Length - 2];
                if (!"aeiou".Contains(char.ToLowerInvariant(beforeY)))
                {
                    return name[..^1] + "ies";
                }
            }

            return name.EndsWith("s", StringComparison.OrdinalIgnoreCase) ? name : $"{name}s";
        }
    }
}
