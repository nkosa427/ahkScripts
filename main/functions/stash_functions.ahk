stashOpen() {
	; Check if the title contains "Stash - Chromium"
    return winHasTitle("Stash - Chromium")
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

