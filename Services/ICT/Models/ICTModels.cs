namespace DotNetWebApp.Services.ICT.Models;

/// <summary>
/// Complete ICT order with header and line items.
/// </summary>
public class ICTOrder
{
    public string OrderNumber { get; set; } = string.Empty;
    public int SourceWarehouseId { get; set; }
    public int DestinationWarehouseId { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime? FinalizedDate { get; set; }
    public string Notes { get; set; } = string.Empty;
    public string JobNumber { get; set; } = string.Empty;
    public List<LineItem> LineItems { get; set; } = new();

    // Summary fields (calculated from line items)
    public int TotalProducts => LineItems.Count;
    public int TotalPallets => LineItems.Sum(l => l.Pallets);
    public decimal TotalNetWeight => LineItems.Sum(l => l.NetWeight);
    public decimal TotalGrossWeight => LineItems.Sum(l => l.GrossWeight);
}

/// <summary>
/// ICT order line item (product).
/// </summary>
public class LineItem
{
    public int Id { get; set; }  // all_index
    public string OrderNumber { get; set; } = string.Empty;
    public string ProductCode { get; set; } = string.Empty;

    /// <summary>
    /// Product description.
    /// PRESERVED BUG: Truncated to 50 characters without warning.
    /// </summary>
    public string Description { get; set; } = string.Empty;

    public decimal Quantity { get; set; }
    public int Pallets { get; set; }
    public decimal NetWeight { get; set; }
    public decimal GrossWeight { get; set; }
    public string UnitOfMeasure { get; set; } = string.Empty;
    public string JobNumber { get; set; } = string.Empty;
}

/// <summary>
/// Request to create new ICT order.
/// </summary>
public class CreateICTOrderRequest
{
    public int SourceWarehouseId { get; set; }      // Where product is coming from
    public int DestinationWarehouseId { get; set; } // Where product is going
    public string Notes { get; set; } = string.Empty;
    public string JobNumber { get; set; } = string.Empty;
}

/// <summary>
/// Request to add product line item to order.
/// </summary>
public class AddLineItemRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string ProductCode { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public string Description { get; set; } = string.Empty;
    public string JobNumber { get; set; } = string.Empty;
}

/// <summary>
/// Summary of ICT order for list display.
/// </summary>
public class ICTOrderSummary
{
    public string OrderNumber { get; set; } = string.Empty;
    public int WarehouseId { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LineCount { get; set; }
    public int TotalPallets { get; set; }
    public decimal TotalNetWeight { get; set; }
    public decimal TotalGrossWeight { get; set; }
}

/// <summary>
/// Result of order submission operation.
/// </summary>
public class SubmitOrderResult
{
    public bool Success { get; set; }
    public string ErrorMessage { get; set; } = string.Empty;
    public DateTime SubmittedDate { get; set; }
}

/// <summary>
/// Result of order delete operation.
/// </summary>
public class DeleteOrderResult
{
    public bool Success { get; set; }
    public string ErrorMessage { get; set; } = string.Empty;
    public int SchedulerRowsDeleted { get; set; }
    public int AllocateRowsDeleted { get; set; }
}

/// <summary>
/// Product information for ICT order selection.
/// </summary>
public class ICTProduct
{
    public string ProductCode { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public decimal AvailableQuantity { get; set; }
    public decimal? CasesPerPallet { get; set; }
    public string UnitOfMeasure { get; set; } = string.Empty;
    public decimal NetWeight { get; set; }
    public decimal GrossWeight { get; set; }
}

/// <summary>
/// Manufacturing job information for ICT planning.
/// </summary>
public class ManufacturingJob
{
    public string JobNumber { get; set; } = string.Empty;
    public DateTime FinishDate { get; set; }
    public DateTime ShipDate { get; set; }  // Finish + 8 business days
    public string ProductCode { get; set; } = string.Empty;
    public int PlannedQuantity { get; set; }
    public string UnitOfMeasure { get; set; } = string.Empty;
}

/// <summary>
/// Validation result for quantity checks.
/// </summary>
public class QuantityValidationResult
{
    public bool IsValid { get; set; }
    public string ErrorMessage { get; set; } = string.Empty;

    public static QuantityValidationResult Valid() => new() { IsValid = true };

    public static QuantityValidationResult Invalid(string message) => new()
    {
        IsValid = false,
        ErrorMessage = message
    };
}
