namespace DotNetWebApp.Services;

public interface IEntityApiService
{
    Task<IEnumerable<object>> GetEntitiesAsync(string entityName);
    Task<int> GetCountAsync(string entityName);
    Task<object> CreateEntityAsync(string entityName, object entity);
}
