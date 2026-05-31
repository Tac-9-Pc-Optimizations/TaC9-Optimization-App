# TaC-_-9s PC Optimization Tools Launcher
# Run with:
# irm https://raw.githubusercontent.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/main/win.ps1 | iex

$ErrorActionPreference = "Stop"

$RepoOwner = "Tac-9-Pc-Optimizations"
$RepoName  = "TaC9-Optimization-App"
$AppName   = "TaC-_-9s PC Optimization Tools"

$Desktop = [Environment]::GetFolderPath("Desktop")
$InstallRoot = Join-Path $Desktop "TaC-_-9s PC Optimization Tools"

$TempRoot = Join-Path $env:TEMP "TaC9_Optimization_App_Download"
$ZipPath = Join-Path $TempRoot "TaC9_App.zip"
$ExtractTemp = Join-Path $TempRoot "Extracted"
$LicenseBackup = Join-Path $TempRoot "License_Backup"

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

$ApiUrl = "https://api.github.com/repos/$RepoOwner/$RepoName/releases/latest"

Write-TaC9 "Checking latest release..."

try {
    $Release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "User-Agent" = "TaC9Launcher" }
} catch {
    Write-TaC9 "Could not find the latest release. Make sure the app ZIP is uploaded under GitHub Releases." "Red"
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

Write-TaC9 "Preparing Desktop install folder..."

Remove-Item $TempRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $TempRoot -Force | Out-Null
New-Item -ItemType Directory -Path $ExtractTemp -Force | Out-Null

# Close old TaC9 app if it is running from the Desktop app folder
Get-Process -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        if ($_.Path -and $_.Path.StartsWith($InstallRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
        }
    } catch {}
}

# Backup saved license files if they exist
$OldLicensePath = Join-Path $InstallRoot "License"
if (Test-Path $OldLicensePath) {
    New-Item -ItemType Directory -Path $LicenseBackup -Force | Out-Null
    Copy-Item -Path (Join-Path $OldLicensePath "*") -Destination $LicenseBackup -Recurse -Force -ErrorAction SilentlyContinue
}

Write-TaC9 "Downloading latest customer app..."
Invoke-WebRequest -Uri $Asset.browser_download_url -OutFile $ZipPath -UseBasicParsing

Write-TaC9 "Extracting app..."
Expand-Archive -Path $ZipPath -DestinationPath $ExtractTemp -Force

$LauncherInExtract = Get-ChildItem -Path $ExtractTemp -Recurse -Filter "TaC9 Launcher.exe" |
    Select-Object -First 1

if (-not $LauncherInExtract) {
    Write-TaC9 "Could not find TaC9 Launcher.exe inside the ZIP." "Red"
    pause
    exit 1
}

# Clean old Desktop copy and copy the new app cleanly
Remove-Item $InstallRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $InstallRoot -Force | Out-Null

$SourceRoot = $LauncherInExtract.Directory.FullName
Copy-Item -Path (Join-Path $SourceRoot "*") -Destination $InstallRoot -Recurse -Force

# Restore saved license files
$NewLicensePath = Join-Path $InstallRoot "License"
if ((Test-Path $LicenseBackup) -and (Test-Path $NewLicensePath)) {
    Copy-Item -Path (Join-Path $LicenseBackup "*") -Destination $NewLicensePath -Recurse -Force -ErrorAction SilentlyContinue
}

$Launcher = Join-Path $InstallRoot "TaC9 Launcher.exe"

if (-not (Test-Path $Launcher)) {
    Write-TaC9 "Could not find TaC9 Launcher.exe after saving to Desktop." "Red"
    pause
    exit 1
}

Write-TaC9 "Saved to Desktop: $InstallRoot" "Green"
Write-TaC9 "Opening $AppName..." "Green"

Start-Process -FilePath $Launcher -Verb RunAs

Write-TaC9 "Done. The app is saved on the Desktop." "Green"
