namespace DotNetWebApp.Models;

public sealed record SpaSectionInfo(
    SpaSection Section,
    string NavLabel,
    string Title,
    string RouteSegment,
    string? EntityName = null,
    string? ViewName = null);
