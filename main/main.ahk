#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; Include default keybinds
#include "%A_ScriptDir%\default_keybinds.ahk"
#include "%A_ScriptDir%\browser_keybinds.ahk" ; Include browser keybinds

;;;;;;;;;;;;;;;;;;;;;;;; PROGRAM FILES ;;;;;;;;;;;;;;;;;;;;;;;;

#include "%A_ScriptDir%\programs\spotify.ahk" ; Include Spotify keybinds
#include "%A_ScriptDir%\programs\notepad++.ahk" ; Include Notepad++ keybinds
#include "%A_ScriptDir%\programs\mpc-hc.ahk" ; Include MPC-HC keybinds
#include "%A_ScriptDir%\programs\mintty.ahk" ; Include Mintty keybinds
#include "%A_ScriptDir%\programs\explorer.ahk" ; Include explorer keybinds
#include "%A_ScriptDir%\programs\vscode.ahk" ; Include VSCode keybinds
#include "%A_ScriptDir%\programs\photos.ahk" ; Include Photos keybinds
#include "%A_ScriptDir%\programs\altserver.ahk" ; Include AltServer keybinds
#include "%A_ScriptDir%\programs\electron.ahk" ; Include Electron keybinds

;;;;;;;;;;;;;;;;;;;;;;;; GAME FILES ;;;;;;;;;;;;;;;;;;;;;;;;

#include "%A_ScriptDir%\games\arma3.ahk" ; Include Arma 3 keybinds
#include "%A_ScriptDir%\games\payday2.ahk" ; Include Payday 2 keybinds
#include "%A_ScriptDir%\games\readyornot.ahk" ; Include Ready or Not keybinds
#include "%A_ScriptDir%\games\7dtd.ahk" ; Include 7 Days to Die keybinds
#include "%A_ScriptDir%\games\warframe.ahk" ; Include Warframe keybinds
#include "%A_ScriptDir%\games\civ6.ahk" ; Include Civilization VI keybinds
#include "%A_ScriptDir%\games\factorio.ahk" ; Include Factorio keybinds
#include "%A_ScriptDir%\games\grb.ahk" ; Include GRB keybinds
#include "%A_ScriptDir%\games\tarkov.ahk" ; Include Escape from Tarkov keybinds
#include "%A_ScriptDir%\games\cms2021.ahk" ; Include Car Mechanic Simulator 2021 keybinds

;;;;;;;;;;;;;;;;;;;;;;;; FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;

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

		; Attempt to activate the "Folder Tree Viewer" window
		if WinExist("Folder Tree Viewer") {
			; Activate the "Folder Tree Viewer" window
			WinActivate("Folder Tree Viewer")
			WinWaitActive("Folder Tree Viewer")  ; Wait for it to become active
			Sleep(50)

			; Send Ctrl+V to paste
			paste()
			Sleep(50)
			Send("{Enter}")
			Sleep(50)
		} else {
			; If the "Folder Tree Viewer" window not found, show a message
			MsgBox("The 'Folder Tree Viewer' window is not open.")
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

		; Attempt to activate the "Folder Tree Viewer" window
		if WinExist("Folder Tree Viewer") {
			; Activate the "Folder Tree Viewer" window
			WinActivate("Folder Tree Viewer")
			WinWaitActive("Folder Tree Viewer")  ; Wait for it to become active
			Sleep(50)

			; Send Ctrl+V to paste
			paste()
			Sleep(50)
			Send("{Enter}")
			Sleep(50)
		} else {
			; If the "Folder Tree Viewer" window not found, show a message
			MsgBox("The 'Folder Tree Viewer' window is not open.")
		}

		; Switch back to the previously active window
		Send("!{Tab}")
	}
}
