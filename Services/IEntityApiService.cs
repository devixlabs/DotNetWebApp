namespace DotNetWebApp.Services;

public interface IEntityApiService
{
    Task<IEnumerable<object>> GetEntitiesAsync(string appName, string entityName);
    Task<int> GetCountAsync(string appName, string entityName);
    Task<object> CreateEntityAsync(string appName, string entityName, object entity);
}
