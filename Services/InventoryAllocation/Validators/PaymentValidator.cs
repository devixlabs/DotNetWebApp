using DotNetWebApp.Services.InventoryAllocation.Models;

namespace DotNetWebApp.Services.InventoryAllocation.Validators;

/// <summary>
/// Validates payment eligibility for allocation.
/// Business Rule: Terms ID 51 = credit terms, allow 3% tolerance.
/// Formula: NOT (termsId == 51 AND balance > totalDue * 0.03)
/// </summary>
public class PaymentValidator
{
    private readonly ILogger<PaymentValidator> _logger;

    /// <summary>
    /// Credit hold terms ID that requires payment validation.
    /// </summary>
    public const int CREDIT_HOLD_TERMS_ID = 51;

    /// <summary>
    /// Payment tolerance percentage (3%).
    /// </summary>
    public const decimal PAYMENT_TOLERANCE = 0.03m;

    public PaymentValidator(ILogger<PaymentValidator> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// Validate if order can be allocated based on payment status.
    /// Terms ID 51 = credit terms, allow 3% tolerance.
    /// </summary>
    /// <param name="termsId">Payment terms ID</param>
    /// <param name="balanceDue">Outstanding balance</param>
    /// <param name="totalDue">Total order amount</param>
    /// <returns>True if payment is valid for allocation</returns>
    public bool ValidatePayment(int termsId, decimal balanceDue, decimal totalDue)
    {
        // Non-credit hold terms are always OK
        if (termsId != CREDIT_HOLD_TERMS_ID)
        {
            return true;
        }

        // Credit hold terms: check 3% tolerance
        decimal tolerance = totalDue * PAYMENT_TOLERANCE;
        bool isValid = balanceDue <= tolerance;

        if (!isValid)
        {
            _logger.LogWarning(
                "Payment validation failed: termsId={TermsId}, balance={Balance}, totalDue={TotalDue}, tolerance={Tolerance}",
                termsId, balanceDue, totalDue, tolerance);
        }

        return isValid;
    }

    /// <summary>
    /// Get payment eligibility result with reason.
    /// </summary>
    public EligibilityResult GetPaymentEligibility(int termsId, decimal balanceDue, decimal totalDue)
    {
        if (ValidatePayment(termsId, balanceDue, totalDue))
        {
            return EligibilityResult.Eligible();
        }

        decimal tolerance = totalDue * PAYMENT_TOLERANCE;
        return EligibilityResult.NotEligible(
            $"Payment hold: balance ${balanceDue:N2} exceeds 3% tolerance (${tolerance:N2}) for terms ID {termsId}");
    }

    /// <summary>
    /// Calculate the OK_To_Ship value.
    /// Formula: NOT (termsId == 51 AND balance > totalDue * 0.03)
    /// </summary>
    public bool CalculateOkToShip(int termsId, decimal balanceDue, decimal totalDue)
    {
        return ValidatePayment(termsId, balanceDue, totalDue);
    }
}
