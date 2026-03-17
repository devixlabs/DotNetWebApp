# SQL Directory - Claude Context

## Overview

This directory contains SQL scripts for database schema and seed data management.

## Key Files

- **schema.sql** - SQL DDL source for entity definitions (run through DDL pipeline)
- **seed.sql** - Seed data for all applications (WEBAPP, WEBAPPMisc databases)
- **views/** - SQL SELECT queries for view definitions (referenced in appsettings.json)

## Database Structure

- **WEBAPP database** - Primary database with example tables (products, customers, orders, etc.)
- **WEBAPPMisc database** - Secondary database with shared application tables (webapp_scheduler, webapp_allocate, webapp_lock, webapp_dmstech, etc.)
- **DotNetWebAppDb database** - Main application database with generated entities

## Seed Data

The seed.sql file contains example data for the generic skeleton. All data uses placeholder company names (Acme Corporation, Initech Solutions, Globex Corp).

### Testing Seed Data

After updating seed.sql:

```bash
make seed                        # Execute seed data
make seed 2>&1 | grep -i error  # Check for errors
```

### Common Pitfalls

1. **Column count mismatches** - Always match existing INSERT format exactly
2. **Order number conflicts** - Check reserved ranges before adding data
3. **Wrong database** - WEBAPP vs WEBAPPMisc vs DotNetWebAppDb confusion
4. **Missing DELETE statements** - Causes data accumulation on re-runs

### sqlcmd Path Note

The SQL Server container uses **mssql-tools18** (not mssql-tools):
```bash
docker exec sqlserver-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C
```

The `-C` flag is required to trust the server certificate.
