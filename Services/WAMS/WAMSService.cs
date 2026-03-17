using Dapper;
using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Models.Generated.WEBAPPMisc;
using DotNetWebApp.Services.WAMS.Models;
using DotNetWebApp.Services.WAMS.Validators;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace DotNetWebApp.Services.WAMS;

/// <summary>
/// Implementation of WAMS (Web App Management System) service
/// Uses dual database access: Dapper for reads, EF Core for writes
/// Follows InventoryPickingService pattern with SecondaryDbContext (WEBAPPMisc)
/// </summary>
public class WAMSService : IWAMSService
{
    private readonly SecondaryDbContext _context;
    private readonly IDapperQueryService _dapperQuery;
    private readonly StatusTransitionValidator _statusValidator;
    private readonly DeleteValidator _deleteValidator;
    private readonly ILogger<WAMSService> _logger;

    public WAMSService(
        SecondaryDbContext context,
        [FromKeyedServices("Secondary")] IDapperQueryService dapperQuery,
        StatusTransitionValidator statusValidator,
        DeleteValidator deleteValidator,
        ILogger<WAMSService> logger)
    {
        _context = context;
        _dapperQuery = dapperQuery;
        _statusValidator = statusValidator;
        _deleteValidator = deleteValidator;
        _logger = logger;
    }

    #region Order Retrieval

    public async Task<IEnumerable<WAMSOrder>> ListOrdersAsync(int warehouseId, DateTime date, string? statusFilter = null)
    {
        try
        {
            var sql = @"
                SELECT
                    gs_ordnum AS OrderNumber,
                    gs_id AS WarehouseId,
                    gs_dock AS Dock,
                    gs_datestart AS StartDate,
                    gs_dateend AS EndDate,
                    gs_company AS Company,
                    gs_carrier AS Carrier,
                    gs_driver AS Driver,
                    gs_chr2 AS Phone,
                    gs_notes AS Notes,
                    gs_status AS Status,
                    gs_datechkin AS CheckInDate,
                    gs_appid AS AppId,
                    gs_forkop AS ForkliftOperator,
                    gs_chr1 AS Allocator,
                    gs_chr3 AS TeamLeader,
                    gs_num1 AS OrderTypeValue,
                    gs_picker AS Picker,
                    gs_auditor AS Auditor,
                    gs_assembler AS Assembler,
                    gs_pickerin AS PickerInTime,
                    gs_pickerout AS PickerOutTime,
                    gs_auditorin AS AuditorInTime,
                    gs_auditorout AS AuditorOutTime,
                    gs_assemblerin AS AssemblerInTime,
                    gs_assemblerout AS AssemblerOutTime,
                    gs_log1 AS Log1,
                    gs_num2 AS Num2,
                    gs_num3 AS Num3,
                    gs_num4 AS Num4,
                    gs_num5 AS Num5,
                    gs_num6 AS Num6,
                    gs_dec1 AS Dec1,
                    gs_dec2 AS Dec2,
                    gs_dec3 AS Dec3,
                    gs_dec4 AS Dec4,
                    gs_dec5 AS Dec5,
                    gs_dec6 AS Dec6,
                    gs_chr4 AS Chr4,
                    gs_chr5 AS Chr5,
                    gs_chr6 AS Chr6
                FROM webapp_scheduler
                WHERE gs_id = @WarehouseId
                  AND CAST(gs_datestart AS DATE) = @Date
                  AND (gs_num1 <= 9 OR gs_num1 IS NULL)";

            // Add optional status filter
            if (!string.IsNullOrWhiteSpace(statusFilter))
            {
                sql += " AND gs_status = @StatusFilter";
            }

            sql += @"
                ORDER BY gs_status DESC, gs_appid";

            var parameters = new
            {
                WarehouseId = warehouseId,
                Date = date.Date,
                StatusFilter = statusFilter
            };

            var orders = await _dapperQuery.QueryAsync<WAMSOrder>(sql, parameters);

            // Parse enums for each order
            foreach (var order in orders)
            {
                order.StatusEnum = WAMSColorCodingService.ParseStatus(order.Status);
                order.OrderTypeEnum = WAMSOrderTypeClassifier.ClassifyFromDatabase(order.OrderTypeValue);
            }

            return orders;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error listing orders for warehouse {WarehouseId} on date {Date}", warehouseId, date);
            throw;
        }
    }

