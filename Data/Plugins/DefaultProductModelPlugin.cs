using DotNetWebApp.Models;
using Microsoft.EntityFrameworkCore;

namespace DotNetWebApp.Data.Plugins
{
    public class DefaultProductModelPlugin : ICustomerModelPlugin
    {
        public bool AppliesTo(string schema)
        {
            return true;
        }

        public void Configure(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Product>()
                .Property(p => p.Price)
                .HasPrecision(18, 2);
        }
    }
}
