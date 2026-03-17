using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Models.Generated.WEBAPPMisc;
using DotNetWebApp.Services.InventoryAllocation.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace DotNetWebApp.Services.InventoryAllocation;

/// <summary>
/// Pessimistic locking service for allocation orders.
/// Business Rule: 10-minute lock timeout.
/// Lock types: 1 = Order, 2 = Product
/// Note: Scheduled auto-release (5:30 PM, 7:30 PM) removed for MVP.
/// </summary>
public interface ILockService
{
    /// <summary>
    /// Acquire lock for order. Returns false if locked by another user.
    /// </summary>
    Task<LockResult> AcquireLockAsync(string orderNumber, string username, int warehouseId);

    /// <summary>
    /// Release lock for order.
    /// </summary>
    Task<bool> ReleaseLockAsync(string orderNumber, string username, int warehouseId);

    /// <summary>
    /// Release all locks held by user.
    /// </summary>
    Task ReleaseAllUserLocksAsync(string username);

    /// <summary>
    /// Check if order is locked.
    /// </summary>
    Task<OrderLock?> GetLockAsync(string orderNumber, int warehouseId);

    /// <summary>
    /// Check if user owns the lock.
    /// </summary>
    Task<bool> UserOwnsLockAsync(string orderNumber, string username, int warehouseId);

    /// <summary>
    /// Release expired locks.
    /// </summary>
    Task<int> ReleaseExpiredLocksAsync();
}

/// <summary>
/// Implementation of pessimistic locking service.
/// Uses webapp_lock table with gl_id = 1 for order locks.
/// Uses EF Core for all operations since this involves writes.
/// </summary>
public class LockService : ILockService
{
    private readonly SecondaryDbContext _context;
    private readonly ILogger<LockService> _logger;

    /// <summary>
    /// Lock timeout in minutes.
    /// </summary>
    public const int LOCK_TIMEOUT_MINUTES = 10;

    /// <summary>
    /// Lock type for orders.
    /// </summary>
    private const int ORDER_LOCK_TYPE = 1;

    public LockService(
        SecondaryDbContext context,
        ILogger<LockService> logger)
    {
        _context = context;
        _logger = logger;
    }

    public async Task<LockResult> AcquireLockAsync(string orderNumber, string username, int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        var existingLock = await GetLockAsync(orderNumber, warehouseId);

        if (existingLock != null)
        {
            var lockAge = DateTime.Now - existingLock.LockDate;

            // Check if lock has timed out
            if (lockAge.TotalMinutes >= LOCK_TIMEOUT_MINUTES)
            {
                _logger.LogInformation(
                    "Lock expired for order {OrderNumber} (held by {LockedBy} for {Minutes:F1} minutes)",
                    orderNumber, existingLock.Username, lockAge.TotalMinutes);

                await ReleaseLockInternalAsync(ordNum, warehouseId);
            }
            else if (string.Equals(existingLock.Username, username, StringComparison.OrdinalIgnoreCase))
            {
                // Already owned by this user - refresh the lock time
                await RefreshLockAsync(ordNum, username, warehouseId);
                return LockResult.AlreadyOwned();
            }
            else
            {
                // Locked by another user
                _logger.LogWarning(
                    "Order {OrderNumber} locked by {LockedBy}",
                    orderNumber, existingLock.Username);

                return LockResult.LockedByOther(existingLock.Username, existingLock.LockDate);
            }
        }

        // Create new lock
        try
        {
            await CreateLockAsync(ordNum, username, warehouseId);
            _logger.LogInformation(
                "Lock acquired for order {OrderNumber} by {Username}",
                orderNumber, username);

            return LockResult.Acquired();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to acquire lock for order {OrderNumber}", orderNumber);
            return LockResult.Failed(ex.Message);
        }
    }

    public async Task<bool> ReleaseLockAsync(string orderNumber, string username, int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        var existingLock = await GetLockAsync(orderNumber, warehouseId);

        if (existingLock == null)
        {
            return true; // No lock to release
        }

        // Only allow release by lock owner
        if (!string.Equals(existingLock.Username, username, StringComparison.OrdinalIgnoreCase))
        {
            _logger.LogWarning(
                "User {Username} attempted to release lock owned by {LockedBy} for order {OrderNumber}",
                username, existingLock.Username, orderNumber);
            return false;
        }

        await ReleaseLockInternalAsync(ordNum, warehouseId);
        _logger.LogInformation(
            "Lock released for order {OrderNumber} by {Username}",
            orderNumber, username);

        return true;
    }

