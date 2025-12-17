#HotIf WinActive("ahk_group browsers") && stashOpen()

F13:: {
	Send("{c down}") ; Send the key-down event for 'c'
	KeyWait("F13")     ; Wait until the F13 key is physically released
	Send("{c up}")   ; Send the key-up event for 'c'
}

PrintScreen & F13:: {
	Send('{b down}') ; Send the key-down event for 'n'
	KeyWait("F13")     ; Wait until the F13 key is physically released
	Send('{b up}')   ; Send the key-up event for 'n'
}

ScrollLock & F13:: paste()

F14:: shiftRight(true)

ScrollLock & F14:: copy()

PrintScreen & F14:: shiftRight(false)

PrintScreen & F15:: {
	Send('r')
	Sleep(10)
	Send('0')
	Sleep(10)
	Send('1')
}

ScrollLock & F15:: {
	Send('r')
	Sleep(10)
	Send('``')
}

F15:: {
	; Create GUI menu
	myGui := Gui("+AlwaysOnTop -Caption +Border")
	myGui.SetFont("s12")

	; Array to store buttons
	buttons := []

	; Add button controls for numbers 0-99 in 10x10 grid
	Loop 100 {
		num := A_Index - 1
		row := Floor(num / 10)
		col := Mod(num, 10)
		xPos := 10 + col * 30
		yPos := 10 + row * 30
		displayText := Format("{:.1f}", num / 10)
		btn := myGui.Add("Button", "x" . xPos . " y" . yPos . " w30 h30", displayText)
		btn.OnEvent("Click", SendNumber.Bind(num))
		buttons.Push({btn: btn, num: num})
	}

	; Get mouse position
	MouseGetPos(&xpos, &ypos)
	; Show GUI at mouse position
	myGui.Show("x" . xpos . " y" . ypos . " w310 h310")

	; Wait for F15 release
	KeyWait("F15")

	; Destroy GUI when F15 is released
	myGui.Destroy()

	SendNumber(num, *) {
		myGui.Destroy()
		; Activate the Stash window
		WinActivate("Stash - Chromium")
		Sleep(50)
		Send("r")
		Sleep(10)
		numStr := (num < 10 ? "0" : "") . num
		for digit in StrSplit(numStr) {
			Send(digit)
			Sleep(10)
		}
	}
}

F16:: {
	Send('{v down}') ; Send the key-down event for 'v'
	KeyWait("F16")     ; Wait until the F15 key is physically released
	Send('{v up}')   ; Send the key-up event for 'v'
}

PrintScreen & F16:: sendStashTag("SHARED")

F17:: shiftLeft(true)

PrintScreen & F17:: shiftLeft(false)

ScrollLock & F17:: backspace()

F18 & LButton:: stashPrev()

F18 & RButton:: stashNext()

PrintScreen & F18:: sendStashTag("SHARED")

ScrollLock & F18:: shiftLeft(true)

ScrollLock & F19:: {
	sendStashTag("AAUnwanted")
	Sleep(25)
	Send("p")
	Sleep(90)
	Send("n")
}

F24:: Send("{F11}")

#HotIf
