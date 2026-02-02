using DotNetWebApp.Services.Allocation.Validators;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;

namespace DotNetWebApp.Tests.Services.Allocation;

/// <summary>
/// Tests for PaymentValidator.
/// Business Rule: Terms ID 51 = credit terms, allow 3% tolerance.
/// Formula: NOT (termsId == 51 AND balance > totalDue * 0.03)
/// </summary>
public class PaymentValidatorTests
{
    private readonly PaymentValidator _validator;

    public PaymentValidatorTests()
    {
        var logger = new Mock<ILogger<PaymentValidator>>();
        _validator = new PaymentValidator(logger.Object);
    }

    [Fact]
    public void ValidatePayment_NonCreditHoldTerms_ReturnsTrue()
    {
        // Any terms ID other than 51 should always pass
        Assert.True(_validator.ValidatePayment(termsId: 1, balanceDue: 1000m, totalDue: 1000m));
        Assert.True(_validator.ValidatePayment(termsId: 30, balanceDue: 5000m, totalDue: 1000m));
        Assert.True(_validator.ValidatePayment(termsId: 99, balanceDue: 0m, totalDue: 0m));
    }

    [Fact]
    public void ValidatePayment_CreditHoldWithZeroBalance_ReturnsTrue()
    {
        // Zero balance should always pass for credit hold
        Assert.True(_validator.ValidatePayment(termsId: 51, balanceDue: 0m, totalDue: 1000m));
    }

    [Fact]
    public void ValidatePayment_CreditHoldWithinTolerance_ReturnsTrue()
    {
        // Balance within 3% tolerance should pass
        // totalDue = 1000, 3% = 30
        Assert.True(_validator.ValidatePayment(termsId: 51, balanceDue: 30m, totalDue: 1000m));
        Assert.True(_validator.ValidatePayment(termsId: 51, balanceDue: 29.99m, totalDue: 1000m));
        Assert.True(_validator.ValidatePayment(termsId: 51, balanceDue: 15m, totalDue: 1000m));
    }

    [Fact]
    public void ValidatePayment_CreditHoldExceedsTolerance_ReturnsFalse()
    {
        // Balance exceeding 3% tolerance should fail
        // totalDue = 1000, 3% = 30
        Assert.False(_validator.ValidatePayment(termsId: 51, balanceDue: 30.01m, totalDue: 1000m));
        Assert.False(_validator.ValidatePayment(termsId: 51, balanceDue: 100m, totalDue: 1000m));
        Assert.False(_validator.ValidatePayment(termsId: 51, balanceDue: 500m, totalDue: 1000m));
    }

    [Theory]
    [InlineData(51, 0, 0, true)]       // Zero total, zero balance
    [InlineData(51, 0, 1000, true)]    // Zero balance
    [InlineData(51, 30, 1000, true)]   // Exactly 3%
    [InlineData(51, 30.01, 1000, false)] // Just over 3%
    [InlineData(51, 100, 1000, false)] // 10%
    [InlineData(1, 1000, 1000, true)]  // Non-credit hold, 100% balance
    [InlineData(30, 500, 100, true)]   // Non-credit hold, 500% balance
    public void ValidatePayment_TheoryTests(int termsId, decimal balance, decimal total, bool expected)
    {
        Assert.Equal(expected, _validator.ValidatePayment(termsId, balance, total));
    }

    [Fact]
    public void GetPaymentEligibility_Valid_ReturnsEligible()
    {
        var result = _validator.GetPaymentEligibility(termsId: 30, balanceDue: 1000m, totalDue: 1000m);
        Assert.True(result.IsEligible);
        Assert.Empty(result.Reason);
    }

    [Fact]
    public void GetPaymentEligibility_CreditHoldValid_ReturnsEligible()
    {
        var result = _validator.GetPaymentEligibility(termsId: 51, balanceDue: 25m, totalDue: 1000m);
        Assert.True(result.IsEligible);
    }

    [Fact]
    public void GetPaymentEligibility_CreditHoldInvalid_ReturnsNotEligible()
    {
        var result = _validator.GetPaymentEligibility(termsId: 51, balanceDue: 100m, totalDue: 1000m);
        Assert.False(result.IsEligible);
        Assert.Contains("Payment hold", result.Reason);
        Assert.Contains("3%", result.Reason);
    }

    [Fact]
    public void CalculateOkToShip_SameAsValidatePayment()
    {
        // CalculateOkToShip should return same result as ValidatePayment
        Assert.True(_validator.CalculateOkToShip(30, 1000m, 1000m));
        Assert.True(_validator.CalculateOkToShip(51, 30m, 1000m));
        Assert.False(_validator.CalculateOkToShip(51, 100m, 1000m));
    }

    [Fact]
    public void Constants_AreCorrect()
    {
        Assert.Equal(51, PaymentValidator.CREDIT_HOLD_TERMS_ID);
        Assert.Equal(0.03m, PaymentValidator.PAYMENT_TOLERANCE);
    }
}
