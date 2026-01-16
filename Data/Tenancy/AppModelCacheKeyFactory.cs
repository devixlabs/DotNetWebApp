using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace DotNetWebApp.Data.Tenancy
{
    public class AppModelCacheKeyFactory : IModelCacheKeyFactory
    {
        public object Create(DbContext context, bool designTime)
        {
            if (context is AppDbContext appContext)
            {
                return (context.GetType(), appContext.Schema, designTime);
            }

            return (context.GetType(), designTime);
        }
    }
}
