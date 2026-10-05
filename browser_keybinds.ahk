GroupAdd("browsers", "ahk_exe firefox.exe")
GroupAdd("browsers", "ahk_exe chrome.exe")
GroupAdd("browsers", "ahk_exe msedge.exe")
GroupAdd("browsers", "ahk_exe AnyDesk.exe")
GroupAdd("browsers", "ahk_exe steamwebhelper.exe")

;;;;;;;;;;;;;;;;;;;;;;;; BROWSER KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Browsers are active
#HotIf WinActive("ahk_group browsers")

F14:: copy()

PrintScreen & F14:: paste()

F16:: CopySwitchPaste()

F17:: enter()

PrintScreen & F17:: backspace()

F18 & WheelUp:: BrowserFunctions.nextTab()

F18 & WheelDown:: BrowserFunctions.prevTab()

PrintScreen & F18:: BrowserFunctions.bitwardenFill()

ScrollLock & F18:: BrowserFunctions.bitwardenFill()

PrintScreen & F20:: Send("^r")

F21:: Send("^t")
PrintScreen & F21:: Send("^w")

F24:: Send("^x")

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
		if (WinActive("ahk_exe msedge.exe")) {
			Send("^+9")
		} else {
			Send("^+l")
		}
	}
}
