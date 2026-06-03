# TaC-_-9s PC Optimization Tools

**TaC-_-9s PC Optimization Tools** is a Windows optimization toolkit made for customers who want a cleaner, smoother, and more gaming-focused PC setup.

This app is designed for gaming performance, high FPS setups, NVIDIA GPU optimization guidance, Windows repair tools, and safer customer-friendly optimization workflows.

---

## Features

### Main PC Optimization App

* Clean customer launcher
* License key activation
* Saves the customer license key to Desktop after clicking **Save Key**
* Main system info dashboard
* Status / app access display
* Customer-friendly popups and progress status
* TaC-_-9s blue/yellow themed UI

---

## Windows Optimization Tools

The Windows optimization section includes performance-focused options for gaming PCs, while keeping important customer functionality safer.

Includes:

* Windows performance tweaks
* Cleanup tools
* Service management
* Restore point support
* TaC-_-9s Apply All workflow
* Dual-PC / VPN safe protections
* Windows Image Repair section
* Network Repair / Reset section

---

## Windows Image Repair

The **Windows Image Repair** section includes repair tools for fixing common Windows issues.

Included tools:

* DISM RestoreHealth
* SFC Scannow
* Windows Update Reset
* Microsoft Store Repair
* Xbox App Repair
* Visual C++ Runtime Installer
* DirectX Runtime Installer

DISM and SFC now show clearer results after running, such as:

* Clean
* Repaired
* Violations remain
* Warning / check logs

---

## Network Repair / Reset

The app includes a separate **Network Repair / Reset** category.

### Dual-PC / VPN Safe Network Repair

This option is safer for customers using:

* Dual-PC streaming setups
* VPNs
* OBS / NDI / Teleport
* Voicemeeter / VBAN
* LAN sharing
* Streaming tools

It only performs light network cache cleanup:

* Flush DNS
* Clear DNS client cache
* Clear ARP cache

### Full Network Reset

A stronger reset option is also included for customers with more serious network issues.

This option should be used carefully because stronger network resets may require a restart and may affect custom VPN/network settings.

---

## GPU Optimization App

The GPU app is made for **NVIDIA GPUs only**.

Features:

* NVIDIA GPU detection
* VRAM detection fix
* Driver version display
* GPU info card
* Step progress tracker
* Customer-friendly step descriptions
* NVIDIA-only warning if no NVIDIA GPU is detected
* NVIDIA Profile Inspector step
* NVIDIA Control Panel guidance
* NVCleanstall / DDU guidance
* GPU optimization workflow

If an AMD-only or Intel-only GPU is detected, the NVIDIA guide will warn the customer that this guide is for NVIDIA GPUs only.

---

## Dual-PC Streaming Safe Services

This build protects important services that may be needed for streaming setups, LAN discovery, VPNs, and network sharing.

Protected services include:

* Function Discovery Provider Host
* Function Discovery Resource Publication
* SSDP Discovery
* UPnP Device Host
* Network Location Awareness
* Network List Service
* Server
* Workstation
* IP Helper
* DNS Client
* DHCP Client

These services are skipped so the app does not break dual-PC streaming, VPN, or local network discovery setups.

---

## ASUS / Armoury Service Protection

ASUS, Aura, and Armoury-related services are skipped to prevent freezing or service control issues on some systems.

The app avoids touching ASUS/Aura/Armoury services during service changes.

---

## Requirements

* Windows 10 or Windows 11
* Run as Administrator
* Internet connection for license check and online tools
* Valid TaC-_-9s license key
* NVIDIA GPU recommended for GPU optimization app

---

## How to Download

Open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/main/win.ps1 | iex
```

This downloads the latest release build and opens the app.

---

## Manual Download

You can also download the ZIP from the latest GitHub release:

```text
https://github.com/Tac-9-Pc-Optimizations/TaC9-Optimization-App/releases/latest/download/TaC-_-9s_PC_Opti.zip
```

After downloading:

1. Extract the ZIP
2. Open the extracted folder
3. Run the launcher
4. Enter your license key
5. Click **Save Key**

After saving the key, the app creates a Desktop file named:

```text
TaC-_-9s License Key.txt
```

This file contains the customer’s license key for future use.

---

## Important Notes

* Always run the app as Administrator.
* Create a restore point before making major system changes.
* Some repairs may require a restart.
* Network reset tools can temporarily disconnect internet.
* Full network resets should be avoided during remote sessions.
* GPU optimization guide is for NVIDIA GPUs only.
* Dual-PC streamers should use the Dual-PC / VPN safe options when possible.

---

## Support

For license help, HWID resets, support, or optimization services, create a ticket in the TaC-_-9s Discord.

**TaC-_-9s PC Optimizations**
High FPS • Low Input Lag • Gaming Performance

---

## Disclaimer

This tool changes Windows settings, runs repair commands, and guides driver optimization steps. Use only if you understand the changes being applied. TaC-_-9s PC Optimizations is not responsible for issues caused by unsupported systems, incorrect usage, interrupted repairs, unstable overclocks, or third-party software conflicts.