    public async Task ReleaseAllUserLocksAsync(string username)
    {
        var userLocks = await _context.Set<Webapp_lock>()
            .Where(l => l.gl_id == ORDER_LOCK_TYPE &&
                        l.gl_username != null &&
                        l.gl_username.ToLower() == username.ToLower())
            .ToListAsync();

        if (userLocks.Any())
        {
            _context.Set<Webapp_lock>().RemoveRange(userLocks);
            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Released {Count} locks for user {Username}",
                userLocks.Count, username);
        }
    }

    public async Task<OrderLock?> GetLockAsync(string orderNumber, int warehouseId)
    {
        long ordNum = long.Parse(orderNumber);

        var lockEntity = await _context.Set<Webapp_lock>()
            .FirstOrDefaultAsync(l =>
                l.gl_id == ORDER_LOCK_TYPE &&
                l.gl_ordnum == ordNum &&
                l.gl_int1 == warehouseId);

        if (lockEntity == null)
            return null;

        return new OrderLock
        {
            LockIndex = lockEntity.gl_index,
            LockId = lockEntity.gl_id,
            OrderNumber = lockEntity.gl_ordnum,
            Username = lockEntity.gl_username ?? string.Empty,
            LockDate = lockEntity.gl_datel ?? DateTime.Now
        };
    }

    public async Task<bool> UserOwnsLockAsync(string orderNumber, string username, int warehouseId)
    {
        var existingLock = await GetLockAsync(orderNumber, warehouseId);

        if (existingLock == null)
            return false;

        return string.Equals(existingLock.Username, username, StringComparison.OrdinalIgnoreCase);
    }

    public async Task<int> ReleaseExpiredLocksAsync()
    {
        var cutoffTime = DateTime.Now.AddMinutes(-LOCK_TIMEOUT_MINUTES);

        var expiredLocks = await _context.Set<Webapp_lock>()
            .Where(l => l.gl_id == ORDER_LOCK_TYPE &&
                        l.gl_datel < cutoffTime)
            .ToListAsync();

        if (expiredLocks.Any())
        {
            _context.Set<Webapp_lock>().RemoveRange(expiredLocks);
            await _context.SaveChangesAsync();

            _logger.LogInformation(
                "Released {Count} expired locks (older than {Minutes} minutes)",
                expiredLocks.Count, LOCK_TIMEOUT_MINUTES);
        }

        return expiredLocks.Count;
    }

    // Private helpers

    private async Task CreateLockAsync(long orderNumber, string username, int warehouseId)
    {
        var lockEntity = new Webapp_lock
        {
            gl_id = ORDER_LOCK_TYPE,
            gl_ordnum = orderNumber,
            gl_partnum = string.Empty,
            gl_userlot = string.Empty,
            gl_username = username.ToLower(), // [PRESERVE BUG]: Username lowercase
            gl_datel = DateTime.Now,
            gl_int1 = warehouseId
        };

        _context.Set<Webapp_lock>().Add(lockEntity);
        await _context.SaveChangesAsync();
    }

    private async Task RefreshLockAsync(long orderNumber, string username, int warehouseId)
    {
        var lockEntity = await _context.Set<Webapp_lock>()
            .FirstOrDefaultAsync(l =>
                l.gl_id == ORDER_LOCK_TYPE &&
                l.gl_ordnum == orderNumber &&
                l.gl_int1 == warehouseId &&
                l.gl_username != null &&
                l.gl_username.ToLower() == username.ToLower());

        if (lockEntity != null)
        {
            lockEntity.gl_datel = DateTime.Now;
            await _context.SaveChangesAsync();
        }
    }

    private async Task ReleaseLockInternalAsync(long orderNumber, int warehouseId)
    {
        var lockEntity = await _context.Set<Webapp_lock>()
            .FirstOrDefaultAsync(l =>
                l.gl_id == ORDER_LOCK_TYPE &&
                l.gl_ordnum == orderNumber &&
                l.gl_int1 == warehouseId);

        if (lockEntity != null)
        {
            _context.Set<Webapp_lock>().Remove(lockEntity);
            await _context.SaveChangesAsync();
        }
    }
}
