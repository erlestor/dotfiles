# Dotfiles

- Here I put all the configuration files that stray away from defaults
- This repo is made to be put inside the $home/.config folder
- Used on windows 11 and linux (omarchy)

## Omarchy

### Installation

- [Wezterm](https://wezterm.org/install/linux.html#__tabbed_1_7) (pacman)
- [oh-my-posh](https://ohmyposh.dev/docs/installation/linux) (pacman)
- [split-workspaces](https://github.com/zjeffer/split-monitor-workspaces) (hyprpm)

### Setup

- Clone this repo into `~/.config`

```bash
git clone https://github.com/erlestor/dotfiles /tmp/dotfiles-tmp # Clone to a temp location
mv /tmp/dotfiles-tmp/.git ~/.config/ # Drop the .git folder into .config — making it the repo
cd ~/.config
git status # Preview what git sees before touching anything
git reset --hard HEAD # Overwrite tracked files with repo versions, leave everything else alone
rm -rf /tmp/dotfiles-tmp # Clean up the temp dir
```

- Install these packages: cpio, cmake, git, meson and gcc
- Run these commands

```bash
hyprpm add https://github.com/zjeffer/split-monitor-workspaces # Add the plugin repository
hyprpm enable split-monitor-workspaces # Enable the plugin
hyprpm reload # Reload the plugins
```

- Delete `~/.bashrc` and add the following line to `~/.bash_profile`

```bash
[[ -f ~/.config/.bashrc ]] && . ~/.config/.bashrc
```

#### MCSR

- Install [hyprmcsr](https://github.com/Relacibo/hyprmcsr/blob/main/docs/001-install-and-setup.md), prismlauncher (pacman) and keyd (pacman)
- Add a default.conf to /etc/keyd with this:

```conf
[ids]

*

[main]
```

- Set up your instance
- If sensitivity setting doesn't work. Install solaar and see: [this issue](https://github.com/pwr-Solaar/Solaar/issues/3073#issuecomment-3707125179)

#### Fix mongodb compass not saving passwords

Run

```bash
cp /usr/share/applications/mongodb-compass.desktop ~/.local/share/applications/mongodb-compass.desktop
nvim ~/.local/share/applications/mongodb-compass.desktop
```

Change the Exec line to

```bash
Exec=mongodb-compass --password-store=gnome-libsecret --ignore-additional-command-line-flags %U
```

## Windows

### Installation

Prefer winget if you can

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

### Setup

- Clone this repo into ´~/.config´
- Make sure to add powershell 7 to path and remove system32 powershell path
- Add these environment variables (via windows search -> environment variables):

```ts
KOMOREBI_AHK_EXE = "C:/Program Files/AutoHotkey/v2/AutoHotkey64";
KOMOREBI_CONFIG_HOME = "C:\Users\erlen\.config\komorebi";
```

- Make these soft symlinks (delete any file/folder which exists already at that location):

```txt
~/.config/nvim -> ~/appdata/local/nvim
~/.config/powershell/profile.ps1 -> ~/documents/powershell/profile.ps1
~/.config/windows-startup/hotkeys.ahk -> ~/appdata/roaming/microsoft/windows/start menu/programs/startup/hotkeys.ahk
```

#### How to symlink

Open powershell as administrator and run:

```powershell
New-Item -ItemType SymbolicLink -Path c:/users/xxx/xxx -Target c:/users/xxx/.config/xxx
```
