using DotNetWebApp.Data.Dapper;
using Microsoft.Extensions.DependencyInjection;

namespace DotNetWebApp.Services.ICT;

/// <summary>
/// Implementation of ICT order number generation service.
/// Uses secondary database (GAIMisc) for querying gai_scheduler.
/// </summary>
public class ICTOrderNumberService : IICTOrderNumberService
{
    private readonly IDapperQueryService _dapperQuery;
    private readonly ILogger<ICTOrderNumberService> _logger;

    public ICTOrderNumberService(
        [FromKeyedServices("Secondary")] IDapperQueryService dapperQuery,
        ILogger<ICTOrderNumberService> logger)
    {
        _dapperQuery = dapperQuery;
        _logger = logger;
    }

    public async Task<string> GenerateNextOrderNumberAsync()
    {
        int year = DateTime.Now.Year;
        int maxIndex = await GetMaxIndexAsync(year);
        int nextIndex = maxIndex + 1;

        string orderNumber = $"{year}{nextIndex:D5}99";

        _logger.LogInformation(
            "Generated ICT order number: {OrderNumber} (Year: {Year}, Index: {Index})",
            orderNumber, year, nextIndex);

        return orderNumber;
    }

    public async Task<int> GetMaxIndexAsync(int year = 0)
    {
        if (year == 0)
            year = DateTime.Now.Year;

        // Query extracts the 5-digit index from order numbers matching the year
        const string sql = @"
            SELECT ISNULL(MAX(CAST(SUBSTRING(CAST(gs_ordnum AS VARCHAR(11)), 5, 5) AS INT)), 0)
            FROM gai_scheduler
            WHERE CAST(SUBSTRING(CAST(gs_ordnum AS VARCHAR(11)), 1, 4) AS INT) = @Year
              AND SUBSTRING(CAST(gs_ordnum AS VARCHAR(11)), 10, 2) = '99'";

        try
        {
            var result = await _dapperQuery.QuerySingleAsync<int?>(sql, new { Year = year });
            int maxIndex = result ?? 0;

            _logger.LogDebug(
                "Max ICT index for year {Year}: {MaxIndex}",
                year, maxIndex);

            return maxIndex;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get max ICT order index for year {Year}", year);
            throw;
        }
    }

    public (int Year, int Index, string Suffix) ParseOrderNumber(string orderNumber)
    {
        if (string.IsNullOrEmpty(orderNumber))
            throw new ArgumentException("Order number cannot be null or empty", nameof(orderNumber));

        if (orderNumber.Length != 11)
            throw new ArgumentException(
                $"Invalid ICT order number format. Expected 11 digits, got {orderNumber.Length}",
                nameof(orderNumber));

        if (!long.TryParse(orderNumber, out _))
            throw new ArgumentException(
                "Order number must contain only digits",
                nameof(orderNumber));

        int year = int.Parse(orderNumber.Substring(0, 4));
        int index = int.Parse(orderNumber.Substring(4, 5));
        string suffix = orderNumber.Substring(9, 2);

        if (suffix != "99")
            throw new ArgumentException(
                $"Not an ICT order number. Expected suffix '99', got '{suffix}'",
                nameof(orderNumber));

        return (year, index, suffix);
    }

    public bool IsValidICTOrderNumber(string orderNumber)
    {
        try
        {
            ParseOrderNumber(orderNumber);
            return true;
        }
        catch
        {
            return false;
        }
    }
}
