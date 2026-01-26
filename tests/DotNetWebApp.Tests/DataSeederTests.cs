using System;
using System.IO;
using System.Threading.Tasks;
using DotNetWebApp.Data;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using DotNetWebApp.Services;
using DotNetWebApp.Tests.TestEntities;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using Xunit;

namespace DotNetWebApp.Tests;

public class DataSeederTests
{
    private const string SeedFileName = "seed.sql";

    [Fact]
    public async Task SeedAsync_AddsRows_WhenScriptExists()
    {
        var tempDir = CreateTemporaryDirectory();
        try
        {
            var sqlPath = Path.Combine(tempDir, SeedFileName);
            await File.WriteAllTextAsync(sqlPath, "INSERT INTO Categories (Name) VALUES ('Seeded');");

            await using var connection = new SqliteConnection("DataSource=:memory:");
            await connection.OpenAsync();
            var options = new DbContextOptionsBuilder<TestAppDbContext>()
                .UseSqlite(connection)
                .Options;

            await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
            await context.Database.EnsureCreatedAsync();

            var seeder = new DataSeeder(
                context,
                new TestHostEnvironment(tempDir),
                NullLogger<DataSeeder>.Instance,
                Options.Create(new DataSeederOptions { SeedFileName = SeedFileName }));
            await seeder.SeedAsync();

            var seeded = await context.Set<Category>().SingleOrDefaultAsync(c => c.Name == "Seeded");
            Assert.NotNull(seeded);
        }
        finally
        {
            Directory.Delete(tempDir, true);
        }
    }

    [Fact]
    public async Task SeedAsync_Skips_WhenScriptMissing()
    {
        var tempDir = CreateTemporaryDirectory();
        try
        {
            await using var connection = new SqliteConnection("DataSource=:memory:");
            await connection.OpenAsync();
            var options = new DbContextOptionsBuilder<TestAppDbContext>()
                .UseSqlite(connection)
                .Options;

            await using var context = new TestAppDbContext(options, new TestTenantSchemaAccessor("dbo"));
            await context.Database.EnsureCreatedAsync();

            var seeder = new DataSeeder(
                context,
                new TestHostEnvironment(tempDir),
                NullLogger<DataSeeder>.Instance,
                Options.Create(new DataSeederOptions { SeedFileName = SeedFileName }));
            await seeder.SeedAsync();

            var count = await context.Set<Category>().CountAsync();
            Assert.Equal(0, count);
        }
        finally
        {
            Directory.Delete(tempDir, true);
        }
    }

    private static string CreateTemporaryDirectory()
    {
        var path = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(path);
        return path;
    }

    private sealed class TestTenantSchemaAccessor : ITenantSchemaAccessor
    {
        public TestTenantSchemaAccessor(string schema) => Schema = schema;
        public string Schema { get; }
    }

    private sealed class TestHostEnvironment : IHostEnvironment
    {
        public string EnvironmentName { get; set; }
        public string ApplicationName { get; set; }
        public string ContentRootPath { get; set; }
        public string WebRootPath { get; set; }
        public IFileProvider ContentRootFileProvider { get; set; }
        public IFileProvider WebRootFileProvider { get; set; }

        public TestHostEnvironment(string contentRootPath)
        {
            EnvironmentName = "Test";
            ApplicationName = "DotNetWebApp.Tests";
            WebRootPath = string.Empty;
            ContentRootPath = contentRootPath;
            ContentRootFileProvider = new PhysicalFileProvider(contentRootPath);
            WebRootFileProvider = new NullFileProvider();
        }
    }
}
