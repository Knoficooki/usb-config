#!/usr/bin/env bash

# Enhanced universal shell setup script for Linux/macOS
CONFIG_PATH="./.config"
PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')
MODE="auto"
VERBOSE=false
TAGS=""
CUSTOM_ARGS=()

# Argument parsing
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --platform) PLATFORM="$2"; shift ;;
        --mode) MODE="$2"; shift ;;
        --config-path) CONFIG_PATH="$2"; shift ;;
        --verbose) VERBOSE=true ;;
        --tags) TAGS="$2"; shift ;;
        --*) 
            key="${1#--}"
            CUSTOM_ARGS+=("--$key" "$2")
            shift 
            ;;
    esac
    shift
done

# Detect package manager if not set
if [ -z "$PKG_MANAGER" ]; then
    if command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
	elif command -v apt-get &> /dev/null; then
		PKG_MANAGER="apt-get"
	elif command -v apk &> /dev/null; then
		PKG_MANAGER="apk"
    elif command -v brew &> /dev/null; then
        PKG_MANAGER="brew"
    elif command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
	else
		PKG_MANAGER="nil"
    fi
fi

# Prepare Lua script arguments
LUA_ARGS=(
    "config/setup.lua"
    "--platform" "$PLATFORM"
    "--mode" "$MODE"
    "--config-path" "$CONFIG_PATH"
    "--pkg-manager" "$PKG_MANAGER"
)

# Add verbose flag
if [ "$VERBOSE" = true ]; then
    LUA_ARGS+=("--verbose")
fi

# Add tags if provided
if [ -n "$TAGS" ]; then
    LUA_ARGS+=("--tags" "$TAGS")
fi

# Add custom arguments
LUA_ARGS+=("${CUSTOM_ARGS[@]}")

LUA_INSTALL_FOLDER="lua-bin"
if [ ! -f "$CONFIG_PATH/$LUA_INSTALL_FOLDER/install/bin/lua" ]; then
	"$CONFIG_PATH/install-lua.sh" LUA_FOLDER=$LUA_INSTALL_FOLDER 
fi

echo 

cd .config
# Execute Lua setup script
"./$LUA_INSTALL_FOLDER/install/bin/lua" "${LUA_ARGS[@]}"