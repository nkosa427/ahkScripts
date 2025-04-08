; Function to press a key, wait, then release
; Uses SendInput and string concatenation
PressKeyWithDelay(key, delay) {
    SendInput "{" . key . " Down}" ; Concatenate key name
    Sleep delay
    SendInput "{" . key . " Up}"   ; Concatenate key name
}
