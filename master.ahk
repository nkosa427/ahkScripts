#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Default keybinds

F13::return
PrintScreen & F13::Send, ^#{Right}

F14::Send, ^c
PrintScreen & F14::Send, ^v

F15::return
PrintScreen & F15::return

F16::return
PrintScreen & F16::Send, ^#{Left}

F17::Send, {Enter}
PrintScreen & F17::Send, {Backspace}

F18::return
PrintScreen & F18::return

F19::return
F19 & WheelUp::Volume_Up
F19 & WheelDown::Volume_Down
F19 & MButton::^a
PrintScreen & F19::return

F20::Send, !{PgUp}
PrintScreen & F20::return

F21::return
PrintScreen & F21::return

F22::Send, {Esc}
PrintScreen & F22::return

F23::Send, !{PgDn}
PrintScreen & F23::Volume_Mute

F24::return
PrintScreen & F24::Send, ^x
