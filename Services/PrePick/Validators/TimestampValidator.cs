using DotNetWebApp.Services.PrePick.Models;

namespace DotNetWebApp.Services.PrePick.Validators;

/// <summary>
/// Validates clock-in and clock-out timestamps.
/// Business Rule: Clock-out cannot equal clock-in (fraud prevention).
/// Message: "Paul says that there is no way you are that fast!"
/// </summary>
public class TimestampValidator
{
    private readonly ILogger<TimestampValidator> _logger;

    public TimestampValidator(ILogger<TimestampValidator> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// Validate clock-in and clock-out times.
    /// </summary>
    public ValidationResult ValidateClockTimes(DateTime clockIn, DateTime clockOut)
    {
        // PRESERVED: Exact message from spec
        if (clockIn == clockOut)
        {
            _logger.LogWarning("Invalid: clock in and clock out are identical at {Time}", clockIn);
            return ValidationResult.Invalid("Paul says that there is no way you are that fast!");
        }

        if (clockOut < clockIn)
        {
            _logger.LogWarning(
                "Invalid: clock out {ClockOut} is before clock in {ClockIn}",
                clockOut, clockIn);
            return ValidationResult.Invalid("Clock out cannot be before clock in");
        }

        return ValidationResult.Valid();
    }

    /// <summary>
    /// Validate clock-in time against current time.
    /// </summary>
    public ValidationResult ValidateClockIn(DateTime clockIn)
    {
        // Clock-in can't be more than 1 hour in the future
        if (clockIn > DateTime.Now.AddHours(1))
        {
            _logger.LogWarning("Invalid: clock in {ClockIn} is too far in the future", clockIn);
            return ValidationResult.Invalid("Clock in time cannot be more than 1 hour in the future");
        }

        // Clock-in can't be more than 24 hours in the past
        if (clockIn < DateTime.Now.AddHours(-24))
        {
            _logger.LogWarning("Invalid: clock in {ClockIn} is too far in the past", clockIn);
            return ValidationResult.Invalid("Clock in time cannot be more than 24 hours in the past");
        }

        return ValidationResult.Valid();
    }
}
