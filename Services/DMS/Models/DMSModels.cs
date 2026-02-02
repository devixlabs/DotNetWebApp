namespace DotNetWebApp.Services.DMS.Models;

/// <summary>
/// Order type classification for DMS
/// Values 1-4 are active order types
/// Values 11-14 are deleted order types (type + 10)
/// </summary>
public enum OrderType
{
    SO = 1,              // Sales Order
    PO = 2,              // Purchase Order
    ICT_NL = 3,          // ICT Northlake
    ICT_CPFG = 4,        // ICT CPFG
    Deleted_SO = 11,     // Deleted Sales Order (1 + 10)
    Deleted_PO = 12,     // Deleted Purchase Order (2 + 10)
    Deleted_ICT_NL = 13, // Deleted ICT Northlake (3 + 10)
    Deleted_ICT_CPFG = 14 // Deleted ICT CPFG (4 + 10)
}

/// <summary>
/// Dock status workflow for orders
/// Status progression: NA → CheckIn → Loading → Unloading → Shipped → Received
/// Special case: CheckIn can revert to NA (only backward transition allowed)
/// </summary>
public enum DockStatus
{
    NA = 0,
    CheckIn = 1,
    Loading = 2,
    Unloading = 3,
    Shipped = 4,
    Received = 5
}

/// <summary>
/// Complete DMS order with all 39 properties from gai_scheduler table
/// Maps to gs_* columns in GAIMisc.dbo.gai_scheduler
/// </summary>
public class DMSOrder
{
    // Core order identification
    public long OrderNumber { get; set; }        // gs_ordnum
    public int WarehouseId { get; set; }         // gs_id
    public string? Dock { get; set; }            // gs_dock

    // Date range
    public DateTime? StartDate { get; set; }     // gs_datestart
    public DateTime? EndDate { get; set; }       // gs_dateend

    // Company and carrier information
    public string? Company { get; set; }         // gs_company
    public string? Carrier { get; set; }         // gs_carrier
    public string? Driver { get; set; }          // gs_driver
    public string? Phone { get; set; }           // gs_chr2
    public string? Notes { get; set; }           // gs_notes

    // Status and check-in
    public string? Status { get; set; }          // gs_status (raw string)
    public DockStatus StatusEnum { get; set; }   // Parsed enum
    public DateTime? CheckInDate { get; set; }   // gs_datechkin

    // AppID grouping and personnel
    public string? AppId { get; set; }           // gs_appid (orders with same AppID move together)
    public string? ForkliftOperator { get; set; } // gs_forkop
    public string? Allocator { get; set; }       // gs_chr1
    public string? TeamLeader { get; set; }      // gs_chr3

    // Order type classification
    public long? OrderTypeValue { get; set; }    // gs_num1 (1=SO, 2=PO, 3=ICT_NL, 4=ICT_CPFG, 11-14=Deleted)
    public OrderType OrderTypeEnum { get; set; } // Parsed enum

    // Personnel from PrePick (inherited fields)
    public string? Picker { get; set; }          // gs_picker
    public string? Auditor { get; set; }         // gs_auditor
    public string? Assembler { get; set; }       // gs_assembler

    // Timestamps (PrePick workflow times)
    public DateTime? PickerInTime { get; set; }    // gs_pickerin
    public DateTime? PickerOutTime { get; set; }   // gs_pickerout
    public DateTime? AuditorInTime { get; set; }   // gs_auditorin
    public DateTime? AuditorOutTime { get; set; }  // gs_auditorout
    public DateTime? AssemblerInTime { get; set; } // gs_assemblerin
    public DateTime? AssemblerOutTime { get; set; }// gs_assemblerout

    // Hidden fields (gs_log1, gs_num2-6, gs_dec1-6, etc.)
    public bool? Log1 { get; set; }              // gs_log1
    public long? Num2 { get; set; }              // gs_num2
    public long? Num3 { get; set; }              // gs_num3
    public long? Num4 { get; set; }              // gs_num4
    public long? Num5 { get; set; }              // gs_num5
    public long? Num6 { get; set; }              // gs_num6
    public decimal? Dec1 { get; set; }           // gs_dec1
    public decimal? Dec2 { get; set; }           // gs_dec2
    public decimal? Dec3 { get; set; }           // gs_dec3 (used for ICT identification: 99 = ICT)
    public decimal? Dec4 { get; set; }           // gs_dec4
    public decimal? Dec5 { get; set; }           // gs_dec5
    public decimal? Dec6 { get; set; }           // gs_dec6

    // Additional character fields
    public string? Chr4 { get; set; }            // gs_chr4
    public string? Chr5 { get; set; }            // gs_chr5
    public string? Chr6 { get; set; }            // gs_chr6
}

/// <summary>
/// Request to change status of a single order
/// </summary>
public class ChangeStatusRequest
{
    public long OrderNumber { get; set; }
    public DockStatus NewStatus { get; set; }
    public int WarehouseId { get; set; }
}

/// <summary>
/// Request to batch change status for all orders with same AppID
/// </summary>
public class BatchStatusByAppIDRequest
{
    public string AppId { get; set; } = string.Empty;
    public DockStatus NewStatus { get; set; }
    public int WarehouseId { get; set; }
}

/// <summary>
/// Request to delete an order (soft delete: type + 10)
/// Requires status = NA and securityLevel <= 2
/// </summary>
public class DeleteOrderRequest
{
    public long OrderNumber { get; set; }
    public int SecurityLevel { get; set; }
    public int WarehouseId { get; set; }
}

/// <summary>
/// Request to update forklift operator for a single order
/// </summary>
public class UpdateOperatorRequest
{
    public long OrderNumber { get; set; }
    public string OperatorUsername { get; set; } = string.Empty;
    public int WarehouseId { get; set; }
}

/// <summary>
/// Request to batch update forklift operator for all orders with same AppID
/// </summary>
public class BatchUpdateOperatorRequest
{
    public string AppId { get; set; } = string.Empty;
    public string OperatorUsername { get; set; } = string.Empty;
    public int WarehouseId { get; set; }
}

/// <summary>
/// Result of status change operation (single or batch)
/// </summary>
public class StatusChangeResult
{
    public bool Success { get; set; }
    public string Message { get; set; } = string.Empty;
    public int UpdatedOrderCount { get; set; }
    public List<long> UpdatedOrderNumbers { get; set; } = new();
}

/// <summary>
/// Operator information for dropdown population
/// Filtered by warehouse (d2_d1id=687 for CPFG users)
/// </summary>
public class OperatorInfo
{
    public string Username { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public bool IsCPFGUser { get; set; }
}
