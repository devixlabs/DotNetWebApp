using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface IDashboardService
{
    Task<DashboardSummary> GetSummaryAsync(CancellationToken cancellationToken = default);
    Task<DashboardSummary> GetSummaryForApplicationAsync(string appName, CancellationToken cancellationToken = default);
}
