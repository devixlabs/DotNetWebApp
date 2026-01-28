namespace DotNetWebApp.Constants;

/// <summary>
/// Standardized error IDs for the view pipeline and data access layer.
/// These IDs provide consistent error identification for logging, monitoring, and user support.
/// </summary>
public static class ErrorIds
{
    // View Registry Errors
    public const string ViewNotFound = "VIEW_NOT_FOUND";
    public const string ViewsYamlMissing = "VIEWS_YAML_MISSING";
    public const string ViewsYamlEmpty = "VIEWS_YAML_EMPTY";
    public const string ViewsYamlParseError = "VIEWS_YAML_PARSE_ERROR";
    public const string ViewNameInvalid = "VIEW_NAME_INVALID";
    public const string ViewSqlFileInvalid = "VIEW_SQL_FILE_INVALID";

    // SQL File Errors
    public const string SqlFileNotFound = "SQL_FILE_NOT_FOUND";
    public const string SqlFilePermissionDenied = "SQL_FILE_PERMISSION_DENIED";
    public const string SqlFilePathInvalid = "SQL_FILE_PATH_INVALID";
    public const string SqlFileDiskError = "SQL_FILE_DISK_ERROR";
    public const string SqlFileReadError = "SQL_FILE_READ_ERROR";
    public const string SqlFileTooLarge = "SQL_FILE_TOO_LARGE";

    // Query Execution Errors
    public const string QueryExecutionFailed = "QUERY_EXECUTION_FAILED";
    public const string QueryTimeout = "QUERY_TIMEOUT";
    public const string QueryInvalidParameter = "QUERY_INVALID_PARAMETER";
    public const string QueryOutOfMemory = "QUERY_OUT_OF_MEMORY";

    // SQL Server Errors
    public const string SqlError = "SQL_ERROR";
    public const string SqlConnectionTimeout = "SQL_CONNECTION_TIMEOUT";
    public const string SqlNetworkError = "SQL_NETWORK_ERROR";
    public const string SqlPermissionDenied = "SQL_PERMISSION_DENIED";
    public const string SqlInvalidColumn = "SQL_INVALID_COLUMN";
    public const string SqlInvalidTable = "SQL_INVALID_TABLE";
    public const string SqlDeadlock = "SQL_DEADLOCK";
    public const string SqlLoginFailed = "SQL_LOGIN_FAILED";

    // View Service Errors
    public const string ViewExecutionFailed = "VIEW_EXECUTION_FAILED";

    /// <summary>
    /// Gets a user-friendly message for a SQL Server error code.
    /// </summary>
    public static string GetFriendlySqlErrorMessage(int errorCode, string originalMessage)
    {
        return errorCode switch
        {
            -2 => "Connection timeout - database is not responding",
            -1 => "Network error communicating with database",
            64 => "Database communication error - connection was reset",
            121 => "Database communication error - semaphore timeout",
            207 => "Invalid column name in query",
            208 => "Invalid table name in query",
            229 => "Permission denied - your user account cannot execute this query",
            1205 => "Database deadlock detected - please retry the operation",
            4060 => "Cannot access database - database does not exist or access denied",
            15007 => "Insufficient permissions to execute this query",
            18456 => "Login failed - check your database credentials",
            _ => $"Database error: {originalMessage}"
        };
    }
}
