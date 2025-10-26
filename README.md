# Dotfiles

- Here I put all the configuration files that I share between machines.
- This repo is made to be put inside the $home/.config folder
- Used on windows 11 and linux (omarchy)

## Installation

Install the following apps/tools. Prefer winget on windows

### Windows

- [Neovim](https://nvchad.com/docs/quickstart/install/)
  - Follow instructions, up until nvchad specific config
  - Run `npm i -g tree-sitter-cli`
- [Wezterm](https://wezfurlong.org/wezterm/install/windows.html) (winget)
- Powershell 7 (winget)
- [Autohotkey v2](https://www.autohotkey.com/) (exe)
- [Yasb](https://github.com/amnweb/yasb)
  - Run and enable autostart
- [Komorebi](https://lgug2z.github.io/komorebi/installation.html)
  - Make a startup script with target: "C:\Program Files\komorebi\bin\komorebic.exe" start --ahk
- [everything](https://www.voidtools.com/downloads/) (I used exe, but try winget)
- [everything powertoys plugin](https://github.com/lin-ycv/EverythingPowerToys/wiki) (I used exe, but try winget)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (winget)
- [fzf](https://github.com/junegunn/fzf) (winget)
- [oh-my-posh](https://ohmyposh.dev/docs/installation/linux) (winget)

### Omarchy

- [Wezterm](https://wezterm.org/install/linux.html#__tabbed_1_7) (pacman)
- [oh-my-posh](https://ohmyposh.dev/docs/installation/linux) (pacman)

## Setup

### Windows

- Clone this repo into ´~/.config´
- Make sure to add powershell 7 to path and remove system32 powershell path
- Add these environment variables (via windows search -> environment variables):

```ts
KOMOREBI_AHK_EXE = "C:/Program Files/AutoHotkey/v2/AutoHotkey64";
KOMOREBI_CONFIG_HOME = "C:\Users\erlen\.config\komorebi";
```

- Make these soft symlinks (delete any file/folder which exists already at that location):

```
~/.config/nvim -> ~/appdata/local/nvim
~/.config/powershell/profile.ps1 -> ~/documents/powershell/profile.ps1
~/.config/windows-startup/hotkeys.ahk -> ~/appdata/roaming/microsoft/windows/start menu/programs/startup/hotkeys.ahk
```

### Linux

- Clone this repo into `~/.config`
- Point oh-my-posh to `~/.config/amro.omp.json` in `.bashrc`
- Delete `~/.bashrc` and add the following line to `~/.bash_profile`

```bash
[[ -f ~/.config/.bashrc ]] && . ~/.config/.bashrc
```

## Resources

### How to symlink (windows)

Open powershell as administrator and run:

```
New-Item -ItemType SymbolicLink -Path c:/users/xxx/xxx -Target c:/users/xxx/.config/xxx
```
