# SHORTCUT FUNCTIONS
function e {
	exit
}
function c {
	cls
}
# open repositories/files
function d {
	cd $HOME\Documents\Koding\cot\deploii
  nvim .
}
# powershell
function pwshc {
	nvim $PROFILE
}
function nvimc {
	cd $HOME/AppData/local/nvim
  nvim .
}
# wezterm config
function termc {
	cd $HOME/.config/wezterm
  nvim .
}
# autohotkey
function ahkc {
  cd "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
  nvim hotkeys.ahk
}
# komorebi wm config
function komoc {
  cd $HOME/.config/komorebi
  nvim .
}
# yasb statusbar config
function yasbc {
  cd $HOME/.config/yasb
  nvim .
}
function yasbstart {
  cd "/Program Files/yasb-main"
  python src/main.py
}

# KOMOREBI
$Env:KOMOREBI_CONFIG_HOME = "C:\Users\erlen\.config\komorebi"
$Env:KOMOREBI_AHK_EXE = "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# OH MY POSH PROMPT
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\amro.omp.json" | Invoke-Expression

# AUTO COMPLETE
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
#Set-PSReadLineOption -PredictionSource History
