using Dapper;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Services.Models;

namespace DotNetWebApp.Services;

/// <summary>
/// Service for querying Deacom ERP system for order enrichment.
/// Uses IDapperQueryService for efficient read-only queries.
/// FIXES: All SQL injection vulnerabilities from original VB.NET code by using parameters.
/// </summary>
public class DeacomService : IDeacomService
{
    private readonly IDapperQueryService _dapper;
    private readonly ILogger<DeacomService> _logger;

    public DeacomService(
        IDapperQueryService dapper,
        ILogger<DeacomService> logger)
    {
        _dapper = dapper;
        _logger = logger;
    }

    /// <summary>
    /// Get sales order details by order number.
    /// Query from spec: Form1.vb:358-365
    /// FIXES: SQL injection vulnerability by using parameters
    /// </summary>
    public async Task<SalesOrderDto?> GetSalesOrderAsync(string orderNumber)
    {
        const string sql = @"
            SELECT
                to_ordnum AS OrderNumber,
                bi_name AS CompanyName,
                sh_name AS ShipToName,
                to_ordtype AS OrderTypeCode,
                to_waid AS WarehouseId,
                to_dueship AS DueShipDate,
                (SELECT d2_value FROM dtd2 WHERE d2_recid=to_id AND d2_d1id=285) AS ProNumber,
                (SELECT us_login FROM GAIsystem.dbo.dxuser
                 WHERE us_id=(SELECT d2_value FROM dtd2 WHERE d2_recid=to_id AND d2_d1id=536)) AS AssemblerLogin
            FROM dttord
            JOIN dmbill ON bi_id=to_biid
            JOIN dmship ON sh_id=to_shid
            LEFT JOIN dtd2 ON d2_recid=to_id AND d2_d1id=285
            WHERE dttord.to_status = 'C' AND to_ordnum = @OrderNumber";

        return await _dapper.QuerySingleAsync<SalesOrderDto>(sql, new { OrderNumber = orderNumber });
    }

    /// <summary>
    /// Get purchase order details by PO number.
    /// Query from spec: Form1.vb:436-440
    /// FIXES: SQL injection vulnerability by using parameters
    /// </summary>
    public async Task<PurchaseOrderDto?> GetPurchaseOrderAsync(string purNumber)
    {
        const string sql = @"
            SELECT
                pu_purnum AS PurchaseOrderNumber,
                ve_name AS VendorName,
                tp_duedock AS DueDockDate
            FROM dtpur
            JOIN dttpur ON dttpur.tp_id = dtpur.pu_tpid
            JOIN dmvend ON dmvend.ve_id = tp_veid
            WHERE dtpur.pu_purnum = @PurNumber";

        return await _dapper.QuerySingleAsync<PurchaseOrderDto>(sql, new { PurNumber = purNumber });
    }

    /// <summary>
    /// Find sales order by pro number.
    /// Query from spec: Form1.vb:506-508
    /// FIXES: SQL injection vulnerability by using parameters
    /// </summary>
    public async Task<string?> FindOrderByProNumberAsync(string proNumber)
    {
        const string sql = @"
            SELECT to_ordnum
            FROM dtd2
            JOIN dttord ON to_id=d2_recid
            WHERE d2_d1id=285
              AND to_status='c'
              AND d2_value LIKE @ProNumber";

        // Use LIKE pattern as in original (though exact match would be better)
        return await _dapper.QuerySingleAsync<string>(sql, new { ProNumber = $"%{proNumber}%" });
    }

    /// <summary>
    /// Find sales orders by customer PO number.
    /// Query from spec: Form1.vb:661-662
    /// FIXES: SQL injection vulnerability by using parameters
    /// NOTE: Original code only processed first match (line 667) - we return all
    /// </summary>
    public async Task<List<string>> FindOrdersByCustomerPOAsync(string customerPO)
    {
        const string sql = @"
            SELECT to_ordnum
            FROM dttord
            WHERE to_status='c'
              AND to_billpo LIKE @CustomerPO";

        var results = await _dapper.QueryAsync<string>(sql, new { CustomerPO = $"%{customerPO}%" });
        return results.ToList();
    }

    /// <summary>
    /// Get user warehouse assignment from gai_dmstech.
    /// Query from spec: Form1.vb:85-87
    /// FIXES: CRITICAL SQL injection vulnerability
    /// NOTE: This queries GAIMisc database (SecondaryDatabase)
    /// </summary>
    public async Task<UserWarehouseDto?> GetUserWarehouseAsync(string userName)
    {
        const string sql = @"
            SELECT
                gs_chr1 AS UserName,
                gs_int1 AS SecurityLevel,
                gs_chr3 AS WarehouseName,
                gs_type AS UserType
            FROM GAIMisc.dbo.gai_dmstech
            WHERE gs_chr1 = @UserName";

        return await _dapper.QuerySingleAsync<UserWarehouseDto>(sql, new { UserName = userName });
    }
}
