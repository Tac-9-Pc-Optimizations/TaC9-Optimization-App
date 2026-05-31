# TaC-_-9s PC Optimization Tools Launcher
# Run with:
# irm https://raw.githubusercontent.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/main/win.ps1 | iex

$ErrorActionPreference = "Stop"

$RepoOwner = "Tac-9-Pc-Optimizations"
$RepoName  = "TaC9-Optimization-App"
$AppName   = "TaC-_-9s PC Optimization Tools"

$TempRoot = Join-Path $env:TEMP "TaC9_Optimization_App"
$ZipPath = Join-Path $TempRoot "TaC9_App.zip"
$ExtractPath = Join-Path $TempRoot "Extracted"

function Write-TaC9 {
    param(
        [string]$Message,
        [string]$Color = "Cyan"
    )
    Write-Host "[TaC-_-9s] $Message" -ForegroundColor $Color
}

Write-TaC9 "Starting $AppName..."

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-TaC9 "Please run PowerShell as Administrator, then paste the command again." "Red"
    pause
    exit 1
}

Remove-Item $TempRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $TempRoot -Force | Out-Null

$ApiUrl = "https://api.github.com/repos/$RepoOwner/$RepoName/releases/latest"

Write-TaC9 "Checking latest release..."

try {
    $Release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "TaC9Launcher" }
} catch {
    Write-TaC9 "Could not find the latest release. Make sure you uploaded the app ZIP under GitHub Releases." "Red"
    pause
    exit 1
}

$Asset = $Release.assets |
    Where-Object { $_.name -like "*.zip" } |
    Select-Object -First 1

if (-not $Asset) {
    Write-TaC9 "No ZIP file found in the latest GitHub release." "Red"
    pause
    exit 1
}

Write-TaC9 "Downloading latest customer app..."
Invoke-WebRequest -Uri $Asset.browser_download_url -OutFile $ZipPath -UseBasicParsing

Write-TaC9 "Extracting app..."
Expand-Archive -Path $ZipPath -DestinationPath $ExtractPath -Force

$Launcher = Get-ChildItem -Path $ExtractPath -Recurse -Filter "TaC9 Launcher.exe" |
    Select-Object -First 1

if (-not $Launcher) {
    Write-TaC9 "Could not find TaC9 Launcher.exe inside the ZIP." "Red"
    pause
    exit 1
}

Write-TaC9 "Opening $AppName..." "Green"
Start-Process -FilePath $Launcher.FullName -Verb RunAs

Write-TaC9 "Done. You can close this PowerShell window." "Green"
