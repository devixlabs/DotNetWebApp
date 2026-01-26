namespace DotNetWebApp.Models;

public sealed class DataSeederOptions
{
    public const string SectionName = "DataSeeder";

    public string SeedFileName { get; set; } = "seed.sql";
}
