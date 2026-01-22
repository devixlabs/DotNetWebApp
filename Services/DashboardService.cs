using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public sealed class DashboardService : IDashboardService
{
    private readonly IEntityApiService _entityApiService;
    private readonly IEntityMetadataService _entityMetadataService;

    public DashboardService(
        IEntityApiService entityApiService,
        IEntityMetadataService entityMetadataService)
    {
        _entityApiService = entityApiService;
        _entityMetadataService = entityMetadataService;
    }

    public async Task<DashboardSummary> GetSummaryAsync(CancellationToken cancellationToken = default)
    {
        // Get all entities
        var entities = _entityMetadataService.Entities;

        // Load counts in parallel
        var countTasks = entities
            .Select(async e =>
            {
                try
                {
                    var count = await _entityApiService.GetCountAsync(e.Definition.Name);
                    return (Name: e.Definition.Name, Count: count);
                }
                catch
                {
                    // Return 0 if count fails for individual entity
                    return (Name: e.Definition.Name, Count: 0);
                }
            })
            .ToArray();

        var counts = await Task.WhenAll(countTasks);

        return new DashboardSummary
        {
            EntityCounts = counts.ToDictionary(c => c.Name, c => c.Count),
            Revenue = 45789.50m,
            ActiveUsers = 1250,
            GrowthPercent = 15,
            RecentActivities = new[]
            {
                new ActivityItem("2 min ago", "New product added"),
                new ActivityItem("15 min ago", "User registered"),
                new ActivityItem("1 hour ago", "Order completed")
            }
        };
    }
}
