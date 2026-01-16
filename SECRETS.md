# Managing Secrets in DotNetWebApp

This project uses **User Secrets** for local development configuration, following .NET best practices.

## What are User Secrets?

User Secrets is a .NET feature that stores sensitive configuration data outside your project directory:
- Location: `~/.microsoft/usersecrets/<UserSecretsId>/secrets.json`
- **Never committed to git**
- Automatically loaded in Development environment
- Per-developer configuration

## Quick Start

### 1. Run the SQL Server setup script:
```bash
./setup.sh
```

The script will automatically configure your connection string in User Secrets.

### 2. Manual Configuration (if needed):

```bash
# Set connection string
dotnet user-secrets set "ConnectionStrings:DefaultConnection" \
  "Server=localhost,1433;Database=DotNetWebAppDb;User Id=sa;Password=YourPassword;TrustServerCertificate=True;"

# List all secrets
dotnet user-secrets list

# Remove a secret
dotnet user-secrets remove "ConnectionStrings:DefaultConnection"

# Clear all secrets
dotnet user-secrets clear
```

## How It Works

1. **DotNetWebApp.csproj** contains a `<UserSecretsId>` - this identifies your secrets store
2. **appsettings.json** has the production connection string (or placeholder)
3. **appsettings.Development.json** has development-specific settings (no secrets)
4. **User Secrets** override both files in Development environment with your local secrets

## Configuration Hierarchy

.NET loads configuration in this order (later sources override earlier ones):
1. `appsettings.json`
2. `appsettings.{Environment}.json`
3. **User Secrets** (Development environment only)
4. Environment variables
5. Command-line arguments

## Why User Secrets?

✅ **Secure**: Secrets never appear in your project directory or git
✅ **Convenient**: Automatically loaded in Development environment
✅ **Standard**: Official .NET approach for local development
✅ **Per-developer**: Each team member has their own configuration

## Alternative: Environment Variables

You can also use environment variables:

```bash
export ConnectionStrings__DefaultConnection="Server=localhost,1433;Database=DotNetWebAppDb;User Id=sa;Password=YourPassword;TrustServerCertificate=True;"
```

Note the double underscore `__` to represent the nested `ConnectionStrings:DefaultConnection` key.

## Alternative: direnv (.envrc / .env.local)

.NET does not load `.env` files automatically. If you use `direnv`, make sure your `.envrc` exports the connection string (you can source `.env.local` if you prefer):

```bash
export ConnectionStrings__DefaultConnection="Server=localhost,1433;Database=DotNetWebAppDb;User Id=sa;Password=YourPassword;TrustServerCertificate=True;"
```

Then run:

```bash
direnv allow
```

## Production Deployment

For production, use:
- **Azure**: App Service Configuration or Key Vault
- **AWS**: Systems Manager Parameter Store or Secrets Manager
- **Docker**: Environment variables or secrets management
- **Kubernetes**: Secrets or ConfigMaps

User Secrets are **only for local development** and are not deployed with your application.
