GroupAdd("browsers", "ahk_exe firefox.exe")
GroupAdd("browsers", "ahk_exe chrome.exe")
GroupAdd("browsers", "ahk_exe msedge.exe")
GroupAdd("browsers", "ahk_exe AnyDesk.exe")

;;;;;;;;;;;;;;;;;;;;;;;; BROWSER KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Browsers are active
#HotIf WinActive("ahk_group browsers")
F13:: {
	if (stashNext())
		return
}
Pause & F13:: {
	if (stashOpen())
		paste()
}
F14:: {
	if (stashOpen())
		shiftRight(true)
	else
		copy()
}
Pause & F14:: {
	if (stashOpen())
		copy()
}
PrintScreen & F14:: {
	if (stashOpen())
		shiftRight(false)
	else
		paste()
}
F15:: BrowserFunctions.nextTab()
Pause & F15:: {
	if (stashOpen())
		sendStashTag("MMF")
}
F16:: {
	if (stashOpen())
		stashPrev()
	else
		CopySwitchPaste()
}
F17:: {
	if (stashOpen())
		shiftLeft(true)
	else
		enter()
}
PrintScreen & F17:: {
	if (stashOpen())
		shiftLeft(false)
	else
		backspace()
}
Pause & F17:: {
	if (stashOpen())
		backspace()
}
F18:: BrowserFunctions.prevTab()
PrintScreen & F18:: {
	if (stashOpen())
		sendStashTag("SHARED")
	else
		BrowserFunctions.bitwardenFill()
}
Pause & F19:: {
	if (!stashOpen())
		CopySwitchPasteMod()
}
PrintScreen & F20:: Send("^r")
F21:: Send("^t")
PrintScreen & F21:: duplicateTab()
PrintScreen & F24:: Send("^w")
Pause & F24:: Send("^+t")
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