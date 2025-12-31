# Use the official .NET 8.0 SDK to build and publish the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file and restore dependencies
COPY ["DotNetWebApp.csproj", "./"]
RUN dotnet restore "DotNetWebApp.csproj"

# Copy remaining source code and publish
COPY . .
RUN dotnet publish "DotNetWebApp.csproj" -c Release -o /app/publish

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expose port and set entrypoint
EXPOSE 80
ENTRYPOINT ["dotnet", "DotNetWebApp.dll"]
