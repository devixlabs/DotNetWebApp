using System;
using System.Diagnostics;
using System.IO;
using Xunit;

namespace ModelGenerator.Tests
{
    public class PathResolutionTests
    {
        [Fact]
        public void ModelGenerator_ShouldOutputToCorrectPath_NotNestedStructure()
        {
            // Arrange: Find the repository root (DotNetWebApp/)
            var testDir = Directory.GetCurrentDirectory();
            var repoRoot = FindRepositoryRoot(testDir);
            Assert.NotNull(repoRoot);

            var modelGeneratorExe = Path.Combine(repoRoot, "ModelGenerator", "bin", "Release", "net8.0", "ModelGenerator.dll");
            var testYamlPath = Path.Combine(repoRoot, "app.yaml");
            var expectedOutputDir = Path.Combine(repoRoot, "DotNetWebApp.Models", "Generated");
            var incorrectOutputDir = Path.Combine(repoRoot, "Models", "Generated");

            // Act: Run ModelGenerator
            var processInfo = new ProcessStartInfo
            {
                FileName = "dotnet",
                Arguments = $"\"{modelGeneratorExe}\" \"{testYamlPath}\"",
                WorkingDirectory = Path.Combine(repoRoot, "ModelGenerator"),
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };

            using var process = Process.Start(processInfo);
            Assert.NotNull(process);

            process.WaitForExit();
            var output = process.StandardOutput.ReadToEnd();
            var error = process.StandardError.ReadToEnd();

            // Assert: Files should be in correct location
            Assert.True(Directory.Exists(expectedOutputDir),
                $"Expected output directory does not exist: {expectedOutputDir}");

            Assert.False(Directory.Exists(incorrectOutputDir),
                $"Incorrect nested directory should not exist: {incorrectOutputDir}");

            // Verify at least one generated file exists in the correct location (including subdirectories for schema-specific entities)
            var generatedFiles = Directory.GetFiles(expectedOutputDir, "*.cs", SearchOption.AllDirectories);
            Assert.True(generatedFiles.Length > 0,
                $"No generated files found in {expectedOutputDir} - try running 'make run-ddl-pipeline'");

            // Verify no files in the incorrect nested location
            if (Directory.Exists(incorrectOutputDir))
            {
                var incorrectFiles = Directory.GetFiles(incorrectOutputDir, "*.cs");
                Assert.True(incorrectFiles.Length == 0,
                    $"Generated files should not exist in nested directory: {incorrectOutputDir}");
            }
        }

        [Fact]
        public void PathResolution_CorrectPathShouldNotCreateNestedStructure()
        {
            // Arrange: Simulate ModelGenerator's working directory
            var repoRoot = FindRepositoryRoot(Directory.GetCurrentDirectory());
            Assert.NotNull(repoRoot);

            var modelGeneratorDir = Path.Combine(repoRoot, "ModelGenerator");

            // Act: Resolve the correct path "../DotNetWebApp.Models/Generated" from ModelGenerator/
            var correctRelativePath = "../DotNetWebApp.Models/Generated";
            var resolvedCorrectPath = Path.GetFullPath(Path.Combine(modelGeneratorDir, correctRelativePath));

            // Assert: Should resolve to DotNetWebApp.Models/Generated
            Assert.EndsWith(Path.Combine("DotNetWebApp.Models", "Generated"), resolvedCorrectPath);
            // Verify it resolves to the expected location, not to nested DotNetWebApp/DotNetWebApp/...
            Assert.Contains("DotNetWebApp.Models", resolvedCorrectPath);
        }

        [Fact]
        public void PathResolution_IncorrectPathWouldOutputToWrongLocation()
        {
            // Arrange: Simulate the scenario with wrong path
            var repoRoot = FindRepositoryRoot(Directory.GetCurrentDirectory());
            Assert.NotNull(repoRoot);

            var modelGeneratorDir = Path.Combine(repoRoot, "ModelGenerator");

            // Act: Resolve the old INCORRECT path "../Models/Generated" (before extraction to DotNetWebApp.Models/)
            var incorrectRelativePath = "../Models/Generated";
            var resolvedIncorrectPath = Path.GetFullPath(Path.Combine(modelGeneratorDir, incorrectRelativePath));

            // Assert: The old path would output to the repository root Models/, not DotNetWebApp.Models/
            Assert.EndsWith(Path.Combine("Models", "Generated"), resolvedIncorrectPath);
            Assert.DoesNotContain("DotNetWebApp.Models", resolvedIncorrectPath);
        }

        private static string? FindRepositoryRoot(string startPath)
        {
            var dir = new DirectoryInfo(startPath);
            while (dir != null)
            {
                // Look for .git directory or DotNetWebApp.sln file
                if (Directory.Exists(Path.Combine(dir.FullName, ".git")) ||
                    File.Exists(Path.Combine(dir.FullName, "DotNetWebApp.sln")))
                {
                    return dir.FullName;
                }
                dir = dir.Parent;
            }
            return null;
        }
    }
}
