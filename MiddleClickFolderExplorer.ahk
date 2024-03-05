#NoEnv
#Warn
#Persistent
#SingleInstance, force
SendMode Input
SetWorkingDir %A_ScriptDir%

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}


#If MouseIsOver("ahk_class CabinetWClass")
MButton::
    Send {LButton}{AppsKey}e
    return