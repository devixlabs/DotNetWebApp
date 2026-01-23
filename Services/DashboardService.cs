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
                    Console.WriteLine($"Error getting count for {e.Definition.Name}: {ex.Message}");
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
