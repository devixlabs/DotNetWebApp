using DotNetWebApp.Services.Allocation.Models;

namespace DotNetWebApp.Services.Allocation.Validators;

/// <summary>
/// Validates shelf life requirements for inventory allocation.
/// Business Rule: Minimum 30 days shelf life required (or customer-specific).
/// </summary>
public class ShelfLifeValidator
{
    private readonly ILogger<ShelfLifeValidator> _logger;

    /// <summary>
    /// Default minimum shelf life in days.
    /// </summary>
    public const int DEFAULT_MIN_SHELF_LIFE_DAYS = 30;

    public ShelfLifeValidator(ILogger<ShelfLifeValidator> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// Check if inventory lot meets shelf life requirements.
    /// </summary>
    /// <param name="lot">Inventory lot to check</param>
    /// <param name="orderDate">Date to check against (usually ship date)</param>
    /// <param name="customerMinDays">Customer-specific minimum days (null = use default)</param>
    /// <returns>True if lot meets shelf life requirements</returns>
    public bool MeetsShelfLifeRequirements(InventoryLot lot, DateTime orderDate, int? customerMinDays = null)
    {
        // No expiration date = always valid
        if (!lot.ExpirationDate.HasValue)
        {
            return true;
        }

        int requiredDays = customerMinDays ?? DEFAULT_MIN_SHELF_LIFE_DAYS;
        int daysRemaining = (lot.ExpirationDate.Value.Date - orderDate.Date).Days;

        bool isValid = daysRemaining >= requiredDays;

        if (!isValid)
        {
            _logger.LogDebug(
                "Lot {LotNumber} for {ProductCode} fails shelf life: {DaysRemaining} days remaining, {RequiredDays} required",
                lot.LotNumber, lot.ProductCode, daysRemaining, requiredDays);
        }

        return isValid;
    }

    /// <summary>
    /// Check if lot meets shelf life by expiration date directly.
    /// </summary>
    public bool MeetsShelfLifeRequirements(DateTime? expirationDate, DateTime orderDate, int? customerMinDays = null)
    {
        if (!expirationDate.HasValue)
        {
            return true;
        }

        int requiredDays = customerMinDays ?? DEFAULT_MIN_SHELF_LIFE_DAYS;
        int daysRemaining = (expirationDate.Value.Date - orderDate.Date).Days;

        return daysRemaining >= requiredDays;
    }

    /// <summary>
    /// Calculate days until expiration.
    /// </summary>
    public int GetDaysUntilExpiration(DateTime? expirationDate, DateTime referenceDate)
    {
        if (!expirationDate.HasValue)
        {
            return int.MaxValue; // No expiration
        }

        return (expirationDate.Value.Date - referenceDate.Date).Days;
    }

    /// <summary>
    /// Get the minimum acceptable expiration date for allocation.
    /// </summary>
    public DateTime GetMinimumExpirationDate(DateTime orderDate, int? customerMinDays = null)
    {
        int requiredDays = customerMinDays ?? DEFAULT_MIN_SHELF_LIFE_DAYS;
        return orderDate.Date.AddDays(requiredDays);
    }

    /// <summary>
    /// Filter lots by shelf life requirements.
    /// </summary>
    public IEnumerable<InventoryLot> FilterByShelfLife(
        IEnumerable<InventoryLot> lots,
        DateTime orderDate,
        int? customerMinDays = null)
    {
        return lots.Where(lot => MeetsShelfLifeRequirements(lot, orderDate, customerMinDays));
    }
}
