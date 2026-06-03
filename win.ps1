$ErrorActionPreference = "Stop"

$ZipUrl = "https://github.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/releases/latest/download/TaC-_-9s_PC_Opti.zip"
$DownloadPath = "$env:USERPROFILE\Downloads\TaC-_-9s_PC_Opti.zip"
$ExtractPath = "$env:USERPROFILE\Desktop\TaC-_-9s PC Optimization Tools"

Write-Host "Downloading TaC-_-9s PC Optimization Tools..." -ForegroundColor Cyan

Invoke-WebRequest -Uri $ZipUrl -OutFile $DownloadPath

Write-Host "Download complete." -ForegroundColor Green
Write-Host "Extracting app to Desktop..." -ForegroundColor Cyan

if (Test-Path $ExtractPath) {
    Remove-Item $ExtractPath -Recurse -Force
}

Expand-Archive -Path $DownloadPath -DestinationPath $ExtractPath -Force

Get-ChildItem $ExtractPath -Recurse | Unblock-File -ErrorAction SilentlyContinue

$Launcher = Get-ChildItem $ExtractPath -Recurse -Filter "TaC9 Launcher.exe" | Select-Object -First 1

if ($Launcher) {
    Write-Host "Opening TaC-_-9s PC Optimization Tools..." -ForegroundColor Green
    Start-Process $Launcher.FullName
} else {
    Write-Host "App extracted, but launcher EXE was not found. Opening folder..." -ForegroundColor Yellow
    Start-Process explorer.exe $ExtractPath
}
