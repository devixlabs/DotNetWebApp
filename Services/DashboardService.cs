using DotNetWebApp.Models;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Services;

public sealed class DashboardService : IDashboardService
{
    private readonly IEntityApiService _entityApiService;
    private readonly IEntityMetadataService _entityMetadataService;
    private readonly ILogger<DashboardService> _logger;

    public DashboardService(
        IEntityApiService entityApiService,
        IEntityMetadataService entityMetadataService,
        ILogger<DashboardService> logger)
    {
        _entityApiService = entityApiService;
        _entityMetadataService = entityMetadataService;
        _logger = logger;
    }

    public async Task<DashboardSummary> GetSummaryAsync(string appName = "admin", CancellationToken cancellationToken = default)
    {
        return await GetSummaryForApplicationAsync(appName, cancellationToken);
    }

    public async Task<DashboardSummary> GetSummaryForApplicationAsync(string appName, CancellationToken cancellationToken = default)
    {
        var entities = _entityMetadataService.GetEntitiesForApplication(appName);

        // Load counts in parallel
        var countTasks = entities
            .Select(async e =>
            {
                var qualifiedName = EntityNameFormatter.BuildQualifiedName(e);
                try
                {
                    var count = await _entityApiService.GetCountAsync(appName, qualifiedName);
                    return new EntityCountInfo(qualifiedName, count);
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "[{ErrorId}] Error getting count for {EntityName}",
                        "ENTITY_COUNT_FAILED", qualifiedName);
                    return new EntityCountInfo(
                        qualifiedName,
                        0,
                        ErrorMessage: $"Failed to load count: {ex.Message}",
                        HasError: true
                    );
                }
            })
            .ToArray();

        var counts = await Task.WhenAll(countTasks);

        return new DashboardSummary
        {
            EntityCounts = counts.ToList().AsReadOnly(),
            Revenue = 45789.50m,
            ActiveUsers = 1250,
            GrowthPercent = 15,
            RecentActivities = new[]
            {
                new ActivityItem("2 min ago", "New entity added"),
                new ActivityItem("15 min ago", "User registered"),
                new ActivityItem("1 hour ago", "Operation completed")
            }
        };
    }
}
