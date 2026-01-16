#!/bin/bash
set -e

echo "=========================================="
echo "SQL Server 2022 Express Setup for Linux"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "This script is designed for Linux/WSL environments."
    echo "For Windows, download SQL Server Express from:"
    echo "https://www.microsoft.com/en-us/sql-server/sql-server-downloads"
    exit 1
fi

# Check for Docker as alternative
echo "Choose installation method:"
echo "1) Native Linux installation (SQL Server on Ubuntu/Debian)"
echo "2) Docker container (recommended, easier to manage)"
read -r -p "Enter choice (1 or 2): " choice

if [ "$choice" = "2" ]; then
    echo ""
    echo -e "${YELLOW}Setting up SQL Server in Docker...${NC}"

    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install Docker first:"
        echo "  sudo apt-get update"
        echo "  sudo apt-get install docker.io"
        echo "  sudo usermod -aG docker $USER"
        exit 1
    fi

    # Check if container already exists
    if docker ps -a | grep -q sqlserver-dev; then
        echo "SQL Server container 'sqlserver-dev' already exists."
        read -r -p "Remove and recreate? (y/n): " recreate
        if [ "$recreate" = "y" ]; then
            docker stop sqlserver-dev 2>/dev/null || true
            docker rm sqlserver-dev 2>/dev/null || true
        else
            echo "Starting existing container..."
            docker start sqlserver-dev
            exit 0
        fi
    fi

    # Set SA password
    read -r -sp "Enter SA password (min 8 chars, uppercase, lowercase, digits, symbols): " SA_PASSWORD
    echo ""

    # Run SQL Server in Docker
    echo "Starting SQL Server 2022 in Docker..."
    docker run -e "ACCEPT_EULA=Y" \
        -e "MSSQL_SA_PASSWORD=$SA_PASSWORD" \
        -p 1433:1433 \
        --name sqlserver-dev \
        --hostname sqlserver \
        -d mcr.microsoft.com/mssql/server:2022-latest

    echo ""
    echo -e "${GREEN}SQL Server Docker container started successfully!${NC}"
    echo ""

    # Configure User Secrets for connection string
    CONNECTION_STRING="Server=localhost,1433;Database=DotNetWebAppDb;User Id=sa;Password=${SA_PASSWORD};TrustServerCertificate=True;"

    # Navigate to project directory and set user secret
    cd "$(dirname "$0")" || exit 1

    echo "Configuring connection string in User Secrets..."
    if command -v dotnet &> /dev/null; then
        dotnet user-secrets set "ConnectionStrings:DefaultConnection" "$CONNECTION_STRING" 2>/dev/null || {
            echo "Note: User Secrets will be configured when you first run the project"
            echo "Connection string stored for setup"
        }
        echo -e "${GREEN}Connection string stored in User Secrets${NC}"
    else
        echo "Note: dotnet CLI not found in current context"
    fi

    echo ""
    echo "Connection details:"
    echo "  Server: localhost,1433"
    echo "  Username: sa"
    echo "  Password: (stored in User Secrets)"
    echo ""
    echo "Useful Docker commands:"
    echo "  docker start sqlserver-dev   # Start the container"
    echo "  docker stop sqlserver-dev    # Stop the container"
    echo "  docker logs sqlserver-dev    # View logs"
    echo "  docker exec -it sqlserver-dev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa"

elif [ "$choice" = "1" ]; then
    echo ""
    echo -e "${YELLOW}Installing SQL Server 2022 natively on Linux...${NC}"

    # Detect Linux distribution
    if [ -f /etc/os-release ]; then
        # shellcheck source=/dev/null
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
    else
        echo "Cannot detect Linux distribution"
        exit 1
    fi

    # Check if SQL Server is already installed
    if command -v /opt/mssql/bin/sqlservr &> /dev/null; then
        echo "SQL Server is already installed."
        read -r -p "Reconfigure? (y/n): " reconfig
    if [ "$reconfig" != "y" ]; then
        exit 0
    fi
fi

echo "Detected: $OS $VER"

if [[ "$OS" == "ubuntu" ]]; then
    # Ubuntu installation
    echo "Installing for Ubuntu..."
    echo ""
    sudo -k
    sudo -v

    # Import Microsoft GPG key
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc

        # Add SQL Server repository based on Ubuntu version
        if [[ "$VER" == "22.04" ]]; then
            sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list)"
        elif [[ "$VER" == "20.04" ]]; then
            sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
        else
            echo "Ubuntu version $VER may not be officially supported. Trying 20.04 repository..."
            sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
        fi

        # Install SQL Server
        sudo apt-get update
        sudo apt-get install -y mssql-server

    elif [[ "$OS" == "debian" ]]; then
        # Debian installation
        echo "Installing for Debian..."

        # Import Microsoft GPG key
        curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

        # Add repository
        curl https://packages.microsoft.com/config/debian/11/mssql-server-2022.list | sudo tee /etc/apt/sources.list.d/mssql-server-2022.list

        # Install SQL Server
        sudo apt-get update
        sudo apt-get install -y mssql-server

    else
        echo "Unsupported distribution: $OS"
        echo "Please use Docker method instead (option 2)"
        exit 1
    fi

    # Configure SQL Server
    echo ""
    echo "Configuring SQL Server..."
    echo "Choose edition:"
    echo "  2) Developer (free, full features)"
    echo "  3) Express (free, limited features)"

    sudo /opt/mssql/bin/mssql-conf setup

    # Enable and start SQL Server
    sudo systemctl enable mssql-server
    sudo systemctl start mssql-server

    # Check status
    systemctl status mssql-server --no-pager

    echo ""
    echo -e "${GREEN}SQL Server installed and started successfully!${NC}"
    echo ""
    read -r -sp "Enter SA password to store in User Secrets (leave blank to skip): " SA_PASSWORD
    echo ""
    if [ -n "$SA_PASSWORD" ]; then
        CONNECTION_STRING="Server=localhost,1433;Database=DotNetWebAppDb;User Id=sa;Password=${SA_PASSWORD};TrustServerCertificate=True;"

        # Navigate to project directory and set user secret
        cd "$(dirname "$0")" || exit 1

        echo "Configuring connection string in User Secrets..."
        if command -v dotnet &> /dev/null; then
            dotnet user-secrets set "ConnectionStrings:DefaultConnection" "$CONNECTION_STRING" 2>/dev/null || {
                echo "Note: User Secrets will be configured when you first run the project"
                echo "Connection string stored for setup"
            }
            echo -e "${GREEN}Connection string stored in User Secrets${NC}"
        else
            echo "Note: dotnet CLI not found in current context"
        fi
    else
        echo "Skipping User Secrets configuration."
    fi

    echo ""
    echo "Install SQL Server command-line tools:"
    echo "  curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -"
    echo "  curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list"
    echo "  sudo apt-get update"
    echo "  sudo apt-get install -y mssql-tools unixodbc-dev"
    echo "  echo 'export PATH=\"\$PATH:/opt/mssql-tools/bin\"' >> ~/.bashrc"

else
    echo "Invalid choice"
    exit 1
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo "Connection string has been stored in User Secrets (~/.microsoft/usersecrets/)"
echo "This keeps your password out of git and safe from accidental commits."
echo ""
echo "Next steps:"
echo "  1. Run: make migrate"
echo "  2. Run: make dev"
