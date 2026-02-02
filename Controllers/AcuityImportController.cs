using DotNetWebApp.Services;
using DotNetWebApp.Services.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace DotNetWebApp.Controllers;

/// <summary>
/// Controller for Acuity Import file upload and processing.
/// Phase 2 - First application implementation.
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class AcuityImportController : ControllerBase
{
    private readonly IAcuityImportService _acuityImportService;
    private readonly ILogger<AcuityImportController> _logger;
    private readonly AcuityImportOptions _options;

    public AcuityImportController(
        IAcuityImportService acuityImportService,
        IOptions<AcuityImportOptions> options,
        ILogger<AcuityImportController> logger)
    {
        _acuityImportService = acuityImportService;
        _options = options.Value;
        _logger = logger;
    }

    /// <summary>
    /// Upload and process an Acuity CSV file.
    /// </summary>
    /// <param name="file">CSV file upload</param>
    /// <param name="userName">Current user name (for warehouse assignment)</param>
    /// <returns>Import result with success/error details</returns>
    [HttpPost("upload")]
    [Consumes("multipart/form-data")]
    [ProducesResponseType(typeof(AcuityImportResult), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<AcuityImportResult>> UploadFile(
        IFormFile file,
        [FromForm] string userName = "testuser")
    {
        try
        {
            if (file == null || file.Length == 0)
                return BadRequest("No file uploaded");

            // Validate file extension
            var fileExtension = Path.GetExtension(file.FileName);
            if (!_options.AllowedFileExtensions.Contains(fileExtension, StringComparer.OrdinalIgnoreCase))
                return BadRequest($"Invalid file type. Allowed: {string.Join(", ", _options.AllowedFileExtensions)}");

            // Validate file size
            if (file.Length > _options.MaxFileSizeBytes)
                return BadRequest($"File too large. Maximum size: {_options.MaxFileSizeBytes / 1024 / 1024}MB");

            _logger.LogInformation("Processing Acuity CSV upload: {FileName}, Size: {Size} bytes",
                file.FileName, file.Length);

            using var stream = file.OpenReadStream();
            var result = await _acuityImportService.ProcessCsvContentAsync(stream, file.FileName, userName);

            if (result.HasErrors)
            {
                _logger.LogWarning("Acuity import completed with errors: {Errors} errors, {Success} success",
                    result.Errors, result.TotalSuccess);
            }
            else
            {
                _logger.LogInformation("Acuity import completed successfully: {Success} records processed",
                    result.TotalSuccess);
            }

            return Ok(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Fatal error processing Acuity CSV upload");
            return StatusCode(500, new { error = "Internal server error", message = ex.Message });
        }
    }

    /// <summary>
    /// Get import status/history (placeholder for future enhancement).
    /// </summary>
    [HttpGet("status")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public ActionResult<object> GetStatus()
    {
        return Ok(new
        {
            service = "Acuity Import",
            status = "operational",
            version = "1.0.0"
        });
    }
}
