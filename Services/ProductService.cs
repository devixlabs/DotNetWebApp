using DotNetWebApp.Models.Generated;

namespace DotNetWebApp.Services;

public sealed class ProductService : IProductService
{
    private readonly HttpClient _httpClient;

    public ProductService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<IReadOnlyList<Product>> GetProductsAsync(CancellationToken cancellationToken = default)
    {
        try
        {
            var products = await _httpClient.GetFromJsonAsync<List<Product>>("api/product", cancellationToken);
            return products ?? new List<Product>();
        }
        catch (Exception)
        {
            return Array.Empty<Product>();
        }
    }

    public async Task<int> GetProductCountAsync(CancellationToken cancellationToken = default)
    {
        try
        {
            return await _httpClient.GetFromJsonAsync<int>("api/product/count", cancellationToken);
        }
        catch (Exception)
        {
            return 0;
        }
    }
}
