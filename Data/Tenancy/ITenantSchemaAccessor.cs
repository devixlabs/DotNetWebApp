namespace DotNetWebApp.Data.Tenancy
{
    public interface ITenantSchemaAccessor
    {
        string Schema { get; }
    }
}
