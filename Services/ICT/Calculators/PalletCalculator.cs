namespace DotNetWebApp.Services.ICT.Calculators;

/// <summary>
/// Calculates pallet requirements for ICT orders.
/// CRITICAL: MUST use Math.Ceiling to always round UP.
/// </summary>
public static class PalletCalculator
{
    /// <summary>
    /// Calculate pallets required for a given quantity.
    /// MUST use Math.Ceiling to round UP.
    ///
    /// Examples:
    ///   100 cases / 40 per pallet = 2.5 → 3 pallets
    ///   100 cases / 50 per pallet = 2.0 → 2 pallets
    ///   101 cases / 50 per pallet = 2.02 → 3 pallets
    ///   1 case / 100 per pallet = 0.01 → 1 pallet
    /// </summary>
    /// <param name="quantity">Total quantity to ship</param>
    /// <param name="casesPerPallet">Cases per pallet (from product attributes)</param>
    /// <returns>Number of pallets required (always rounded UP)</returns>
    /// <exception cref="ArgumentException">Thrown if casesPerPallet is zero or negative</exception>
    public static int CalculatePallets(decimal quantity, decimal casesPerPallet)
    {
        if (casesPerPallet <= 0)
            throw new ArgumentException("Cases per pallet must be greater than zero", nameof(casesPerPallet));

        if (quantity <= 0)
            return 0;

        // CRITICAL: Math.Ceiling, NOT Math.Floor or Math.Round
        decimal pallets = quantity / casesPerPallet;
        return (int)Math.Ceiling(pallets);
    }

    /// <summary>
    /// Calculate pallets required, using a default value if casesPerPallet is not available.
    /// </summary>
    /// <param name="quantity">Total quantity to ship</param>
    /// <param name="casesPerPallet">Cases per pallet (nullable from product attributes)</param>
    /// <param name="defaultCasesPerPallet">Default value if casesPerPallet is null (default: 40)</param>
    /// <returns>Number of pallets required</returns>
    public static int CalculatePallets(decimal quantity, decimal? casesPerPallet, decimal defaultCasesPerPallet = 40)
    {
        return CalculatePallets(quantity, casesPerPallet ?? defaultCasesPerPallet);
    }
}