    public async Task<WAMSOrder?> GetOrderAsync(long orderNumber, int warehouseId)
    {
        try
        {
            var sql = @"
                SELECT
                    gs_ordnum AS OrderNumber,
                    gs_id AS WarehouseId,
                    gs_dock AS Dock,
                    gs_datestart AS StartDate,
                    gs_dateend AS EndDate,
                    gs_company AS Company,
                    gs_carrier AS Carrier,
                    gs_driver AS Driver,
                    gs_chr2 AS Phone,
                    gs_notes AS Notes,
                    gs_status AS Status,
                    gs_datechkin AS CheckInDate,
                    gs_appid AS AppId,
                    gs_forkop AS ForkliftOperator,
                    gs_chr1 AS Allocator,
                    gs_chr3 AS TeamLeader,
                    gs_num1 AS OrderTypeValue,
                    gs_picker AS Picker,
                    gs_auditor AS Auditor,
                    gs_assembler AS Assembler,
                    gs_pickerin AS PickerInTime,
                    gs_pickerout AS PickerOutTime,
                    gs_auditorin AS AuditorInTime,
                    gs_auditorout AS AuditorOutTime,
                    gs_assemblerin AS AssemblerInTime,
                    gs_assemblerout AS AssemblerOutTime,
                    gs_log1 AS Log1,
                    gs_num2 AS Num2,
                    gs_num3 AS Num3,
                    gs_num4 AS Num4,
                    gs_num5 AS Num5,
                    gs_num6 AS Num6,
                    gs_dec1 AS Dec1,
                    gs_dec2 AS Dec2,
                    gs_dec3 AS Dec3,
                    gs_dec4 AS Dec4,
                    gs_dec5 AS Dec5,
                    gs_dec6 AS Dec6,
                    gs_chr4 AS Chr4,
                    gs_chr5 AS Chr5,
                    gs_chr6 AS Chr6
                FROM webapp_scheduler
                WHERE gs_ordnum = @OrderNumber
                  AND gs_id = @WarehouseId";

            var order = await _dapperQuery.QuerySingleAsync<WAMSOrder>(sql, new { OrderNumber = orderNumber, WarehouseId = warehouseId });

            if (order != null)
            {
                order.StatusEnum = WAMSColorCodingService.ParseStatus(order.Status);
                order.OrderTypeEnum = WAMSOrderTypeClassifier.ClassifyFromDatabase(order.OrderTypeValue);
            }

            return order;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting order {OrderNumber} for warehouse {WarehouseId}", orderNumber, warehouseId);
            throw;
        }
    }

    #endregion

    #region Status Management

