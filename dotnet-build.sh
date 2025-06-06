#!/bin/bash
# Wrapper script to handle global.json SDK version conflicts

# Check for global.json in current directory and parent directories
GLOBAL_JSON_PATH=""
if [ -f "global.json" ]; then
    GLOBAL_JSON_PATH="global.json"
elif [ -f "../global.json" ]; then
    GLOBAL_JSON_PATH="../global.json"
elif [ -f "../../global.json" ]; then
    GLOBAL_JSON_PATH="../../global.json"
fi

# If global.json found, temporarily move it
if [ -n "$GLOBAL_JSON_PATH" ]; then
    mv "$GLOBAL_JSON_PATH" "$GLOBAL_JSON_PATH.temp"
    /snap/bin/dotnet "$@"
    EXIT_CODE=$?
    mv "$GLOBAL_JSON_PATH.temp" "$GLOBAL_JSON_PATH"
    exit $EXIT_CODE
else
    /snap/bin/dotnet "$@"
fi