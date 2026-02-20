#!/bin/bash
set -e

echo "🚀 Starting DotNetWebApp..."
echo "⏳ Waiting for SQL Server to be ready (15s)..."
sleep 15

echo "✅ SQL Server ready!"
echo "🌐 Starting application on http://+:5210..."
echo "📝 Note: Ensure databases (GAI, GAIMisc) and schema are created before app startup"
echo "   Run locally: make migrate"
echo ""

# Start the app
exec dotnet DotNetWebApp.dll
