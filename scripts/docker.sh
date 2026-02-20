#!/usr/bin/env bash
# Docker SQL Server operations dispatcher
# Handles all docker exec + sqlcmd interactions for db-* Makefile targets
# Usage: scripts/docker.sh <command> [args...]

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

# Execute sqlcmd inside the container
# Args: $1=PASSWORD, $2=database, $3..=sqlcmd arguments
# Pipes stdin to sqlcmd
docker_sqlcmd() {
    local PASSWORD="$1"
    local DATABASE="${2:-master}"
    shift 2

    docker exec -i -e "SA_PASSWORD=$PASSWORD" sqlserver-dev /bin/sh -c "
        # Discover sqlcmd path (v17 vs v18)
        if [ -x /opt/mssql-tools/bin/sqlcmd ]; then
            SQLCMD=/opt/mssql-tools/bin/sqlcmd
        elif [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
            SQLCMD=/opt/mssql-tools18/bin/sqlcmd
        else
            echo 'sqlcmd not found in container.' >&2
            exit 1
        fi

        \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -d \"$DATABASE\" -C \"\$@\"
    " -- "$@"
}

# Main command dispatcher
COMMAND="${1:-}"
shift || true

case "$COMMAND" in
    check)
        echo "Checking database health and ensuring required databases exist..."
        PASSWORD=$(resolve_password)

        docker exec -i -e "SA_PASSWORD=$PASSWORD" sqlserver-dev /bin/sh -c "
            if [ -x /opt/mssql-tools/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools/bin/sqlcmd
            elif [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools18/bin/sqlcmd
            else
                echo 'sqlcmd not found in container.' >&2
                exit 1
            fi

            echo 'Creating databases if they don'\''t exist...'
            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -C -Q \"CREATE DATABASE [GAI];\" 2>/dev/null || echo 'GAI already exists'
            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -C -Q \"CREATE DATABASE [GAIMisc];\" 2>/dev/null || echo 'GAIMisc already exists'
            echo 'Verifying databases...'
            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -C -Q \"SELECT name FROM sys.databases WHERE name IN ('GAI', 'GAIMisc') ORDER BY name;\" && echo '✅ All required databases exist'
        "
        ;;

    init-schema)
        echo "Initializing database schema from sql/schema.sql..."
        PASSWORD=$(resolve_password)

        # Ensure databases exist first
        bash "$(dirname "$0")/docker.sh" check > /dev/null

        # Apply schema
        echo "Applying schema from sql/schema.sql..."
        docker exec -i -e "SA_PASSWORD=$PASSWORD" sqlserver-dev /bin/sh -c "
            if [ -x /opt/mssql-tools/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools/bin/sqlcmd
            elif [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools18/bin/sqlcmd
            else
                echo 'sqlcmd not found in container.' >&2
                exit 1
            fi

            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -C -i /dev/stdin
        " < sql/schema.sql
        echo "✅ Database schema initialized successfully"
        ;;

    migrate)
        echo "Applying idempotent migration to database..."
        PASSWORD=$(resolve_password)

        docker exec -i -e "SA_PASSWORD=$PASSWORD" sqlserver-dev /bin/sh -c "
            if [ -x /opt/mssql-tools/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools/bin/sqlcmd
            elif [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools18/bin/sqlcmd
            else
                echo 'sqlcmd not found in container.' >&2
                exit 1
            fi

            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -C -Q \"IF DB_ID('DotNetWebAppDb') IS NULL CREATE DATABASE [DotNetWebAppDb]\" && \
            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -d DotNetWebAppDb -C -i /dev/stdin
        " < sql/idempotent-migration.sql
        echo "✅ Migration applied successfully"
        ;;

    seed)
        echo "Seeding database via Docker sqlcmd..."
        PASSWORD=$(resolve_password)

        docker exec -i -e "SA_PASSWORD=$PASSWORD" sqlserver-dev /bin/sh -c "
            if [ -x /opt/mssql-tools/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools/bin/sqlcmd
            elif [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools18/bin/sqlcmd
            else
                echo 'sqlcmd not found in container.' >&2
                exit 1
            fi

            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -C -i /dev/stdin
        " < sql/seed.sql
        echo "✅ Database seeded successfully"
        ;;

    drop)
        echo "Dropping databases..."
        PASSWORD=$(resolve_password)

        docker exec -i -e "SA_PASSWORD=$PASSWORD" sqlserver-dev /bin/sh -c "
            if [ -x /opt/mssql-tools/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools/bin/sqlcmd
            elif [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
                SQLCMD=/opt/mssql-tools18/bin/sqlcmd
            else
                echo 'sqlcmd not found in container.' >&2
                exit 1
            fi

            \$SQLCMD -S localhost -U sa -P \"$PASSWORD\" -C -Q \\
                \"IF DB_ID('GAI') IS NOT NULL BEGIN ALTER DATABASE [GAI] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [GAI]; END; \\
                IF DB_ID('GAIMisc') IS NOT NULL BEGIN ALTER DATABASE [GAIMisc] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [GAIMisc]; END; \\
                IF DB_ID('DotNetWebAppDb') IS NOT NULL BEGIN ALTER DATABASE [DotNetWebAppDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [DotNetWebAppDb]; END;\" && \\
            echo 'Dropped databases GAI, GAIMisc, DotNetWebAppDb (if they existed).' || echo 'Failed to drop databases.'
        "
        ;;

    *)
        die "Unknown command: $COMMAND. Valid commands: check, init-schema, migrate, seed, drop"
        ;;
esac
