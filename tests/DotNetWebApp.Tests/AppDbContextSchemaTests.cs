using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using DotNetWebApp.Data;
using DotNetWebApp.Data.Tenancy;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Xunit;

namespace DotNetWebApp.Tests;

public class AppDbContextSchemaTests
{
    [Fact]
    public void OnModelCreating_ModelWithSchemaAttribute_AppliesSchema()
    {
        // Arrange
        var options = new DbContextOptionsBuilder<TestSchemaContext>()
            .UseSqlite(":memory:")
            .Options;

        var tenantAccessor = new MockTenantSchemaAccessor("acme");
        var dbContext = new TestSchemaContext(options, tenantAccessor);

        // Act - Build the model
        var model = dbContext.Model;

        // Assert - Verify schema is applied
        var entityType = model.FindEntityType(typeof(SchemaQualifiedTestEntity));
        Assert.NotNull(entityType);
        Assert.Equal("acme", entityType.GetSchema());
    }

    [Fact]
    public void OnModelCreating_MultipleEntitiesWithDifferentSchemas_PreservesEachSchema()
    {
        // Arrange
        var options = new DbContextOptionsBuilder<TestMultiSchemaContext>()
            .UseSqlite(":memory:")
            .Options;

        var tenantAccessor = new MockTenantSchemaAccessor("default");
        var dbContext = new TestMultiSchemaContext(options, tenantAccessor);

        // Act
        var model = dbContext.Model;

        // Assert
        var acmeEntity = model.FindEntityType(typeof(AcmeSchemaEntity));
        var tenant1Entity = model.FindEntityType(typeof(Tenant1SchemaEntity));

        Assert.NotNull(acmeEntity);
        Assert.NotNull(tenant1Entity);

        Assert.Equal("acme", acmeEntity.GetSchema());
        Assert.Equal("tenant1", tenant1Entity.GetSchema());
    }

    [Fact]
    public void OnModelCreating_EntityWithoutSchemaAttribute_UsesDefaultSchema()
    {
        // Arrange
        var options = new DbContextOptionsBuilder<TestNoSchemaContext>()
            .UseSqlite(":memory:")
            .Options;

        var tenantAccessor = new MockTenantSchemaAccessor("dbo");
        var dbContext = new TestNoSchemaContext(options, tenantAccessor);

        // Act
        var model = dbContext.Model;

        // Assert
        var entityType = model.FindEntityType(typeof(NoSchemaTestEntity));
        Assert.NotNull(entityType);
        // When no schema attribute is present, it uses the default schema from the context
        Assert.Equal("dbo", entityType.GetSchema());
    }

    // Test Models
    [Table("SchemaQualified", Schema = "acme")]
    public class SchemaQualifiedTestEntity
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
    }

    [Table("AcmeEntity", Schema = "acme")]
    public class AcmeSchemaEntity
    {
        public int Id { get; set; }
    }

    [Table("Tenant1Entity", Schema = "tenant1")]
    public class Tenant1SchemaEntity
    {
        public int Id { get; set; }
    }

    [Table("NoSchema")]
    public class NoSchemaTestEntity
    {
        public int Id { get; set; }
    }

    // Test Context 1 - Single schema-qualified entity
    public class TestSchemaContext : DbContext
    {
        private readonly ITenantSchemaAccessor _tenantSchemaAccessor;

        public TestSchemaContext(
            DbContextOptions<TestSchemaContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor)
            : base(options)
        {
            _tenantSchemaAccessor = tenantSchemaAccessor;
        }

        public string Schema => _tenantSchemaAccessor.Schema;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            var entity = modelBuilder.Entity<SchemaQualifiedTestEntity>();

            // Extract schema from [Table] attribute if present
            var tableAttr = typeof(SchemaQualifiedTestEntity).GetCustomAttributes(false)
                .OfType<TableAttribute>()
                .FirstOrDefault();
            var tableName = typeof(SchemaQualifiedTestEntity).Name;
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

    // Test Context 2 - Multiple schemas
    public class TestMultiSchemaContext : DbContext
    {
        private readonly ITenantSchemaAccessor _tenantSchemaAccessor;

        public TestMultiSchemaContext(
            DbContextOptions<TestMultiSchemaContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor)
            : base(options)
        {
            _tenantSchemaAccessor = tenantSchemaAccessor;
        }

        public string Schema => _tenantSchemaAccessor.Schema;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            ConfigureEntity<AcmeSchemaEntity>(modelBuilder);
            ConfigureEntity<Tenant1SchemaEntity>(modelBuilder);
        }

        private void ConfigureEntity<T>(ModelBuilder modelBuilder) where T : class
        {
            var entity = modelBuilder.Entity<T>();
            var type = typeof(T);

            var tableAttr = type.GetCustomAttributes(false)
                .OfType<TableAttribute>()
                .FirstOrDefault();
            var tableName = type.Name;
            var tableSchema = tableAttr?.Schema;

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

    // Test Context 3 - No schema attribute
    public class TestNoSchemaContext : DbContext
    {
        private readonly ITenantSchemaAccessor _tenantSchemaAccessor;

        public TestNoSchemaContext(
            DbContextOptions<TestNoSchemaContext> options,
            ITenantSchemaAccessor tenantSchemaAccessor)
            : base(options)
        {
            _tenantSchemaAccessor = tenantSchemaAccessor;
        }

        public string Schema => _tenantSchemaAccessor.Schema;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            if (!string.IsNullOrWhiteSpace(Schema))
            {
                modelBuilder.HasDefaultSchema(Schema);
            }

            modelBuilder.Entity<NoSchemaTestEntity>().ToTable("NoSchema");
        }
    }

    // Mock tenant accessor for testing
    public class MockTenantSchemaAccessor : ITenantSchemaAccessor
    {
        private readonly string _schema;

        public MockTenantSchemaAccessor(string schema = "dbo")
        {
            _schema = schema;
        }

        public string Schema => _schema;
    }
}
