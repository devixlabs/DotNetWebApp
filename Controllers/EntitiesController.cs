using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DotNetWebApp.Services;
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
                entity = JsonSerializer.Deserialize(json, metadata.ClrType);
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
    }
}
