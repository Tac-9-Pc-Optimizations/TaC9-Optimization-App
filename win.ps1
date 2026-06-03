# TaC-_-9s PC Optimization Tools - GitHub Installer
# Downloads latest release ZIP, extracts to Desktop, unblocks files, and opens launcher.

$ErrorActionPreference = "Stop"

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
} catch {}

$AppName = "TaC-_-9s PC Optimization Tools"
$ZipUrl = "https://github.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/releases/latest/download/TaC-_-9s_PC_Opti.zip"

$DownloadDir = Join-Path $env:USERPROFILE "Downloads"
$DesktopDir = [Environment]::GetFolderPath("Desktop")

$ZipPath = Join-Path $DownloadDir "TaC-_-9s_PC_Opti.zip"
$ExtractPath = Join-Path $DesktopDir $AppName

function Write-Step {
    param([string]$Text)
    Write-Host ""
    Write-Host "[TaC-_-9s] $Text" -ForegroundColor Cyan
}

function Write-Good {
    param([string]$Text)
    Write-Host "[OK] $Text" -ForegroundColor Green
}

function Write-Warn {
    param([string]$Text)
    Write-Host "[WARNING] $Text" -ForegroundColor Yellow
}

function Write-Bad {
    param([string]$Text)
    Write-Host "[ERROR] $Text" -ForegroundColor Red
}

Clear-Host

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " TaC-_-9s PC Optimization Tools Installer" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

Write-Step "Creating download folder..."
New-Item -ItemType Directory -Path $DownloadDir -Force | Out-Null

Write-Step "Removing old downloaded ZIP if found..."
if (Test-Path $ZipPath) {
    Remove-Item $ZipPath -Force
}

Write-Step "Downloading latest customer build..."
Write-Host $ZipUrl -ForegroundColor DarkGray

try {
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing
} catch {
    Write-Bad "Download failed."
    Write-Host $_.Exception.Message -ForegroundColor Red
    pause
    exit 1
}

if (!(Test-Path $ZipPath)) {
    Write-Bad "ZIP was not downloaded."
    pause
    exit 1
}

$ZipSize = [math]::Round((Get-Item $ZipPath).Length / 1MB, 2)
Write-Good "Download complete: $ZipSize MB"

Write-Step "Removing old Desktop app folder if found..."
if (Test-Path $ExtractPath) {
    try {
        Remove-Item $ExtractPath -Recurse -Force
    } catch {
        Write-Warn "Could not fully remove old folder. Close the app if it is open, then try again."
        Write-Host $_.Exception.Message -ForegroundColor Yellow
        pause
        exit 1
    }
}

Write-Step "Creating Desktop app folder..."
New-Item -ItemType Directory -Path $ExtractPath -Force | Out-Null

Write-Step "Extracting app to Desktop..."
try {
    Expand-Archive -Path $ZipPath -DestinationPath $ExtractPath -Force
} catch {
    Write-Bad "Extract failed."
    Write-Host $_.Exception.Message -ForegroundColor Red
    pause
    exit 1
}

Write-Step "Unblocking downloaded app files..."
try {
    Get-ChildItem $ExtractPath -Recurse -Force | Unblock-File -ErrorAction SilentlyContinue
} catch {}

Write-Step "Searching for launcher..."

$Launcher = Get-ChildItem $ExtractPath -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object {
        $_.Name -match "TaC9 Launcher\.exe|Launcher\.exe|TaC.*Launcher.*\.exe"
    } |
    Select-Object -First 1

if ($Launcher) {
    Write-Good "Launcher found:"
    Write-Host $Launcher.FullName -ForegroundColor Green

    Write-Step "Opening TaC-_-9s PC Optimization Tools..."
    Start-Process -FilePath $Launcher.FullName
} else {
    Write-Warn "Launcher EXE was not found. Opening extracted folder instead."
    Start-Process explorer.exe $ExtractPath
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Done. App was downloaded and extracted to Desktop." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
