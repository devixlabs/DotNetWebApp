using DotNetWebApp.Data.Tenancy;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Reflection;

namespace DotNetWebApp.Data
{
    public class AppDbContext : DbContext {
        public AppDbContext(
            DbContextOptions<AppDbContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor) : base(options)
        {
            Schema = tenantSchemaAccessor.Schema;
        }

        public string Schema { get; }

        protected override void OnModelCreating(ModelBuilder modelBuilder) {
            base.OnModelCreating(modelBuilder);

            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            // Dynamically register all entities in the Generated namespace
            var entityTypes = Assembly.GetExecutingAssembly().GetTypes()
                .Where(t => t.IsClass && t.Namespace == "DotNetWebApp.Models.Generated");

            foreach (var type in entityTypes)
            {
                modelBuilder.Entity(type)
                    .ToTable(ToPlural(type.Name));
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
