using DotNetWebApp.Data;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Tests.TestEntities;
using Microsoft.EntityFrameworkCore;

namespace DotNetWebApp.Tests
{
    public class TestAppDbContext : DbContext
    {
        public TestAppDbContext(
            DbContextOptions<TestAppDbContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor) : base(options)
        {
            Schema = tenantSchemaAccessor.Schema;
        }

        public string Schema { get; }

        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            modelBuilder.Entity<Product>().ToTable("Products");
            modelBuilder.Entity<Category>().ToTable("Categories");
        }
    }
}
