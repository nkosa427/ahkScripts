GroupAdd("browsers", "ahk_exe firefox.exe")
GroupAdd("browsers", "ahk_exe chrome.exe")
GroupAdd("browsers", "ahk_exe msedge.exe")
GroupAdd("browsers", "ahk_exe AnyDesk.exe")

;;;;;;;;;;;;;;;;;;;;;;;; BROWSER KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Browsers are active
#HotIf WinActive("ahk_group browsers")
F13 & WheelUp:: {
	if (stashNext())
		return
}

F13 & WheelDown:: {
	if (stashPrev())
		return
}

ScrollLock & F13:: {
	if (stashOpen())
		paste()
}

F14:: {
	if (shiftRight(true))
		return
	else
		copy()
}

ScrollLock & F14:: {
	if (stashOpen())
		copy()
}

PrintScreen & F14:: {
	if (stashOpen())
		shiftRight(false)
	else
		paste()
}

F15:: {
	if (stashOpen()) {
		Send('{n down}') ; Send the key-down event for 'n'
		KeyWait("F15")     ; Wait until the F15 key is physically released
		Send('{n up}')   ; Send the key-up event for 'n'
	}
	else
		return
}

PrintScreen & F15:: {
	if (stashOpen()) {
		Send('{c down}') ; Send the key-down event for 'c'
		KeyWait("F15")     ; Wait until the F15 key is physically released
		Send('{c up}')   ; Send the key-up event for 'c'
	}
	else
		return
}

ScrollLock & F15:: {
	if (stashOpen())
		sendStashTag("MMF")
}

F16:: {
	if (stashOpen())
		; stashPrev()
		return
	else
		CopySwitchPaste()
}

F17:: {
	if (shiftLeft(true))
		return
	else
		enter()
}

PrintScreen & F17:: {
	if (shiftLeft(false))
		return
	else
		backspace()
}

ScrollLock & F17:: {
	if (stashOpen())
		backspace()
}

F18 & WheelUp:: BrowserFunctions.nextTab()

F18 & WheelDown:: BrowserFunctions.prevTab()

PrintScreen & F18:: {
	if (sendStashTag("SHARED"))
		return
	else
		BrowserFunctions.bitwardenFill()
}

ScrollLock & F19:: {
	if (stashOpen()) {
		sendStashTag("AAUnwanted")
		Sleep(25)
		Send("p")
		Sleep(90)
		Send("n")
	}
	return
}

PrintScreen & F20:: Send("^r")

F21:: Send("^t")
PrintScreen & F21:: Send("^w")

PrintScreen & F24:: duplicateTab()

ScrollLock & F24:: Send("^+t")
#HotIf

class BrowserFunctions {
	static nextTab() {
		Send("^{Tab}")
	}

	static prevTab() {
		Send("^+{Tab}")
	}

	static bitwardenFill() {
		Send("^+l")
	}
}
