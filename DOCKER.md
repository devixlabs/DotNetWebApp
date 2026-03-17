# Docker Database Setup Guide

## Overview

This project uses **Docker SQL Server** for local development. All database operations (migrations, seeding, CRUD) happen through the containerized SQL Server.

## Quick Connection Reference

**Container Details:**
```
Name:        sqlserver-dev
Port:        1433 (Docker → Host)
User:        sa
Database:    DotNetWebAppDb
Password:    Set via SA_PASSWORD environment variable
```

**Connection String:**
```
Server=localhost,1433;Database=DotNetWebAppDb;User Id=sa;Password=<SA_PASSWORD>;TrustServerCertificate=True;
```

## Essential Commands

| Task | Command |
|------|---------|
| **Create container** | `export SA_PASSWORD="YourStrongPassword123!" && make db-create` |
| **Start container** | `make db-start` |
| **Stop container** | `make db-stop` |
| **View logs** | `make db-logs` |
| **Apply migrations** | `make db-migrate` or `make migrate` |
| **Seed data** | `make db-seed` or `make seed` |
| **Drop database** | `make db-drop` (keeps container running) |
| **Destroy container** | `make db-destroy` (full cleanup) |
| **Interactive SQL shell** | `docker exec -it sqlserver-dev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD"` |

## Initial Setup (One-Time)

### 1. Set the SA Password

```bash
export SA_PASSWORD="YourStrongPassword123!"
```

**Password requirements:** min 8 chars, uppercase, lowercase, digits, symbols.

### 2. Create the Docker Container

```bash
make db-create
```

This pulls the SQL Server 2022 image, starts the container, and waits 30s for startup.

### 3. Store Password in User Secrets (Optional)

```bash
./setup.sh
```

Optionally provides User Secrets storage so you don't re-export `SA_PASSWORD` in every session.

## Full Development Workflow

```bash
# 1. Set password (or retrieve from User Secrets if already stored)
export SA_PASSWORD="YourStrongPassword123!"

# 2. Create container (one-time)
make db-create

# 3. Generate models from DDL
make run-ddl-pipeline

# 4. Apply migrations to database
make db-migrate

# 5. Seed sample data
make db-seed

# 6. Start dev server with hot reload
make dev
```

## One-Line Database Connection

Open an interactive SQL shell inside the container:

```bash
export SA_PASSWORD="YourStrongPassword123!"
docker exec -it sqlserver-dev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD"
```

Type `GO` to execute statements, `EXIT` to quit.

## Verify Database Connection

```bash
# Check if container is running
docker ps | grep sqlserver-dev

# View container logs
make db-logs

# Check if database exists
export SA_PASSWORD="YourStrongPassword123!"
docker exec -i sqlserver-dev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" \
  -Q "SELECT name FROM sys.databases WHERE name = 'DotNetWebAppDb';"
```

## Troubleshooting

### "Cannot connect to database"

- Verify container is running: `docker ps | grep sqlserver-dev`
- Verify `SA_PASSWORD` is exported: `echo $SA_PASSWORD`
- Check container logs: `make db-logs`
- If stuck, destroy and recreate: `make db-destroy && make db-create`

### "SA_PASSWORD required" error in make commands

- Export in current shell: `export SA_PASSWORD="YourStrongPassword123!"`
- Or use setup.sh to store in User Secrets: `./setup.sh`

### Container exits immediately

- Check logs for startup errors: `docker logs sqlserver-dev`
- Verify SA_PASSWORD meets requirements (min 8 chars, mixed case, digits, symbols)
- Try recreating: `make db-destroy && make db-create`

### Database connection from .NET app

- The app reads from User Secrets or environment variables during development
- See `SECRETS.md` for details
- Connection string is automatically built with `localhost,1433` and stored password

## Migration Patterns

### Standard EF Core Migration

```bash
make migrate
```

Use for most development scenarios. Requires SQL Server running and valid connection string.

### Docker-Based Idempotent Migration

```bash
make db-migrate
```

Safe to run against existing databases with tables. Automatically initializes schema from `sql/schema.sql` first.

**Requires:** Docker container running, `SA_PASSWORD` environment variable set

## Database Reset Pipeline

### Standard Reset Flow

```bash
make db-drop && make run-ddl-pipeline && make migrate && make seed
```

Use this for clean slate after schema.sql changes.

### End-to-End Testing

```bash
./verify.sh
```

Use instead of running commands individually. Handles the full pipeline, starts the dev server, and runs comprehensive CRUD tests with automatic cleanup.

**Verify.sh stages:**
1. `make check` - Build validation
2. `make test` - Unit tests (192+ tests)
3. `make db-drop` - Database reset
4. `make run-ddl-pipeline` - Regenerate models
5. `make migrate` - Apply migrations
6. `make seed` - Populate data
7. `make dev` - Start dev server
8. Run 14 integration tests

## Secrets Management

- Project uses **User Secrets** for local development
- Connection strings stored in `~/.microsoft/usersecrets/`, never in git
- `setup.sh` script automatically configures User Secrets when setting up SQL Server
- Manual management: `dotnet user-secrets list`, `dotnet user-secrets set`, etc.
- See `SECRETS.md` for full details
