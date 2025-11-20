#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run, net stop Audiosrv, , Hide

Sleep, 1000

Run, net start Audiosrv, , Hide

TrayTip, Audio Service Restarted, The audiosrv service has been restarted., 3