#Requires AutoHotkey v2.0-a

; ---------------------------------------------------------------------------------------------------------
; Open applications

LWin & Enter::Run "C:\Program Files\WezTerm\wezterm-gui.exe"
LWin & b::Run "zen.exe"
LWin & m::Run "spotify.exe"
LWin & d::Run "C:/Program Files/Docker/Docker/Docker Desktop.exe"
LWin & f::Run "explorer.exe"

; ---------------------------------------------------------------------------------------------------------
; Minecraft speedrunning

#HotIf WinActive("ahk_exe javaw.exe")
XButton2::F3
z::F3
h::0
<::h
Alt::Esc
; To walk while using f3 menu without triggering commands
a::j
s::k
d::m
; For ground zero
Numpad1::MButton
Numpad2::RButton
#HotIf
