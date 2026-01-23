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

    public async Task<DashboardSummary> GetSummaryAsync(CancellationToken cancellationToken = default)
    {
        var entities = _entityMetadataService.Entities;

        // Load counts in parallel
        var countTasks = entities
            .Select(async e =>
            {
                try
                {
                    var count = await _entityApiService.GetCountAsync(e.Definition.Name);
                    return new EntityCountInfo(e.Definition.Name, count);
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Error getting count for {EntityName}", e.Definition.Name);
                    return new EntityCountInfo(e.Definition.Name, 0);
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
