#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; Global variables
global tmuxWaitingForConfirm := false

;;;;;;;;;;;;;;;;;;;;;;;; GROUPS ;;;;;;;;;;;;;;;;;;;;;;;;

GroupAdd("browsers", "ahk_exe firefox.exe")
GroupAdd("browsers", "ahk_exe chrome.exe")
GroupAdd("browsers", "ahk_exe msedge.exe")
GroupAdd("browsers", "ahk_exe AnyDesk.exe")
 
;;;;;;;;;;;;;;;;;;;;;;;; DEFAULT KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

	;------------------------------------------ No command for F13
	F13::
	{
	   ToolTip("No command for F13", 10, 10)
	}

	;------------------------------------------ Switch to next desktop (Ctrl+Win+Right)
	PrintScreen & F13:: {
		; ToolTip("Sending Desktop Right", 10, 10)
		Send("^#{Right}")
	}
	;------------------------------------------ Copy (Depends on window)
	F14:: copy()

	;------------------------------------------ Paste (Depends on window)
	PrintScreen & F14:: paste()

	;------------------------------------------ Up Arrow (Up)
	F15:: Send("{Up}")

	;------------------------------------------ No command for F16
	F16::
	{
	;    ToolTip("No command for F16", 10, 10)
	}

	;------------------------------------------ Switch to previous desktop (Ctrl+Win+Left)
	PrintScreen & F16:: Send("^#{Left}")

	;------------------------------------------ Go the first desktop (Ctrl+Win+Left several times)
	NumpadMult & F16:: goToFirstDesktop()

	;------------------------------------------ Enter (Enter)
	F17:: enter()

	;------------------------------------------ Backspace (Backspace)
	PrintScreen & F17:: backspace()

	;------------------------------------------ Down Arrow (Down)
	F18:: Send("{Down}")

	;------------------------------------------ No command for F19
	;F19::
	;{
	;    return
	;}

	;------------------------------------------ Volume Up (F19 + Scroll Up)
	F19 & WheelUp:: Send("{Volume_Up}")

	;------------------------------------------ Volume Down (F19 + Scroll Down)
	F19 & WheelDown:: Send("{Volume_Down}")

	;------------------------------------------ Select All (Ctrl+A)
	F19 & MButton:: Send("^a")

	;------------------------------------------ Select All (Ctrl+A)
	PrintScreen & F19:: Send("^a")

	;------------------------------------------ Brightness Up (Alt+PgUp)
	F20:: Send("!{PgUp}")

	;------------------------------------------ Delete (del)
	NumpadMult & F20:: Send("{Del}")

	;------------------------------------------ No command for F21
	;F21::
	;{
	;    return
	;}

	;------------------------------------------ Escape (Esc)
	F22:: Send("{Esc}")

	;------------------------------------------ Task View (Win+Tab)
	PrintScreen & F22:: Send("#{Tab}")

	;------------------------------------------ Brightness Down (Alt+PgDn)
	F23:: Send("!{PgDn}")

	;------------------------------------------ Volume Mute (F23)
	PrintScreen & F23:: SoundSetMute(-1)

	;------------------------------------------ No command for F24
	;F24::
	;{
	;    return
	;}

	;------------------------------------------ Cut (Ctrl+X)
	F24:: Send("^x")

	;------------------------------------------ Close (Depends on window)
	PrintScreen & F24:: close()

	NumpadMult::
	PrintScreen:: 
	PrintScreen & NumpadMult:: 

;;;;;;;;;;;;;;;;;;;;;;;; PROGRAM KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Windows Explorer is active
#HotIf WinActive("ahk_class CabinetWClass")
MButton:: {
    Send("{LButton}{AppsKey}e")
}
F13:: {
	Send("{Shift down}")
	KeyWait("F13")
	Send("{Shift up}")
}
F16:: Send("!{Tab}")
PrintScreen & F18:: Send("{F2}")
PrintScreen & F20:: Send("^r")
#HotIf

