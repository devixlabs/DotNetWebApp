# shellcheck shell=bash
# shellcheck disable=SC2034,SC1089,SC2288
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

.PHONY: clean check restore build build-all build-release https migrate test run-ddl-pipeline docker-build run dev db-start db-stop db-logs db-drop ms-logs ms-drop

clean:
	rm -f msbuild.binlog
	$(DOTNET) clean DotNetWebApp.csproj
	$(DOTNET) clean ModelGenerator/ModelGenerator.csproj
	$(DOTNET) clean DdlParser/DdlParser.csproj
	$(DOTNET) clean tests/DotNetWebApp.Tests/DotNetWebApp.Tests.csproj
	$(DOTNET) clean tests/ModelGenerator.Tests/ModelGenerator.Tests.csproj

https:
	$(DOTNET) dev-certs https

check:
	shellcheck setup.sh & shellcheck dotnet-build.sh & shellcheck Makefile & wait
	$(MAKE) restore
	$(MAKE) build

restore:
	$(DOTNET) restore DotNetWebApp.csproj
	$(DOTNET) restore ModelGenerator/ModelGenerator.csproj
	$(DOTNET) restore DdlParser/DdlParser.csproj
	$(DOTNET) restore tests/DotNetWebApp.Tests/DotNetWebApp.Tests.csproj
	$(DOTNET) restore tests/ModelGenerator.Tests/ModelGenerator.Tests.csproj

# Build with configurable configuration (Debug by default for fast dev iteration)
# Builds main projects only (excludes test projects to avoid OOM on memory-limited systems)
# Note: Reduced parallelism (-maxcpucount:2) to prevent memory exhaustion
# If error(s) contain "Run a NuGet package restore", try 'make restore' 
build:
	$(DOTNET) build DotNetWebApp.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore -maxcpucount:2 --nologo
	$(DOTNET) build ModelGenerator/ModelGenerator.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore -maxcpucount:2 --nologo
	$(DOTNET) build DdlParser/DdlParser.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore -maxcpucount:2 --nologo

# Build everything including test projects (higher memory usage)
build-all:
	$(DOTNET) build DotNetWebApp.sln --configuration "$(BUILD_CONFIGURATION)" --no-restore -maxcpucount:2 --nologo

# Build with Release configuration for production deployments
# This target always uses Release regardless of BUILD_CONFIGURATION variable
build-release:
	$(DOTNET) build DotNetWebApp.csproj --configuration Release --no-restore -maxcpucount:2 --nologo
	$(DOTNET) build ModelGenerator/ModelGenerator.csproj --configuration Release --no-restore -maxcpucount:2 --nologo
	$(DOTNET) build DdlParser/DdlParser.csproj --configuration Release --no-restore -maxcpucount:2 --nologo

migrate: build
	ASPNETCORE_ENVIRONMENT=$(ASPNETCORE_ENVIRONMENT) DOTNET_ENVIRONMENT=$(DOTNET_ENVIRONMENT) $(DOTNET) ef database update

seed: migrate
	$(DOTNET) run --project DotNetWebApp.csproj -- --seed

# Run tests with same configuration as build target for consistency
# Builds and runs test projects sequentially to avoid memory exhaustion
test:
	$(DOTNET) build tests/DotNetWebApp.Tests/DotNetWebApp.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore --nologo
	$(DOTNET) test tests/DotNetWebApp.Tests/DotNetWebApp.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-build --no-restore --nologo
	$(DOTNET) build tests/ModelGenerator.Tests/ModelGenerator.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore --nologo
	$(DOTNET) test tests/ModelGenerator.Tests/ModelGenerator.Tests.csproj --configuration "$(BUILD_CONFIGURATION)" --no-build --no-restore --nologo

# Run the complete DDL → YAML → Model generation pipeline
run-ddl-pipeline: clean
	@echo "Starting pipeline run..."
	@echo " -- Parsing DDL to YAML..."
	cd DdlParser && "../$(DOTNET)" run -- ../schema.sql ../app.yaml
	@echo ""
	@echo " -- Generating models from YAML..."
	cd ModelGenerator && "../$(DOTNET)" run ../app.yaml
	@echo ""
	@echo " -- Regenerating EF Core migration..."
	rm -f Migrations/*.cs
	$(DOTNET) build DotNetWebApp.csproj --configuration "$(BUILD_CONFIGURATION)" --no-restore -maxcpucount:2 --nologo
	$(DOTNET) ef migrations add InitialCreate --output-dir Migrations --context AppDbContext --no-build
	@echo ""
	@echo " -- Building project..."
	$(MAKE) build
	@echo ""
	@echo " -- DDL pipeline test completed!"
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
