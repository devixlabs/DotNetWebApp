# shellcheck shell=bash
# shellcheck disable=SC2034,SC1089,SC2288,SC2046,SC1072,SC1073

DOTNET=./dotnet-build.sh
# shellcheck disable=SC2034
IMAGE_NAME=dotnetwebapp
# shellcheck disable=SC2034
TAG=latest
# shellcheck disable=SC2211,SC2276
DOTNET_ENVIRONMENT?=Development
# shellcheck disable=SC2211,SC2276
ASPNETCORE_ENVIRONMENT?=Development
# Performance optimization: Skip global.json search since this project doesn't use it
# shellcheck disable=SC2211,SC2276
export SKIP_GLOBAL_JSON_HANDLING?=true

# Performance optimization: Use Debug builds by default for faster iteration
# Debug builds are 3-10x faster than Release builds for development work
# For production builds or CI/CD, use: BUILD_CONFIGURATION=Release make build
# shellcheck disable=SC2211,SC2276
BUILD_CONFIGURATION?=Debug

.PHONY: clean check restore build build-release https migrate test run-ddl-pipeline docker-build run dev stop-dev db-start db-stop db-logs db-drop ms-logs ms-drop cleanup-nested-dirs shutdown-build-servers

clean:
	$(DOTNET) clean DotNetWebApp.sln
	@$(MAKE) cleanup-nested-dirs
	rm -f msbuild.binlog

# Internal helper: Remove nested project directories created by MSBuild during build/test
# Prevents inotify watch exhaustion on Linux (limit: 65,536)
cleanup-nested-dirs:
	@find . -type d -path "*/bin/*/tests" -o -path "*/bin/*/DotNetWebApp.Models" -o -path "*/bin/*/ModelGenerator" -o -path "*/bin/*/DdlParser" | xargs rm -rf 2>/dev/null || true

# Shutdown all MSBuild/Roslyn/Razor build servers to free memory and prevent process accumulation
# Run this after intensive build sessions or when dotnet processes are consuming too much memory
# Force-kills processes if they don't respond to shutdown command
shutdown-build-servers:
	@echo "Shutting down .NET build servers..."
	@$(DOTNET) build-server shutdown 2>/dev/null || true
	@sleep 1
	@ps -ef | grep -e "MSBuild\.dll" -e "VBCSCompiler\.dll" -e "RazorServer\.dll" | grep -v grep | awk '{print $$2}' | xargs -r kill -9 2>/dev/null || true
	@echo "Build servers stopped."

https:
	$(DOTNET) dev-certs https

check:
	shellcheck setup.sh
	shellcheck dotnet-build.sh
	shellcheck verify.sh
	shellcheck Makefile
	$(DOTNET) format whitespace DotNetWebApp.csproj
	$(DOTNET) format style DotNetWebApp.csproj
	$(MAKE) restore
	$(MAKE) build

restore:
	$(DOTNET) restore DotNetWebApp.sln

# Build with configurable configuration (Debug by default for fast dev iteration)
# Builds entire solution including test projects with reduced parallelism
# Note: Reduced parallelism (-maxcpucount:2) to prevent memory exhaustion
# If error(s) contain "Run a NuGet package restore", try 'make restore'
build:
	$(DOTNET) build DotNetWebApp.sln --configuration "$(BUILD_CONFIGURATION)" --no-restore -maxcpucount:2 --nologo
	@$(MAKE) cleanup-nested-dirs

# Build with Release configuration for production deployments
# This target always uses Release regardless of BUILD_CONFIGURATION variable
build-release:
	$(DOTNET) build DotNetWebApp.sln --configuration Release --no-restore -maxcpucount:2 --nologo
	@$(MAKE) cleanup-nested-dirs

migrate: build
	ASPNETCORE_ENVIRONMENT=$(ASPNETCORE_ENVIRONMENT) DOTNET_ENVIRONMENT=$(DOTNET_ENVIRONMENT) $(DOTNET) ef database update

