#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance, force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;;;;;;;;;;;;;;;;;;;;;;; GROUPS ;;;;;;;;;;;;;;;;;;;;;;;;

GroupAdd, browsers, ahk_exe firefox.exe
GroupAdd, browsers, ahk_exe chrome.exe
GroupAdd, browsers, ahk_exe msedge.exe

;;;;;;;;;;;;;;;;;;;;;;;; DEFAULT KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

;F13::return
PrintScreen & F13::Send, ^#{Right}

F14::Send, ^c
PrintScreen & F14::Send, ^v

F15::Send, {Up}
;PrintScreen & F15::return

F16::return
PrintScreen & F16::Send, ^#{Left}

F17::Send, {Enter}
PrintScreen & F17::Send, {Backspace}

F18::Send, {Down}
;PrintScreen & F18::return

;F19::return
F19 & WheelUp::Volume_Up
F19 & WheelDown::Volume_Down
F19 & MButton::^a
;PrintScreen & F19::return

F20::Send, !{PgUp}
;PrintScreen & F20::return

;F21::return
;PrintScreen & F21::return

F22::Send, {Esc}
;PrintScreen & F22::return

F23::Send, !{PgDn}
PrintScreen & F23::Volume_Mute

F24::Send, {F3}
PrintScreen & F24::Send, ^x

Pause::Send, #{Tab}
PrintScreen & Pause::return

;;;;;;;;;;;;;;;;;;;;;;;; PROGRAM KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Windows Explorer is active
#IfWinActive ahk_class CabinetWClass
{
    F16::Send, !{Tab}
    F24::Send, {F2}
}

; Keybinds for when Browsers are active
#IfWinActive ahk_group browsers
{
	F15::Send, ^{Tab}
	F18::Send, ^+{Tab}
	PrintScreen & F20::Send, ^r
	F21::Send, ^t
	PrintScreen & F21::Send, ^w
	PrintScreen & Pause::Send, ^+t
}

; Keybinds for when Notepad++ is active
#IfWinActive ahk_exe notepad++.exe
{
	F15::Send, ^{Tab}
    F18::Send, ^+{Tab}
}

;;;;;;;;;;;;;;;;;;;;;;;; GAME KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when 7DTD is active
#IfWinActive ahk_exe 7DaysToDie.exe
{
	Toggle := false
	ToggleLMB := false
	
	F21::Send, {Tab}
    F24::Send, m
	
	PrintScreen & F15::
	{
		Toggle := !Toggle
		If Toggle then
		{
			Send, {W Down}{Shift down}
		} Else {
			Send, {W Up}{Shift up}
		}
	}
	return
	
	PrintScreen & F18::
	{
		ToggleLMB := !ToggleLMB
		If ToggleLMB then
		{
			Send, {LButton down}  
		} Else {
			Send, {LButton up}  
		}
	}
	return

}

;;;;;;;;;;;;;;;;;;;;;;;; OTHER ;;;;;;;;;;;;;;;;;;;;;;;;

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}


#If MouseIsOver("ahk_class CabinetWClass")
MButton::
    Send {LButton}{AppsKey}e
    return