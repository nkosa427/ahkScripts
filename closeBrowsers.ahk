#NoEnv
#SingleInstance force

closeBrowsers() {
    Process, Exist, msedge.exe
    if (ErrorLevel != 0) {
        WinActivate, ahk_exe msedge.exe
        Send, !f
        Sleep, 100
        Send, c
        Sleep, 200
    }

    Process, Exist, chrome.exe
    if (ErrorLevel != 0) {
        WinActivate, ahk_exe chrome.exe
        Send, !f
        Sleep, 100
        Send, x
        Sleep, 200
    }

    Process, Exist, firefox.exe
    if (ErrorLevel != 0) {
        WinActivate, ahk_exe firefox.exe
        Send, ^+q
    }

    Process, Exist, Code.exe
    if (ErrorLevel != 0) {
        WinActivate, ahk_exe Code.exe
        Send, !f
        Sleep, 100
        Send, x
    }
}

closeBrowsers()