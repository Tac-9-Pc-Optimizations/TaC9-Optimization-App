# TaC-_-9s PC Optimization Suite

TaC-_-9s PC Optimization Suite is an all-in-one Windows app made for gaming PCs, fresh Windows installs, and anyone who wants an easier way to optimize their PC or install the TaC9 Call of Duty configuration.

Everything is together in one launcher so you do not have to search through folders for each tool.

## Latest Update: 11.2.0.45

- Fixed Personal Settings so Explorer-related changes no longer open repeated This PC windows; the shell-only refresh is safely deferred until the required restart
- Fixed Fresh Open ISLC and Open ISLC so a saved start-minimized setting cannot leave the real ISLC window hidden
- Updated ISLC free-memory presets to 15000 MB for 32 GB RAM and 30000 MB for 64 GB RAM
- Moved Check for Updates onto the same aligned row as Save Key, Show HWID, and Clear Key
- Replaced the retired NVIDIA profile with the approved 616.56 full-driver profile
- Added an Apply NPI Profile Only button beside Automatic Normal Install in the GPU app
- Clean first visible frame for both the protected suite and Windows Optimization App
- Full launcher and Windows card layouts are prepared before either window is revealed
- Removed automatic startup warning popups and competing first-launch layout passes
- Guarded app buttons that prevent accidental duplicate launches
- Faster Windows system information and incremental live-setting checks
- Smoother scrolling and repainting in the Windows Optimization App
- Real Windows-reported DISM RestoreHealth and SFC /scannow percentages
- A redesigned progress window with wrapped, aligned text at standard and minimum sizes
- Reliable Personal Settings worker exit codes, saved diagnostics, and full process-tree cancellation
- Restart remains opt-in and requires an explicit Yes selection

## Included Apps

### Windows Optimization App

Windows performance settings, cleanup tools, repair options, services, networking, storage, input, graphics, and power settings.

### GPU Optimization App

A step-by-step NVIDIA setup with GPU detection, clean driver guidance, NVIDIA Profile Inspector, the 616.56 profile, and a dedicated profile-only apply button.

### ISLC Setup App

Helps install and set up ISLC with RAM-specific presets and reliable foreground opening even when ISLC is configured to start minimized.

### Debloat App

Finds Windows apps and system components and lets you choose what you want to remove. After the normal uninstallers finish, TaC9 can scan all selected apps together for leftover files, folders, shortcuts, registry entries, services, and scheduled tasks.

The advanced review window preselects only high-confidence owned leftovers and includes Select Recommended, Select All, and Clear controls. Shared or uncertain matches remain unchecked by default, protected Windows areas are excluded, duplicate results are combined, and registry or scheduled-task changes require a verified backup before removal.

### COD Config Installer

Installs the embedded TaC9 Call of Duty player configuration for the Xbox App or Battle.net version, clears only the selected installation's validated shader cache, and keeps a first-seen backup for one-click restore. The utility is included in the suite and does not require a suite license key.

## Features

- One TaC-_-9s launcher for all five apps
- Saves your license key
- Windows and system information
- Gaming and performance options
- Windows repair and cleanup tools
- Live DISM and SFC repair percentages reported directly by Windows
- NVIDIA optimization guide
- ISLC setup options
- Windows app debloat and cleanup
- Reviewed multi-app leftover cleanup with duplicate detection and safety exclusions
- Cleanup manifests plus required registry and scheduled-task backups
- Xbox App and Battle.net COD configuration installer
- Guarded Call of Duty shader-cache cleanup and original-file restore
- Check for Updates button
- TaC-_-9s themed interface and icons

## Quick Install

Open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/main/win.ps1 | iex
```

This downloads the newest TaC-_-9s app, creates a Desktop shortcut, and opens it.

## Manual Download

[Download the latest TaC9 PC Optimization Suite EXE](https://github.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/releases/latest/download/TaC9-PC-Optimization-Suite.exe)

Run the app as Administrator after downloading it.

## How to Use

1. Download or install the app.
2. Run the app as Administrator.
3. Enter and save your license key for the licensed optimization apps. The COD Config Installer and Socials buttons do not require it.
4. Choose the app you want to use.
5. Follow the steps and descriptions inside each app.

## Important

- Always run the app as Administrator.
- Some Windows changes may require a restart.
- Create a restore point before making major system changes.
- The GPU app is made for NVIDIA GPUs.
- Close Call of Duty before installing, restoring, or clearing its shader cache.
- Read the descriptions before applying settings or removing apps.

## Support

For purchases, license help, HWID resets, or support, make a ticket in the TaC-_-9s Discord.

## Screenshots

<img width="1254" height="1254" alt="TaC9 PC Optimizations Emblem" src="https://github.com/user-attachments/assets/04b6dffe-3f7d-4ace-82a0-41dc5f2f0a66" />

<img width="1255" height="746" alt="TaC9 Windows Optimization" src="https://github.com/user-attachments/assets/b3aa48b4-c96b-4046-a9c5-4a8ddb9aa10a" />

<img width="1253" height="1370" alt="TaC9 GPU Optimization" src="https://github.com/user-attachments/assets/f9dca483-f7e3-49ed-b7f9-11a91d63be0e" />

<img width="1265" height="1373" alt="TaC9 ISLC Setup" src="https://github.com/user-attachments/assets/4ad70eae-dcf8-45fd-8730-1baa92c402a4" />

<img width="2550" height="1331" alt="TaC9 Debloat App" src="https://github.com/user-attachments/assets/f942dea5-c890-4fa4-af18-a798520cf9cb" />

### Live DISM and SFC Progress

![TaC9 Windows Optimization showing live DISM progress reported by Windows](docs/screenshots/live-dism-sfc-progress.png)

### COD Config Installer

![TaC9 COD Config Installer Xbox App view](docs/screenshots/cod-config-installer.png)
