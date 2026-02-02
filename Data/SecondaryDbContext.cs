using DotNetWebApp.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Reflection;

namespace DotNetWebApp.Data
{
    /// <summary>
    /// Secondary DbContext for the secondary database.
    /// Only registers entities matching the configured SecondaryNamespacePattern.
    /// </summary>
    public class SecondaryDbContext : DbContext
    {
        private readonly DatabaseMappingOptions _mappingOptions;

        public SecondaryDbContext(
            DbContextOptions<SecondaryDbContext> options,
            IOptions<DatabaseMappingOptions> mappingOptions) : base(options)
        {
            _mappingOptions = mappingOptions.Value;
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Default to dbo schema
            modelBuilder.HasDefaultSchema("dbo");

            // Only register entities matching the secondary namespace pattern
            var modelsAssembly = typeof(EntityMetadata).Assembly;
            var namespacePattern = _mappingOptions.SecondaryNamespacePattern;
            var entityTypes = modelsAssembly.GetTypes()
                .Where(t => t.IsClass && t.Namespace != null &&
                       !string.IsNullOrWhiteSpace(namespacePattern) &&
                       t.Namespace.Contains(namespacePattern));

            foreach (var type in entityTypes)
            {
                var entity = modelBuilder.Entity(type);

                var tableAttr = type.GetCustomAttribute<TableAttribute>();
                var tableName = (tableAttr?.Name ?? type.Name).ToLower();

                // Map schema via configuration
                var effectiveSchema = _mappingOptions.GetEffectiveSchema(tableAttr?.Schema);
                if (string.IsNullOrWhiteSpace(effectiveSchema))
                {
                    effectiveSchema = "dbo";
                }

                entity.ToTable(tableName, effectiveSchema);

                // Configure keyless entities
                var hasKeyProperties = type.GetProperties()
                    .Any(p => p.GetCustomAttribute<System.ComponentModel.DataAnnotations.KeyAttribute>() != null);

                if (!hasKeyProperties && type.GetCustomAttribute<Microsoft.EntityFrameworkCore.PrimaryKeyAttribute>() == null)
                {
                    entity.HasNoKey();
                }
            }
        }
    }
}
