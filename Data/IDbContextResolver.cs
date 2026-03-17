using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace DotNetWebApp.Data
{
    /// <summary>
    /// Resolves the appropriate DbContext based on entity type.
    /// Routes entities to SecondaryDbContext based on configured namespace pattern.
    /// </summary>
    public interface IDbContextResolver
    {
        DbContext GetContextForEntity(Type entityType);
    }

    public class DbContextResolver : IDbContextResolver
    {
        private readonly AppDbContext _primaryContext;
        private readonly SecondaryDbContext _secondaryContext;
        private readonly DatabaseMappingOptions _mappingOptions;

        public DbContextResolver(
            AppDbContext primaryContext,
            SecondaryDbContext secondaryContext,
            IOptions<DatabaseMappingOptions> mappingOptions)
        {
            _primaryContext = primaryContext;
            _secondaryContext = secondaryContext;
            _mappingOptions = mappingOptions.Value;
        }

        public DbContext GetContextForEntity(Type entityType)
        {
            // Route to SecondaryDbContext based on configured namespace pattern
            if (_mappingOptions.IsSecondaryDatabase(entityType))
            {
                return _secondaryContext;
            }

            // All other entities use AppDbContext (PrimaryDatabase)
            return _primaryContext;
        }
    }
}
