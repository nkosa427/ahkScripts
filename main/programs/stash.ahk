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

F15 & WheelUp:: {
	Send("!]")
}

F15 & WheelDown:: {
	Send("![")
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

F24 & WheelUp:: {
	Send("+]")
}

F24 & WheelDown:: {
	Send("+[")
}

PrintScreen & F24:: Send("{F11}")

#HotIf
