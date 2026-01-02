DOTNET = ./dotnet-build.sh
IMAGE_NAME = dotnetwebapp
TAG = latest

.PHONY: clean check build migrate test docker-build run

clean:
	$(DOTNET) clean

check:
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

run:
	$(DOTNET) run

