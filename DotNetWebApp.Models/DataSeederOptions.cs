namespace DotNetWebApp.Models;

public sealed class DataSeederOptions
{
    public const string SectionName = "DataSeeder";

    public string SeedFileName { get; set; } = "sql/seed.sql";
}
