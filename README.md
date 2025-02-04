# My config / dotfiles

Managed by [chezmoi](https://www.chezmoi.io/)

## Installation

Install the following apps/tools. Prefer to use winget if available, if not use chocolatey

- Powershell 7 (winget)
- [Autohotkey v2](https://www.autohotkey.com/) (exe)
- [Yasb](https://github.com/amnweb/yasb). Run it and enable autostart
- [Komorebi](https://lgug2z.github.io/komorebi/installation.html). Make a startup script with target: "C:\Program Files\komorebi\bin\komorebic.exe" start --ahk
- Voidtools [everything](https://www.voidtools.com/downloads/) and [everything powertoys plugin](https://github.com/lin-ycv/EverythingPowerToys/wiki). I used exe for both, but try winget
- [Chezmoi](https://www.chezmoi.io/install/) (winget). Add watchman with startup script for auto applying config changes. Add chezmoi startup script if not added automatically. Need my own command for watchman since it shows for bash so translate to powershell with an LLM
- [Neovim with nvchad](https://nvchad.com/docs/quickstart/install/)
- [Wezterm](https://wezfurlong.org/wezterm/install/windows.html) (winget)

### Environment variables (in windows)

```ts
KOMOREBI_AHK_EXE = "C:/Program Files/AutoHotkey/v2/AutoHotkey64"
KOMOREBI_CONFIG_HOME = "C:\Users\erlen\.config\komorebi"
```
- Make sure to add powershell 7 to path and remove system32 powershell path

### Other stuff I use, but doesn't have a config file in this repo

- nvm, pnpm, pyenv, pip

## Resources (docs)
### Window manager and statusbar
- [komorebi](https://lgug2z.github.io/komorebi/)
- [yasb](https://github.com/amnweb/yasb)
### Terminal
- [wezterm](https://wezfurlong.org/wezterm/index.html)
- [oh-my-posh](https://ohmyposh.dev/docs/installation/windows)
### Misc QoL
- [autohotkey](https://www.autohotkey.com/docs/v2/)
