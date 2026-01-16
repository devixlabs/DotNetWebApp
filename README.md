# DotNetWebApp

.NET version 8 application manually created with the help of ChatGPT4.

# Setup

## 1. Install SQL Server
Run the setup script to install SQL Server (Docker or native Linux):
```bash
./setup.sh
```

## Database (Docker)
If you chose Docker in `./setup.sh`, use these commands to manage the SQL Server container:
```bash
make db-start
make db-stop
make db-logs
```

## 2. Setup .NET tools and build
```bash
dotnet tool install --global dotnet-ef --version 8.*
make check
make migrate
```
If you're using native SQL Server (not Docker), ensure your connection string is set via User Secrets or an environment variable before running `make migrate`. See `SECRETS.md`.

# Build
```
make build
```

## Docker

### Build the image
```bash
make docker-build
```

# Testing
```
make test
```

# Running

For active development (with hot reload):
```
make dev
```

For production-like testing (without hot reload):
```
make run
```

### Run the container
```bash
docker run -d \
  -p 8080:80 \
  --name dotnetwebapp \
  dotnetwebapp:latest
```

# Database migrations
```
make migrate
```
