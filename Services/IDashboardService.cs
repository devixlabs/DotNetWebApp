using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface IDashboardService
{
    Task<DashboardSummary> GetSummaryAsync(CancellationToken cancellationToken = default);
}
