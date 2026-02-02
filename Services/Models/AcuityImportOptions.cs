namespace DotNetWebApp.Services.Models;

/// <summary>
/// Configuration options for Acuity Import service.
/// Binds to "AcuityImport" section in appsettings.json.
/// </summary>
public class AcuityImportOptions
{
    public const string SectionName = "AcuityImport";

    /// <summary>
    /// Directory path for uploaded CSV files (relative or absolute).
    /// Default: "uploads/acuity"
    /// </summary>
    public string CsvUploadPath { get; set; } = "uploads/acuity";

    /// <summary>
    /// Directory path for archived processed CSV files.
    /// Default: "uploads/acuity/archive"
    /// </summary>
    public string CsvArchivePath { get; set; } = "uploads/acuity/archive";

    /// <summary>
    /// Maximum allowed file size in bytes.
    /// Default: 10MB (10485760 bytes)
    /// </summary>
    public long MaxFileSizeBytes { get; set; } = 10 * 1024 * 1024; // 10MB

    /// <summary>
    /// Allowed file extensions for upload.
    /// Default: [".csv"]
    /// </summary>
    public string[] AllowedFileExtensions { get; set; } = new[] { ".csv" };
}
