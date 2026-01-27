using System.Collections;
using System.Collections.Concurrent;
using System.Linq.Expressions;
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using DotNetWebApp.Models;
using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services;

/// <summary>
/// Implementation of IEntityOperationService with cached compiled delegates for optimal reflection performance.
/// Caches expression trees as compiled Func<> delegates to eliminate per-call reflection overhead.
/// </summary>
public sealed class EntityOperationService : IEntityOperationService
{
    private readonly DbContext _context;
    private readonly IEntityMetadataService _metadataService;

    // Cache compiled delegates for DbContext.Set() method calls
    private static readonly ConcurrentDictionary<Type, Func<DbContext, IQueryable>> _queryableFactories = new();

    // Cache primary key properties by entity type
    private static readonly ConcurrentDictionary<Type, PropertyInfo?> _primaryKeyProperties = new();

    public EntityOperationService(DbContext context, IEntityMetadataService metadataService)
    {
        _context = context;
        _metadataService = metadataService;
    }

    public async Task<IList> GetAllAsync(Type entityType, CancellationToken ct = default)
    {
        var queryable = GetQueryable(entityType);
        return await ExecuteToListAsync(entityType, queryable, ct);
    }

    public async Task<int> GetCountAsync(Type entityType, CancellationToken ct = default)
    {
        var queryable = GetQueryable(entityType);
        return await ExecuteCountAsync(entityType, queryable, ct);
    }

    public async Task<object> CreateAsync(Type entityType, object entity, CancellationToken ct = default)
    {
        var queryable = GetQueryable(entityType);
        var addMethod = queryable.GetType().GetMethod("Add")
            ?? throw new InvalidOperationException($"Failed to resolve Add method for type {entityType.Name}");

        addMethod.Invoke(queryable, new[] { entity });
        await _context.SaveChangesAsync(ct);

        return entity;
    }

    public async Task<object?> GetByIdAsync(Type entityType, object id, CancellationToken ct = default)
    {
        var findAsyncMethod = typeof(DbContext)
            .GetMethod(nameof(DbContext.FindAsync), new[] { typeof(Type), typeof(object[]) })
            ?? throw new InvalidOperationException($"Failed to resolve FindAsync method");

        var valueTask = findAsyncMethod.Invoke(_context, new object[] { entityType, new[] { id } });
        if (valueTask == null)
        {
            return null;
        }

        // ValueTask<object?> needs to be awaited
        var asTaskMethod = valueTask.GetType().GetMethod("AsTask")
            ?? throw new InvalidOperationException("Failed to resolve AsTask method on ValueTask");

        var task = (Task)asTaskMethod.Invoke(valueTask, null)!;
        await task.ConfigureAwait(false);

        var resultProperty = task.GetType().GetProperty("Result");
        return resultProperty?.GetValue(task);
    }

    public async Task<object> UpdateAsync(Type entityType, object entity, CancellationToken ct = default)
    {
        var metadata = _metadataService.Entities
            .FirstOrDefault(m => m.ClrType == entityType)
            ?? throw new InvalidOperationException($"Entity type {entityType.Name} not found in metadata");

        var pkProperty = metadata.Definition.Properties?
            .FirstOrDefault(p => p.IsPrimaryKey)
            ?? throw new InvalidOperationException($"Entity {entityType.Name} does not have a primary key");

        var pkValue = entityType.GetProperty(pkProperty.Name, BindingFlags.Public | BindingFlags.Instance)?
            .GetValue(entity)
            ?? throw new InvalidOperationException($"Primary key property {pkProperty.Name} not found on entity");

        var existingEntity = await GetByIdAsync(entityType, pkValue, ct)
            ?? throw new InvalidOperationException($"Entity with id '{pkValue}' not found");

        // Copy properties from updated entity to existing entity
        var properties = entityType.GetProperties(BindingFlags.Public | BindingFlags.Instance);
        foreach (var property in properties)
        {
            // Skip primary key and navigation properties
            if (property.Name == pkProperty.Name || !property.CanWrite)
            {
                continue;
            }

            var value = property.GetValue(entity);
            property.SetValue(existingEntity, value);
        }

        await _context.SaveChangesAsync(ct);

        return existingEntity;
    }

