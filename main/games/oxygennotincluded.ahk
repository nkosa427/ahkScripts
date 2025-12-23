#HotIf WinActive("ahk_exe OxygenNotIncluded.exe")

; Global variable to track the current F-key index
currentFKey := 0

F14:: Send("b")
F19:: Send("g")
PrintScreen & F19:: Send("x")
F21:: Send("{Space}")

; F13:: binding to suppress the F13 key itself
F13:: {
    global currentFKey
    ; Reset the index when F13 is pressed
    currentFKey := 0
    return
}

; F13 & WheelUp:: binding to increment the F-key index and send the corresponding F-key
F13 & WheelUp:: {
    global currentFKey
    currentFKey++
    if (currentFKey > 11) {
        currentFKey := 1
    }
    Send("{F" . currentFKey . "}")
    return
}

; F13 & WheelDown:: binding to decrement the F-key index and send the corresponding F-key
F13 & WheelDown:: {
    global currentFKey
    currentFKey--
    if (currentFKey < 1) {
        currentFKey := 11
    }
    Send("{F" . currentFKey . "}")
    return
}

#HotIf