namespace DotNetWebApp.Models;

public class AppCustomizationOptions
{
    public string AppTitle { get; set; } = "DotNetWebApp";
    public string SourceLinkText { get; set; } = "Source Code";
    public string SourceLinkUrl { get; set; } = "https://github.com/devixlabs/DotNetWebApp/";
    public BrandCustomization Branding { get; set; } = new();
    public NavigationLabels Navigation { get; set; } = new();
    public bool EnableSpaExample { get; set; } = true;
    public SpaSectionLabels SpaSections { get; set; } = new();
}

public class BrandCustomization
{
    public string LogoText { get; set; } = "DN";
    public string? LogoUrl { get; set; }
    public string LogoAlt { get; set; } = "Brand logo";
    public string FontFamily { get; set; } = "\"Space Grotesk\", \"Segoe UI\", sans-serif";
    public string PrimaryColor { get; set; } = "#0f766e";
    public string AccentColor { get; set; } = "#14b8a6";
    public string HeaderBackground { get; set; } = "linear-gradient(120deg, rgba(15,118,110,0.08), rgba(20,184,166,0.2))";
    public string HeaderTextColor { get; set; } = "#0f172a";
    public string LogoBackgroundColor { get; set; } = "rgba(20,184,166,0.2)";
    public string LogoTextColor { get; set; } = "#0f172a";
}

public class NavigationLabels
{
    public string Home { get; set; } = "Home";
    public string Application { get; set; } = "Application";
}

public class SpaSectionLabels
{
    public string DashboardNav { get; set; } = "Dashboard";
    public string SettingsNav { get; set; } = "Settings";
    public string DashboardTitle { get; set; } = "Dashboard";
    public string SettingsTitle { get; set; } = "Application Settings";
}
