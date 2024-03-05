#NoEnv
#SingleInstance force

SetTitleMatchMode, 2
DetectHiddenWindows, On

; Define the process name
ProcName := "LCore.exe"

; Kill the process if it's running
IfWinExist, ahk_exe %ProcName%
{
    WinGet, ProcID, PID, ahk_exe %ProcName%
    Process, Close, %ProcID%
    WinWaitClose, ahk_exe %ProcName%
}

; Restart the process
Run, "C:\Program Files\Logitech Gaming Software\LCore.exe"

; Wait for the process to start
WinWait, ahk_exe %ProcName%
