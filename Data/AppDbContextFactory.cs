using DotNetWebApp.Data.Tenancy;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;

namespace DotNetWebApp.Data
{
    public class AppDbContextFactory : IDesignTimeDbContextFactory<AppDbContext>
    {
        public AppDbContext CreateDbContext(string[] args)
        {
            var configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddUserSecrets<AppDbContext>(optional: true)
                .Build();

            var optionsBuilder = new DbContextOptionsBuilder<AppDbContext>();
            var connectionString = configuration.GetConnectionString("PrimaryDatabase")
                ?? configuration.GetConnectionString("DefaultConnection")
                ?? "Server=localhost;Database=DotNetWebAppDb;Trusted_Connection=true;Encrypt=False;";

            optionsBuilder.UseSqlServer(connectionString);

            // Load DatabaseMappingOptions from configuration
            var mappingOptions = new DatabaseMappingOptions();
            configuration.GetSection(DatabaseMappingOptions.SectionName).Bind(mappingOptions);

            return new AppDbContext(
                optionsBuilder.Options,
                new DesignTimeSchemaAccessor(),
                Options.Create(mappingOptions));
        }

        private sealed class DesignTimeSchemaAccessor : ITenantSchemaAccessor
        {
            public string Schema => "dbo";
        }
    }
}
