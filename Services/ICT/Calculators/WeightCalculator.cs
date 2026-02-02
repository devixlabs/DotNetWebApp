namespace DotNetWebApp.Services.ICT.Calculators;

/// <summary>
/// Calculates net and gross weights for ICT orders.
/// </summary>
public static class WeightCalculator
{
    /// <summary>
    /// Calculate net weight.
    /// Net Weight = Quantity × Unit Net Weight
    /// </summary>
    /// <param name="quantity">Total quantity</param>
    /// <param name="unitNetWeight">Unit net weight (from product master)</param>
    /// <returns>Total net weight</returns>
    public static decimal CalculateNetWeight(decimal quantity, decimal unitNetWeight)
    {
        return quantity * unitNetWeight;
    }

    /// <summary>
    /// Calculate gross weight.
    /// Gross Weight = Quantity × (Unit Net Weight + Tare Weight)
    /// </summary>
    /// <param name="quantity">Total quantity</param>
    /// <param name="unitNetWeight">Unit net weight (from product master)</param>
    /// <param name="tareWeight">Tare weight per unit (from product master)</param>
    /// <returns>Total gross weight</returns>
    public static decimal CalculateGrossWeight(decimal quantity, decimal unitNetWeight, decimal tareWeight)
    {
        return quantity * (unitNetWeight + tareWeight);
    }

    /// <summary>
    /// Calculate total tare weight.
    /// Tare = Gross - Net
    /// </summary>
    /// <param name="grossWeight">Total gross weight</param>
    /// <param name="netWeight">Total net weight</param>
    /// <returns>Total tare weight</returns>
    public static decimal CalculateTareTotal(decimal grossWeight, decimal netWeight)
    {
        return grossWeight - netWeight;
    }

    /// <summary>
    /// Calculate unit gross weight.
    /// Unit Gross = Unit Net + Tare
    /// </summary>
    /// <param name="unitNetWeight">Unit net weight</param>
    /// <param name="tareWeight">Tare weight per unit</param>
    /// <returns>Unit gross weight</returns>
    public static decimal CalculateUnitGrossWeight(decimal unitNetWeight, decimal tareWeight)
    {
        return unitNetWeight + tareWeight;
    }
}
