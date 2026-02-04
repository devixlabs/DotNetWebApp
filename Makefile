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

.PHONY: clean check restore build build-release https migrate seed db-migrate db-seed ms-migrate ms-seed test run-ddl-pipeline docker-build run dev stop-dev db-start db-stop db-logs db-destroy db-create db-drop db-check ms-status ms-start ms-stop ms-logs ms-drop cleanup-nested-dirs shutdown-build-servers full-rebuild _db-init-schema

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

# Full rebuild from scratch: clean, regenerate all code, check, build, and test
full-rebuild:
	@echo "=== FULL REBUILD FROM SCRATCH ==="
	$(MAKE) clean
	$(MAKE) run-ddl-pipeline
	$(MAKE) check
	$(MAKE) test
	@echo "=== FULL REBUILD SUCCESSFUL ==="

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
	$(DOTNET) format whitespace DotNetWebApp.csproj
	$(DOTNET) format style DotNetWebApp.csproj
	@# Regenerate if generated files are missing - check for app.yaml as indicator
	@test -f app.yaml || $(MAKE) run-ddl-pipeline
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

# Backwards-compatible alias: migrate → db-migrate (Docker dev environment)
migrate: db-migrate

# Idempotent migration via Docker - safe to run multiple times against existing databases
# For databases with existing tables, marks migration as applied without re-creating tables
# Uses container's sqlcmd (same pattern as db-drop)
# Automatically initializes database schema from sql/schema.sql before applying EF migrations
db-migrate: build _db-init-schema
	@echo "Generating idempotent migration script..."
	$(DOTNET) ef migrations script --idempotent --output sql/idempotent-migration.sql --context AppDbContext
	@# Remove UTF-8 BOM if present - sqlcmd does not handle it
	@sed -i '1s/^\xEF\xBB\xBF//' sql/idempotent-migration.sql 2>/dev/null || true
	@echo "Applying idempotent migration to database..."
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
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -d master -C -Q "IF DB_ID('"'"'DotNetWebAppDb'"'"') IS NULL CREATE DATABASE [DotNetWebAppDb]" && \
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -d DotNetWebAppDb -C -i /dev/stdin' < sql/idempotent-migration.sql
	@echo "✅ Migration applied successfully"

# Backwards-compatible alias: seed → db-seed (Docker dev environment)
seed: db-seed

# Seed database via Docker sqlcmd - runs sql/seed.sql against Docker SQL Server
# Note: seed.sql contains USE [$(PRIMARY_DB)] and USE [$(SECONDARY_DB)] statements, so we connect to master
db-seed:
	@echo "Seeding database via Docker sqlcmd..."
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
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -d master -C -i /dev/stdin' < sql/seed.sql
	@echo "✅ Database seeded successfully"

