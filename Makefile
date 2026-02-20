# shellcheck shell=bash
# shellcheck disable=SC2034,SC1089,SC2288,SC2046,SC1072,SC1073,SC1090,SC1091,SC2171

DOTNET=./dotnet-build.sh
# shellcheck disable=SC2034
IMAGE_NAME=dotnetwebapp
# shellcheck disable=SC2034
TAG=latest

# [FIXME:Use env vars] Database names - configure these to match your sql/schema.sql USE statements
# shellcheck disable=SC2034
PRIMARY_DB=GAI
# shellcheck disable=SC2034
SECONDARY_DB=GAIMisc
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

.PHONY: clean check restore build build-release https db-migrate db-seed ms-migrate ms-seed test run-ddl-pipeline docker-build run dev stop-dev db-start db-stop db-logs db-destroy db-create db-drop db-check ms-status ms-start ms-stop ms-check ms-logs ms-drop cleanup-nested-dirs shutdown-build-servers all _ensure-pipeline _incremental-pipeline ms-init-schema compose-up compose-down

clean:
	$(DOTNET) clean DotNetWebApp.sln
	@$(MAKE) cleanup-nested-dirs
	rm -f msbuild.binlog
	@# Remove all generated files
	rm -rf DotNetWebApp.Models/Generated/*
	rm -rf DotNetWebApp.Models/ViewModels/*.generated.cs
	rm -f Migrations/*.cs
	rm -f app.yaml
	rm -f data.yaml
	rm -f sql/idempotent-migration.sql

# Full rebuild from scratch: clean, drop databases, regenerate models, build, test, migrate, and seed
# This is the definitive target for a complete fresh start
all: clean db-drop run-ddl-pipeline test db-migrate db-seed
	@echo ""
	@echo "╔════════════════════════════════════════════════════╗"
	@echo "║      ✅ FULL PIPELINE RUN SUCCESSFUL               ║"
	@echo "╚════════════════════════════════════════════════════╝"
	@echo ""
	@echo "🚀 Next steps:"
	@echo "   make dev              - Start dev server with hot reload"
	@echo "   ./verify.sh           - Run end-to-end integration tests"
	@echo ""

ms-all: clean ms-drop run-ddl-pipeline test ms-migrate ms-seed
	@echo "MSSQL all completed!"

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
	$(DOTNET) dev-certs https -ep ./dotnetwebapp.crt --format PEM --no-password
	@echo "✅ Certificates exported to ./dotnetwebapp.crt and ./dotnetwebapp.key"
	@echo ""
	@echo "To use with Nginx, move them to /etc/nginx/ssl/:"
	@echo "  sudo mkdir -p /etc/nginx/ssl"
	@echo "  sudo mv dotnetwebapp.crt /etc/nginx/ssl/"
	@echo "  sudo mv dotnetwebapp.key /etc/nginx/ssl/"
	@echo "  sudo nginx -t && sudo systemctl reload nginx"

check:
	shellcheck setup.sh
	shellcheck dotnet-build.sh
	shellcheck verify.sh
	shellcheck Makefile
	shellcheck scripts/seed-full-month.sh
	shellcheck scripts/docker.sh
	shellcheck scripts/mssql.sh
	shellcheck docker/entrypoint.sh
	$(DOTNET) format whitespace DotNetWebApp.csproj
	$(DOTNET) format style DotNetWebApp.csproj
	@# Regenerate if generated files are missing - check for app.yaml as indicator
	@test -f app.yaml || $(MAKE) run-ddl-pipeline
	$(MAKE) restore
	$(MAKE) build

restore:
	$(DOTNET) restore DotNetWebApp.sln

# Internal helper: Ensure generated files exist without full clean
# Checks for app.yaml as indicator - if missing, regenerate everything
_ensure-pipeline:
	@if [ ! -f app.yaml ] || [ ! -d DotNetWebApp.Models/Generated ] || [ ! -d Migrations ] || [ -z "$$(find Migrations -name '*InitialCreate*.cs' 2>/dev/null)" ]; then \
		echo "Generated files missing, running incremental regeneration..."; \
		$(MAKE) _incremental-pipeline; \
	fi

# Internal helper: Incremental pipeline without full clean
# Only deletes generated models, not build artifacts
# Steps 1-7 from run-ddl-pipeline but without clean dependency or final build call
_incremental-pipeline:
	@echo "Starting incremental DDL pipeline..."
	@echo " -- Step 1: Parsing DDL to data.yaml (intermediate, dataModel only)..."
	cd DdlParser && "../$(DOTNET)" run -- ../sql/schema.sql ../data.yaml
	@echo ""
	@echo " -- Step 2: Merging ViewDefinitions from appsettings.json into data.yaml (modifies in place; intermediate now contains dataModel + views)..."
	cd YamlMerger && "../$(DOTNET)" run ../data.yaml ../appsettings.json
	@echo ""
	@echo " -- Step 3: Cleaning old Generated models and generating C# models from data.yaml..."
	rm -rf DotNetWebApp.Models/Generated/*
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
	@echo "✅ Incremental pipeline completed!"

# Build with configurable configuration (Debug by default for fast dev iteration)
# Builds entire solution including test projects with reduced parallelism
# Note: Reduced parallelism (-maxcpucount:2) to prevent memory exhaustion
# If error(s) contain "Run a NuGet package restore", try 'make restore'
build: _ensure-pipeline
	$(DOTNET) build DotNetWebApp.sln --configuration "$(BUILD_CONFIGURATION)" -maxcpucount:2 --nologo
	@$(MAKE) cleanup-nested-dirs

# Build with Release configuration for production deployments
# This target always uses Release regardless of BUILD_CONFIGURATION variable
build-release: _ensure-pipeline
	$(DOTNET) build DotNetWebApp.sln --configuration Release
	@$(MAKE) cleanup-nested-dirs

# Idempotent migration via Docker - safe to run multiple times against existing databases
# For databases with existing tables, marks migration as applied without re-creating tables
# Uses container's sqlcmd (same pattern as db-drop)
# Automatically initializes database schema from sql/schema.sql before applying EF migrations
db-migrate: build
	@echo "Generating idempotent migration script..."
	$(DOTNET) ef migrations script --idempotent --output sql/idempotent-migration.sql --context AppDbContext
	@# Remove UTF-8 BOM if present - sqlcmd does not handle it
	@sed -i '1s/^\xEF\xBB\xBF//' sql/idempotent-migration.sql 2>/dev/null || true
	@bash scripts/docker.sh init-schema
	@bash scripts/docker.sh migrate

# Seed database via Docker sqlcmd - runs sql/seed.sql against Docker SQL Server
# Note: seed.sql contains USE [$(PRIMARY_DB)] and USE [$(SECONDARY_DB)] statements, so we connect to master
db-seed:
	@bash scripts/docker.sh seed

# Run tests with same configuration as build target for consistency
# Builds and runs test projects sequentially to avoid memory exhaustion
# Note: Cleans up nested project directories after build to prevent inotify exhaustion on Linux
test: build
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
	cd DdlParser && "../$(DOTNET)" run -- ../sql/schema.sql ../data.yaml
	@echo ""
	@echo " -- Step 2: Merging ViewDefinitions from appsettings.json into data.yaml (modifies in place; intermediate now contains dataModel + views)..."
	cd YamlMerger && "../$(DOTNET)" run ../data.yaml ../appsettings.json
	@echo ""
	@echo " -- Step 3: Cleaning old Generated models and generating C# models from data.yaml..."
	rm -rf DotNetWebApp.Models/Generated/*
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
	@echo "✅ DDL pipeline completed!"
	@echo ""
	@echo "🚀 Next: Run 'make migrate', then 'make seed', then 'make dev'"

docker-build:
	docker build -t "$(IMAGE_NAME):$(TAG)" .

# Start the full Docker Compose stack with database initialization
# Starts SQL Server first, waits for health check, initializes schema + migrations, seeds data, then starts app
# Requires SA_PASSWORD environment variable (load via: source .envrc or export SA_PASSWORD=...)
compose-up:
	@[ -n "$$SA_PASSWORD" ] || { echo "Error: SA_PASSWORD environment variable required" >&2; echo "  export SA_PASSWORD='YourStrongPassword123!'" >&2; exit 1; }
	@echo "Removing any pre-existing standalone sqlserver-dev container..."
	@docker rm -f sqlserver-dev 2>/dev/null || true
	@echo "Starting SQL Server and waiting for health check..."
	@docker compose up -d --wait sqlserver
	@echo "Initializing databases..."
	$(MAKE) db-migrate
	@echo "Seeding data..."
	$(MAKE) db-seed
	@echo "Starting application container..."
	@docker compose up -d dotnetwebapp
	@echo ""
	@echo "╔════════════════════════════════════════════════════╗"
	@echo "║      ✅ Docker stack is up                         ║"
	@echo "╚════════════════════════════════════════════════════╝"
	@echo ""
	@echo "  App:  http://localhost:5210"
	@echo "  Logs: docker compose logs -f dotnetwebapp"
	@echo ""

# Stop and remove all Docker Compose containers (preserves volumes/data)
compose-down:
	@docker compose down

# Run in Release (production-like) mode
run: build-release
	$(DOTNET) run --project DotNetWebApp.csproj --configuration Release

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

# Completely destroy the SQL Server Docker container (for clean slate)
db-destroy:
	@echo "Stopping and removing sqlserver-dev container..."
	@docker stop sqlserver-dev 2>/dev/null || true
	@docker rm sqlserver-dev 2>/dev/null || true
	@rm -f Migrations/*.cs && echo "Cleared old EF Core migrations."
	@echo "Container destroyed. Run 'make db-create' to recreate."

# Create a fresh SQL Server Docker container (requires SA_PASSWORD env var)
db-create:
	@[ -n "$$SA_PASSWORD" ] || { echo "Error: SA_PASSWORD environment variable required" >&2; echo "  export SA_PASSWORD='YourStrongPassword123!'" >&2; exit 1; }
	@echo "Creating sqlserver-dev container..."
	@docker run -e "ACCEPT_EULA=Y" \
		-e "MSSQL_SA_PASSWORD=$$SA_PASSWORD" \
		-p 1433:1433 \
		--name sqlserver-dev \
		--hostname sqlserver \
		-d mcr.microsoft.com/mssql/server:2022-latest
	@echo "Waiting for SQL Server to start (30s)..."
	@sleep 30
	@echo "Container created. Run 'make migrate' to initialize database."

# Tail native SQL Server logs (systemd + errorlog)
ms-logs:
	@echo "Tailing systemd and errorlog (Ctrl+C to stop)..."
	@sudo sh -c 'journalctl -u mssql-server -f --no-pager & tail -f /var/opt/mssql/log/errorlog; wait'

# Drop the local dev databases (uses SA_PASSWORD or container MSSQL_SA_PASSWORD)
# Drops $(PRIMARY_DB), $(SECONDARY_DB), and DotNetWebAppDb databases
# Also removes EF Core migrations to ensure clean slate when schema.sql changes
db-drop:
	@rm -f Migrations/*.cs && echo "Cleared old EF Core migrations."
	@bash scripts/docker.sh drop

# Check and create required databases if they don't exist
# Useful for verifying database health and recreating them without full reset
# Can be extended in the future with more checks (backups, index verification, etc.)
db-check:
	@bash scripts/docker.sh check

# Local install of MSSQL (no Docker)
ms-status:
	systemctl status mssql-server
	ss -ltnp | rg 1433

ms-start:
	sudo systemctl start mssql-server

ms-stop:
	sudo systemctl stop mssql-server

# Check and create required databases if they don't exist (native MSSQL)
# Useful for verifying database health and recreating them without full reset
ms-check:
	@bash scripts/mssql.sh check

# Internal helper: Initialize database schema from sql/schema.sql via native sqlcmd
# Creates required databases ($(PRIMARY_DB), $(SECONDARY_DB)) and all tables defined in sql/schema.sql
# Called automatically by ms-migrate - do not call directly
ms-init-schema:
	@bash scripts/mssql.sh check > /dev/null
	@echo "Initializing database schema from sql/schema.sql..."
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
		echo "Applying schema from sql/schema.sql..."; \
		sqlcmd -S localhost -U sa -P "$$PASSWORD" -C -i sql/schema.sql'
	@echo "✅ Database schema initialized successfully"

# Idempotent migration via native sqlcmd - safe to run multiple times against existing databases
# For production MSSQL Server environments
ms-migrate: build ms-init-schema
	@echo "Generating idempotent migration script..."
	$(DOTNET) ef migrations script --idempotent --output sql/idempotent-migration.sql --context AppDbContext
	@# Remove UTF-8 BOM if present - sqlcmd does not handle it
	@sed -i '1s/^\xEF\xBB\xBF//' sql/idempotent-migration.sql 2>/dev/null || true
	@bash scripts/mssql.sh migrate

# Seed database via native sqlcmd - runs sql/seed.sql against native MSSQL Server
# Note: seed.sql contains USE [$(PRIMARY_DB)] and USE [$(SECONDARY_DB)] statements, so we connect to master
ms-seed:
	@bash scripts/mssql.sh seed

# Drop the databases from native MSSQL instance on Linux
# Drops $(PRIMARY_DB), $(SECONDARY_DB), and DotNetWebAppDb databases
# Also removes EF Core migrations to ensure clean slate when schema.sql changes
ms-drop:
	@rm -f Migrations/*.cs && echo "Cleared old EF Core migrations."
	@bash scripts/mssql.sh drop
