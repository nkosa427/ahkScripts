#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run, net stop "Razer Central Service", , Hide
Run, net stop "Razer Central (32 bit)", , Hide
Run, net stop "Razer Central Service (32 bit)", , Hide
Run, net stop "Razer Game Manager", , Hide
Run, net stop "GameManagerService (32 bit)", , Hide
Run, net stop "Razer Synapse Service", , Hide
Run, net stop "Razer Synapse Service (32 bit)", , Hide
Run, net stop "Razer Synapse Service Process", , Hide
Run, net stop "Razer Synapse 3 (32 bit)", , Hide
Sleep 500

Run, net stop "Razer Central Service", , Hide
Run, net stop "Razer Central (32 bit)", , Hide
Run, net stop "Razer Central Service (32 bit)", , Hide
Run, net stop "Razer Game Manager", , Hide
Run, net stop "Razer Synapse Service", , Hide
Run, net stop "Razer Synapse Service Process", , Hide

Sleep, 3000

TrayTip, Razer Services stopped., 2

return