$ErrorActionPreference = 'Stop'

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
} catch {}

$appName = 'TaC9 PC Optimization Suite'
$downloadUrl = 'https://github.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/releases/latest/download/TaC9-PC-Optimization-Suite.exe'
$installDirectory = Join-Path $env:LOCALAPPDATA 'TaC9\App'
$installedExe = Join-Path $installDirectory 'TaC9-PC-Optimization-Suite.exe'
$pendingExe = Join-Path $env:TEMP ('TaC9-PC-Optimization-Suite-{0}.exe' -f [Guid]::NewGuid().ToString('N'))

try {
    Write-Host "Downloading $appName..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force -Path $installDirectory | Out-Null
    Invoke-WebRequest -Uri $downloadUrl -OutFile $pendingExe -UseBasicParsing

    if (-not (Test-Path -LiteralPath $pendingExe -PathType Leaf) -or (Get-Item -LiteralPath $pendingExe).Length -lt 1MB) {
        throw 'The downloaded application is missing or incomplete.'
    }

    Unblock-File -LiteralPath $pendingExe -ErrorAction SilentlyContinue
    $verification = Start-Process -FilePath $pendingExe -ArgumentList '--verify' -WindowStyle Hidden -Wait -PassThru
    if ($verification.ExitCode -ne 0) {
        throw "TaC9 package verification failed with exit code $($verification.ExitCode)."
    }

    Move-Item -LiteralPath $pendingExe -Destination $installedExe -Force

    $desktop = [Environment]::GetFolderPath('Desktop')
    $shortcutPath = Join-Path $desktop 'TaC9 PC Optimization Suite.lnk'
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $installedExe
    $shortcut.WorkingDirectory = $installDirectory
    $shortcut.IconLocation = "$installedExe,0"
    $shortcut.Description = 'Launch TaC9 PC Optimization Suite'
    $shortcut.Save()

    Write-Host 'Verified download complete. Opening TaC9...' -ForegroundColor Green
    Start-Process -FilePath $installedExe -WorkingDirectory $installDirectory -Verb RunAs
} catch {
    Write-Host "TaC9 installation failed: $($_.Exception.Message)" -ForegroundColor Red
    throw
} finally {
    Remove-Item -LiteralPath $pendingExe -Force -ErrorAction SilentlyContinue
}
