GroupAdd("browsers", "ahk_exe firefox.exe")
GroupAdd("browsers", "ahk_exe chrome.exe")
GroupAdd("browsers", "ahk_exe msedge.exe")
GroupAdd("browsers", "ahk_exe AnyDesk.exe")

;;;;;;;;;;;;;;;;;;;;;;;; BROWSER KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

; Keybinds for when Browsers are active
#HotIf WinActive("ahk_group browsers")
F13:: {
	if (stashOpen()) {
		Send("{c down}") ; Send the key-down event for 'c'
		KeyWait("F13")     ; Wait until the F13 key is physically released
		Send("{c up}")   ; Send the key-up event for 'c'
	}	
	else
		return
}

PrintScreen & F13:: {
	if (stashOpen()) {
		Send('{b down}') ; Send the key-down event for 'n'
		KeyWait("F13")     ; Wait until the F13 key is physically released
		Send('{b up}')   ; Send the key-up event for 'n'
	}
	else
		return
}

; F13 & WheelUp:: {
; 	if (stashOpen())
; 		stashNext()
; 	else
; 		return
; }

; F13 & WheelDown:: {
; 	if (stashOpen())
; 		stashPrev()
; 	else
; 		return
; }

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

PrintScreen & F15:: {
	if (stashOpen()) {
		Send('r')
		Sleep(10)
		Send('0')
		Sleep(10)
		Send('1')
	} 
	return
}

ScrollLock & F15:: {
	if (stashOpen()) {
		Send('r')
		Sleep(10)
		Send('``')
	}
	return
}

F15:: {
	if (!stashOpen()) {
		return
	}

	; Create GUI menu
	myGui := Gui("+AlwaysOnTop -Caption +Border")
	myGui.SetFont("s12")

	; Add button controls for numbers 1-10
	Loop 10 {
		num := A_Index
		yPos := 10 + (A_Index - 1) * 30
		btn := myGui.Add("Button", "x10 y" . yPos . " w30 h30", num)
		btn.OnEvent("Click", SendNumber.Bind(num))
	}

	; Show GUI centered
	myGui.Show("xCenter yCenter w50 h320")

	; Wait for F15 release
	KeyWait("F15")

	; If F15 released without clicking, destroy GUI
	myGui.Destroy()

	SendNumber(num, *) {
		myGui.Destroy()
		; Activate the Stash window
		WinActivate("Stash - Chromium")
		Sleep(50)
		Send("r")
		Sleep(10)
		for digit in StrSplit(num) {
			Send(digit)
			Sleep(10)
		}
	}
}

F16:: {
	if (stashOpen()) {
		Send('{v down}') ; Send the key-down event for 'v'
		KeyWait("F16")     ; Wait until the F15 key is physically released
		Send('{v up}')   ; Send the key-up event for 'v'
	}
	else
		CopySwitchPaste()
}

PrintScreen & F16:: {
	if (sendStashTag("SHARED"))
		return
	else
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

ScrollLock & F17:: {
	if (stashOpen())
		backspace()
}

F18 & WheelUp:: BrowserFunctions.nextTab()

F18 & WheelDown:: BrowserFunctions.prevTab()

F18 & LButton:: {
	if (stashOpen())
		stashPrev()
	else
		return
}

F18 & RButton:: {
	if (stashOpen())
		stashNext()
	else
		return
}

PrintScreen & F18:: {
	if (sendStashTag("SHARED"))
		return
	else
		BrowserFunctions.bitwardenFill()
}

ScrollLock & F18:: {
	if (shiftLeft(true))
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

F24:: {
	if (stashOpen()) {
		Send("{F11}")
	} else {
		Send("^x")
	}
	
}

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
