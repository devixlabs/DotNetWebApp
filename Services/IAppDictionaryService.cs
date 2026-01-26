using DotNetWebApp.Models.AppDictionary;

namespace DotNetWebApp.Services
{
    public interface IAppDictionaryService
    {
        AppDefinition AppDefinition { get; }
    }
}
