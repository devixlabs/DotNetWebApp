using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DotNetWebApp.Services;
using DotNetWebApp.Models;
using System.Collections;
using System.Reflection;
using System.Text.Json;

namespace DotNetWebApp.Controllers
{
    [ApiController]
    [Route("api/entities")]
    public class EntitiesController : ControllerBase
    {
        private readonly DbContext _context;
        private readonly IEntityMetadataService _metadataService;
        private static readonly JsonSerializerOptions _jsonOptions = new()
        {
            PropertyNameCaseInsensitive = true
        };

        public EntitiesController(
            DbContext context,
            IEntityMetadataService metadataService)
        {
            _context = context;
            _metadataService = metadataService;
        }

        private async Task<IList> ExecuteToListAsync(Type entityType, IQueryable query)
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

            var task = (Task)toListAsyncMethod.Invoke(null, new object[] { query, CancellationToken.None })!;
            await task;

            var resultProperty = task.GetType().GetProperty("Result");
            if (resultProperty == null)
            {
                throw new InvalidOperationException("Failed to extract result from Task");
            }

            return (IList)resultProperty.GetValue(task)!;
        }

        private async Task<int> ExecuteCountAsync(Type entityType, IQueryable query)
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

            var task = (Task<int>)countAsyncMethod.Invoke(null, new object[] { query, CancellationToken.None })!;
            return await task;
        }

        [HttpGet("{entityName}")]
        public async Task<ActionResult> GetEntities(string entityName)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var dbSet = GetDbSet(metadata.ClrType);
            var list = await ExecuteToListAsync(metadata.ClrType, dbSet);

            return Ok(list);
        }

        private IQueryable GetDbSet(Type entityType)
        {
            var setMethod = typeof(DbContext)
                .GetMethod(nameof(DbContext.Set), Type.EmptyTypes)
                ?.MakeGenericMethod(entityType);

            if (setMethod == null)
            {
                throw new InvalidOperationException($"Failed to resolve Set method for type {entityType.Name}");
            }

            return (IQueryable)setMethod.Invoke(_context, null)!;
        }

        [HttpGet("{entityName}/count")]
        public async Task<ActionResult<int>> GetEntityCount(string entityName)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var dbSet = GetDbSet(metadata.ClrType);
            var count = await ExecuteCountAsync(metadata.ClrType, dbSet);

            return Ok(count);
        }

        [HttpPost("{entityName}")]
        public async Task<ActionResult> CreateEntity(string entityName)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            using var reader = new StreamReader(Request.Body);
            var json = await reader.ReadToEndAsync();

            if (string.IsNullOrWhiteSpace(json))
            {
                return BadRequest(new { error = "Request body is empty" });
            }

            object? entity;
            try
            {
                entity = JsonSerializer.Deserialize(json, metadata.ClrType, _jsonOptions);
            }
            catch (JsonException ex)
            {
                return BadRequest(new { error = $"Invalid JSON: {ex.Message}" });
            }

            if (entity == null)
            {
                return BadRequest(new { error = "Failed to deserialize entity" });
            }

            var dbSet = GetDbSet(metadata.ClrType);
            var addMethod = dbSet.GetType().GetMethod("Add");
            if (addMethod == null)
            {
                throw new InvalidOperationException($"Failed to resolve Add method for type {metadata.ClrType.Name}");
            }

            addMethod.Invoke(dbSet, new[] { entity });
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetEntities),
                new { entityName = entityName },
                entity);
        }

        [HttpGet("{entityName}/{id}")]
        public async Task<ActionResult> GetEntityById(string entityName, string id)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var pkProperty = GetPrimaryKeyProperty(metadata);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{entityName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = ConvertPrimaryKeyValue(id, pkProperty);
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = $"Invalid primary key value: {ex.Message}" });
            }

            var entity = await FindEntityByPrimaryKey(metadata.ClrType, pkValue);
            if (entity == null)
            {
                return NotFound(new { error = $"Entity with id '{id}' not found" });
            }

            return Ok(entity);
        }

        [HttpPut("{entityName}/{id}")]
        public async Task<ActionResult> UpdateEntity(string entityName, string id)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var pkProperty = GetPrimaryKeyProperty(metadata);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{entityName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = ConvertPrimaryKeyValue(id, pkProperty);
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = $"Invalid primary key value: {ex.Message}" });
            }

            var existingEntity = await FindEntityByPrimaryKey(metadata.ClrType, pkValue);
            if (existingEntity == null)
            {
                return NotFound(new { error = $"Entity with id '{id}' not found" });
            }

            using var reader = new StreamReader(Request.Body);
            var json = await reader.ReadToEndAsync();

            if (string.IsNullOrWhiteSpace(json))
            {
                return BadRequest(new { error = "Request body is empty" });
            }

            object? updatedEntity;
            try
            {
                updatedEntity = JsonSerializer.Deserialize(json, metadata.ClrType, _jsonOptions);
            }
            catch (JsonException ex)
            {
                return BadRequest(new { error = $"Invalid JSON: {ex.Message}" });
            }

            if (updatedEntity == null)
            {
                return BadRequest(new { error = "Failed to deserialize entity" });
            }

            // Copy properties from updatedEntity to existingEntity
            var properties = metadata.ClrType.GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (var property in properties)
            {
                // Skip primary key and navigation properties
                if (property.Name == pkProperty.Name || !property.CanWrite)
                {
                    continue;
                }

                var value = property.GetValue(updatedEntity);
                property.SetValue(existingEntity, value);
            }

            await _context.SaveChangesAsync();

            return Ok(existingEntity);
        }

        [HttpDelete("{entityName}/{id}")]
        public async Task<ActionResult> DeleteEntity(string entityName, string id)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var pkProperty = GetPrimaryKeyProperty(metadata);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{entityName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = ConvertPrimaryKeyValue(id, pkProperty);
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = $"Invalid primary key value: {ex.Message}" });
            }

            var entity = await FindEntityByPrimaryKey(metadata.ClrType, pkValue);
            if (entity == null)
            {
                return NotFound(new { error = $"Entity with id '{id}' not found" });
            }

            var dbSet = GetDbSet(metadata.ClrType);
            var removeMethod = dbSet.GetType().GetMethod("Remove");
            if (removeMethod == null)
            {
                throw new InvalidOperationException($"Failed to resolve Remove method for type {metadata.ClrType.Name}");
            }

            removeMethod.Invoke(dbSet, new[] { entity });
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private Models.AppDictionary.Property? GetPrimaryKeyProperty(EntityMetadata metadata)
        {
            return metadata.Definition.Properties?
                .FirstOrDefault(p => p.IsPrimaryKey);
        }

        private object ConvertPrimaryKeyValue(string id, Models.AppDictionary.Property pkProperty)
        {
            return pkProperty.Type.ToLowerInvariant() switch
            {
                "int" => int.Parse(id),
                "long" => long.Parse(id),
                "guid" => Guid.Parse(id),
                "string" => id,
                _ => throw new InvalidOperationException($"Unsupported primary key type: {pkProperty.Type}")
            };
        }

        private async Task<object?> FindEntityByPrimaryKey(Type entityType, object pkValue)
        {
            var findAsyncMethod = typeof(DbContext)
                .GetMethod(nameof(DbContext.FindAsync), new[] { typeof(Type), typeof(object[]) });

            if (findAsyncMethod == null)
            {
                throw new InvalidOperationException($"Failed to resolve FindAsync method");
            }

            var valueTask = findAsyncMethod.Invoke(_context, new object[] { entityType, new[] { pkValue } });
            if (valueTask == null)
            {
                return null;
            }

            // ValueTask<object?> needs to be awaited
            var asTaskMethod = valueTask.GetType().GetMethod("AsTask");
            if (asTaskMethod == null)
            {
                throw new InvalidOperationException("Failed to resolve AsTask method on ValueTask");
            }

            var task = (Task)asTaskMethod.Invoke(valueTask, null)!;
            await task;

            var resultProperty = task.GetType().GetProperty("Result");
            return resultProperty?.GetValue(task);
        }
    }
}