seed:
	$(DOTNET) run --project DotNetWebApp.csproj -- --seed

# Run tests with same configuration as build target for consistency
# Builds and runs test projects sequentially to avoid memory exhaustion
# Note: Cleans up nested project directories after build to prevent inotify exhaustion on Linux
test:
	$(DOTNET) build tests/DotNetWebApp.Tests/DotNetWebApp.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore --nologo
	$(DOTNET) test tests/DotNetWebApp.Tests/DotNetWebApp.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-build --no-restore --nologo
	$(DOTNET) build tests/ModelGenerator.Tests/ModelGenerator.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore --nologo
	$(DOTNET) test tests/ModelGenerator.Tests/ModelGenerator.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-build --no-restore --nologo
	$(DOTNET) build tests/YamlMerger.Tests/YamlMerger.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore --nologo
	$(DOTNET) test tests/YamlMerger.Tests/YamlMerger.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-build --no-restore --nologo
	$(DOTNET) build tests/AppsYamlGenerator.Tests/AppsYamlGenerator.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore --nologo
	$(DOTNET) test tests/AppsYamlGenerator.Tests/AppsYamlGenerator.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-build --no-restore --nologo
	$(DOTNET) build tests/DdlParser.Tests/DdlParser.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore --nologo
	$(DOTNET) test tests/DdlParser.Tests/DdlParser.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-build --no-restore --nologo
	@$(MAKE) cleanup-nested-dirs