# Internal helper: Initialize database schema from sql/schema.sql via Docker sqlcmd
# Creates required databases ($(PRIMARY_DB), $(SECONDARY_DB)) and all tables defined in sql/schema.sql
# Called automatically by db-migrate - do not call directly
_db-init-schema:
	@echo "Initializing database schema from sql/schema.sql..."
	@make db-check  # Ensure databases exist first
	# Now apply schema to the databases
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
		echo "Applying schema from sql/schema.sql..."; \
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -C -i /dev/stdin' < sql/schema.sql
	@echo "✅ Database schema initialized successfully"

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
	@echo " -- Step 8: Building project..."
	$(MAKE) build
	@echo ""
	@echo "✅ DDL pipeline completed!"
	@echo ""
	@echo "🚀 Next: Run 'make migrate', then 'make seed', then 'make dev'"

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
	# Clear old migrations to avoid conflicts when schema.sql changes
	@rm -f Migrations/*.cs && echo "Cleared old EF Core migrations."
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
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -C -Q "\
			IF DB_ID('"'"'$(PRIMARY_DB)'"'"') IS NOT NULL BEGIN ALTER DATABASE [$(PRIMARY_DB)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [$(PRIMARY_DB)]; END; \
			IF DB_ID('"'"'$(SECONDARY_DB)'"'"') IS NOT NULL BEGIN ALTER DATABASE [$(SECONDARY_DB)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [$(SECONDARY_DB)]; END; \
			IF DB_ID('"'"'DotNetWebAppDb'"'"') IS NOT NULL BEGIN ALTER DATABASE [DotNetWebAppDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [DotNetWebAppDb]; END;" && \
		echo "Dropped databases $(PRIMARY_DB), $(SECONDARY_DB), DotNetWebAppDb (if they existed)." || echo "Failed to drop databases."'

# Check and create required databases if they don't exist
# Useful for verifying database health and recreating them without full reset
# Can be extended in the future with more checks (backups, index verification, etc.)
db-check:
	@echo "Checking database health and ensuring required databases exist..."
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
		echo "Creating databases if they don'"'"'t exist..."; \
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -C -Q "CREATE DATABASE [$(PRIMARY_DB)];" 2>/dev/null || echo "$(PRIMARY_DB) already exists"; \
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -C -Q "CREATE DATABASE [$(SECONDARY_DB)];" 2>/dev/null || echo "$(SECONDARY_DB) already exists"; \
		echo "Verifying databases..."; \
		$$SQLCMD -S localhost -U sa -P "$$PASSWORD" -C -Q "SELECT name FROM sys.databases WHERE name IN ('"'"'$(PRIMARY_DB)'"'"', '"'"'$(SECONDARY_DB)'"'"') ORDER BY name;" && echo "✅ All required databases exist"'

# Local install of MSSQL (no Docker)
ms-status:
	systemctl status mssql-server
	ss -ltnp | rg 1433

ms-start:
	sudo systemctl start mssql-server

ms-stop:
	sudo systemctl stop mssql-server

# Idempotent migration via native sqlcmd - safe to run multiple times against existing databases
# For production MSSQL Server environments
ms-migrate: build
	@echo "Generating idempotent migration script..."
	$(DOTNET) ef migrations script --idempotent --output sql/idempotent-migration.sql --context AppDbContext
	@# Remove UTF-8 BOM if present - sqlcmd does not handle it
	@sed -i '1s/^\xEF\xBB\xBF//' sql/idempotent-migration.sql 2>/dev/null || true
	@echo "Applying idempotent migration to database..."
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
		sqlcmd -S localhost -U sa -P "$$PASSWORD" -d master -C -Q "IF DB_ID('"'"'DotNetWebAppDb'"'"') IS NULL CREATE DATABASE [DotNetWebAppDb]" && \
		sqlcmd -S localhost -U sa -P "$$PASSWORD" -d DotNetWebAppDb -C -i sql/idempotent-migration.sql'
	@echo "✅ Migration applied successfully"

# Seed database via native sqlcmd - runs sql/seed.sql against native MSSQL Server
# Note: seed.sql contains USE [$(PRIMARY_DB)] and USE [$(SECONDARY_DB)] statements, so we connect to master
ms-seed:
	@echo "Seeding database via native sqlcmd..."
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
		sqlcmd -S localhost -U sa -P "$$PASSWORD" -d master -C -i sql/seed.sql'
	@echo "✅ Database seeded successfully"

# Drop the databases from native MSSQL instance on Linux
# Drops $(PRIMARY_DB), $(SECONDARY_DB), and DotNetWebAppDb databases
# Also removes EF Core migrations to ensure clean slate when schema.sql changes
ms-drop:
	# Clear old migrations to avoid conflicts when schema.sql changes
	@rm -f Migrations/*.cs && echo "Cleared old EF Core migrations."
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
		sqlcmd -S localhost -U sa -P "$$PASSWORD" -C -Q "\
			IF DB_ID('"'"'$(PRIMARY_DB)'"'"') IS NOT NULL BEGIN ALTER DATABASE [$(PRIMARY_DB)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [$(PRIMARY_DB)]; END; \
			IF DB_ID('"'"'$(SECONDARY_DB)'"'"') IS NOT NULL BEGIN ALTER DATABASE [$(SECONDARY_DB)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [$(SECONDARY_DB)]; END; \
			IF DB_ID('"'"'DotNetWebAppDb'"'"') IS NOT NULL BEGIN ALTER DATABASE [DotNetWebAppDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [DotNetWebAppDb]; END;" && \
		echo "Dropped databases $(PRIMARY_DB), $(SECONDARY_DB), DotNetWebAppDb (if they existed)." || echo "Failed to drop databases."'
