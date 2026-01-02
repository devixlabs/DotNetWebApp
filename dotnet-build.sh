#!/bin/bash
# Wrapper script to handle global.json SDK version conflicts across Windows/WSL
#
# Problem: Developers may have different .NET SDK versions installed on:
# - Windows (native install or Snap)
# - WSL (apt-get, Snap, or other package managers)
# This causes "SDK version not found" errors when global.json specifies a version
# not matching the local installation.
#
# Solution: Temporarily hide global.json during dotnet execution, allowing
# developers to work locally without version constraint enforcement.
# Note: CI/CD servers should have the correct SDK version and don't use this script.

# Check if dotnet is installed
if ! command -v dotnet &> /dev/null; then
    echo "Error: dotnet CLI not found in PATH" >&2
    exit 1
fi

# Check if dotnet-ef is installed
if ! command -v dotnet-ef &> /dev/null; then
    echo "Error: dotnet-ef CLI not found in PATH" >&2
    exit 1
fi

# Search for global.json up the directory tree
GLOBAL_JSON_PATH=""
for dir in . .. ../..; do
    if [ -f "$dir/global.json" ]; then
        GLOBAL_JSON_PATH="$dir/global.json"
        break
    fi
done

# Temporarily hide global.json to bypass version constraint enforcement
if [ -n "$GLOBAL_JSON_PATH" ]; then
    mv "$GLOBAL_JSON_PATH" "$GLOBAL_JSON_PATH.temp"
    dotnet "$@"
    EXIT_CODE=$?
    mv "$GLOBAL_JSON_PATH.temp" "$GLOBAL_JSON_PATH"
    exit $EXIT_CODE
else
    dotnet "$@"
fi