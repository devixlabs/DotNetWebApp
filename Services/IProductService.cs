using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface IProductService
{
    Task<IReadOnlyList<Product>> GetProductsAsync(CancellationToken cancellationToken = default);
    Task<int> GetProductCountAsync(CancellationToken cancellationToken = default);
}