# Run the complete DDL → YAML → Model generation pipeline
# WARNING: This removes all existing migrations
run-ddl-pipeline: clean
	@echo "Starting pipeline run..."
	@echo " -- Step 1: Parsing DDL to data.yaml (intermediate, dataModel only)..."
	cd DdlParser && "../$(DOTNET)" run -- ../schema.sql ../data.yaml
	@echo ""
	@echo " -- Step 2: Merging ViewDefinitions from appsettings.json → data.yaml (intermediate now has dataModel + views)..."
	cd YamlMerger && "../$(DOTNET)" run ../data.yaml ../appsettings.json
	@echo ""
	@echo " -- Step 3: Generating C# models from data.yaml..."
	cd ModelGenerator && "../$(DOTNET)" run ../data.yaml
	@echo ""
	@echo " -- Step 4: Generating view models from data.yaml..."
	cd ModelGenerator && "../$(DOTNET)" run -- --mode=views --views-yaml=../data.yaml --output-dir=../DotNetWebApp.Models/ViewModels
	@echo ""
	@echo " -- Step 5: Merging appsettings.json + data.yaml → app.yaml (final)..."
	cd AppsYamlGenerator && "../$(DOTNET)" run -- ../appsettings.json ../data.yaml ../app.yaml
	@echo ""
	@echo " -- Step 6: Cleaning up intermediate data.yaml..."
	rm -f data.yaml
	@echo ""
	@echo " -- Step 7: Regenerating EF Core migration..."
	rm -f Migrations/*.cs
	$(DOTNET) build DotNetWebApp.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore -maxcpucount:2 --nologo
	$(DOTNET) ef migrations add InitialCreate --output-dir Migrations --context AppDbContext --no-build
	@echo ""
	@echo " -- Step 8: Building project..."
	$(MAKE) build
	@echo ""
	@echo "✅ DDL pipeline completed!"
	@echo ""
	@echo "🚀 Next: Run 'make dev' to start the application"

docker-build:
	docker build -t "$(IMAGE_NAME):$(TAG)" .

# Run the application once without hot reload (uses Debug by default unless BUILD_CONFIGURATION=Release)
run:
	$(DOTNET) run --project DotNetWebApp.csproj --configuration "$(BUILD_CONFIGURATION)"

# Run the application with hot reload (use for active development - auto-reloads on file changes)
# Always uses Debug configuration for fastest rebuild times during watch mode
dev:
	$(DOTNET) watch --project DotNetWebApp.csproj run --launch-profile https --configuration Debug

# Stop any orphaned 'dotnet watch' processes from previous dev sessions
# Kills wrapper scripts, parent "dotnet watch" commands, and child dotnet-watch.dll processes
# Uses kill -9 because dotnet watch ignores SIGTERM for graceful shutdown handling
stop-dev:
	@echo "Looking for orphaned 'dotnet watch' processes..."
	@ps -ef | grep -e "dotnet-build\.sh watch" -e "dotnet watch --project DotNetWebApp.csproj" -e "dotnet-watch.dll --project DotNetWebApp.csproj" -e "bin/Debug/net8.0/DotNetWebApp" | grep -v grep | awk '{print $$2}' | xargs -r kill -9 2>/dev/null && echo "Force-stopped orphaned dev processes." || echo "No orphaned dev processes found or failed to stop them."
	@$(MAKE) shutdown-build-servers

# Start the SQL Server Docker container used for local dev
db-start:
	@docker start sqlserver-dev

# Stop the SQL Server Docker container
db-stop:
	@docker stop sqlserver-dev

# Tail logs for the SQL Server Docker container
db-logs:
	@docker logs -f sqlserver-dev

# Tail native SQL Server logs (systemd + errorlog)
ms-logs:
	@echo "Tailing systemd and errorlog (Ctrl+C to stop)..."
	@sudo sh -c 'journalctl -u mssql-server -f --no-pager & tail -f /var/opt/mssql/log/errorlog; wait'

# Drop the local dev database (uses SA_PASSWORD or container MSSQL_SA_PASSWORD)
db-drop:
	# shellcheck disable=SC2016
	@docker exec -i -e SA_PASSWORD="$$SA_PASSWORD" sqlserver-dev /bin/sh -c '\
		PASSWORD="$$SA_PASSWORD"; \
		if [ -z "$$PASSWORD" ] && [ -n "$$MSSQL_SA_PASSWORD" ]; then \
			PASSWORD="$$MSSQL_SA_PASSWORD"; \
		fi; \
		if [ -z "$$PASSWORD" ]; then \
			echo "SA_PASSWORD is required (export SA_PASSWORD=...)" >&2; \
			exit 1; \
		fi; \
		if [ -x /opt/mssql-tools/bin/sqlcmd ]; then \
			SQLCMD=/opt/mssql-tools/bin/sqlcmd; \
		elif [ -x /opt/mssql-tools18/bin/sqlcmd ]; then \
			SQLCMD=/opt/mssql-tools18/bin/sqlcmd; \
		else \
			echo "sqlcmd not found in container." >&2; \
			exit 1; \
		fi; \
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -C \
			-Q "IF DB_ID('"'"'DotNetWebAppDb'"'"') IS NOT NULL BEGIN ALTER DATABASE [DotNetWebAppDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [DotNetWebAppDb]; END"; \
		echo "Dropped database DotNetWebAppDb (if it existed)."'

# Local install of MSSQL (no Docker)
ms-status:
	systemctl status mssql-server
	ss -ltnp | rg 1433

ms-start:
	sudo systemctl start mssql-server

# Drop the database from native MSSQL instance on Linux
ms-drop:
	# shellcheck disable=SC2016
	@/bin/sh -c '\
		PASSWORD="$$SA_PASSWORD"; \
		if [ -z "$$PASSWORD" ] && [ -n "$$MSSQL_SA_PASSWORD" ]; then \
			PASSWORD="$$MSSQL_SA_PASSWORD"; \
		fi; \
		if [ -z "$$PASSWORD" ]; then \
			echo "SA_PASSWORD is required (export SA_PASSWORD=...)" >&2; \
			exit 1; \
		fi; \
		sqlcmd -S localhost -U sa -P "$$PASSWORD" -C \
			-Q "IF DB_ID('"'"'DotNetWebAppDb'"'"') IS NOT NULL BEGIN ALTER DATABASE [DotNetWebAppDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [DotNetWebAppDb]; END"; \
		echo "Dropped database DotNetWebAppDb (if it existed)."'
