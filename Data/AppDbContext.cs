using Microsoft.EntityFrameworkCore;
using DotNetWebApp.Models;

namespace DotNetWebApp.Data
{
    public class AppDbContext : DbContext {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Product> Products { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder) {
            modelBuilder.Entity<Product>()
                .Property(p => p.Price)
                .HasPrecision(18, 2); // Explicitly set precision for decimal
                //.HasColumnType("decimal(18,2)"); // or SQLServer specific type

        }
    }
}
