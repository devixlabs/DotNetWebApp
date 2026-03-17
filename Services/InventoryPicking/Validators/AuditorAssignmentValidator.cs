using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Services.InventoryPicking.Models;
using Microsoft.Extensions.DependencyInjection;

namespace DotNetWebApp.Services.InventoryPicking.Validators;

/// <summary>
/// Validates auditor assignment based on complex business rules.
/// Rules:
/// 1. Must have picker assigned first
/// 2. Must be "Fully Allocated" OR "Fully Picked"
/// 3. Exception: "Partially Allocated" + small package carriers (UPS, FedEx)
/// </summary>
public class AuditorAssignmentValidator
{
    private readonly IDapperQueryService _secondaryDapper;
    private readonly ILogger<AuditorAssignmentValidator> _logger;

    // Small package carriers that allow auditor with partial allocation
    private static readonly string[] SmallPackageCarriers = { "UPS", "Federal Express", "FedEx" };

    public AuditorAssignmentValidator(
        [FromKeyedServices("Secondary")] IDapperQueryService secondaryDapper,
        ILogger<AuditorAssignmentValidator> logger)
    {
        _secondaryDapper = secondaryDapper;
        _logger = logger;
    }

    /// <summary>
    /// Validate if auditor can be assigned to order.
    /// </summary>
    public async Task<ValidationResult> CanAssignAuditorAsync(
        string orderNumber,
        string? pickerUsername,
        string? carrierName)
    {
        // Rule 1: Must have picker first
        if (string.IsNullOrEmpty(pickerUsername))
        {
            _logger.LogWarning(
                "Auditor assignment rejected for order {OrderNumber}: No picker assigned",
                orderNumber);
            return ValidationResult.Invalid(
                "You can't add a Auditor until you staging the product in Deacom " +
                "AND/OR Have a Picker selected to the Order");
        }

        // Rule 2 & 3: Check allocation status
        string status = await GetAllocationStatusAsync(orderNumber);

        if (status == "Fully Allocated" || status == "Fully Picked")
        {
            _logger.LogInformation(
                "Auditor assignment allowed for order {OrderNumber}: Status is {Status}",
                orderNumber, status);
            return ValidationResult.Valid();
        }

        // Exception for small package carriers
        if (status == "Partially Allocated" && IsSmallPackageCarrier(carrierName))
        {
            _logger.LogInformation(
                "Auditor assignment allowed for order {OrderNumber}: Partially allocated with small package carrier {Carrier}",
                orderNumber, carrierName);
            return ValidationResult.Valid();
        }

        // Rejection
        _logger.LogWarning(
            "Auditor assignment rejected for order {OrderNumber}: Status is {Status}, Carrier is {Carrier}",
            orderNumber, status, carrierName);

        return ValidationResult.Invalid(
            $"Order Number: {orderNumber} with Deacom status: {status}\n" +
            "You can't add a Auditor until you staging the product in Deacom " +
            "AND/OR Have a Picker selected to the Order");
    }

    /// <summary>
    /// Get the allocation status for an order from the reservedstatus view.
    /// </summary>
    private async Task<string> GetAllocationStatusAsync(string orderNumber)
    {
        // Query webapp_allocate to determine allocation status
        // Allocation status is based on all_pick field:
        // - all_pick = 0: Not picked yet
        // - all_pick > 0: Picked
        const string sql = @"
            SELECT
                CASE
                    WHEN COUNT(*) = 0 THEN 'Not Allocated'
                    WHEN SUM(CASE WHEN ISNULL(all_pick, 0) > 0 THEN 1 ELSE 0 END) = COUNT(*) THEN 'Fully Picked'
                    WHEN SUM(CASE WHEN ISNULL(all_qty, 0) > 0 THEN 1 ELSE 0 END) = COUNT(*) THEN 'Fully Allocated'
                    ELSE 'Partially Allocated'
                END AS AllocationStatus
            FROM webapp_allocate
            WHERE all_ordernum = @OrderNumber";

        try
        {
            string? status = await _secondaryDapper.QuerySingleAsync<string>(
                sql, new { OrderNumber = long.Parse(orderNumber) });
            return status ?? "Not Allocated";
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get allocation status for order {OrderNumber}", orderNumber);
            return "Not Allocated";
        }
    }

    /// <summary>
    /// Check if the carrier is a small package carrier.
    /// </summary>
    private static bool IsSmallPackageCarrier(string? carrierName)
    {
        if (string.IsNullOrEmpty(carrierName))
            return false;

        return SmallPackageCarriers.Any(c =>
            carrierName.Equals(c, StringComparison.OrdinalIgnoreCase) ||
            carrierName.Contains(c, StringComparison.OrdinalIgnoreCase));
    }
}
