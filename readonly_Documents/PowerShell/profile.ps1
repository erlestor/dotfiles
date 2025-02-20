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
# this was supposed to help when I open a new tab after writing "d" and it not updating cwd
function cd-nvim {
  param (
      [string]$directory
  )
  cd $directory

# Manually emit the OSC 7 sequence
# this is for the terminal to know the cwd. so wezterm can use it when creating a new tab
# doesnt fully work tho
  $cwd = Get-Location
  $osc7 = "`e]7;file://$($env:COMPUTERNAME)$($cwd.Path.Replace('\', '/'))`a"
  Write-Host -NoNewline $osc7

  nvim .
}
function d {
  cd-nvim $HOME\Documents\Koding\cot\deploii
}
# CONFIGS
$config = "$HOME/.local/share/chezmoi"
# powershell
function pwshc {
  cd $config/readonly_Documents/PowerShell
  nvim profile.ps1
}
function nvimc {
	cd-nvim $config/AppData/local/nvim
}
# wezterm config
function termc {
	cd-nvim $config/dot_config/wezterm
}
# autohotkey
function ahkc {
  cd "$config/AppData/Roaming/Microsoft/Windows/readonly_Start Menu/readonly_Programs/readonly_Startup"
  nvim hotkeys.ahk
}
# komorebi wm config
function komoc {
  cd-nvim $config/dot_config/komorebi
}
# yasb statusbar config
function yasbc {
  cd-nvim $config/dot_config/yasb
}
function chezmoic {
  cd-nvim $config
}
function chezmoicd {
  cd $config
}
function sshdc {
  cd c:/programdata/ssh
  nvim sshd_config
}
function lazygitc {
  cd $config/appdata/local/lazygit
  nvim config.yml
}
function cdStartup {
  cd "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
}

# Aliases
Set-Alias -Name "p" -Value "pnpm"
Set-Alias docker-start "C:/Program Files/Docker/Docker/Docker Desktop.exe"

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

