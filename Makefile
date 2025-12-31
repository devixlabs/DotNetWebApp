DOTNET = ./dotnet-build.sh
IMAGE_NAME = dotnetwebapp
TAG = latest

.PHONY: check build test docker-build

check:
	shellcheck dotnet-build.sh
	$(DOTNET) restore
	$(DOTNET) build --no-restore

build:
	$(DOTNET) build --configuration Release

test:
	$(DOTNET) test --configuration Release --no-build

docker-build:
	docker build -t $(IMAGE_NAME):$(TAG) .
