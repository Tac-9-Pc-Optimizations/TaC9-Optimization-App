```powershell
# TaC-_-9s PC Optimization Tools - GitHub Installer
# Downloads latest release ZIP, extracts to Desktop, unblocks files, creates Desktop shortcut, and opens launcher.

$ErrorActionPreference = "Stop"

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
} catch {}

$AppName = "TaC-_-9s PC Optimization Tools"

# GitHub latest release asset URL
$ZipUrl = "https://github.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/releases/latest/download/TaC-_-9s_PC_Opti.App.zip"

$DownloadDir = Join-Path $env:USERPROFILE "Downloads"
$DesktopDir = [Environment]::GetFolderPath("Desktop")

$ZipPath = Join-Path $DownloadDir "TaC-_-9s_PC_Opti.App.zip"
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

Write-Step "Removing old downloaded ZIP files if found..."

$OldZip1 = Join-Path $DownloadDir "TaC-_-9s_PC_Opti.zip"
$OldZip2 = Join-Path $DownloadDir "TaC-_-9s_PC_Opti.App.zip"

if (Test-Path $OldZip1) {
    Remove-Item $OldZip1 -Force -ErrorAction SilentlyContinue
}

if (Test-Path $OldZip2) {
    Remove-Item $OldZip2 -Force -ErrorAction SilentlyContinue
}

Write-Step "Downloading latest customer build..."
Write-Host $ZipUrl -ForegroundColor DarkGray

try {
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing
} catch {
    Write-Bad "Download failed."
    Write-Host ""
    Write-Host "Possible causes:" -ForegroundColor Yellow
    Write-Host "1. The GitHub release asset name does not match the URL." -ForegroundColor Yellow
    Write-Host "2. The release is missing the ZIP file." -ForegroundColor Yellow
    Write-Host "3. The GitHub repo or release is private." -ForegroundColor Yellow
    Write-Host "4. Internet or GitHub connection issue." -ForegroundColor Yellow
    Write-Host ""
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
        Write-Warn "Could not fully remove old folder."
        Write-Host "Close the app if it is open, then try again." -ForegroundColor Yellow
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

$LauncherPath = Join-Path $ExtractPath "TaC-_-9s Opti.exe"

if (Test-Path $LauncherPath) {
    $Launcher = Get-Item $LauncherPath
} else {
    $Launcher = Get-ChildItem $ExtractPath -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object {
            $_.Name -match "TaC-_-9s Opti\.exe|TaC.*Opti.*\.exe|TaC.*Launcher.*\.exe|Launcher\.exe"
        } |
        Sort-Object FullName |
        Select-Object -First 1
}

if ($Launcher) {
    Write-Good "Launcher found:"
    Write-Host $Launcher.FullName -ForegroundColor Green

    Write-Step "Creating Desktop launcher shortcut..."

    try {
        $ShortcutPath = Join-Path $DesktopDir "TaC-_-9s Opti.lnk"

        if (Test-Path $ShortcutPath) {
            Remove-Item $ShortcutPath -Force -ErrorAction SilentlyContinue
        }

        $WScriptShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
        $Shortcut.TargetPath = $Launcher.FullName
        $Shortcut.WorkingDirectory = $Launcher.DirectoryName
        $Shortcut.IconLocation = $Launcher.FullName
        $Shortcut.Description = "Launch TaC-_-9s PC Optimization Tools"
        $Shortcut.Save()

        Write-Good "Desktop shortcut created:"
        Write-Host $ShortcutPath -ForegroundColor Green
    } catch {
        Write-Warn "Could not create Desktop shortcut."
        Write-Host $_.Exception.Message -ForegroundColor Yellow
    }

    Write-Step "Opening TaC-_-9s PC Optimization Tools..."

    try {
        Start-Process -FilePath $Launcher.FullName -WorkingDirectory $Launcher.DirectoryName
    } catch {
        Write-Warn "Launcher was found but could not be opened automatically."
        Write-Host $_.Exception.Message -ForegroundColor Yellow
        Start-Process explorer.exe $ExtractPath
    }
} else {
    Write-Warn "Launcher EXE was not found. Opening extracted folder instead."
    Start-Process explorer.exe $ExtractPath
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Done. App was downloaded and extracted to Desktop." -ForegroundColor Green
Write-Host " Shortcut created as: TaC-_-9s Opti" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

pause
```
