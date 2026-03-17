namespace DotNetWebApp.Services.InventoryPicking.Models;

/// <summary>
/// Represents an InventoryPicking order with picker, auditor, and assembler assignments.
/// </summary>
public class InventoryPickingOrder
{
    public string OrderNumber { get; set; } = string.Empty;
    public DateTime? DueShipDate { get; set; }
    public DateTime? DockTime { get; set; }
    public string CarrierName { get; set; } = string.Empty;
    public string BillToName { get; set; } = string.Empty;
    public string ShipToName { get; set; } = string.Empty;
    public string Allocator { get; set; } = string.Empty;
    public string TeamLeader { get; set; } = string.Empty;

    // Picker assignment
    public string PickerUsername { get; set; } = string.Empty;
    public DateTime? PickerClockIn { get; set; }
    public DateTime? PickerClockOut { get; set; }

    // Auditor assignment
    public string AuditorUsername { get; set; } = string.Empty;
    public DateTime? AuditorClockIn { get; set; }
    public DateTime? AuditorClockOut { get; set; }

    // Assembler assignment
    public string AssemblerUsername { get; set; } = string.Empty;
    public DateTime? AssemblerClockIn { get; set; }
    public DateTime? AssemblerClockOut { get; set; }

    // Order status and metrics
    public int CrossDock { get; set; }
    public bool OkToShip { get; set; }
    public string CsrLogin { get; set; } = string.Empty;
    public string FollowUp { get; set; } = string.Empty;
    public string Notes { get; set; } = string.Empty;
    public int PalletCount { get; set; }
    public int ProductCount { get; set; }
    public string FollowUpNotes { get; set; } = string.Empty;
    public int PrintStatus { get; set; }  // gs_num2: 10=printed from Deacom, 11=printed from allocation
    public bool IsExport { get; set; }
    public int StatusCode { get; set; }  // gs_num1: 1-4
    public bool IsIct { get; set; }  // Order number ends in 99

    // Allocation status
    public string AllocationStatus { get; set; } = string.Empty;  // "Not Allocated", "Partially Allocated", "Fully Allocated", "Fully Picked"

    // Warehouse info
    public int WarehouseId { get; set; }

    // Computed properties
    public string Status => StatusCode switch
    {
        1 => "Status1",
        2 => "Status2",
        3 => "Status3",
        4 => "Status4",
        _ => "Unknown"
    };

    public bool HasPickerInProgress => !string.IsNullOrEmpty(PickerUsername) && PickerClockIn.HasValue && !PickerClockOut.HasValue;
    public bool IsPickerComplete => !string.IsNullOrEmpty(PickerUsername) && PickerClockIn.HasValue && PickerClockOut.HasValue;
    public bool HasAuditorInProgress => !string.IsNullOrEmpty(AuditorUsername) && AuditorClockIn.HasValue && !AuditorClockOut.HasValue;
    public bool IsAuditorComplete => !string.IsNullOrEmpty(AuditorUsername) && AuditorClockIn.HasValue && AuditorClockOut.HasValue;
    public bool HasAssemblerInProgress => !string.IsNullOrEmpty(AssemblerUsername) && AssemblerClockIn.HasValue && !AssemblerClockOut.HasValue;
    public bool IsAssemblerComplete => !string.IsNullOrEmpty(AssemblerUsername) && AssemblerClockIn.HasValue && AssemblerClockOut.HasValue;
}

/// <summary>
/// Summary view of an InventoryPicking order for list display.
/// </summary>
public class InventoryPickingOrderSummary
{
    public string OrderNumber { get; set; } = string.Empty;
    public DateTime? DueShipDate { get; set; }
    public string CarrierName { get; set; } = string.Empty;
    public string BillToName { get; set; } = string.Empty;
    public string ShipToName { get; set; } = string.Empty;
    public string PickerUsername { get; set; } = string.Empty;
    public string AuditorUsername { get; set; } = string.Empty;
    public string AssemblerUsername { get; set; } = string.Empty;
    public int StatusCode { get; set; }
    public bool OkToShip { get; set; }
    public int PalletCount { get; set; }
    public int ProductCount { get; set; }
    public string Allocator { get; set; } = string.Empty;
    public string TeamLeader { get; set; } = string.Empty;
}

/// <summary>
/// Request to assign a picker to an order.
/// </summary>
public class AssignPickerRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string PickerUsername { get; set; } = string.Empty;
    public DateTime ClockIn { get; set; }
}

/// <summary>
/// Request to assign an auditor to an order.
/// </summary>
public class AssignAuditorRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string AuditorUsername { get; set; } = string.Empty;
    public DateTime ClockIn { get; set; }
}

/// <summary>
/// Request to assign an assembler to an order.
/// </summary>
public class AssignAssemblerRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string AssemblerUsername { get; set; } = string.Empty;
    public DateTime ClockIn { get; set; }
}

/// <summary>
/// Request to clock out a worker.
/// </summary>
public class ClockOutRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string WorkerType { get; set; } = string.Empty;  // "Picker", "Auditor", "Assembler"
    public DateTime ClockOut { get; set; }
}

/// <summary>
/// Request to update order status fields.
/// </summary>
public class UpdateOrderRequest
{
    public string OrderNumber { get; set; } = string.Empty;
    public string? Allocator { get; set; }
    public string? TeamLeader { get; set; }
    public string? Notes { get; set; }
    public int? StatusCode { get; set; }
}

/// <summary>
/// Result of an assignment operation.
/// </summary>
public class AssignmentResult
{
    public bool Success { get; set; }
    public string? ErrorMessage { get; set; }

    public static AssignmentResult Succeeded() => new() { Success = true };
    public static AssignmentResult Failed(string message) => new() { Success = false, ErrorMessage = message };
}

/// <summary>
/// Result of a validation operation.
/// </summary>
public class ValidationResult
{
    public bool IsValid { get; set; }
    public string Message { get; set; } = string.Empty;

    public static ValidationResult Valid() => new() { IsValid = true };
    public static ValidationResult Invalid(string message) => new() { IsValid = false, Message = message };
}

/// <summary>
/// Available operator for picker/auditor/assembler assignment.
/// </summary>
public class AvailableOperator
{
    public string Username { get; set; } = string.Empty;
    public bool IsCpfgUser { get; set; }
}

/// <summary>
/// Available allocator.
/// </summary>
public class AvailableAllocator
{
    public string Username { get; set; } = string.Empty;
}

/// <summary>
/// Available team leader.
/// </summary>
public class AvailableTeamLeader
{
    public string Username { get; set; } = string.Empty;
}
