using System.Collections;

namespace DotNetWebApp.Services;

/// <summary>
/// Service for performing CRUD operations on dynamically-resolved entity types.
/// Centralizes reflection logic for improved performance and testability.
/// </summary>
public interface IEntityOperationService
{
    /// <summary>
    /// Retrieves all entities of the specified type.
    /// </summary>
    Task<IList> GetAllAsync(Type entityType, CancellationToken ct = default);

    /// <summary>
    /// Retrieves the count of entities of the specified type.
    /// </summary>
    Task<int> GetCountAsync(Type entityType, CancellationToken ct = default);

    /// <summary>
    /// Creates a new entity of the specified type and saves it to the database.
    /// </summary>
    Task<object> CreateAsync(Type entityType, object entity, CancellationToken ct = default);

    /// <summary>
    /// Retrieves an entity by its primary key value.
    /// </summary>
    Task<object?> GetByIdAsync(Type entityType, object id, CancellationToken ct = default);

    /// <summary>
    /// Updates an existing entity and saves changes to the database.
    /// </summary>
    Task<object> UpdateAsync(Type entityType, object entity, CancellationToken ct = default);

    /// <summary>
    /// Deletes an entity by its primary key value.
    /// </summary>
    Task DeleteAsync(Type entityType, object id, CancellationToken ct = default);
}
