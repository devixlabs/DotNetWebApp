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

# Ensure DOTNET_ROOT is set so global tools can find the runtime.
if [ -z "$DOTNET_ROOT" ]; then
    DOTNET_PATH=$(command -v dotnet)
    DOTNET_ROOT=$(dirname "$(readlink -f "$DOTNET_PATH")")
    export DOTNET_ROOT
fi

# Check if dotnet-ef is installed
if ! command -v dotnet-ef &> /dev/null; then
    echo "Error: dotnet-ef CLI not found in PATH" >&2
    exit 1
fi

# Performance optimization: Skip global.json handling if explicitly disabled
# Set SKIP_GLOBAL_JSON_HANDLING=true in your environment or Makefile to bypass
# the filesystem search when you know your project doesn't use global.json
if [ "${SKIP_GLOBAL_JSON_HANDLING:-false}" = "true" ]; then
    dotnet "$@"
    exit $?
fi

# Search for global.json up the directory tree
# This search happens on every dotnet command, so we optimize by:
# 1. Checking only 3 levels (current, parent, grandparent)
# 2. Breaking immediately when found
# 3. Skipping mv operations entirely if not found
GLOBAL_JSON_PATH=""
for dir in . .. ../..; do
    if [ -f "$dir/global.json" ]; then
        GLOBAL_JSON_PATH="$dir/global.json"
        break
    fi
done

# Only perform mv operations if global.json was actually found
# This avoids unnecessary filesystem operations for projects without global.json
if [ -n "$GLOBAL_JSON_PATH" ]; then
    # Temporarily hide global.json to bypass version constraint enforcement
    mv "$GLOBAL_JSON_PATH" "$GLOBAL_JSON_PATH.temp"
    dotnet "$@"
    EXIT_CODE=$?
    mv "$GLOBAL_JSON_PATH.temp" "$GLOBAL_JSON_PATH"
    exit $EXIT_CODE
else
    # No global.json found - run dotnet directly without any file operations
    dotnet "$@"
fi
