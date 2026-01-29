using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface ISpaSectionService
{
    SpaSectionInfo? DefaultSection { get; }
    IReadOnlyList<SpaSectionInfo> Sections { get; }
    SpaSectionInfo? FromUri(string uri);
    SpaSectionInfo? FromRouteSegment(string? segment);
    SpaSectionInfo? GetInfo(SpaSection section);
    void NavigateTo(SpaSectionInfo section, bool replace = true);
    IReadOnlyList<SpaSectionInfo> GetSectionsForApplication(string appName);
}
