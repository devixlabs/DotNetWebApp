using System.IO;
using System.Threading;
using DotNetWebApp.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Services;

public sealed class DataSeeder
{
    private readonly DbContext _dbContext;
    private readonly IHostEnvironment _environment;
    private readonly ILogger<DataSeeder> _logger;
    private const string SeedFileName = "seed.sql";

    public DataSeeder(
        DbContext dbContext,
        IHostEnvironment environment,
        ILogger<DataSeeder> logger)
    {
        _dbContext = dbContext;
        _environment = environment;
        _logger = logger;
    }

    public async Task SeedAsync(CancellationToken cancellationToken = default)
    {
        var seedPath = Path.Combine(_environment.ContentRootPath, SeedFileName);

        if (!File.Exists(seedPath))
        {
            _logger.LogWarning("Seed script {SeedFile} not found; skipping data seed.", seedPath);
            return;
        }

        var sql = await File.ReadAllTextAsync(seedPath, cancellationToken);
        if (string.IsNullOrWhiteSpace(sql))
        {
            _logger.LogWarning("Seed script {SeedFile} is empty; nothing to execute.", seedPath);
            return;
        }

        _logger.LogInformation("Applying seed data from {SeedFile}.", seedPath);
        await _dbContext.Database.ExecuteSqlRawAsync(sql, cancellationToken);
        _logger.LogInformation("Seed data applied.");
    }
}
