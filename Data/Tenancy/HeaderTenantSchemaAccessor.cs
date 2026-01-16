using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;

namespace DotNetWebApp.Data.Tenancy
{
    public class HeaderTenantSchemaAccessor : ITenantSchemaAccessor
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly TenantSchemaOptions _options;

        public HeaderTenantSchemaAccessor(
            IHttpContextAccessor httpContextAccessor,
            IOptions<TenantSchemaOptions> options)
        {
            _httpContextAccessor = httpContextAccessor;
            _options = options.Value;
        }

        public string Schema
        {
            get
            {
                var context = _httpContextAccessor.HttpContext;
                if (context?.Request?.Headers == null)
                {
                    return _options.DefaultSchema;
                }

                if (context.Request.Headers.TryGetValue(_options.HeaderName, out var schemaValue))
                {
                    var schema = schemaValue.ToString().Trim();
                    if (!string.IsNullOrWhiteSpace(schema))
                    {
                        return schema;
                    }
                }

                return _options.DefaultSchema;
            }
        }
    }
}
