using DotNetWebApp.Data.Plugins;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace DotNetWebApp.Data
{
    public class AppDbContext : DbContext {
        private readonly IEnumerable<ICustomerModelPlugin> _modelPlugins;

        public AppDbContext(
            DbContextOptions<AppDbContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor,
            IEnumerable<ICustomerModelPlugin> modelPlugins) : base(options)
        {
            Schema = tenantSchemaAccessor.Schema;
            _modelPlugins = modelPlugins ?? Enumerable.Empty<ICustomerModelPlugin>();
        }

        public string Schema { get; }

        public DbSet<Product> Products { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder) {
            base.OnModelCreating(modelBuilder);

            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            foreach (var plugin in _modelPlugins)
            {
                if (plugin.AppliesTo(Schema))
                {
                    plugin.Configure(modelBuilder);
                }
            }
        }
    }
}
