# shellcheck shell=bash
# shellcheck disable=SC2034
DOTNET=./dotnet-build.sh
# shellcheck disable=SC2034
IMAGE_NAME=dotnetwebapp
# shellcheck disable=SC2034
TAG=latest
# shellcheck disable=SC2211,SC2276
DOTNET_ENVIRONMENT?=Development
# shellcheck disable=SC2211,SC2276
ASPNETCORE_ENVIRONMENT?=Development

.PHONY: clean check build migrate test docker-build run dev db-start db-stop db-logs db-drop

clean:
	$(DOTNET) clean

check:
	shellcheck setup.sh
	shellcheck dotnet-build.sh
	$(DOTNET) restore
	$(DOTNET) build --no-restore

build:
	$(DOTNET) build --configuration Release

migrate:
	ASPNETCORE_ENVIRONMENT=$(ASPNETCORE_ENVIRONMENT) DOTNET_ENVIRONMENT=$(DOTNET_ENVIRONMENT) $(DOTNET) ef database update

test:
	$(DOTNET) test --configuration Release --no-build

docker-build:
	docker build -t "$(IMAGE_NAME):$(TAG)" .

# Run the application once without hot reload (use for production-like testing or CI/CD)
run:
	$(DOTNET) run

# Run the application with hot reload (use for active development - auto-reloads on file changes)
dev:
	$(DOTNET) watch run --project DotNetWebApp.csproj --launch-profile https

# Start the SQL Server Docker container used for local dev
db-start:
	@if docker ps -a --format '{{.Names}}' | grep -q '^sqlserver-dev$$'; then docker start sqlserver-dev; else echo "sqlserver-dev container not found. Run ./setup.sh and choose Docker." >&2; exit 1; fi

# Stop the SQL Server Docker container
db-stop:
	@docker stop sqlserver-dev

# Tail logs for the SQL Server Docker container
db-logs:
	@docker logs -f sqlserver-dev

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
