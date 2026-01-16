using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public sealed class DashboardService : IDashboardService
{
    private readonly IProductService _productService;

    public DashboardService(IProductService productService)
    {
        _productService = productService;
    }

    public async Task<DashboardSummary> GetSummaryAsync(CancellationToken cancellationToken = default)
    {
        var totalProducts = await _productService.GetProductCountAsync(cancellationToken);

        return new DashboardSummary
        {
            TotalProducts = totalProducts,
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