    public async Task DeleteAsync(Type entityType, object id, CancellationToken ct = default)
    {
        var entity = await GetByIdAsync(entityType, id, ct)
            ?? throw new InvalidOperationException($"Entity with id '{id}' not found");

        var queryable = GetQueryable(entityType);
        var removeMethod = queryable.GetType().GetMethod("Remove")
            ?? throw new InvalidOperationException($"Failed to resolve Remove method for type {entityType.Name}");

        removeMethod.Invoke(queryable, new[] { entity });
        await _context.SaveChangesAsync(ct);
    }

    /// <summary>
    /// Gets a cached IQueryable<T> for the entity type using compiled delegates.
    /// First call compiles the expression tree; subsequent calls invoke the cached delegate.
    /// </summary>
    private IQueryable GetQueryable(Type entityType)
    {
        var factory = _queryableFactories.GetOrAdd(entityType, t =>
        {
            // Build: ctx => ctx.Set<T>()
            var setMethod = typeof(DbContext)
                .GetMethod(nameof(DbContext.Set), Type.EmptyTypes)?
                .MakeGenericMethod(t)
                ?? throw new InvalidOperationException($"Failed to resolve Set method for type {t.Name}");

            var ctxParam = Expression.Parameter(typeof(DbContext), "ctx");
            var call = Expression.Call(ctxParam, setMethod);
            var lambda = Expression.Lambda<Func<DbContext, IQueryable>>(call, ctxParam);

            return lambda.Compile();
        });

        return factory(_context);
    }

    /// <summary>
    /// Executes ToListAsync using reflection on an IQueryable.
    /// </summary>
    private static async Task<IList> ExecuteToListAsync(Type entityType, IQueryable query, CancellationToken ct)
    {
        var methods = typeof(EntityFrameworkQueryableExtensions)
            .GetMethods()
            .Where(m => m.Name == nameof(EntityFrameworkQueryableExtensions.ToListAsync)
                && m.IsGenericMethodDefinition
                && m.GetParameters().Length == 2)
            .ToArray();

        if (methods.Length == 0)
        {
            throw new InvalidOperationException("Failed to find ToListAsync method");
        }

        var toListAsyncMethod = methods[0].MakeGenericMethod(entityType);

        var task = (Task)toListAsyncMethod.Invoke(null, new object[] { query, ct })!;
        await task.ConfigureAwait(false);

        var resultProperty = task.GetType().GetProperty("Result");
        if (resultProperty == null)
        {
            throw new InvalidOperationException("Failed to extract result from Task");
        }

        return (IList)resultProperty.GetValue(task)!;
    }

    /// <summary>
    /// Executes CountAsync using reflection on an IQueryable.
    /// </summary>
    private static async Task<int> ExecuteCountAsync(Type entityType, IQueryable query, CancellationToken ct)
    {
        var methods = typeof(EntityFrameworkQueryableExtensions)
            .GetMethods()
            .Where(m => m.Name == nameof(EntityFrameworkQueryableExtensions.CountAsync)
                && m.IsGenericMethodDefinition
                && m.GetParameters().Length == 2
                && m.GetParameters()[0].ParameterType.GetGenericTypeDefinition() == typeof(IQueryable<>))
            .ToArray();

        if (methods.Length == 0)
        {
            throw new InvalidOperationException("Failed to find CountAsync method");
        }

        var countAsyncMethod = methods[0].MakeGenericMethod(entityType);

        var task = (Task<int>)countAsyncMethod.Invoke(null, new object[] { query, ct })!;
        return await task.ConfigureAwait(false);
    }
}
