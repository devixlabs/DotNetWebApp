# DotNetWebApp

.NET version 8 application manually created with the help of ChatGPT4. Make sure to have a local SQL Server database installed.

# Setup
```
dotnet tool install --global dotnet-ef --version 8.*
make check
make migrate
```

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