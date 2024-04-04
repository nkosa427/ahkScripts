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

;F13::return
PrintScreen & F13::Send, ^#{Right}

F14::copy()
PrintScreen & F14::paste()

F15::Send, {Up}

;F16::return
PrintScreen & F16::Send, ^#{Left}
NumpadDot & F16::goToFirstDesktop()

F17::enter()
PrintScreen & F17::backspace()

F18::Send, {Down}

;F19::return
F19 & WheelUp::Volume_Up
F19 & WheelDown::Volume_Down
F19 & MButton::^a
PrintScreen & F19::Send, ^a

F20::Send, !{PgUp}

;F21::return

F22::Send, {Esc}
PrintScreen & F22::Send, #{Tab}

F23::Send, !{PgDn}
PrintScreen & F23::Volume_Mute

;F24::return
PrintScreen & F24::Send, ^x

NumpadDot::return
PrintScreen::return
PrintScreen & NumpadDot::return

;;;;;;;;;;;;;;;;;;;;;;;; PROGRAM KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Windows Explorer is active
#IfWinActive ahk_class CabinetWClass
{
    F16::Send, !{Tab}
	PrintScreen & F20::Send, ^r
    F24::Send, {F2}
}

; Keybinds for when Browsers are active
#IfWinActive ahk_group browsers
{
	F13::
		stashOpen() ? stashNext() : ""
		return
	NumpadDot & F13::
		stashOpen() ? paste() : ""
		return
	F14::
		stashOpen() ? shiftRight(true) : copy()
		return
	NumpadDot & F14::
		stashOpen() ? copy() : ""
		return
	PrintScreen & F14::
		stashOpen() ? shiftRight(false) : paste()
		return
	F15::Send, ^{Tab}
	F16::
		stashOpen() ? stashPrev() : CopySwitchPaste()
		return
	F17::
		stashOpen() ? shiftLeft(true) : enter()
		return
	PrintScreen & F17::
		stashOpen() ? shiftLeft(false) : backspace()
		return
	NumpadDot & F17::
		stashOpen() ? backspace() : ""
		return
	F18::Send, ^+{Tab}
	PrintScreen & F20::Send, ^r
	F21::Send, ^t
	PrintScreen & F21::Send, ^w
	NumpadDot & F24::Send, ^+t
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
	PrintScreen & F21::Send, !x
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
#IfWinActive ahk_exe Code.exe
{
	F15::Send, ^{PgDn}
	F18::Send, ^{PgUp}
	PrintScreen & F19::Send, ^{/}
	F24::Send, !{F12}
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

;;;;;;;;;;;;;;;;;;;;;;;; GAME KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

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
	NumpadDot & F24::Send, gggggG{^}6
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

stashOpen() {
	; Check if the title contains "Stash - Chromium"
    return winHasTitle("Stash - Chromium")
}

winHasTitle(name) {
	; Get the title of the active window
    WinGetTitle, title, A

    ; Check if the title contains name
    return InStr(title, name) > 0
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
