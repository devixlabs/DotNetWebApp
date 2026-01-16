DOTNET = ./dotnet-build.sh
IMAGE_NAME = dotnetwebapp
TAG = latest
DOTNET_ENVIRONMENT ?= Development
ASPNETCORE_ENVIRONMENT ?= Development

.PHONY: clean check build migrate test docker-build run dev db-start db-stop db-logs

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
	docker build -t $(IMAGE_NAME):$(TAG) .

# Run the application once without hot reload (use for production-like testing or CI/CD)
run:
	$(DOTNET) run

# Run the application with hot reload (use for active development - auto-reloads on file changes)
dev:
	$(DOTNET) watch

# Start the SQL Server Docker container used for local dev
db-start:
	@docker ps -a --format '{{.Names}}' | grep -q '^sqlserver-dev$$' && \
		docker start sqlserver-dev || \
		( echo "sqlserver-dev container not found. Run ./setup.sh and choose Docker." && exit 1 )

# Stop the SQL Server Docker container
db-stop:
	@docker stop sqlserver-dev

# Tail logs for the SQL Server Docker container
db-logs:
	@docker logs -f sqlserver-dev
