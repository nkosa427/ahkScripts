#Requires AutoHotkey v1.1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance, force
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;;;;;;;;;;;;;;;;;;;;;;; GROUPS ;;;;;;;;;;;;;;;;;;;;;;;;

GroupAdd, browsers, ahk_exe firefox.exe
GroupAdd, browsers, ahk_exe chrome.exe
GroupAdd, browsers, ahk_exe msedge.exe
GroupAdd, browsers, ahk_exe AnyDesk.exe
 
;;;;;;;;;;;;;;;;;;;;;;;; DEFAULT KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;


	;------------------------------------------ No command for F13
	;F13::return

	;------------------------------------------ Switch to next desktop (Ctrl+Win+Right)
	PrintScreen & F13::Send, ^#{Right}

	;------------------------------------------ Copy (Depends on window)
	F14::copy()	;

	;------------------------------------------ Paste (Depends on window)
	PrintScreen & F14::paste()

	;------------------------------------------ Up Arrow (Up)
	F15::Send, {Up}

	;------------------------------------------ No command for F16
	;F16::return

	;------------------------------------------ Switch to previous desktop (Ctrl+Win+Left)
	PrintScreen & F16::Send, ^#{Left}

	;------------------------------------------ Go the first desktop (Ctrl+Win+Left several times)
	ScrollLock & F16::goToFirstDesktop()

	;------------------------------------------ Enter (Enter)
	F17::enter()

	;------------------------------------------ Backspace (Backspace)
	PrintScreen & F17::backspace()

	;------------------------------------------ Down Arrow (Down)
	F18::Send, {Down}

	;------------------------------------------ No command for F19
	;F19::return

	;------------------------------------------ Volume Up (F19 + Scroll Up)
	F19 & WheelUp::Volume_Up

	;------------------------------------------ Volume Down (F19 + Scroll Down)
	F19 & WheelDown::Volume_Down

	;------------------------------------------ Select All (Ctrl+A)
	F19 & MButton::^a

	;------------------------------------------ Select All (Ctrl+A)
	PrintScreen & F19::Send, ^a

	;------------------------------------------ Brightness Up (Alt+PgUp)
	F20::Send, !{PgUp}

	;------------------------------------------ Delete (del)
	ScrollLock & F20::Send, {Del}

	;------------------------------------------ No command for F21
	;F21::return

	;------------------------------------------ Escape (Esc)
	F22::Send, {Esc}

	;------------------------------------------ Task View (Win+Tab)
	PrintScreen & F22::Send, #{Tab}

	;------------------------------------------ Brightness Down (Alt+PgDn)
	F23::Send, !{PgDn}

	;------------------------------------------ Volume Mute (F23)
	PrintScreen & F23::Volume_Mute

	;------------------------------------------ No command for F24
	;F24::return

	;------------------------------------------ Cut (Ctrl+X)
	F24::Send, ^x

	;------------------------------------------ Close (Depends on window)
	PrintScreen & F24::close()

	ScrollLock::return
	PrintScreen::return
	PrintScreen & ScrollLock::return

;;;;;;;;;;;;;;;;;;;;;;;; PROGRAM KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Windows Explorer is active
#IfWinActive ahk_class CabinetWClass
{
	F13::
		Send, {Shift down}
		KeyWait, F13
		Send, {Shift up}
		return
	F16::Send, !{Tab}
	PrintScreen & F18::Send, {F2}
	PrintScreen & F20::Send, ^r
}

