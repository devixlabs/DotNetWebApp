DOTNET = ./dotnet-build.sh
IMAGE_NAME = dotnetwebapp
TAG = latest

.PHONY: clean check build migrate test docker-build run dev

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
	$(DOTNET) ef database update

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

