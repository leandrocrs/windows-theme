# windows-theme
> Powershell module to easily switch between Windows 10 Light and Dark themes.

![CI](https://github.com/leandrocrs/windows-theme/workflows/CI/badge.svg?branch=master)
![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/windows-theme.svg)

![windows-theme logo](./assets/icon.png "windows-theme logo, a square sliced in two pieces, one light and other dark colored")

## Requirements
* Windows 10
* Powershell version 5 or higher or Powershell core

## Install

First, [see the instructions to enable PSGallery repository in PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/gallery/overview), then proceed to `windows-theme` module instalation. 

Open a powershell terminal and enter de following command:
```powershell
Install-Module -Name windows-theme
```

## Usage
```powershell
Get-WindowsTheme # show what theme config is in use for system and apps
win-theme-default # enable default theme (dark bar, light apps). Same as Use-WindowsDefaultTheme
win-theme-inverted # enable inverted theme (light bar, dark apps). Same as Use-WindowsInvertedTheme
win-theme-light # enable light theme. Same as Use-WindowsLightTheme
win-theme-dark # enable dark theme. Same as Use-WindowsDarkTheme
Set-WindowsTheme -System dark -Apps light # set -System and -Apps theme separately
Get-WindowsAppsTheme # show theme in use for apps
Set-WindowsAppsTheme dark # set theme for apps only
Get-WindowsSystemTheme # show theme in use for system only
Set-WindowsSystemTheme light # set theme for system only
```

Possible values for params are: `light` or `dark`.

## Themes

### win-theme-default

![print of windows with win-theme-default applied](./assets/win-theme-default.png "Windows print with dark taskbar and light theme for apps")

### win-theme-light

![print of windows with win-theme-light applied](./assets/win-theme-light.png "Windows print with light theme for taskbar and apps")

### win-theme-dark

![print of windows with win-theme-dark applied](./assets/win-theme-dark.png "Windows print with dark theme for taskbar and apps")

### win-theme-inverted

![print of windows with win-theme-inverted applied](./assets/win-theme-inverted.png "Windows print with light taskbar and dark theme for apps")