; Keybinds for when Browsers are active
#HotIf WinActive("ahk_group browsers")
F13:: {
	if (stashOpen())
		stashNext()
	else
		copyURL()
}
NumpadMult & F13:: {
	if (stashOpen())
		paste()
}
F14:: {
	if (stashOpen())
		shiftRight(true)
	else
		copy()
}
NumpadMult & F14:: {
	if (stashOpen())
		copy()
}
PrintScreen & F14:: {
	if (stashOpen())
		shiftRight(false)
	else
		paste()
}
F15:: nextTab()
NumpadMult & F15:: {
	if (stashOpen())
		sendStashTag("MMF")
}
F16:: {
	if (stashOpen())
		stashPrev()
	else
		CopySwitchPaste()
}
F17:: {
	if (stashOpen())
		shiftLeft(true)
	else
		enter()
}
PrintScreen & F17:: {
	if (stashOpen())
		shiftLeft(false)
	else
		backspace()
}
NumpadMult & F17:: {
	if (stashOpen())
		backspace()
}
F18:: prevTab()
PrintScreen & F18:: {
	if (stashOpen())
		sendStashTag("SHARED")
	else
		bitwardenFill()
}
NumpadMult & F18:: bitwardenFill()
NumpadMult & F19:: {
	if (!stashOpen())
		CopySwitchPasteMod()
}
PrintScreen & F20:: Send("^r")
F21:: Send("^t")
PrintScreen & F21:: duplicateTab()
NumpadMult & F24:: Send("^+t")
#HotIf

; Keybinds for when Spotify is active
#HotIf WinActive("ahk_exe Spotify.exe")
F13:: Send("^{Right}")
F16:: Send("^{Left}")
F21:: Send("{Space}")
F18:: Send("^+{Tab}")
#HotIf

; Keybinds for when Notepad++ is active
#HotIf WinActive("ahk_exe notepad++.exe")
F15:: Send("^{Tab}")
F18:: Send("^+{Tab}")
#HotIf

; Keybinds for when MPC-HC is active
#HotIf WinActive("ahk_exe mpc-hc64.exe")
F13:: Send("^{PgDn}")
F14:: Send("{Right}")
PrintScreen & F14:: Send("^!{Right}")
F15:: Send("^+d")
F16:: Send("^{PgUp}")
F17:: Send("{Left}")
PrintScreen & F17:: Send("^!{Left}")
F18:: Send("^+a")
F21:: Send("{Space}")
PrintScreen & F21:: Send("^c")
#HotIf

; Keybinds for when Cygwin is active
#HotIf WinActive("ahk_exe mintty.exe")
F14:: Send("^{Insert}")
PrintScreen & F14:: Send("+{Insert}")
PrintScreen & F24:: {
    Send("^b")
    Sleep(50)
    Send("x")    
    ; Set up a monitoring system for the next key press
    global tmuxWaitingForConfirm := true
    
    ; Show debug tooltip
    ToolTip("Tmux confirmation mode active", 10, 10)
    
    ; Create a timer that will reset the flag after 5 seconds
    SetTimer(ResetTmuxFlag, -5000)
}

; Function to reset the flag (moved outside the hotkey for clarity)
ResetTmuxFlag() {
    global tmuxWaitingForConfirm := false
    ToolTip("")  ; Clear tooltip when timer expires
}

; Handle confirmation when waiting for tmux confirmation
F17:: {
    if (tmuxWaitingForConfirm) {
        ToolTip("Confirming tmux command...", 10, 10)
        Send("y")
        global tmuxWaitingForConfirm := false
        SetTimer(ToolTip, -1000)  ; Clear tooltip after 1 second
        return
    }
    ; If not waiting for confirmation, perform normal F17 behavior
    enter()
}
#HotIf

; Keybinds for when electron is active
#HotIf WinActive("ahk_exe electron.exe")
F14:: Send("^{Insert}")
F15:: Send("{Right}")
F16:: activateIfOpen("firefox.exe")
F18:: Send("{Left}")
PrintScreen & F14:: Send("+{Insert}")
#HotIf

; Keybinds for when VSCode is active
#HotIf WinActive("ahk_exe Code.exe") or WinActive("ahk_exe Code - Insiders.exe")
F13:: Send("!{F12}")	; Peek Definition
F15:: Send("^{PgDn}")
F18:: Send("^{PgUp}")
F19:: Send("^{i}")
PrintScreen & F19:: Send("^{/}")
#HotIf

; Keybinds for when Photos is active
#HotIf WinActive("ahk_exe ApplicationFrameHost.exe") and winHasTitle("Photos")
F16 & WheelUp:: Send("^{=}")
F16 & WheelDown:: Send("^{-}")
PrintScreen & F19:: Send("^w")
F22:: Send("^0")
#HotIf

