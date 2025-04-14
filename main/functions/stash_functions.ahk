stashOpen() {
	; Check if the title contains "Stash - Chromium"
    return winHasTitle("Stash - Chromium")
}

sendStashTag(text) {
	Send("!q")
	Sleep(1)
	Send(text)
	Sleep(1)
	Send("{Enter}")
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
	Send("p")
	Sleep(5)
	Send("p")
}

shiftRight(shift := false) {
    if (shift)
        Send("+{Right}")
    else
        Send("{Right}")
}

shiftLeft(shift := false) {
    if (shift)
        Send("+{Left}")
    else
        Send("{Left}")
}

