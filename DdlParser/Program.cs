using DdlParser;
using System;
using System.IO;

if (args.Length < 2)
{
    Console.WriteLine("Usage: DdlParser <input.sql> <output.yaml>");
    Console.WriteLine("Example: DdlParser schema.sql data.yaml");
    Environment.Exit(1);
}

var inputFile = args[0];
var outputFile = args[1];

try
{
    // Validate input file exists
    if (!File.Exists(inputFile))
    {
        Console.Error.WriteLine($"Error: Input file not found: {inputFile}");
        Environment.Exit(1);
    }

    // Read SQL content
    Console.WriteLine($"Reading SQL file: {inputFile}");
    var sqlContent = File.ReadAllText(inputFile);

    // Parse SQL DDL
    Console.WriteLine("Parsing SQL DDL...");
    var parser = new SqlDdlParser();
    var tables = parser.Parse(sqlContent);

    if (tables.Count == 0)
    {
        Console.WriteLine("Warning: No tables found in SQL file");
    }
    else
    {
        Console.WriteLine($"Found {tables.Count} table(s):");
        foreach (var table in tables)
        {
            Console.WriteLine($"  - {table.Name} ({table.Columns.Count} columns)");
        }
    }

    // Generate YAML
    Console.WriteLine("Generating YAML...");
    var generator = new YamlGenerator();
    var yaml = generator.Generate(tables);

    // Write output file
    var outputDir = Path.GetDirectoryName(outputFile);
    if (!string.IsNullOrEmpty(outputDir) && !Directory.Exists(outputDir))
    {
        Directory.CreateDirectory(outputDir);
    }

    File.WriteAllText(outputFile, yaml);
    Console.WriteLine($"Successfully wrote YAML to: {outputFile}");
}
catch (Exception ex)
{
    Console.Error.WriteLine($"Error: {ex.Message}");
    if (!string.IsNullOrEmpty(ex.InnerException?.Message))
    {
        Console.Error.WriteLine($"Details: {ex.InnerException.Message}");
    }
    Environment.Exit(1);
}
