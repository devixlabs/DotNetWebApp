using DotNetWebApp.Services.Models;

namespace DotNetWebApp.Services;

/// <summary>
/// Service for processing Acuity scheduling CSV files and importing into gai_scheduler.
/// Handles order classification, Deacom enrichment, and database upserts.
/// </summary>
public interface IAcuityImportService
{
    /// <summary>
    /// Process an Acuity CSV file and import records to gai_scheduler.
    /// </summary>
    /// <param name="csvFilePath">Path to the CSV file</param>
    /// <param name="userName">Current user name for warehouse assignment</param>
    /// <returns>Import result with success/error counts and details</returns>
    Task<AcuityImportResult> ProcessFileAsync(string csvFilePath, string userName);

    /// <summary>
    /// Process raw CSV content (for uploaded files).
    /// </summary>
    /// <param name="csvContent">CSV file content as stream</param>
    /// <param name="fileName">Original file name</param>
    /// <param name="userName">Current user name for warehouse assignment</param>
    /// <returns>Import result with success/error counts and details</returns>
    Task<AcuityImportResult> ProcessCsvContentAsync(Stream csvContent, string fileName, string userName);
}
