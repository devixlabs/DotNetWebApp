using Microsoft.EntityFrameworkCore;

namespace DotNetWebApp.Data.Plugins
{
    public interface ICustomerModelPlugin
    {
        bool AppliesTo(string schema);
        void Configure(ModelBuilder modelBuilder);
    }
}
