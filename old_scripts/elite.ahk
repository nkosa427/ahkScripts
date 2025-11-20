#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
#SingleInstance, force

Loop
{
    WinWait, ahk_exe EliteDangerous64.exe
    WinWaitClose, ahk_exe EliteDangerous64.exe
    WinClose, ahk_exe EDlaunch.exe
    
    ; Add a wait of 1 second before the next iteration
    Sleep, 10000
}