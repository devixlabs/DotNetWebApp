using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public sealed class DashboardService : IDashboardService
{
    private readonly IEntityApiService _entityApiService;
    private readonly IAppDictionaryService _appDictionaryService;

    public DashboardService(IEntityApiService entityApiService, IAppDictionaryService appDictionaryService)
    {
        _entityApiService = entityApiService;
        _appDictionaryService = appDictionaryService;
    }

    public async Task<DashboardSummary> GetSummaryAsync(CancellationToken cancellationToken = default)
    {
        var entityCounts = new List<EntityCountInfo>();

        var entities = _appDictionaryService.AppDefinition.DataModel.Entities;
        foreach (var entity in entities)
        {
            try
            {
                var count = await _entityApiService.GetCountAsync(entity.Name);
                entityCounts.Add(new EntityCountInfo(entity.Name, count));
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error getting count for {entity.Name}: {ex.Message}");
            }
        }

        return new DashboardSummary
        {
            EntityCounts = entityCounts.AsReadOnly(),
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
