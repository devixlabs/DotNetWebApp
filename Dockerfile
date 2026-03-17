# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder
WORKDIR /src

# Copy solution and project files
COPY DotNetWebApp.sln .
COPY DotNetWebApp.csproj .
COPY DotNetWebApp.Models/DotNetWebApp.Models.csproj ./DotNetWebApp.Models/
COPY DdlParser/DdlParser.csproj ./DdlParser/
COPY ModelGenerator/ModelGenerator.csproj ./ModelGenerator/
COPY YamlMerger/YamlMerger.csproj ./YamlMerger/
COPY AppsYamlGenerator/AppsYamlGenerator.csproj ./AppsYamlGenerator/

# Copy source code
COPY . .

# Restore and build (solution-level restore, but exclude test projects via .dockerignore)
RUN dotnet restore DotNetWebApp.csproj
RUN dotnet build DotNetWebApp.csproj --configuration Release --no-restore

# Publish
RUN dotnet publish DotNetWebApp.csproj --configuration Release --no-build --output /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy published application from builder
COPY --from=builder /app/publish .

# Copy entrypoint script
COPY docker/entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Set environment
ENV ASPNETCORE_URLS=http://+:5210
ENV ASPNETCORE_ENVIRONMENT=Docker
ENV DOTNET_RUNNING_IN_CONTAINER=true

EXPOSE 7012

# Run migrations on startup, then start app
ENTRYPOINT ["/app/entrypoint.sh"]
