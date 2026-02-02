namespace DotNetWebApp.Services.ICT;

/// <summary>
/// Service for generating ICT order numbers.
/// Format: YYYY + 5-digit-index + "99"
/// Example: 202500123​99 (2025 + 00123 + 99)
/// </summary>
public interface IICTOrderNumberService
{
    /// <summary>
    /// Generate next ICT order number.
    /// Gets max index from gai_scheduler, increments, formats with year + "99" suffix.
    /// </summary>
    /// <returns>New ICT order number (11 digits)</returns>
    Task<string> GenerateNextOrderNumberAsync();

    /// <summary>
    /// Get current max index for the year from gai_scheduler.
    /// </summary>
    /// <param name="year">Year to check (default: current year)</param>
    /// <returns>Maximum index found, or 0 if no orders exist</returns>
    Task<int> GetMaxIndexAsync(int year = 0);

    /// <summary>
    /// Parse ICT order number and extract components.
    /// </summary>
    /// <param name="orderNumber">ICT order number to parse</param>
    /// <returns>Tuple of (Year, Index, Suffix)</returns>
    /// <exception cref="ArgumentException">Thrown if order number format is invalid</exception>
    (int Year, int Index, string Suffix) ParseOrderNumber(string orderNumber);

    /// <summary>
    /// Validate if a string is a valid ICT order number format.
    /// </summary>
    /// <param name="orderNumber">Order number to validate</param>
    /// <returns>True if valid ICT order number format</returns>
    bool IsValidICTOrderNumber(string orderNumber);
}
