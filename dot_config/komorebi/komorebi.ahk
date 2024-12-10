#Requires AutoHotkey v2.0.2
#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}


!q::Komorebic("close")
!m::Komorebic("minimize")

; Focus windows
!h::Komorebic("focus left")
!j::Komorebic("focus down")
!k::Komorebic("focus up")
!l::Komorebic("focus right")

!+[::Komorebic("cycle-focus previous")
!+]::Komorebic("cycle-focus next")

; Focus displays
!a::Komorebic("cycle-monitor previous")
!d::Komorebic("cycle-monitor next")

; Move windows
!+h::Komorebic("move left")
!+j::Komorebic("move down")
!+k::Komorebic("move up")
!+l::Komorebic("move right")

; Move windows to display
!+a::Komorebic("cycle-move-to-monitor previous")
!+d::Komorebic("cycle-move-to-monitor next")

; Stack windows
!+u::Komorebic("stack left")
!+i::Komorebic("stack down")
!+o::Komorebic("stack up")
!+p::Komorebic("stack right")
!p::Komorebic("unstack")
!u::Komorebic("cycle-stack previous")
!i::Komorebic("cycle-stack next")
!s::Komorebic("toggle-window-container-behaviour")

; Resize
!=::Komorebic("resize-axis horizontal increase")
!-::Komorebic("resize-axis horizontal decrease")
!+=::Komorebic("resize-axis vertical increase")
!+_::Komorebic("resize-axis vertical decrease")

; TODO: usable keybinds for resizing

; Manipulate windows
!t::Komorebic("toggle-float")
!f::Komorebic("toggle-monocle")

; Window manager options
!+r::Komorebic("retile")
;!p::Komorebic("toggle-pause")

; Layouts
!x::Komorebic("flip-layout horizontal")
!y::Komorebic("flip-layout vertical")
!c::Komorebic("cycle-layout next")

; Workspaces
!1::Komorebic("focus-workspaces 0")
!2::Komorebic("focus-workspaces 1")
!3::Komorebic("focus-workspaces 2")

; Move windows across workspaces
!+1::{
  Komorebic("move-to-workspace 0")
  Komorebic("focus-workspaces 0")
}
!+2::{
  Komorebic("move-to-workspace 1")
  Komorebic("focus-workspaces 1")
}
!+3::{
  Komorebic("move-to-workspace 2")
  Komorebic("focus-workspaces 2")
}


; Open applications. Using RAlt which is AltGr on my corsair keyboard
RAlt & t::Run "C:\Program Files\WezTerm\wezterm-gui.exe"
RAlt & a::{
  if WinExist("ahk_exe Arc.exe") {
      ; If Arc is running, activate it and send the New Window shortcut
      WinActivate("ahk_exe Arc.exe")
      Send("^n") ; Adjust this to Arc's actual shortcut for new window
  } else {
      ; If Arc is not running, start it
      Run("Arc.exe")
  }
}
;RAlt & LShift & d::Run "discord.exe"
RAlt & s::Run "spotify.exe"
RAlt & d::Run "C:/Program Files/Docker/Docker/Docker Desktop.exe"
RAlt & p::Run "C:/Users/erlen/AppData/Local/Postman/Postman.exe"
RAlt & m::Run "C:/Users/erlen/AppData/Local/MongoDBCompass/MongoDBCompass.exe"
RAlt & o::Run "C:/Users/erlen/AppData/Local/Programs/Obsidian/Obsidian.exe"

