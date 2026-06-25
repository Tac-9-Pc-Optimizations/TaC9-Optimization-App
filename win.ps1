Write-Step "Searching for launcher..."

$Launcher = Get-ChildItem $ExtractPath -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object {
        $_.Name -match "TaC9 Launcher\.exe|TaC.*Launcher.*\.exe|Launcher\.exe"
    } |
    Sort-Object FullName |
    Select-Object -First 1

if ($Launcher) {
    Write-Good "Launcher found:"
    Write-Host $Launcher.FullName -ForegroundColor Green

    Write-Step "Creating Desktop launcher shortcut..."

    try {
        # Shortcut name on Desktop
        $ShortcutPath = Join-Path $DesktopDir "TaC-_-9s Launcher.lnk"

        # Remove old shortcut if it exists
        if (Test-Path $ShortcutPath) {
            Remove-Item $ShortcutPath -Force -ErrorAction SilentlyContinue
        }

        # Create shortcut
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
