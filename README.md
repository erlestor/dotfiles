# Dotfiles

- Here I put all the configuration files that stray away from defaults
- This repo is made to be put inside the $home/.config folder
- Used on windows 11 and linux (omarchy)

## Tanker om å forbedre readme her
- æ gjør jo litt custom setup for ting som ikke e i dotfiles repo. så langt har æ holdt instruka te ting i dotfiles only
- men typ. det å sett opp obsidian, ssh osv e jo litt ekstra ass. kan jo ha sånn "ekstra" seksjon med bonus ting
- for ssh kan æ jo ha ssh config her. også en felles key for alle datamaskinan og serveran æ ska ssh te. så alt æ treng å gjør e å bare flytt den key'n over te ny pc
- hadd vært litt sick å ha .sh script for å intaller alt æ treng. slipp å dokumenter i readme da. ulempe e at det må maintaines hvis æ endre på ka æ bruke eller package endre installation method. men tbh det hold sæ jo for det meste likt uansett
- gidde virkelig ikke chezmoi selv om det hadd løst non problema. stow også i guess, men ærig talt. kor mange ting må æ endre på utafor .config?

## Mac
- make this pretty later
- same instructions as for omarchy for cloning dotfiles. honestly tho can just clone directly and rename folder because no .config folder exists on mac by default
- installed neovim. follow lazyvim instructions for requirements. all the things are just "brew install X". no flags. same for nerd font. alacritty installed through .dmg file
- i installed aerospace, zen and linearmouse. add configs to dotfiles repo btw
- i switched caps lock to escape
- changed some settings too, but not many tbh. not so important yet. hide dock, turned off lower screen brightness on low battery
- installed mise en place with the shell script. and installed npm pnpm and node globally (npm is needed for Mason in neovim (lsp))
- there are some problems with sharing config with omarchy, but not that i notice really. Themeing. In .local/state/omarchy/current/theme there aer some files that omarchy uses and includes in configs. So for neovim and alacritty etc. not important, but i might just import those for styling. keybinds are weird. like i bind ctrl or alt to stuff on linux, but doesnt make sense on mac. idk. lets just get the general setup first. mvp.
- installed tmux (brew install tmux). og sesh (brew install sesh)
- installert docker med colima: (brew install docker og brew install colima og brew services start colima)

### IKKE SLETT NOKKA HERFRA FØR DU HAR DOKUMENTERT DET OVER
### Todo viktig

- legg te linearmouse config te dotfiles
- sett opp deploii ting
  - mangle ssh te server, mail, teams
- sett opp propulse progging
  - logg inn på gitlab, slack osv
  - clone propulse-intern repo. kopier .env og sql dump fra gamle laptop. kjør pg kommando for å loade inn sql fila i postgres container
- sett opp skole ting
  - ripes.dk web app, logg inn på ting, mail, vpn? (treng ikke på laptop da)
- sett opp bindings for å launche apps med enkel keybinds
  - discord, spotify

### Todo mindre viktig
- sjekk ut OmniVM. Ser bedre ut. Bare teste. ønske spesifikt at det ska se smoother ut og vær litt rasker (spamme terminala på aerospace, ser helt fucked ut)
- installer lazydocker. for å manage volumes og images som ikke blir brukt osv
- bruk samme ls som i omarchy. den e vakker
- key repeat e for treigt i neovim f.eks.
- enten bruk bash på mac eller zsh på omarchy. i det minste legg .zshrc i .config og synce med dotfiles repo
- vil del custom config for prompt, aliases, osv.
- fikse litt på aerospace? hvis ikke omnivm e bedre
- se på artiklan på zen. flere gode tips der

## Omarchy

### Installation

- [oh-my-posh](https://ohmyposh.dev/docs/installation/linux) (pacman)

#### Dependencies

- sesh-bin (aur). for tmux sesh plugin
- entr (pacman). for tmux-autoreload

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

- Follow the installations instructions for [split-monitor-workspaces](https://github.com/zjeffer/split-monitor-workspaces#installation)

- Delete `~/.bashrc` and add the following line to `~/.bash_profile`

```bash
[[ -f ~/.config/.bashrc ]] && . ~/.config/.bashrc
```

- Run this to install tpm (tmux plugin manager) with `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`

- Load tmux plugins: open terminal and press "prefix + I"

#### NTNU VPN

- Install networkmanager-openconnect from pacman
- Install tray VPN plugin `omarchy plugin add https://github.com/jkoestinger/omarchy-vpn.git --enable`
- Add the following with `sudo nvim /etc/NetworkManager/system-connections/NTNU-VPN.nmconnection`

```
[connection]
id=NTNU-VPN
uuid=cd280eb7-4b51-47c7-bcb8-6ce6951bb721
type=vpn
autoconnect=false

[vpn]
authtype=password
autoconnect-flags=0
certsigs-flags=0
cookie-flags=2
disable_udp=no
enable_csd_trojan=no
gateway=vpn2.ntnu.no
gateway-flags=2
gnutls_priorities=NORMAL:-VERS-ALL:+VERS-TLS1.2
gwcert-flags=2
lasthost-flags=0
pem_passphrase_fsid=no
prevent_invalid_cert=no
protocol=anyconnect
resolve-flags=2
stoken_source=disabled
useragent=AnyConnect Linux
usergroup=SSO
service-type=org.freedesktop.NetworkManager.openconnect

[vpn-secrets]
lasthost=vpn2.ntnu.no

[ipv4]
method=auto

[ipv6]
addr-gen-mode=stable-privacy
method=auto

[proxy]
```

- Add the following with `sudo nvim /etc/gnutls/config`

```
[overrides]
disable-version = tsl1.0
disable-version = tsl1.1
disable-version = tsl1.3
```

- If still not working: reboot pc

#### MCSR

- Install [hyprmcsr](https://github.com/Relacibo/hyprmcsr/blob/main/docs/001-install-and-setup.md), prismlauncher (pacman) and [keyd](https://github.com/rvaiya/keyd) (pacman)
- Follow keyd instructions closely. And restart after usermod command
- This is my /etc/keyd/default.conf:

```conf
[ids]

*

[main]
```

- Set up your instance
- Set up ninjabrainbot. See [this video](https://www.youtube.com/watch?v=l1Z2t9e6Qko) for boat eye settings
- If sensitivity setting doesn't work. Install solaar and see: [this issue](https://github.com/pwr-Solaar/Solaar/issues/3073#issuecomment-3707125179). Just one command is needed
- My window rules in hyprland and commands in hyprmcsr config are very specific. So double check those

#### Fix mongodb compass not saving passwords

- Run:

```bash
cp /usr/share/applications/mongodb-compass.desktop ~/.local/share/applications/mongodb-compass.desktop
nvim ~/.local/share/applications/mongodb-compass.desktop
```

- Change the Exec line to:

```bash
Exec=mongodb-compass --password-store=gnome-libsecret --ignore-additional-command-line-flags %U
```

#### Arduino IDE setup

- Install arduino-ide-bin (pacman)
- Follow section 2.1 in the [arch wiki](https://wiki.archlinux.org/title/Arduino#Accessing_serial)
- Run:

```bash
cp /usr/share/applications/arduino-ide-v2.desktop ~/.local/share/applications/arduino-ide-v2.desktop
nvim ~/.local/share/applications/arduino-ide-v2.desktop
```

- Change the Exec line to:

```bash
Exec=arduino-ide %U --ozone-platform=x11
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
