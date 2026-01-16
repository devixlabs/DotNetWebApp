namespace DotNetWebApp.Data.Tenancy
{
    public class TenantSchemaOptions
    {
        public string DefaultSchema { get; set; } = "dbo";
        public string HeaderName { get; set; } = "X-Customer-Schema";
    }
}