; Keybinds for when Vidupe is active
#HotIf WinActive("ahk_exe Vidupe.exe")
F13:: {
	Send("{Left}")
	Sleep(125)
	Send("{Left}")
	Sleep(150)
	Send("{Enter}")
	Sleep(125)
    Send("{Right}")
    Sleep(125)
    Send("{Right}")
	Sleep(150)
    Send("{Enter}")
}
F15:: {
	Send("{Right}")
	Sleep(125)
	Send("{Right}")
	Sleep(150)
	Send("{Enter}")
	Sleep(125)
    Send("{Left}")
    Sleep(125)
    Send("{Left}")
	Sleep(150)
    Send("{Enter}")
}
#HotIf

; Keybinds for altserver
#HotIf WinActive("ahk_exe AltServer.exe")
F13:: Send("nickchase5146@gmail.com")
F16:: Send("6h{#}hJRlX0gGMXv")
#HotIf

;;;;;;;;;;;;;;;;;;;;;;;; GAME KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

#HotIf WinActive("ahk_exe EscapeFromTarkov.exe")
NumpadMult & F13:: Send("y")
F21:: Send("{Tab}")
PrintScreen & F23:: Send("{F11}")
F24:: {
	Send("{m down}")
	KeyWait("F24")
	Send("{m up}")
}
#HotIf

#HotIf WinActive("ahk_exe Car Mechanic Simulator 2021.exe")
F18:: Send("b")
F24:: Send("b")
F13:: Send("b")
#HotIf

#HotIf WinActive("ahk_class Arma 3")
F13:: Send("{NumpadAdd}")
F14:: Send("{LAlt}")
F16:: Send("{NumpadSub}")
F19:: Send("{NumpadEnter}")
F21:: Send("i")
F22:: Send("{Esc}")
F24:: Send("m")
#HotIf

#HotIf WinActive("ahk_exe payday2_win32_release.exe")
F22:: Send("{Esc}")
#HotIf

#HotIf WinActive("ahk_exe ReadyOrNot-Win64-Shipping.exe")
F19:: Send("p")
#HotIf

; Keybinds for when 7DTD is active
#HotIf WinActive("ahk_exe 7DaysToDie.exe")
Toggle := false
ToggleLMB := false

PrintScreen & F15:: holdShiftW(Toggle)
PrintScreen & F18:: holdLMB(ToggleLMB)
F21:: Send("{Tab}")
F24:: Send("m")
#HotIf

; Keybinds for when Warframe is active
#HotIf WinActive("ahk_exe Warframe.x64.exe")
F13:: Send("1")
F14:: Send("2")
F15:: Send("3")
F16:: Send("4")
F24:: Send("m")
NumpadMult & F24:: Send("gggggG{^}6")
#HotIf

#HotIf WinActive("ahk_exe CivilizationVI_DX12.exe")
F15:: Send(".")
F18:: Send(",")
#HotIf

#HotIf WinActive("ahk_exe Factorio.exe")
F13:: Send("r")
F16:: Send("+r")
F18:: Send("q")
F21:: Send("e")
F24:: Send("m")
PrintScreen & F24:: Send("b")
#HotIf

#HotIf WinActive("ahk_exe GRB.exe")
F13:: Send("1")
F14:: Send("2")
F15:: Send("3")
F22:: Send("{Esc}")
#HotIf

;;;;;;;;;;;;;;;;;;;;;;;; OTHER ;;;;;;;;;;;;;;;;;;;;;;;;

nextTab() {
	Send("^{Tab}")
}

prevTab() {
	Send("^+{Tab}")
}

close() {
	if WinActive("ahk_group browsers") {
		Send("^w")
		return
	}

	activeExe := getActiveWindowExe()
	
	if (activeExe = "mpc-hc64.exe") {
		Send("!x")
		return
	}

	ToolTip(activeExe . " not supported")
	Sleep(1000)
	ToolTip("")
}

holdShiftW(Toggle) {
	Toggle := !Toggle
	If Toggle {
		Send("{W Down}{Shift down}")
	} Else {
		Send("{W Up}{Shift up}")
	}
}

holdLMB(ToggleLMB) {
	ToggleLMB := !ToggleLMB
	If ToggleLMB {
		Send("{LButton down}")
	} Else {
		Send("{LButton up}")
	}
}

bitwardenFill() {
	Send("^+l")
}

stashOpen() {
	; Check if the title contains "Stash - Chromium"
    return winHasTitle("Stash - Chromium")
}

