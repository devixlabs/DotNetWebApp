using DotNetWebApp.Models;

namespace DotNetWebApp.Services;

public interface ISpaSectionService
{
    SpaSection DefaultSection { get; }
    IReadOnlyList<SpaSectionInfo> Sections { get; }
    SpaSection? FromUri(string uri);
    SpaSection? FromRouteSegment(string? segment);
    SpaSectionInfo GetInfo(SpaSection section);
    void NavigateTo(SpaSection section, bool replace = true);
}
