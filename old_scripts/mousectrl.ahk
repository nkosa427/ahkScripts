#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Open the mouse properties menu
Run control main.cpl

; Wait for the mouse properties window to open
WinWait, Mouse Properties

; Navigate to the "Pointer Options" tab
ControlClick, Button1, Mouse Properties, &Pointer Options

; Navigate to the "Hide pointer while typing" checkbox
ControlClick, Button1, Mouse Properties, Screen
ControlClick, Button1, Mouse Properties, Screen

; Check the "Hide pointer while typing" checkbox
ControlSend, Button1, {SPACE}, Mouse Properties, Screen

; Click the "Apply" button
ControlClick, Button1, Mouse Properties, &Apply

; Wait for the changes to take effect
Sleep, 1000

; Uncheck the "Hide pointer while typing" checkbox
ControlSend, Button1, {SPACE}, Mouse Properties, Screen

; Click the "Apply" button
ControlClick, Button1, Mouse Properties, &Apply

; Close the mouse properties window
ControlClick, Button1, Mouse Properties, &Close
