#Requires AutoHotkey v2.0-a

; ---------------------------------------------------------------------------------------------------------
; Open applications

LWin & Enter::Run "C:\Program Files\WezTerm\wezterm-gui.exe"
LWin & b::Run "zen.exe"
LWin & m::Run "spotify.exe"
LWin & d::Run "C:\Users\erlen\AppData\Local\Discord\app-1.0.9212\Discord.exe"
; LWin & LShift & d::Run "C:\Program Files\Docker\Docker\Docker Desktop.exe"
LWin & f::Run "explorer.exe"

; ---------------------------------------------------------------------------------------------------------
; Minecraft speedrunning

#HotIf WinActive("ahk_exe javaw.exe")
; Misc shit rly
XButton2::F3
z::F3
h::0
<::h
Alt::Esc
; To walk while using f3 menu without triggering commands
; Avoid a,d,b,g,c
; a::j
; d::m
; Testing search craft
; we need. b,e,a,w,o
q::i
e::o
s::e
d::b
f::k
g::d
z::p
; Also avoid f3 conflicts when walking. problem for left (a) and right (d/b)
XButton2 & a::a
; For ground zero
Numpad1::MButton
Numpad2::RButton
#HotIf
