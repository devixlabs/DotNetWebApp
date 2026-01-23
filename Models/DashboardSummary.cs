namespace DotNetWebApp.Models;

public class DashboardSummary
{
    public IReadOnlyList<EntityCountInfo> EntityCounts { get; set; } = Array.Empty<EntityCountInfo>();
    public decimal Revenue { get; set; }
    public int ActiveUsers { get; set; }
    public int GrowthPercent { get; set; }
    public IReadOnlyList<ActivityItem> RecentActivities { get; set; } = Array.Empty<ActivityItem>();
}

public sealed record EntityCountInfo(string EntityName, int Count);
public sealed record ActivityItem(string When, string Description);
