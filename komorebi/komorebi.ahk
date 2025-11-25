#Requires AutoHotkey v2.0.2
#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

; Disable in mc
#HotIf WinActive("ahk_exe javaw.exe")
!w::return
!a::return
!s::return
!d::return
!v::return
LWin & w::return
#HotIf

LWin & w::Komorebic("close")
!m::Komorebic("minimize")

; Focus windows
!h::Komorebic("focus left")
!j::Komorebic("focus down")
!k::Komorebic("focus up")
!l::Komorebic("focus right")

;!+[::Komorebic("cycle-focus previous")
;!+]::Komorebic("cycle-focus next")

; Focus displays
!a::Komorebic("cycle-monitor next")
!d::Komorebic("cycle-monitor previous")

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
!1::Komorebic("focus-workspace 0")
!2::Komorebic("focus-workspace 1")
!3::Komorebic("focus-workspace 2")
!4::Komorebic("focus-workspace 3")
!5::Komorebic("focus-workspace 4")

; Change workspace on all monitors. Disabled because it conflicts with my symbol layer
; <^>!1::Komorebic("focus-workspaces 0")
; <^>!2::Komorebic("focus-workspaces 1")
; <^>!3::Komorebic("focus-workspaces 2")
; <^>!4::Komorebic("focus-workspaces 3")
; <^>!5::Komorebic("focus-workspaces 4")

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

; Swap windows on left and right screen
!,::{
  Komorebic("focus right")
  Komorebic("focus right")
  Komorebic("focus right")
  Komorebic("swap-workspaces-with-monitor 2")
}
; Move all windows one screen to the left
; Assuming no split windows and windows on middle and right screen
!+,::{
  Komorebic("focus right")
  Komorebic("focus right")
  Komorebic("focus left")
  Komorebic("move left")
  Komorebic("focus right")
  Komorebic("focus right")
  Komorebic("move left")
}

!+.::{
  Komorebic("focus left")
  Komorebic("focus left")
  Komorebic("focus right")
  Komorebic("move right")
  Komorebic("focus left")
  Komorebic("focus left")
  Komorebic("move right")
}
