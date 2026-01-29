namespace DotNetWebApp.Models.UI;

/// <summary>
/// Configuration for a data grid column - describes display, formatting, editability, and visibility.
/// Used by SmartDataGrid<T> component for flexible column rendering.
/// </summary>
public class ColumnConfig
{
    /// <summary>
    /// The C# property name this column maps to (e.g., "ProductName")
    /// </summary>
    public string Property { get; set; } = string.Empty;

    /// <summary>
    /// Display header text for the column
    /// </summary>
    public string DisplayName { get; set; } = string.Empty;

    /// <summary>
    /// Whether users can sort by this column
    /// </summary>
    public bool Sortable { get; set; } = true;

    /// <summary>
    /// Whether users can filter by this column
    /// </summary>
    public bool Filterable { get; set; } = true;

    /// <summary>
    /// Whether this column allows inline editing
    /// </summary>
    public bool Editable { get; set; } = false;

    /// <summary>
    /// Whether this column is hidden from display (but still in data)
    /// </summary>
    public bool Hidden { get; set; } = false;

    /// <summary>
    /// Optional format string for display (e.g., "{0:C2}" for currency)
    /// </summary>
    public string? FormatString { get; set; }

    /// <summary>
    /// Optional column width in pixels
    /// </summary>
    public int? Width { get; set; }
}
