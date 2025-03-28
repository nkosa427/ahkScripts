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

; Include default keybinds
#include "%A_ScriptDir%\default_keybinds.ahk"
#include "%A_ScriptDir%\browser_keybinds.ahk" ; Include browser keybinds

;;;;;;;;;;;;;;;;;;;;;;;; PROGRAM KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

#include "%A_ScriptDir%\programs\spotify.ahk" ; Include Spotify keybinds
#include "%A_ScriptDir%\programs\notepad++.ahk" ; Include Notepad++ keybinds
#include "%A_ScriptDir%\programs\mpc-hc.ahk" ; Include MPC-HC keybinds
#include "%A_ScriptDir%\programs\mintty.ahk" ; Include Mintty keybinds
#include "%A_ScriptDir%\programs\explorer.ahk" ; Include explorer keybinds
#include "%A_ScriptDir%\programs\vscode.ahk" ; Include VSCode keybinds
#include "%A_ScriptDir%\programs\photos.ahk" ; Include Photos keybinds
#include "%A_ScriptDir%\programs\altserver.ahk" ; Include AltServer keybinds
#include "%A_ScriptDir%\programs\electron.ahk" ; Include Electron keybinds

;;;;;;;;;;;;;;;;;;;;;;;; GAME KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

#include "%A_ScriptDir%\games\arma3.ahk" ; Include Arma 3 keybinds
#include "%A_ScriptDir%\games\payday2.ahk" ; Include Payday 2 keybinds
#include "%A_ScriptDir%\games\readyornot.ahk" ; Include Ready or Not keybinds
#include "%A_ScriptDir%\games\7dtd.ahk" ; Include 7 Days to Die keybinds
#include "%A_ScriptDir%\games\warframe.ahk" ; Include Warframe keybinds
#include "%A_ScriptDir%\games\civ6.ahk" ; Include Civilization VI keybinds
#include "%A_ScriptDir%\games\factorio.ahk" ; Include Factorio keybinds
#include "%A_ScriptDir%\games\grb.ahk" ; Include GRB keybinds

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

; #HotIf WinActive("ahk_class Arma 3")
; F13:: Send("{NumpadAdd}")
; F14:: Send("{LAlt}")
; F16:: Send("{NumpadSub}")
; F19:: Send("{NumpadEnter}")
; F21:: Send("i")
; F22:: Send("{Esc}")
; F24:: Send("m")
; #HotIf

; #HotIf WinActive("ahk_exe payday2_win32_release.exe")
; F22:: Send("{Esc}")
; #HotIf

; #HotIf WinActive("ahk_exe ReadyOrNot-Win64-Shipping.exe")
; F19:: Send("p")
; #HotIf

; ; Keybinds for when 7DTD is active
; #HotIf WinActive("ahk_exe 7DaysToDie.exe")
; Toggle := false
; ToggleLMB := false

; PrintScreen & F15:: holdShiftW(Toggle)
; PrintScreen & F18:: holdLMB(ToggleLMB)
; F21:: Send("{Tab}")
; F24:: Send("m")
; #HotIf

; ; Keybinds for when Warframe is active
; #HotIf WinActive("ahk_exe Warframe.x64.exe")
; F13:: Send("1")
; F14:: Send("2")
; F15:: Send("3")
; F16:: Send("4")
; F24:: Send("m")
; NumpadMult & F24:: Send("gggggG{^}6")
; #HotIf

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
