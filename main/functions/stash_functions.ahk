stashOpen() {
    static lastHwnd := 0
    static lastResult := false
    static lastTime := 0
    static cacheTimeout := 1000 ; Cache result for 1 second

    ; Get active window handle
    try {
        activeHwnd := WinGetID("A")
    } catch {
        return false
    }

    ; If window hasn't changed and we're within timeout, return cached result
    if (activeHwnd == lastHwnd && (A_TickCount - lastTime) < cacheTimeout) {
        return lastResult
    }

    ; Update cache metadata
    lastHwnd := activeHwnd
    lastTime := A_TickCount
    lastResult := false ; Default to false

    ; Check if it's Chrome
    try {
        processName := WinGetProcessName("ahk_id " activeHwnd)
        if (processName != "chrome.exe") {
            return lastResult := false
        }
    } catch {
        return lastResult := false
    }

    ; Use UIA to check URL
    try {
        cUIA := UIA_Browser("ahk_id " activeHwnd)
        url := cUIA.GetCurrentURL()
        if (InStr(url, "closetcomputing:4557")) {
            lastResult := true
        }
    } catch {
        ; If UIA fails (e.g. window closing), default to false
        lastResult := false
    }

    return lastResult
}

sendStashTag(text) {
    if (stashOpen()) {
        Send("!q")
        Sleep(1)
        Send(text)
        Sleep(1)
        Send("{Enter}")
        return true
    } else {
        return false
    }
}

stashNext() {
    if (stashOpen()) {
        Send("p")
        Sleep(5)
        Send("n")
        return true
    } else {
        return false
    }
}

stashPrev() {
    if (stashOpen()) {
        Send("p")
        Sleep(5)
        Send("p")
        return true
    } else {
        return false
    }
}

shiftRight(shift := false) {
    if (stashOpen()) {
        if (shift)
            Send("+{Right}")
        else
            Send("{Right}")
        return true
    } else {
        return false
    }
}

shiftLeft(shift := false) {
    if (stashOpen()) {
        if (shift)
            Send("+{Left}")
        else
            Send("{Left}")
        return true
    } else {
        return false
    }
}
