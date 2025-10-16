# Aliases
Set-Alias -Name "p" -Value "pnpm"
Set-Alias -Name "lg" -Value "lazygit"
Set-Alias docker-start "C:/Program Files/Docker/Docker/Docker Desktop.exe"

# shortcut functions
function e {
	exit
}
function c {
	cls
}
function n {
  nvim .
}
function wssh {
  wezterm connect SSHMUX:$args
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
oh-my-posh init pwsh --config "$home/.config/amro.omp.json" | Invoke-Expression

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

# ZOXIDE
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Set-Alias cd z -Option AllScope
