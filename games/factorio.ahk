#HotIf WinActive("ahk_exe Factorio.exe")
F13:: Send("r")
PrintScreen & F13:: Send("+r")
; F13 & WheelUp:: Send("r")
; F13 & WheelDown:: Send("+r")
F15 & WheelUp:: Send("!{Right}")
F15 & WheelDown:: Send("!{Left}")
; F16:: Send("+r")
F16 & WheelUp:: Send("{Up}")
F16 & WheelDown:: Send("{Down}")
F18:: Send("q")
F21:: Send("e")
PrintScreen & F21:: Send("!d")
F22:: SendDebounced("{Esc}", 100)
F24:: Send("m")
PrintScreen & F24:: Send("b")

#HotIf

; --- DEBOUNCING FUNCTION ---
; key: The key or string you want to send (e.g., "m", "!d", "{Up}")
; delay: The cooldown time in milliseconds (default is 200ms)
SendDebounced(key, delay := 30) {
    static lastPresses := Map() ; Create a memory map to store times for each hotkey

    ; If this hotkey hasn't been pressed before, initialize it to 0
    if !lastPresses.Has(A_ThisHotkey)
        lastPresses[A_ThisHotkey] := 0

    ; Check if enough time has passed since THIS specific hotkey was last pressed
    if (A_TickCount - lastPresses[A_ThisHotkey] > delay) {
        lastPresses[A_ThisHotkey] := A_TickCount ; Update the time
        Send(key)
    }
}