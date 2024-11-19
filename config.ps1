#!/usr/bin/env pwsh

# Enhanced PowerShell setup script for Windows
param (
    [string]$ConfigPath = ".\.config\",
    [string]$Platform = $null,
    [string]$Mode = "auto",
    [switch]$Verbose = $false,
    [string[]]$Tags = @(),
    [hashtable]$CustomArgs = @{}
)

# Detect platform if not specified
if (-not $Platform) {
    $Platform = $(uname | tr '[:upper:]' '[:lower:]')
}

# Prepare arguments for Lua script
$ArgList = @(
    "config/setup.lua",
    "--platform", $Platform,
    "--mode", $Mode,
    "--config-path", $ConfigPath
)

# Add verbose flag
if ($Verbose) {
    $ArgList += "--verbose"
}

# Add tags
if ($Tags.Length -gt 0) {
    $ArgList += "--tags"
    $ArgList += ($Tags -join ",")
}

# Add custom arguments
foreach ($key in $CustomArgs.Keys) {
    $ArgList += "--$key"
    $ArgList += $CustomArgs[$key]
}

# Execute Lua setup script with arguments
. "$ConfigPath\lua\install\bin\lua.exe" @ArgList