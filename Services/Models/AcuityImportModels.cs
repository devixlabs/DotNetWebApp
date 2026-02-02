namespace DotNetWebApp.Services.Models;

/// <summary>
/// Result of processing an Acuity CSV import.
/// </summary>
public class AcuityImportResult
{
    public int TotalRows { get; set; }
    public int SuccessfulInserts { get; set; }
    public int SuccessfulUpdates { get; set; }
    public int Errors { get; set; }
    public List<ImportError> ErrorDetails { get; set; } = new();
    public DateTime ProcessedAt { get; set; } = DateTime.Now;
    public string FileName { get; set; } = string.Empty;

    public bool HasErrors => Errors > 0;
    public int TotalSuccess => SuccessfulInserts + SuccessfulUpdates;
}

/// <summary>
/// Details of an import error.
/// </summary>
public class ImportError
{
    public string OrderNumber { get; set; } = string.Empty;
    public string ErrorMessage { get; set; } = string.Empty;
    public string? CompanyName { get; set; }
    public string? AppointmentId { get; set; }
    public DateTime? ScheduleDate { get; set; }
}

/// <summary>
/// Raw CSV row from Acuity scheduling export (22 columns).
/// Maps to the documented column structure from spec.
/// </summary>
public class AcuityRow
{
    // Column indices from spec (0-based)
    public string StartTime { get; set; } = string.Empty;           // Column 0
    public string EndTime { get; set; } = string.Empty;             // Column 1
    public string Timezone { get; set; } = string.Empty;            // Column 2
    public string FirstName { get; set; } = string.Empty;           // Column 3
    public string LastName { get; set; } = string.Empty;            // Column 4
    public string Phone { get; set; } = string.Empty;               // Column 5
    public string Email { get; set; } = string.Empty;               // Column 6
    public string Type { get; set; } = string.Empty;                // Column 7 (Warehouse location)
    public string Calendar { get; set; } = string.Empty;            // Column 8
    public string AppointmentPrice { get; set; } = string.Empty;    // Column 9 (unused)
    public string Paid { get; set; } = string.Empty;                // Column 10 (unused)
    public string AmountPaidOnline { get; set; } = string.Empty;    // Column 11 (unused)
    public string CertificateCode { get; set; } = string.Empty;     // Column 12 (unused)
    public string Notes { get; set; } = string.Empty;               // Column 13 (unused)
    public string DateScheduled { get; set; } = string.Empty;       // Column 14
    public string Label { get; set; } = string.Empty;               // Column 15 (unused)
    public string ScheduledBy { get; set; } = string.Empty;         // Column 16
    public string DateRescheduled { get; set; } = string.Empty;     // Column 17
    public string CarrierName { get; set; } = string.Empty;         // Column 18
    public string AppointmentType { get; set; } = string.Empty;     // Column 19 (Pickup/Delivery)
    public string OrderNumbers { get; set; } = string.Empty;        // Column 20 *** CRITICAL ***
    public string AppointmentId { get; set; } = string.Empty;       // Column 21
}

/// <summary>
/// Processed order ready for database insert/update.
/// Maps to gai_scheduler table structure.
/// </summary>
public class ProcessedOrder
{
    public string OrderNumber { get; set; } = string.Empty;
    public string Dock { get; set; } = "0";
    public DateTime DateStart { get; set; }
    public DateTime DateEnd { get; set; }
    public TimeSpan DockMinutes { get; set; } = TimeSpan.Zero;
    public string Company { get; set; } = string.Empty;
    public string Carrier { get; set; } = "TBD";
    public string Driver { get; set; } = string.Empty;
    public string Phone { get; set; } = "()";
    public string Notes { get; set; } = "Notes";
    public string Status { get; set; } = "N/A";
    public DateTime CheckInDate { get; set; }
    public string AppointmentId { get; set; } = string.Empty;
    public string ForkliftOperator { get; set; } = string.Empty;
    public int OrderType { get; set; }  // 1=SO, 2=PO, 3=ICT-NL, 4=ICT-CPFG
    public string? ProNumber { get; set; }
    public DateTime? PromiseDate { get; set; }
    public int WarehouseId { get; set; }  // 3=CPFG, 92=Northlake
}

/// <summary>
/// Order type classification.
/// </summary>
public enum OrderType
{
    Unknown = 0,
    SalesOrder = 1,          // SO - ends in 00
    PurchaseOrder = 2,       // PO - other endings
    ICT_Northlake = 3,       // ICT - ends in 99, WID=92
    ICT_CPFG = 4             // ICT - ends in 99, WID=3 (or Make orders)
}

/// <summary>
/// Sales order details from Deacom ERP.
/// </summary>
public class SalesOrderDto
{
    public string OrderNumber { get; set; } = string.Empty;
    public string CompanyName { get; set; } = string.Empty;  // bi_name
    public string ShipToName { get; set; } = string.Empty;   // sh_name
    public string OrderTypeCode { get; set; } = string.Empty; // to_ordtype ('s'=sales, 'm'=make)
    public int WarehouseId { get; set; }                     // to_waid
    public DateTime? DueShipDate { get; set; }               // to_dueship
    public string? ProNumber { get; set; }                   // from dtd2 where d2_d1id=285
    public string? AssemblerLogin { get; set; }              // from dxuser via dtd2
}

/// <summary>
/// Purchase order details from Deacom ERP.
/// </summary>
public class PurchaseOrderDto
{
    public string PurchaseOrderNumber { get; set; } = string.Empty;
    public string VendorName { get; set; } = string.Empty;   // ve_name
    public DateTime? DueDockDate { get; set; }               // tp_duedock
}

/// <summary>
/// User warehouse assignment from gai_dmstech.
/// </summary>
public class UserWarehouseDto
{
    public string UserName { get; set; } = string.Empty;     // gs_chr1
    public int SecurityLevel { get; set; }                   // gs_int1
    public string WarehouseName { get; set; } = string.Empty; // gs_chr3 ("CPFG" or "Northlake")
    public string? UserType { get; set; }                    // gs_type

    public int WarehouseId => WarehouseName switch
    {
        "CPFG" => 3,
        "Northlake" => 92,
        _ => 0
    };
}
