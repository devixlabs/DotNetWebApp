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
            var expectedOutputDir = Path.Combine(repoRoot, "Models", "Generated");
            var incorrectOutputDir = Path.Combine(repoRoot, "DotNetWebApp", "Models", "Generated");

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

            // Verify at least one generated file exists in the correct location
            var generatedFiles = Directory.GetFiles(expectedOutputDir, "*.cs");
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

            // Act: Resolve the correct path "../Models/Generated" from ModelGenerator/
            var correctRelativePath = "../Models/Generated";
            var resolvedCorrectPath = Path.GetFullPath(Path.Combine(modelGeneratorDir, correctRelativePath));

            // Assert: Should resolve to DotNetWebApp/Models/Generated
            Assert.EndsWith(Path.Combine("Models", "Generated"), resolvedCorrectPath);
            Assert.DoesNotContain(Path.Combine("DotNetWebApp", "DotNetWebApp"), resolvedCorrectPath);
        }

        [Fact]
        public void PathResolution_IncorrectPathWouldCreateNestedStructure()
        {
            // Arrange: Simulate the BUG scenario
            var repoRoot = FindRepositoryRoot(Directory.GetCurrentDirectory());
            Assert.NotNull(repoRoot);

            var modelGeneratorDir = Path.Combine(repoRoot, "ModelGenerator");

            // Act: Resolve the INCORRECT path "../DotNetWebApp/Models/Generated"
            var incorrectRelativePath = "../DotNetWebApp/Models/Generated";
            var resolvedIncorrectPath = Path.GetFullPath(Path.Combine(modelGeneratorDir, incorrectRelativePath));

            // Assert: This WOULD create nested DotNetWebApp/DotNetWebApp (demonstrating the bug)
            Assert.Contains(Path.Combine("DotNetWebApp", "Models", "Generated"), resolvedIncorrectPath);

            // Verify this is actually creating a nested structure by checking if "DotNetWebApp" appears twice in path
            var pathParts = resolvedIncorrectPath.Split(Path.DirectorySeparatorChar);
            var dotNetWebAppCount = 0;
            foreach (var part in pathParts)
            {
                if (part == "DotNetWebApp") dotNetWebAppCount++;
            }
            Assert.True(dotNetWebAppCount >= 2,
                "Incorrect path should contain 'DotNetWebApp' at least twice (nested structure)");
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