; Keybinds for when Browsers are active
#IfWinActive ahk_group browsers
{
	F13::
		stashOpen() ? stashNext() : copyURL()
		return
	ScrollLock & F13::
		stashOpen() ? paste() : ""
		return
	F14::
		stashOpen() ? shiftRight(true) : copy()
		return
	ScrollLock & F14::
		stashOpen() ? copy() : ""
		return
	PrintScreen & F14::
		stashOpen() ? shiftRight(false) : paste()
		return
	F15::nextTab()
	ScrollLock & F15::
		stashOpen() ? sendStashTag("MMF") : ""
		return
	F16::
		stashOpen() ? stashPrev() : CopySwitchPaste()
		return
	F17::
		stashOpen() ? shiftLeft(true) : enter()
		return
	PrintScreen & F17::
		stashOpen() ? shiftLeft(false) : backspace()
		return
	ScrollLock & F17::
		stashOpen() ? backspace() : ""
		return
	F18::prevTab()
	PrintScreen & F18::
		stashOpen() ? sendStashTag("SHARED") : bitwardenFill()
		return
	ScrollLock & F18::bitwardenFill()
	;F19::
		;stashOpen() ? stashPrev() : CopySwitchPasteMod()
		;return
	ScrollLock & F19::
		stashOpen() ? "" : CopySwitchPasteMod()
		return
	PrintScreen & F20::Send, ^r
	F21::Send, ^t
	PrintScreen & F21::duplicateTab()
	; PrintScreen & F24::close()
	ScrollLock & F24::Send, ^+t
}

; Keybinds for when Spotify is active
#IfWinActive ahk_exe Spotify.exe
{
	F13::Send, ^{Right}
	F16::Send, ^{Left}
	F21::Send, {Space}
    F18::Send, ^+{Tab}
}

; Keybinds for when Notepad++ is active
#IfWinActive ahk_exe notepad++.exe
{
	F15::Send, ^{Tab}
    F18::Send, ^+{Tab}
}

; Keybinds for when MPC-HC is active
#IfWinActive ahk_exe mpc-hc64.exe
{
	F13::Send, ^{PgDn}
	F14::Send, {Right}
	PrintScreen & F14:: Send, ^!{Right}
	F15::Send, ^+d
	F16::Send, ^{PgUp}
	F17::Send, {Left}
	PrintScreen & F17:: Send, ^!{Left}
	F18::Send, ^+a
	F21::Send, {Space}
	PrintScreen & F21::Send, ^c
}

; Keybinds for when Cygwin is active
#IfWinActive ahk_exe mintty.exe
{
	F14::Send, ^{Insert}
	PrintScreen & F14::Send, +{Insert}
}

; Keybinds for when electron is active
#IfWinActive ahk_exe electron.exe
{
	F14::Send, ^{Insert}
	F15::Send, {Right}
	F16::activateIfOpen("firefox.exe")
	F18::Send, {Left}
	PrintScreen & F14::Send, +{Insert}
}


; Keybinds for when VSCode is active
#IfWinActive ahk_exe Code.exe OR ahk_exe Code - Insiders.exe
{
	F13::Send, !{F12}	; Peek Definition
	F15::Send, ^{PgDn}
	F18::Send, ^{PgUp}
	F19::Send, ^{i}
	PrintScreen & F19::Send, ^{/}
}

; Keybinds for when Photos is active
#IfWinActive ahk_exe ApplicationFrameHost.exe
{
	if (winHasTitle("Photos")) {
		F16 & WheelUp::Send, ^{=}
		F16 & WheelDown::Send, ^{-}
		PrintScreen & F19::Send, ^w
		F22::Send, ^0
	}
}

; Keybinds for when Vidupe is active
#IfWinActive, ahk_exe Vidupe.exe
{
	F13::
		Send, {Left}
		Sleep, 125
		Send, {Left}
		Sleep, 150
		Send, {Enter}
		Sleep, 125
        Send, {Right}
        Sleep, 125
        Send, {Right}
		Sleep, 150
        Send, {Enter}
        ; Sleep, 50
        ; Send, {Enter}
        return
	F15::
		Send, {Right}
		Sleep, 125
		Send, {Right}
		Sleep, 150
		Send, {Enter}
		Sleep, 125
        Send, {Left}
        Sleep, 125
        Send, {Left}
		Sleep, 150
        Send, {Enter}
        ; Sleep, 50
        ; Send, {Enter}
        return

}

