#!/usr/bin/env bash
# Native MSSQL Server operations dispatcher
# Handles all sqlcmd interactions for ms-* Makefile targets (non-Docker)
# Usage: scripts/mssql.sh <command> [args...]

set -e

# Color output for status messages
RED='\033[0;31m'
NC='\033[0m' # No Color

die() {
    echo -e "${RED}Error: $*${NC}" >&2
    exit 1
}

# Resolve SA_PASSWORD (check SA_PASSWORD, fallback to MSSQL_SA_PASSWORD)
resolve_password() {
    local PASSWORD="$SA_PASSWORD"
    if [ -z "$PASSWORD" ] && [ -n "$MSSQL_SA_PASSWORD" ]; then
        PASSWORD="$MSSQL_SA_PASSWORD"
    fi
    if [ -z "$PASSWORD" ]; then
        die "SA_PASSWORD is required (export SA_PASSWORD=...)"
    fi
    echo "$PASSWORD"
}

# Main command dispatcher
COMMAND="${1:-}"
shift || true

case "$COMMAND" in
    check)
        echo "Checking database health and ensuring required databases exist..."
        PASSWORD=$(resolve_password)

        sqlcmd -S localhost -U sa -P "$PASSWORD" -C -Q "CREATE DATABASE [GAI];" 2>/dev/null || echo "GAI already exists"
        sqlcmd -S localhost -U sa -P "$PASSWORD" -C -Q "CREATE DATABASE [GAIMisc];" 2>/dev/null || echo "GAIMisc already exists"
        echo "Verifying databases..."
        sqlcmd -S localhost -U sa -P "$PASSWORD" -C -Q "SELECT name FROM sys.databases WHERE name IN ('GAI', 'GAIMisc') ORDER BY name;" && echo "✅ All required databases exist"
        ;;

    migrate)
        echo "Applying idempotent migration to database..."
        PASSWORD=$(resolve_password)

        /bin/sh -c "
            sqlcmd -S localhost -U sa -P \"$PASSWORD\" -C -Q \"IF DB_ID('DotNetWebAppDb') IS NULL CREATE DATABASE [DotNetWebAppDb]\" && \
            sqlcmd -S localhost -U sa -P \"$PASSWORD\" -d DotNetWebAppDb -C -i sql/idempotent-migration.sql
        "
        echo "✅ Migration applied successfully"
        ;;

    seed)
        echo "Seeding database via native sqlcmd..."
        PASSWORD=$(resolve_password)

        sqlcmd -S localhost -U sa -P "$PASSWORD" -C -i sql/seed.sql
        echo "✅ Database seeded successfully"
        ;;

    drop)
        echo "Dropping databases..."
        PASSWORD=$(resolve_password)

        sqlcmd -S localhost -U sa -P "$PASSWORD" -C -Q "
            IF DB_ID('GAI') IS NOT NULL BEGIN ALTER DATABASE [GAI] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [GAI]; END;
            IF DB_ID('GAIMisc') IS NOT NULL BEGIN ALTER DATABASE [GAIMisc] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [GAIMisc]; END;
            IF DB_ID('DotNetWebAppDb') IS NOT NULL BEGIN ALTER DATABASE [DotNetWebAppDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [DotNetWebAppDb]; END;" && \
        echo "Dropped databases GAI, GAIMisc, DotNetWebAppDb (if they existed)." || echo "Failed to drop databases."
        ;;

    *)
        die "Unknown command: $COMMAND. Valid commands: migrate, seed, drop"
        ;;
esac