    public async Task<StatusChangeResult> ChangeStatusAsync(long orderNumber, DockStatus newStatus, int warehouseId)
    {
        try
        {
            // Get current order
            var order = await GetOrderAsync(orderNumber, warehouseId);
            if (order == null)
            {
                return new StatusChangeResult
                {
                    Success = false,
                    Message = $"Order {orderNumber} not found in warehouse {warehouseId}",
                    UpdatedOrderCount = 0
                };
            }

            // Validate transition
            var (isValid, errorMessage) = _statusValidator.ValidateTransition(order.StatusEnum, newStatus);
            if (!isValid)
            {
                return new StatusChangeResult
                {
                    Success = false,
                    Message = errorMessage,
                    UpdatedOrderCount = 0
                };
            }

            // Update status using EF Core
            var entity = await _context.Set<Webapp_scheduler>()
                .FirstOrDefaultAsync(e => e.gs_ordnum == orderNumber && e.gs_id == warehouseId);

            if (entity == null)
            {
                return new StatusChangeResult
                {
                    Success = false,
                    Message = $"Order {orderNumber} not found",
                    UpdatedOrderCount = 0
                };
            }

            var newStatusString = WAMSColorCodingService.ToStatusString(newStatus);
            entity.gs_status = newStatusString;

            // Manage check-in date
            if (newStatus == DockStatus.CheckIn)
            {
                entity.gs_datechkin = DateTime.Now;
            }
            else if (newStatus == DockStatus.NA && order.StatusEnum == DockStatus.CheckIn)
            {
                // Reverting from CheckIn to NA clears check-in date
                entity.gs_datechkin = null;
            }

            await _context.SaveChangesAsync();

            _logger.LogInformation("Changed status for order {OrderNumber} from {OldStatus} to {NewStatus}",
                orderNumber, order.StatusEnum, newStatus);

            return new StatusChangeResult
            {
                Success = true,
                Message = $"Status changed to {newStatusString}",
                UpdatedOrderCount = 1,
                UpdatedOrderNumbers = new List<long> { orderNumber }
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error changing status for order {OrderNumber}", orderNumber);
            return new StatusChangeResult
            {
                Success = false,
                Message = $"Error: {ex.Message}",
                UpdatedOrderCount = 0
            };
        }
    }

    public async Task<StatusChangeResult> BatchChangeStatusByAppIDAsync(string appId, DockStatus newStatus, int warehouseId)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(appId))
            {
                return new StatusChangeResult
                {
                    Success = false,
                    Message = "AppID cannot be empty",
                    UpdatedOrderCount = 0
                };
            }

            // Get all orders with this AppID
            var orders = await GetOrdersByAppIdAsync(appId, warehouseId);
            var ordersList = orders.ToList();

            if (!ordersList.Any())
            {
                return new StatusChangeResult
                {
                    Success = false,
                    Message = $"No orders found with AppID {appId}",
                    UpdatedOrderCount = 0
                };
            }

            // Validate all transitions
            var invalidTransitions = new List<string>();
            foreach (var order in ordersList)
            {
                var (isValid, errorMessage) = _statusValidator.ValidateTransition(order.StatusEnum, newStatus);
                if (!isValid)
                {
                    invalidTransitions.Add($"Order {order.OrderNumber}: {errorMessage}");
                }
            }

            if (invalidTransitions.Any())
            {
                return new StatusChangeResult
                {
                    Success = false,
                    Message = $"Some transitions are invalid: {string.Join("; ", invalidTransitions)}",
                    UpdatedOrderCount = 0
                };
            }

            // Update all orders in single transaction
            var entities = await _context.Set<Webapp_scheduler>()
                .Where(e => e.gs_appid == appId && e.gs_id == warehouseId)
                .ToListAsync();

            var newStatusString = WAMSColorCodingService.ToStatusString(newStatus);
            foreach (var entity in entities)
            {
                entity.gs_status = newStatusString;

                // Manage check-in date
                if (newStatus == DockStatus.CheckIn)
                {
                    entity.gs_datechkin = DateTime.Now;
                }
                else if (newStatus == DockStatus.NA)
                {
                    // Reverting to NA clears check-in date
                    entity.gs_datechkin = null;
                }
            }

            await _context.SaveChangesAsync();

            var updatedOrderNumbers = entities.Select(e => e.gs_ordnum).ToList();

            _logger.LogInformation("Batch changed status for {Count} orders with AppID {AppId} to {NewStatus}",
                entities.Count, appId, newStatus);

