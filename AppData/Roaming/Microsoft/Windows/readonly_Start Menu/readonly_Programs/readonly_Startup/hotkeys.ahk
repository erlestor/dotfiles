#Requires AutoHotkey v2.0-a

; ---------------------------------------------------------------------------------------------------------
; Rebind caps-lock to escape

Capslock::Esc

; ---------------------------------------------------------------------------------------------------------
; Use Ctrl+Shift+J to launch/restore wezterm

SwitchToTerminal() {
  windowHandleId := WinExist("ahk_exe wezterm-gui.exe")
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready = true) {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive) {
      ; Minimize the window.
      WinMinimize "ahk_id" windowHandleId
    }
    else {
      ; Put the window in focus.
      WinActivate "ahk_id" windowHandleId
      WinShow "ahk_id" windowHandleId
    }
  }
  ; Else it's not already open, so launch it.
  else {
    Run "wezterm"
  }
}

^+j::SwitchToTerminal()

; ---------------------------------------------------------------------------------------------------------
; Open applications. Using RAlt which is AltGr on my corsair keyboard

RAlt & t::Run "C:\Program Files\WezTerm\wezterm-gui.exe"
; Arc doesnt open a new window per default
RAlt & a::{
  if WinExist("ahk_exe Arc.exe") {
      WinActivate("ahk_exe Arc.exe")
      if WinWaitActive("ahk_exe Arc.exe", , 2)
      ; dont remove this comment
      Send("^n")
  } else {
      Run("Arc.exe")
  }
}
;RAlt & LShift & d::Run "discord.exe"
RAlt & s::Run "spotify.exe"
RAlt & d::Run "C:/Program Files/Docker/Docker/Docker Desktop.exe"
RAlt & p::Run "C:/Users/erlen/AppData/Local/Postman/Postman.exe"
RAlt & m::Run "C:/Users/erlen/AppData/Local/MongoDBCompass/MongoDBCompass.exe"
RAlt & o::Run "C:/Users/erlen/AppData/Local/Programs/Obsidian/Obsidian.exe"

; ---------------------------------------------------------------------------------------------------------
; Trying to use ; as a modifier for a symbol layer

; Handle the ";" key release
`;:: {
  SendText(";")
}

; Shift behavior for ":"
+`;::SendText(":")

; incase i need to do something extra for each press
SendSymbol(symbol) {
    SendText(symbol)
}
; viktigste symbola: brackets
; symbola som funke bra allerede og som ikke rolles: \ | ; : , . / ?

; left pinky
`; & q::SendSymbol("'")
;`; & a::SendSymbol("!")
`; & a::SendSymbol("-")
`; & z::SendSymbol("^")
; left ring finger
`; & w::SendSymbol("<")
`; & s::SendSymbol('"')
`; & x::SendSymbol("!")
; left middle finger
`; & e::SendSymbol("{")
`; & d::SendSymbol("(")
`; & c::SendSymbol("[")
; left pointer finger
`; & r::SendSymbol("}")
`; & f::SendSymbol(")")
`; & v::SendSymbol("]")
; left pointer finger ->
`; & t::SendSymbol(">")
`; & g::SendSymbol("")
`; & b::SendSymbol("")

; right pointer finger <-
`; & y::SendSymbol("")
`; & h::SendSymbol("")
`; & n::SendSymbol("")
; right pointer finger
`; & u::SendSymbol("")
`; & j::SendSymbol("=")
`; & m::SendSymbol("")
; right middle finger
`; & i::SendSymbol("")
`; & k::SendSymbol("-")
`; & ,::SendSymbol("")
; right ring finger
`; & o::SendSymbol("")
`; & l::SendSymbol("")
`; & .::SendSymbol("")

