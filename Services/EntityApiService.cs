using System.Text.Json;

namespace DotNetWebApp.Services;

public sealed class EntityApiService : IEntityApiService
{
    private readonly HttpClient _httpClient;
    private readonly IEntityMetadataService _metadataService;
    private readonly IApplicationContextAccessor _appContext;

    public EntityApiService(
        HttpClient httpClient,
        IEntityMetadataService metadataService,
        IApplicationContextAccessor appContext)
    {
        _httpClient = httpClient;
        _metadataService = metadataService;
        _appContext = appContext;
    }

    // Convert internal colon format (schema:EntityName) to URL slash format (schema/EntityName)
    // If no schema is present, default to 'dbo'
    private static string ToUrlFormat(string entityName)
    {
        if (entityName.Contains(':'))
        {
            return entityName.Replace(':', '/');
        }
        // No schema specified, default to dbo
        return $"dbo/{entityName}";
    }

    public async Task<IEnumerable<object>> GetEntitiesAsync(string entityName)
    {
        var appName = _appContext.ApplicationName
            ?? throw new InvalidOperationException("No application context available");

        var metadata = _metadataService.Find(entityName);
        if (metadata?.ClrType == null)
        {
            throw new InvalidOperationException($"Entity '{entityName}' not found or has no CLR type");
        }

        try
        {
            var urlPath = ToUrlFormat(entityName);
            var response = await _httpClient.GetAsync($"api/{appName}/entities/{urlPath}");
            if (!response.IsSuccessStatusCode)
            {
                throw new HttpRequestException($"Failed to fetch {entityName} entities (HTTP {(int)response.StatusCode})");
            }

            var json = await response.Content.ReadAsStringAsync();
            var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
            var listType = typeof(List<>).MakeGenericType(metadata.ClrType);
            var entities = (System.Collections.IEnumerable?)JsonSerializer.Deserialize(json, listType, options);

            return entities?.Cast<object>() ?? Enumerable.Empty<object>();
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to load {entityName} data: {ex.Message}", ex);
        }
    }

    public async Task<int> GetCountAsync(string entityName)
    {
        var appName = _appContext.ApplicationName
            ?? throw new InvalidOperationException("No application context available");

        var metadata = _metadataService.Find(entityName);
        if (metadata?.ClrType == null)
        {
            throw new InvalidOperationException($"Entity '{entityName}' not found or has no CLR type");
        }

        try
        {
            var urlPath = ToUrlFormat(entityName);
            var response = await _httpClient.GetAsync($"api/{appName}/entities/{urlPath}/count");
            if (!response.IsSuccessStatusCode)
            {
                throw new HttpRequestException($"Failed to fetch {entityName} count (HTTP {(int)response.StatusCode})");
            }

            var json = await response.Content.ReadAsStringAsync();
            var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
            if (int.TryParse(json.Trim('"'), out var count))
            {
                return count;
            }

            throw new InvalidOperationException("Invalid count response");
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to fetch {entityName} count: {ex.Message}", ex);
        }
    }

    public async Task<object> CreateEntityAsync(string entityName, object entity)
    {
        var appName = _appContext.ApplicationName
            ?? throw new InvalidOperationException("No application context available");

        var metadata = _metadataService.Find(entityName);
        if (metadata?.ClrType == null)
        {
            throw new InvalidOperationException($"Entity '{entityName}' not found or has no CLR type");
        }

        try
        {
            var json = JsonSerializer.Serialize(entity);
            var content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");
            var urlPath = ToUrlFormat(entityName);
            var response = await _httpClient.PostAsync($"api/{appName}/entities/{urlPath}", content);

            if (!response.IsSuccessStatusCode)
            {
                throw new HttpRequestException($"Failed to create {entityName} (HTTP {(int)response.StatusCode})");
            }

            var responseJson = await response.Content.ReadAsStringAsync();
            var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
            var result = JsonSerializer.Deserialize(responseJson, metadata.ClrType, options);

            return result ?? throw new InvalidOperationException("Failed to deserialize created entity");
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException($"Failed to create {entityName}: {ex.Message}", ex);
        }
    }
}