            return new StatusChangeResult
            {
                Success = true,
                Message = $"Updated {entities.Count} orders to {newStatusString}",
                UpdatedOrderCount = entities.Count,
                UpdatedOrderNumbers = updatedOrderNumbers
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error batch changing status for AppID {AppId}", appId);
            return new StatusChangeResult
            {
                Success = false,
                Message = $"Error: {ex.Message}",
                UpdatedOrderCount = 0
            };
        }
    }

    public async Task<bool> ClearCheckInAsync(long orderNumber, int warehouseId)
    {
        try
        {
            var entity = await _context.Set<Webapp_scheduler>()
                .FirstOrDefaultAsync(e => e.gs_ordnum == orderNumber && e.gs_id == warehouseId);

            if (entity == null)
            {
                _logger.LogWarning("Order {OrderNumber} not found for clearing check-in", orderNumber);
                return false;
            }

            entity.gs_datechkin = null;
            entity.gs_status = "N/A"; // Revert to NA when clearing check-in

            await _context.SaveChangesAsync();

            _logger.LogInformation("Cleared check-in for order {OrderNumber}", orderNumber);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error clearing check-in for order {OrderNumber}", orderNumber);
            return false;
        }
    }

    #endregion

    #region Delete/Undelete

    public async Task<bool> DeleteOrderAsync(long orderNumber, int securityLevel, int warehouseId)
    {
        try
        {
            // Get current order
            var order = await GetOrderAsync(orderNumber, warehouseId);
            if (order == null)
            {
                _logger.LogWarning("Order {OrderNumber} not found for deletion", orderNumber);
                return false;
            }

            // Validate deletion
            var (isValid, errorMessage) = _deleteValidator.CanDelete(order.StatusEnum, securityLevel, order.OrderTypeEnum);
            if (!isValid)
            {
                _logger.LogWarning("Cannot delete order {OrderNumber}: {Reason}", orderNumber, errorMessage);
                return false;
            }

            // Soft delete: add 10 to gs_num1
            var entity = await _context.Set<Webapp_scheduler>()
                .FirstOrDefaultAsync(e => e.gs_ordnum == orderNumber && e.gs_id == warehouseId);

            if (entity == null)
            {
                return false;
            }

            var currentType = entity.gs_num1 ?? 1;
            entity.gs_num1 = currentType + 10;

            await _context.SaveChangesAsync();

            _logger.LogInformation("Soft deleted order {OrderNumber}, type changed from {OldType} to {NewType}",
                orderNumber, currentType, entity.gs_num1);

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting order {OrderNumber}", orderNumber);
            return false;
        }
    }

    public async Task<bool> UndeleteOrderAsync(long orderNumber, int warehouseId)
    {
        try
        {
            // Get current order
            var order = await GetOrderAsync(orderNumber, warehouseId);
            if (order == null)
            {
                _logger.LogWarning("Order {OrderNumber} not found for undeletion", orderNumber);
                return false;
            }

            // Validate undeletion
            var (isValid, errorMessage) = _deleteValidator.CanUndelete(order.OrderTypeEnum);
            if (!isValid)
            {
                _logger.LogWarning("Cannot undelete order {OrderNumber}: {Reason}", orderNumber, errorMessage);
                return false;
            }

            // Undelete: subtract 10 from gs_num1
            var entity = await _context.Set<Webapp_scheduler>()
                .FirstOrDefaultAsync(e => e.gs_ordnum == orderNumber && e.gs_id == warehouseId);

            if (entity == null)
            {
                return false;
            }

            var currentType = entity.gs_num1 ?? 11;
            entity.gs_num1 = currentType - 10;

            await _context.SaveChangesAsync();

            _logger.LogInformation("Undeleted order {OrderNumber}, type changed from {OldType} to {NewType}",
                orderNumber, currentType, entity.gs_num1);

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error undeleting order {OrderNumber}", orderNumber);
            return false;
        }
    }

    #endregion

    #region Personnel Management

    public async Task<bool> UpdateForkliftOperatorAsync(long orderNumber, string operatorUsername, int warehouseId)
    {
        try
        {
            var entity = await _context.Set<Webapp_scheduler>()
                .FirstOrDefaultAsync(e => e.gs_ordnum == orderNumber && e.gs_id == warehouseId);

            if (entity == null)
            {
                _logger.LogWarning("Order {OrderNumber} not found for operator update", orderNumber);
                return false;
            }

            entity.gs_forkop = operatorUsername;

            await _context.SaveChangesAsync();

            _logger.LogInformation("Updated forklift operator for order {OrderNumber} to {Operator}",
                orderNumber, operatorUsername);

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating forklift operator for order {OrderNumber}", orderNumber);
            return false;
        }
    }

    public async Task<bool> BatchUpdateForkliftByAppIDAsync(string appId, string operatorUsername, int warehouseId)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(appId))
            {
                _logger.LogWarning("AppID cannot be empty for batch operator update");
                return false;
            }

            var entities = await _context.Set<Webapp_scheduler>()
                .Where(e => e.gs_appid == appId && e.gs_id == warehouseId)
                .ToListAsync();

            if (!entities.Any())
            {
                _logger.LogWarning("No orders found with AppID {AppId} for operator update", appId);
                return false;
            }

            foreach (var entity in entities)
            {
                entity.gs_forkop = operatorUsername;
            }

            await _context.SaveChangesAsync();

            _logger.LogInformation("Batch updated forklift operator for {Count} orders with AppID {AppId} to {Operator}",
                entities.Count, appId, operatorUsername);

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error batch updating forklift operator for AppID {AppId}", appId);
            return false;
        }
    }

    public async Task<IEnumerable<OperatorInfo>> GetAvailableOperatorsAsync(int warehouseId)
    {
        try
        {
            // TODO: BLOCKER - WEBAPPSystem Database Schema Not Yet Integrated
            //
            // This method requires the WEBAPPSystem database schema to be added to the project.
            // The WEBAPPSystem database is currently external and not modeled in DotNetWebApp.
            //
            // Spec Reference: BUSINESS_LOGIC_COMPLETE-WAMS.md (lines 338-346)
            //
            // Correct Query (pending WEBAPPSystem schema integration):
            //   SELECT us_login, ISNULL(cpfg_user.d2_value, 'No') AS is_Chicago_user
            //   FROM webappsystem.dbo.dxuser
            //   JOIN dtd2 forklift ON forklift.d2_recid = us_id AND forklift.d2_d1id = 478
            //   LEFT JOIN dtd2 cpfg_user ON cpfg_user.d2_recid = us_id AND cpfg_user.d2_d1id = 687
            //   WHERE us_active = 1
            //   ORDER BY us_login
            //
            // Key IDs (from spec, magic numbers section):
            //   - 478 = Forklift operator group ID in dtd2
            //   - 687 = Chicago user flag ID in dtd2
            //
            // Implementation Status:
            // - [ ] Add WEBAPPSystem database schema to SQL DDL pipeline
            // - [ ] Generate webappsystem.dbo.dxuser entity
            // - [ ] Generate WEBAPP.dbo.dtd2 entity (if not already present)
            // - [ ] Update SecondaryDbContext to include these entities
            // - [ ] Implement correct query using Dapper with proper joins
            // - [ ] Add warehouse-specific filtering logic (d2_d1id = 687 for Chicago, exclude for NYC)
            //
            // JIRA Reference: External WEBAPPSystem schema integration task (not yet in this repo)
            //
            // Current Status: RETURNS EMPTY until schema is available

            _logger.LogWarning("GetAvailableOperatorsAsync called but WEBAPPSystem schema not yet integrated. Returning empty list.");
            return Enumerable.Empty<OperatorInfo>();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting available operators for warehouse {WarehouseId}", warehouseId);
            return Enumerable.Empty<OperatorInfo>();
        }
    }

    #endregion

    #region Helper Methods

    private async Task<IEnumerable<WAMSOrder>> GetOrdersByAppIdAsync(string appId, int warehouseId)
    {
        var sql = @"
            SELECT
                gs_ordnum AS OrderNumber,
                gs_id AS WarehouseId,
                gs_status AS Status,
                gs_num1 AS OrderTypeValue,
                gs_appid AS AppId
            FROM webapp_scheduler
            WHERE gs_appid = @AppId
              AND gs_id = @WarehouseId";

        var orders = await _dapperQuery.QueryAsync<WAMSOrder>(sql, new { AppId = appId, WarehouseId = warehouseId });

        foreach (var order in orders)
        {
            order.StatusEnum = WAMSColorCodingService.ParseStatus(order.Status);
            order.OrderTypeEnum = WAMSOrderTypeClassifier.ClassifyFromDatabase(order.OrderTypeValue);
        }

        return orders;
    }

    #endregion
}
