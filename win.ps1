$ErrorActionPreference = "Stop"

$ZipUrl = "https://github.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/releases/latest/download/TaC-_-9s_PC_Opti.zip"
$DownloadPath = "$env:USERPROFILE\Downloads\TaC-_-9s_PC_Opti.zip"
$ExtractPath = "$env:USERPROFILE\Desktop\TaC-_-9s PC Optimization Tools"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " TaC-_-9s PC Optimization Tools Installer" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Downloading latest TaC-_-9s PC Optimization Tools..." -ForegroundColor Cyan

if (Test-Path $DownloadPath) {
    Remove-Item $DownloadPath -Force
}

Invoke-WebRequest -Uri $ZipUrl -OutFile $DownloadPath -UseBasicParsing

Write-Host "Download complete." -ForegroundColor Green
Write-Host "Extracting app to Desktop..." -ForegroundColor Cyan

if (Test-Path $ExtractPath) {
    Remove-Item $ExtractPath -Recurse -Force
}

New-Item -ItemType Directory -Path $ExtractPath -Force | Out-Null
Expand-Archive -Path $DownloadPath -DestinationPath $ExtractPath -Force

Write-Host "Unblocking files..." -ForegroundColor Cyan
Get-ChildItem $ExtractPath -Recurse | Unblock-File -ErrorAction SilentlyContinue

$Launcher = Get-ChildItem $ExtractPath -Recurse -Filter "TaC9 Launcher.exe" | Select-Object -First 1

if ($Launcher) {
    Write-Host "Opening TaC-_-9s PC Optimization Tools..." -ForegroundColor Green
    Start-Process $Launcher.FullName
} else {
    Write-Host "Launcher EXE was not found. Opening app folder..." -ForegroundColor Yellow
    Start-Process explorer.exe $ExtractPath
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
