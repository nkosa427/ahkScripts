
;;;;;;;;;;;;;;;;;;;;;;;; BROWSER KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Browsers are active
#HotIf WinActive("ahk_group browsers")
F13:: {
	if (stashOpen())
		stashNext()
	; else
	; 	copyURL()
}
NumpadMult & F13:: {
	if (stashOpen())
		paste()
}
F14:: {
	if (stashOpen())
		shiftRight(true)
	else
		copy()
}
NumpadMult & F14:: {
	if (stashOpen())
		copy()
}
PrintScreen & F14:: {
	if (stashOpen())
		shiftRight(false)
	else
		paste()
}
F15:: nextTab()
NumpadMult & F15:: {
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
NumpadMult & F17:: {
	if (stashOpen())
		backspace()
}
F18:: prevTab()
PrintScreen & F18:: {
	if (stashOpen())
		sendStashTag("SHARED")
	else
		bitwardenFill()
}
NumpadMult & F18:: bitwardenFill()
NumpadMult & F19:: {
	if (!stashOpen())
		CopySwitchPasteMod()
}
PrintScreen & F20:: Send("^r")
F21:: Send("^t")
PrintScreen & F21:: duplicateTab()
NumpadMult & F24:: Send("^+t")
#HotIf