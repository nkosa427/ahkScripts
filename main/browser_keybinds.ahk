GroupAdd("browsers", "ahk_exe firefox.exe")
GroupAdd("browsers", "ahk_exe chrome.exe")
GroupAdd("browsers", "ahk_exe msedge.exe")
GroupAdd("browsers", "ahk_exe AnyDesk.exe")

;;;;;;;;;;;;;;;;;;;;;;;; BROWSER KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Browsers are active
#HotIf WinActive("ahk_group browsers")
F13:: {
	if (stashOpen())
		return
}

F13 & WheelUp:: {
	if (shiftRight(false))
		return
}

F13 & WheelDown:: {
	if (shiftLeft(false))
		return
}

NumpadMult & F13:: {
	if (stashOpen())
		paste()
}

; F15:: BrowserFunctions.nextTab()
F14 & WheelUp:: {
	BrowserFunctions.nextTab()
}

F14 & WheelDown:: {
	BrowserFunctions.prevTab()
}

F14 & PrintScreen:: Send("^t")

F14 & NumpadMult:: Send("^w")

F14 & WheelLeft:: Send("^+t")

NumpadMult & F15:: {
	if (sendStashTag("MMF"))
		return
}

F15:: {
	if (stashOpen())
		return
	else
		copy()
}

PrintScreen & F15:: {
	if (stashOpen())
		return
	else
		paste()
}

F15 & WheelUp:: {
	if (stashNext())
		return
}

F15 & WheelDown:: {
	if (stashPrev())
		return
}

F16:: {
	if (stashOpen())
		return
	else
		CopySwitchPaste()
}

F16 & WheelUp:: {
	if (shiftRight(true))
		return
}

F16 & WheelDown:: {
	if (shiftLeft(true))
		return
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

NumpadMult & F17:: {
	if (stashOpen())
		backspace()
}

; F18:: BrowserFunctions.prevTab()

PrintScreen & F18:: {
	if (sendStashTag("SHARED"))
		return
	else
		BrowserFunctions.bitwardenFill()
}

; F19:: {

; }

NumpadMult & F19:: {
	if (!stashOpen())
		CopySwitchPasteMod()
}

PrintScreen & F20:: Send("^r")

; F21:: Send("^t")

PrintScreen & F21:: duplicateTab()

; PrintScreen & F24:: Send("^w")

; NumpadMult & F24:: Send("^+t")

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