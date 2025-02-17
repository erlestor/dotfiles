# SHORTCUT FUNCTIONS
function e {
	exit
}
function c {
	cls
}
function wssh {
  wezterm connect SSHMUX:$args
}
# open repositories/files
function d {
	cd $HOME\Documents\Koding\cot\deploii
  nvim .
}
# CONFIGS
$config = "$HOME/.local/share/chezmoi"
# powershell
function pwshc {
  cd $config/readonly_Documents/PowerShell
  nvim profile.ps1
}
function nvimc {
	cd $config/AppData/local/nvim
  nvim .
}
# wezterm config
function termc {
	cd $config/dot_config/wezterm
  nvim .
}
# autohotkey
function ahkc {
  cd "$config/AppData/Roaming/Microsoft/Windows/readonly_Start Menu/readonly_Programs/readonly_Startup"
  nvim hotkeys.ahk
}
# komorebi wm config
function komoc {
  cd $config/dot_config/komorebi
  nvim .
}
# yasb statusbar config
function yasbc {
  cd $config/dot_config/yasb
  nvim .
}
function chezmoic {
  cd $config
  nvim .
}
function sshdc {
  cd c:/programdata/ssh
  nvim sshd_config
}
function cdStartup {
  cd "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
}

# KOMOREBI
$Env:KOMOREBI_CONFIG_HOME = "C:\Users\erlen\.config\komorebi"
$Env:KOMOREBI_AHK_EXE = "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"

# CHOCOLATEY
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# OH MY POSH PROMPT
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\amro.omp.json" | Invoke-Expression

# IDK
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle Inline

# OTHER HOTKEYS
Set-PSReadLineKeyHandler -Chord Ctrl+u -Function PreviousHistory
Set-PSReadLineKeyHandler -Chord Ctrl+i -Function NextHistory
Set-PSReadLineKeyHandler -Key Tab -Function AcceptSuggestion

# Set default editor for lazygit. doesnt work lmao
$env:EDITOR = "nvim"

# Aliases
Set-Alias -Name "p" -Value "pnpm"
