; Function to press a key, wait, then release
; Uses SendInput and string concatenation
PressKeyWithDelay(key, delay) {
    SendInput "{" . key . " Down}" ; Concatenate key name
    Sleep delay
    SendInput "{" . key . " Up}"   ; Concatenate key name
}

; Function to press two keys with configurable delays
; First key is pressed, delay1 passes, second key is pressed
; delay2 passes, then both keys are released
PressTwoKeysWithDelay(key1, key2, delay1, delay2) {
    SendInput "{" . key1 . " Down}" ; Press first key
    Sleep delay1
    SendInput "{" . key2 . " Down}" ; Press second key
    Sleep delay2
    SendInput "{" . key2 . " Up}"   ; Release second key
    SendInput "{" . key1 . " Up}"   ; Release first key
}
