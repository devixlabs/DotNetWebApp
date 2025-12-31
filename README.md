# DotNetWebApp

.NET version 8 application manually created with the help of ChatGPT4. Make sure to have a local SQL Server database installed.

# Setup
```
dotnet ef migrations add InitialCreate
dotnet ef database update
```

# Running
```
dotnet build
dotnet run
```

# Build

## Docker

### Build the image
```bash
docker build -t dotnetwebapp:latest .
```

### Run the container
```bash
docker run -d \
  -p 8080:80 \
  --name dotnetwebapp \
  dotnetwebapp:latest
```
