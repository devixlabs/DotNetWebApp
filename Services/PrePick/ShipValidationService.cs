namespace DotNetWebApp.Services.PrePick;

/// <summary>
/// Service for validating shipping eligibility.
/// Business Rule: NOT (termsId == 51 AND balance > totalDue * 0.03)
/// Simplifies to: termsId != 51 OR balance <= totalDue * 0.03
/// Terms ID 51 is likely COD/credit hold.
/// </summary>
public class ShipValidationService
{
    private readonly ILogger<ShipValidationService> _logger;

    // Terms ID that requires balance check
    private const int CreditHoldTermsId = 51;
    // Tolerance percentage (3%)
    private const decimal TolerancePercentage = 0.03m;

    public ShipValidationService(ILogger<ShipValidationService> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// Determine if order is OK to ship.
    /// Formula: NOT (termsId == 51 AND balance > totalDue * 0.03)
    /// </summary>
    public bool CanShip(int termsId, decimal balance, decimal totalDue)
    {
        if (termsId == CreditHoldTermsId)
        {
            decimal tolerance = totalDue * TolerancePercentage;
            bool canShip = balance <= tolerance;

            if (!canShip)
            {
                _logger.LogInformation(
                    "Order cannot ship: TermsId={TermsId}, Balance={Balance}, TotalDue={TotalDue}, Tolerance={Tolerance}",
                    termsId, balance, totalDue, tolerance);
            }

            return canShip;
        }

        // Other terms are OK to ship
        return true;
    }

    /// <summary>
    /// Calculate OK_To_Ship flag using the same formula as the SQL query.
    /// IIF(to_teid=51 AND to_balance>(to_totdue*0.03),0,1)
    /// </summary>
    public static bool CalculateOkToShip(int termsId, decimal balance, decimal totalDue)
    {
        if (termsId == CreditHoldTermsId)
        {
            return balance <= totalDue * TolerancePercentage;
        }
        return true;
    }
}