winHasTitle(name) {
	; Get the title of the active window
    title := WinGetTitle("A")

    ; Check if the title contains name
    return InStr(title, name) > 0
}

sendStashTag(text) {
	Send("!q")
	Sleep(1)
	Send(text)
	Sleep(1)
	Send("{Enter}")
}

stashNext() {
	Send("p")
	Sleep(5)
	Send("n")
}

stashPrev() {
	Send("p")
	Sleep(5)
	Send("p")
}

shiftRight(shift := false) {
    if (shift)
        Send("+{Right}")
    else
        Send("{Right}")
}

shiftLeft(shift := false) {
    if (shift)
        Send("+{Left}")
    else
        Send("{Left}")
}

#HotIf WinActive("ahk_exe chrome.exe")
copyURL() {
	Send("^l")
	Sleep(150)
	Send("^c")
	Sleep(50)
	Send("!{Tab}")
}
#HotIf

copy() {
	Send("^c")
}

paste() {
	Send("^v")
}

enter() {
	Send("{Enter}")
}

backspace() {
	Send("{Backspace}")
}

MouseIsOver(WinTitle) {
    MouseGetPos(,, &Win)
    return WinExist(WinTitle . " ahk_id " . Win)
}

duplicateTab() {
	; Get the active window's executable
    activeWindow := WinGetProcessName("A")
    
    ; Check if Firefox is active
    if (activeWindow = "firefox.exe") {
        Send("^l")
        Sleep(50)
        Send("!{Enter}")
    }
    ; Check if Edge is active
    else if (activeWindow = "msedge.exe") {
        Send("^+k")
    }
}

goToFirstDesktop() {
	Loop 8 {
        ; Send the key combination Win+Ctrl+Left
        Send("#^{Left}")
        
        ; Optional: Add a short delay between each iteration to simulate human typing speed
        Sleep(10)
    }
}

activateIfOpen(exeName) {
    ; Check if the specified AHK executable is already open
	if WinExist("ahk_exe " . exeName) {
		; If the AHK executable is open, activate its window
		WinActivate("ahk_exe " . exeName)
	} else {
		; If the AHK executable is not open, display a message
		MsgBox(exeName . " is not currently open.")
	}
}

getActiveWindowExe() {
	return WinGetProcessName("A")
}

; Define a function to perform the copy, switch, and paste
CopySwitchPaste() {
	; Get the active window's title
    title := WinGetTitle("A")

	if !(InStr(title, "Stash - Chromium")) {
		; Store the title of the currently active window
		originalTitle := WinGetTitle("A")

		; Send Ctrl+C to copy
		Send("^c")
		Sleep(50)  ; Wait for the copying operation to complete

		; Attempt to activate the window associated with the "electron.exe" process
		if WinExist("ahk_exe electron.exe") {
			; Activate the window associated with "electron.exe"
			WinActivate("ahk_exe electron.exe")
			WinWaitActive("ahk_exe electron.exe")  ; Wait for it to become active
			Sleep(50)

			; Send Ctrl+V to paste
			paste()
			Sleep(50)
			Send("{Enter}")
			Sleep(50)
		} else {
			; If the window associated with "electron.exe" not found, show a message
			MsgBox("The window associated with 'electron.exe' is not open.")
		}

		; Switch back to the previously active window
		Send("!{Tab}")
	}
}

CopySwitchPasteMod() {
	; Get the active window's title
    title := WinGetTitle("A")

	if !(InStr(title, "Stash - Chromium")) {
		; Store the title of the currently active window
		originalTitle := WinGetTitle("A")

		; Send Ctrl+C to copy
		Send("^c")
		Sleep(10)
		Send("^+v")
		Sleep(50)  ; Wait for the copying operation to complete

		; Attempt to activate the window associated with the "electron.exe" process
		if WinExist("ahk_exe electron.exe") {
			; Activate the window associated with "electron.exe"
			WinActivate("ahk_exe electron.exe")
			WinWaitActive("ahk_exe electron.exe")  ; Wait for it to become active
			Sleep(50)

			; Send Ctrl+V to paste
			paste()
			Sleep(50)
			Send("{Enter}")
			Sleep(50)
		} else {
			; If the window associated with "electron.exe" not found, show a message
			MsgBox("The window associated with 'electron.exe' is not open.")
		}

		; Switch back to the previously active window
		Send("!{Tab}")
	}
}
