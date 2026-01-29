using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services
{
    public interface IAppDictionaryService
    {
        AppDefinition AppDefinition { get; }
        IReadOnlyList<ApplicationInfo> GetAllApplications();
        ApplicationInfo? GetApplication(string appName);
    }
}
