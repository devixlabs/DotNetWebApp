using Microsoft.AspNetCore.Mvc;
using DotNetWebApp.Services;
using DotNetWebApp.Models;
using System.Text.Json;

namespace DotNetWebApp.Controllers
{
    [ApiController]
    [Route("api/entities")]
    public class EntitiesController : ControllerBase
    {
        private readonly IEntityOperationService _operationService;
        private readonly IEntityMetadataService _metadataService;
        private static readonly JsonSerializerOptions _jsonOptions = new()
        {
            PropertyNameCaseInsensitive = true
        };

        public EntitiesController(
            IEntityOperationService operationService,
            IEntityMetadataService metadataService)
        {
            _operationService = operationService;
            _metadataService = metadataService;
        }

        [HttpGet("{entityName}")]
        public async Task<ActionResult> GetEntities(string entityName)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var list = await _operationService.GetAllAsync(metadata.ClrType);

            return Ok(list);
        }

        [HttpGet("{entityName}/count")]
        public async Task<ActionResult<int>> GetEntityCount(string entityName)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var count = await _operationService.GetCountAsync(metadata.ClrType);

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

            await _operationService.CreateAsync(metadata.ClrType, entity);

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

            var pkProperty = metadata.Definition.Properties?
                .FirstOrDefault(p => p.IsPrimaryKey);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{entityName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = pkProperty.Type.ToLowerInvariant() switch
                {
                    "int" => int.Parse(id),
                    "long" => long.Parse(id),
                    "guid" => Guid.Parse(id),
                    "string" => id,
                    _ => throw new InvalidOperationException($"Unsupported primary key type: {pkProperty.Type}")
                };
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = $"Invalid primary key value: {ex.Message}" });
            }

            var entity = await _operationService.GetByIdAsync(metadata.ClrType, pkValue);
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

            var pkProperty = metadata.Definition.Properties?
                .FirstOrDefault(p => p.IsPrimaryKey);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{entityName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = pkProperty.Type.ToLowerInvariant() switch
                {
                    "int" => int.Parse(id),
                    "long" => long.Parse(id),
                    "guid" => Guid.Parse(id),
                    "string" => id,
                    _ => throw new InvalidOperationException($"Unsupported primary key type: {pkProperty.Type}")
                };
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = $"Invalid primary key value: {ex.Message}" });
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

            var entity = await _operationService.UpdateAsync(metadata.ClrType, updatedEntity);

            return Ok(entity);
        }

        [HttpDelete("{entityName}/{id}")]
        public async Task<ActionResult> DeleteEntity(string entityName, string id)
        {
            var metadata = _metadataService.Find(entityName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{entityName}' not found" });
            }

            var pkProperty = metadata.Definition.Properties?
                .FirstOrDefault(p => p.IsPrimaryKey);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{entityName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = pkProperty.Type.ToLowerInvariant() switch
                {
                    "int" => int.Parse(id),
                    "long" => long.Parse(id),
                    "guid" => Guid.Parse(id),
                    "string" => id,
                    _ => throw new InvalidOperationException($"Unsupported primary key type: {pkProperty.Type}")
                };
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = $"Invalid primary key value: {ex.Message}" });
            }

            await _operationService.DeleteAsync(metadata.ClrType, pkValue);

            return NoContent();
        }
    }
}