; Keybinds for altserver
#IfWinActive, ahk_exe AltServer.exe
{
	F13::Send, nickchase5146@gmail.com
	F16::Send, 6h{#}hJRlX0gGMXv
}

;;;;;;;;;;;;;;;;;;;;;;;; GAME KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_exe EscapeFromTarkov.exe
{
	ScrollLock & F13::Send, y
	F21::Send, {Tab}
	PrintScreen & F23::Send, {F11}
	F24::
		Send, {m down}
		KeyWait, F24
		Send, {m up}
		return
	
}

#IfWinActive ahk_exe Car Mechanic Simulator 2021.exe
{
	F18::SendInput, b
	F24::Send, b
	F13::SendPlay, b
}

#IfWinActive ahk_class Arma 3
{
	F13::Send, {NumpadAdd}
	F14::Send, {LAlt}
	F16::Send, {NumpadSub}
	F19::Send, {NumpadEnter}
	F21::Send, i
	F22::Send, {Esc}
	F24::Send, m
}

#IfWinActive ahk_exe payday2_win32_release.exe
{
	F22::SendInput, {Esc}
}

#IfWinActive ahk_exe ReadyOrNot-Win64-Shipping.exe
{
	F19::Send, p
}

; Keybinds for when 7DTD is active
#IfWinActive ahk_exe 7DaysToDie.exe
{
	Toggle := false
	ToggleLMB := false
	
	PrintScreen & F15::
		holdShiftW(Toggle)
		return
	PrintScreen & F18::
		holdLMB(ToggleLMB)
		return
	F21::Send, {Tab}
    F24::Send, m
}

; Keybinds for when Warframe is active
#IfWinActive ahk_exe Warframe.x64.exe
{
	F13::Send, 1
	F14::Send, 2
	F15::Send, 3
	F16::Send, 4
	F24::Send, m
	ScrollLock & F24::Send, gggggG{^}6
}

#IfWinActive ahk_exe CivilizationVI_DX12.exe
{
	F15::Send, .
	F18::Send, ,
}

#IfWinActive ahk_exe Factorio.exe
{
	F13::Send, r
	F16::Send, +r
	F18::Send, q
	F21::Send, e
	F24::Send, m
	PrintScreen & F24::Send, b
}

#IfWinActive ahk_exe GRB.exe
{
	F13::Send, 1
	F14::Send, 2
	F15::Send, 3
	F22::SendInput, {Esc}
}

;;;;;;;;;;;;;;;;;;;;;;;; OTHER ;;;;;;;;;;;;;;;;;;;;;;;;

nextTab() {
	Send, ^{Tab}
}

prevTab() {
	Send, ^+{Tab}
}

close() {
	if WinActive("ahk_group browsers") {
			Send, ^w
			return
	}

	activeExe := getActiveWindowExe()
	
	if (activeExe = "mpc-hc64.exe") {
		Send, !x
		return
	}

	ToolTip, %activeExe% not supported
	Sleep, 1000
	ToolTip
}

holdShiftW(Toggle) {
	Toggle := !Toggle
	If Toggle then
	{
		Send, {W Down}{Shift down}
	} Else {
		Send, {W Up}{Shift up}
	}
}

holdLMB(ToggleLMB) {
	ToggleLMB := !ToggleLMB
	If ToggleLMB then
	{
		Send, {LButton down}  
	} Else {
		Send, {LButton up}  
	}
}

bitwardenFill() {
	Send, ^+l
}

stashOpen() {
	; Check if the title contains "Stash - Chromium"
    return winHasTitle("Stash - Chromium")
	; return winHasTitle("Stash — Mozilla Firefox")
}

winHasTitle(name) {
	; Get the title of the active window
    WinGetTitle, title, A

    ; Check if the title contains name
    return InStr(title, name) > 0
}

sendStashTag(text) {
	;Send, ^+k
	;Sleep, 300
	;Send, %text%
	;Send, {Enter}

	Send, {Alt down}
	Sleep, 1
	Send, q
	Sleep, 1
	Send, {Alt up}
	Send, %text%
	Sleep, 1
	Send, {Enter}
}

stashNext() {
	Send, p
	Sleep, 5
	Send, n
}

stashPrev() {
	Send, p
	Sleep, 5
	Send, p
}

shiftRight(shift := false) {
    if (shift)
        Send, +{Right}
    else
        Send, {Right}
}

shiftLeft(shift := false) {
    if (shift)
        Send, +{Left}
    else
        Send, {Left}
}

copyURL() {
	#IfWinActive ahk_exe chrome.exe
	{
		Send, ^l
		Sleep, 150
		Send, ^c
		Sleep, 50
		Send, !{Tab}
	}
}

copy() {
	Send, ^c
}

paste() {
	Send, ^v
}

enter() {
	Send, {Enter}
}

backspace() {
	Send, {Backspace}
}



MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

duplicateTab() {
	; Get the active window's executable
    WinGet, activeWindow, ProcessName, A
    
    ; Check if Firefox is active
    if (activeWindow = "firefox.exe") {
        Send, ^l
        Sleep, 50
        Send, !{Enter}
    }
    ; Check if Edge is active
    else if (activeWindow = "msedge.exe") {
        Send, ^+k
    }
}

#If MouseIsOver("ahk_class CabinetWClass")
MButton::
    Send {LButton}{AppsKey}e
    return
	
goToFirstDesktop() {
	Loop 8
    {
        ; Send the key combination Win+Ctrl+Left
        Send, #^{Left}
        
        ; Optional: Add a short delay between each iteration to simulate human typing speed
        Sleep, 10
    }
}

activateIfOpen(exeName) {
    ; Check if the specified AHK executable is already open
	IfWinExist ahk_exe %exeName%
	{
			; If the AHK executable is open, activate its window
			WinActivate ahk_exe %exeName%
	}
	else
	{
			; If the AHK executable is not open, display a message
			MsgBox, %exeName% is not currently open.
	}
}

getActiveWindowExe() {
	WinGet, activeWindow, ProcessName, A
	return activeWindow
}

; Define a function to perform the copy, switch, and paste
CopySwitchPaste() {
	; Get the active window's title
    WinGetTitle, title, A

	if !(InStr(title, "Stash - Chromium"))
	{
		; Store the title of the currently active window
		WinGetTitle, originalTitle, A

		; Send Ctrl+C to copy
		SendInput, ^c
		Sleep, 50  ; Wait for the copying operation to complete

		; Attempt to activate the window associated with the "electron.exe" process
		if WinExist("ahk_exe electron.exe")
		{
			; Activate the window associated with "electron.exe"
			WinActivate, ahk_exe electron.exe
			WinWaitActive, ahk_exe electron.exe  ; Wait for it to become active
			Sleep, 50

			; Send Ctrl+V to paste
			paste()
			Sleep, 50
			SendInput, {Enter}
			Sleep, 50
		}
		else
		{
			; If the window associated with "electron.exe" not found, show a message
			MsgBox, The window associated with "electron.exe" is not open.
		}

		; Switch back to the previously active window
		; WinActivate, %originalTitle%
		Send, !{Tab}
	}
}

CopySwitchPasteMod() {
	; Get the active window's title
    WinGetTitle, title, A

	if !(InStr(title, "Stash - Chromium"))
	{
		; Store the title of the currently active window
		WinGetTitle, originalTitle, A

		; Send Ctrl+C to copy
		SendInput, ^c
		Sleep, 10
		SendInput, ^+v
		Sleep, 50  ; Wait for the copying operation to complete

		; Attempt to activate the window associated with the "electron.exe" process
		if WinExist("ahk_exe electron.exe")
		{
			; Activate the window associated with "electron.exe"
			WinActivate, ahk_exe electron.exe
			WinWaitActive, ahk_exe electron.exe  ; Wait for it to become active
			Sleep, 50

			; Send Ctrl+V to paste
			paste()
			Sleep, 50
			SendInput, {Enter}
			Sleep, 50
		}
		else
		{
			; If the window associated with "electron.exe" not found, show a message
			MsgBox, The window associated with "electron.exe" is not open.
		}

		; Switch back to the previously active window
		; WinActivate, %originalTitle%
		Send, !{Tab}
	}
}
