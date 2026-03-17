using DotNetWebApp.Services.WAMS.Models;

namespace DotNetWebApp.Services.WAMS.Validators;

/// <summary>
/// Validates status transitions in the WAMS workflow
/// State machine: NA -> CheckIn -> Loading -> Unloading -> Shipped -> Received
/// Special case: CheckIn can revert to NA (only backward transition allowed)
/// </summary>
public class StatusTransitionValidator
{
    /// <summary>
    /// Validates a status transition from current to new status
    /// </summary>
    /// <param name="currentStatus">Current dock status</param>
    /// <param name="newStatus">Desired new dock status</param>
    /// <returns>Tuple of (IsValid, ErrorMessage). ErrorMessage is empty if valid.</returns>
    public (bool IsValid, string ErrorMessage) ValidateTransition(
        DockStatus currentStatus,
        DockStatus newStatus)
    {
        // Prevent no-op transitions
        if (currentStatus == newStatus)
            return (false, "Status is already set to this value");

        // Special case: CheckIn -> NA is the only allowed backward transition
        // This allows clearing the check-in time
        if (currentStatus == DockStatus.CheckIn && newStatus == DockStatus.NA)
            return (true, "");

        // All other transitions must be forward in the workflow
        if ((int)newStatus <= (int)currentStatus)
            return (false, "Can only move forward in status workflow (except CheckIn -> N/A)");

        // Check if the transition is valid according to the state machine
        var validNextStatuses = GetValidNextStatuses(currentStatus);
        if (!validNextStatuses.Contains(newStatus))
        {
            var validOptions = string.Join(", ", validNextStatuses.Select(s => s.ToString()));
            return (false, $"Invalid transition from {currentStatus} to {newStatus}. Valid next statuses: {validOptions}");
        }

        return (true, "");
    }

    /// <summary>
    /// Gets the list of valid next statuses for a given current status
    /// </summary>
    /// <param name="current">Current dock status</param>
    /// <returns>List of valid next statuses</returns>
    private List<DockStatus> GetValidNextStatuses(DockStatus current)
    {
        return current switch
        {
            // From NA, can only go to CheckIn
            DockStatus.NA => new List<DockStatus> { DockStatus.CheckIn },

            // From CheckIn, can go to Loading or revert to NA
            DockStatus.CheckIn => new List<DockStatus> { DockStatus.Loading, DockStatus.NA },

            // From Loading, can go to Unloading or skip to Shipped (for outbound)
            DockStatus.Loading => new List<DockStatus> { DockStatus.Unloading, DockStatus.Shipped },

            // From Unloading, can go to Shipped (outbound) or Received (inbound)
            DockStatus.Unloading => new List<DockStatus> { DockStatus.Shipped, DockStatus.Received },

            // From Shipped, can only go to Received (final confirmation)
            DockStatus.Shipped => new List<DockStatus> { DockStatus.Received },

            // Received is terminal state
            DockStatus.Received => new List<DockStatus> { },

            // Unknown status - no valid transitions
            _ => new List<DockStatus> { }
        };
    }

    /// <summary>
    /// Checks if a status is a terminal state (no further transitions possible)
    /// </summary>
    /// <param name="status">Dock status to check</param>
    /// <returns>True if terminal, false otherwise</returns>
    public bool IsTerminalStatus(DockStatus status)
    {
        return status == DockStatus.Received;
    }

    /// <summary>
    /// Gets all valid statuses that can be reached from the current status
    /// Includes direct transitions and any further reachable statuses
    /// </summary>
    /// <param name="current">Current dock status</param>
    /// <returns>List of all reachable statuses</returns>
    public List<DockStatus> GetReachableStatuses(DockStatus current)
    {
        var reachable = new HashSet<DockStatus>();
        var toExplore = new Queue<DockStatus>();
        toExplore.Enqueue(current);

        while (toExplore.Count > 0)
        {
            var status = toExplore.Dequeue();
            var nextStatuses = GetValidNextStatuses(status);

            foreach (var next in nextStatuses)
            {
                if (reachable.Add(next)) // Returns true if newly added
                {
                    toExplore.Enqueue(next);
                }
            }
        }

        return reachable.OrderBy(s => (int)s).ToList();
    }
}
