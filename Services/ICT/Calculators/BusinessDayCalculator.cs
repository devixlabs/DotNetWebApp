namespace DotNetWebApp.Services.ICT.Calculators;

/// <summary>
/// Calculates business days for job ship date determination.
/// Business days skip weekends (Saturday and Sunday).
/// </summary>
public static class BusinessDayCalculator
{
    /// <summary>
    /// Calculate job ship date by adding business days to finish date.
    /// Skips weekends (Saturday, Sunday).
    ///
    /// Example: If finish date is Friday, 8 business days forward is:
    ///   Monday (1), Tuesday (2), Wednesday (3), Thursday (4), Friday (5),
    ///   Monday (6), Tuesday (7), Wednesday (8) = 12 calendar days
    /// </summary>
    /// <param name="startDate">Job finish date</param>
    /// <param name="businessDaysToAdd">Number of business days (typically 8 for ICT)</param>
    /// <returns>Calculated ship date</returns>
    public static DateTime AddBusinessDays(DateTime startDate, int businessDaysToAdd)
    {
        if (businessDaysToAdd < 0)
            throw new ArgumentException("Business days to add must be non-negative", nameof(businessDaysToAdd));

        if (businessDaysToAdd == 0)
            return startDate;

        DateTime currentDate = startDate;
        int addedDays = 0;

        while (addedDays < businessDaysToAdd)
        {
            currentDate = currentDate.AddDays(1);

            // Skip weekends
            if (currentDate.DayOfWeek != DayOfWeek.Saturday &&
                currentDate.DayOfWeek != DayOfWeek.Sunday)
            {
                addedDays++;
            }
        }

        return currentDate;
    }

    /// <summary>
    /// Calculate the number of business days between two dates.
    /// </summary>
    /// <param name="startDate">Start date</param>
    /// <param name="endDate">End date</param>
    /// <returns>Number of business days between dates</returns>
    public static int CountBusinessDays(DateTime startDate, DateTime endDate)
    {
        if (endDate < startDate)
            throw new ArgumentException("End date must be after start date");

        int businessDays = 0;
        DateTime currentDate = startDate;

        while (currentDate < endDate)
        {
            currentDate = currentDate.AddDays(1);

            if (currentDate.DayOfWeek != DayOfWeek.Saturday &&
                currentDate.DayOfWeek != DayOfWeek.Sunday)
            {
                businessDays++;
            }
        }

        return businessDays;
    }

    /// <summary>
    /// Check if a date is a business day (Monday-Friday).
    /// </summary>
    /// <param name="date">Date to check</param>
    /// <returns>True if business day, false if weekend</returns>
    public static bool IsBusinessDay(DateTime date)
    {
        return date.DayOfWeek != DayOfWeek.Saturday &&
               date.DayOfWeek != DayOfWeek.Sunday;
    }
}
