global tmuxWaitingForConfirm := false

#HotIf WinActive("ahk_exe mintty.exe")
F14:: Send("^{Insert}")
PrintScreen & F14:: Send("+{Insert}")
PrintScreen & F24:: {
    Send("^b")
    Sleep(50)
    Send("x")    
    ; Set up a monitoring system for the next key press
    global tmuxWaitingForConfirm := true
    
    ; Show debug tooltip
    ToolTip("Tmux confirmation mode active", 10, 10)
    
    ; Create a timer that will reset the flag after 5 seconds
    SetTimer(ResetTmuxFlag, -5000)
}

; Function to reset the flag (moved outside the hotkey for clarity)
ResetTmuxFlag() {
    global tmuxWaitingForConfirm := false
    ToolTip("")  ; Clear tooltip when timer expires
}

; Handle confirmation when waiting for tmux confirmation
F17:: {
    if (tmuxWaitingForConfirm) {
        ToolTip("Confirming tmux command...", 10, 10)
        Send("y")
        global tmuxWaitingForConfirm := false
        SetTimer(ToolTip, -1000)  ; Clear tooltip after 1 second
        return
    }
    ; If not waiting for confirmation, perform normal F17 behavior
    enter()
}
#HotIf
