namespace DotNetWebApp.Models;

public class DashboardSummary
{
    public int TotalProducts { get; set; }
    public decimal Revenue { get; set; }
    public int ActiveUsers { get; set; }
    public int GrowthPercent { get; set; }
    public IReadOnlyList<ActivityItem> RecentActivities { get; set; } = Array.Empty<ActivityItem>();
}

public sealed record ActivityItem(string When, string Description);
