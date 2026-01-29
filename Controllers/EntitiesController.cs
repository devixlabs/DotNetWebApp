using Microsoft.AspNetCore.Mvc;
using DotNetWebApp.Services;
using DotNetWebApp.Models;
using System.Text.Json;

namespace DotNetWebApp.Controllers
{
    [ApiController]
    [Route("api/{appName}/entities")]
    public class EntitiesController : ControllerBase
    {
        private readonly IEntityOperationService _operationService;
        private readonly IEntityMetadataService _metadataService;
        private readonly IAppDictionaryService _appDictionary;
        private static readonly JsonSerializerOptions _jsonOptions = new()
        {
            PropertyNameCaseInsensitive = true
        };

        public EntitiesController(
            IEntityOperationService operationService,
            IEntityMetadataService metadataService,
            IAppDictionaryService appDictionary)
        {
            _operationService = operationService;
            _metadataService = metadataService;
            _appDictionary = appDictionary;
        }

        private string BuildQualifiedName(string schema, string entityName)
        {
            var effectiveSchema = string.IsNullOrWhiteSpace(schema) ? "dbo" : schema;
            return EntityNameFormatter.BuildQualifiedName(effectiveSchema, entityName);
        }

        private ActionResult? ValidateEntity(string appName, string qualifiedName, out EntityMetadata? metadata)
        {
            metadata = _metadataService.Find(qualifiedName);
            if (metadata == null || metadata.ClrType == null)
            {
                return NotFound(new { error = $"Entity '{qualifiedName}' not found" });
            }

            if (!_metadataService.IsEntityVisibleInApplication(metadata, appName))
            {
                return NotFound(new { error = $"Entity '{qualifiedName}' not found in app '{appName}'" });
            }

            return null;
        }

        private object? ParsePrimaryKey(string id, string pkType)
        {
            return pkType.ToLowerInvariant() switch
            {
                "int" => int.Parse(id),
                "long" => long.Parse(id),
                "guid" => Guid.Parse(id),
                "string" => id,
                _ => throw new InvalidOperationException($"Unsupported primary key type: {pkType}")
            };
        }

        private ActionResult? ValidateApp(string appName)
        {
            var app = _appDictionary.GetApplication(appName);
            if (app == null)
                return NotFound(new { error = $"Application '{appName}' not found" });

            if (!app.Entities.Any())
                return NoContent();

            return null;
        }

        [HttpGet("{schema}/{entityName}")]
        public async Task<ActionResult> GetEntities(string appName, string schema, string entityName)
        {
            var appValidation = ValidateApp(appName);
            if (appValidation != null)
                return appValidation;

            var qualifiedName = BuildQualifiedName(schema, entityName);
            var entityValidation = ValidateEntity(appName, qualifiedName, out var metadata);
            if (entityValidation != null)
                return entityValidation;

            var list = await _operationService.GetAllAsync(metadata!.ClrType);
            return Ok(list);
        }

        [HttpGet("{schema}/{entityName}/count")]
        public async Task<ActionResult<int>> GetEntityCount(string appName, string schema, string entityName)
        {
            var appValidation = ValidateApp(appName);
            if (appValidation != null)
                return appValidation;

            var qualifiedName = BuildQualifiedName(schema, entityName);
            var entityValidation = ValidateEntity(appName, qualifiedName, out var metadata);
            if (entityValidation != null)
                return entityValidation;

            var count = await _operationService.GetCountAsync(metadata!.ClrType);
            return Ok(count);
        }

        [HttpPost("{schema}/{entityName}")]
        public async Task<ActionResult> CreateEntity(string appName, string schema, string entityName)
        {
            var appValidation = ValidateApp(appName);
            if (appValidation != null)
                return appValidation;

            var qualifiedName = BuildQualifiedName(schema, entityName);
            var entityValidation = ValidateEntity(appName, qualifiedName, out var metadata);
            if (entityValidation != null)
                return entityValidation;

            using var reader = new StreamReader(Request.Body);
            var json = await reader.ReadToEndAsync();

            if (string.IsNullOrWhiteSpace(json))
            {
                return BadRequest(new { error = "Request body is empty" });
            }

            object? entity;
            try
            {
                entity = JsonSerializer.Deserialize(json, metadata!.ClrType, _jsonOptions);
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
                new { appName = appName, schema = schema, entityName = entityName },
                entity);
        }

        [HttpGet("{schema}/{entityName}/{id}")]
        public async Task<ActionResult> GetEntityById(string appName, string schema, string entityName, string id)
        {
            var appValidation = ValidateApp(appName);
            if (appValidation != null)
                return appValidation;

            var qualifiedName = BuildQualifiedName(schema, entityName);
            var entityValidation = ValidateEntity(appName, qualifiedName, out var metadata);
            if (entityValidation != null)
                return entityValidation;

            var pkProperty = metadata!.Definition.Properties?
                .FirstOrDefault(p => p.IsPrimaryKey);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{qualifiedName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = ParsePrimaryKey(id, pkProperty.Type);
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

        [HttpPut("{schema}/{entityName}/{id}")]
        public async Task<ActionResult> UpdateEntity(string appName, string schema, string entityName, string id)
        {
            var appValidation = ValidateApp(appName);
            if (appValidation != null)
                return appValidation;

            var qualifiedName = BuildQualifiedName(schema, entityName);
            var entityValidation = ValidateEntity(appName, qualifiedName, out var metadata);
            if (entityValidation != null)
                return entityValidation;

            var pkProperty = metadata!.Definition.Properties?
                .FirstOrDefault(p => p.IsPrimaryKey);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{qualifiedName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = ParsePrimaryKey(id, pkProperty.Type);
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

            // Set the primary key on the entity (it comes from the URL, not the JSON body)
            var pkPropertyInfo = metadata.ClrType.GetProperty(pkProperty.Name);
            if (pkPropertyInfo != null && pkPropertyInfo.CanWrite)
            {
                pkPropertyInfo.SetValue(updatedEntity, pkValue);
            }

            var entity = await _operationService.UpdateAsync(metadata.ClrType, updatedEntity);
            return Ok(entity);
        }

        [HttpDelete("{schema}/{entityName}/{id}")]
        public async Task<ActionResult> DeleteEntity(string appName, string schema, string entityName, string id)
        {
            var appValidation = ValidateApp(appName);
            if (appValidation != null)
                return appValidation;

            var qualifiedName = BuildQualifiedName(schema, entityName);
            var entityValidation = ValidateEntity(appName, qualifiedName, out var metadata);
            if (entityValidation != null)
                return entityValidation;

            var pkProperty = metadata!.Definition.Properties?
                .FirstOrDefault(p => p.IsPrimaryKey);
            if (pkProperty == null)
            {
                return BadRequest(new { error = $"Entity '{qualifiedName}' does not have a primary key defined" });
            }

            object? pkValue;
            try
            {
                pkValue = ParsePrimaryKey(id, pkProperty.Type);
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
