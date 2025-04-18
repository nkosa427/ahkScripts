#HotIf WinActive("ahk_exe EscapeFromTarkov.exe")
ScrollLock & F13:: Send("y")
F21:: Send("{Tab}")
PrintScreen & F23:: Send("{F11}")
F24:: {
	Send("{m down}")
	KeyWait("F24")
	Send("{m up}")
}
#HotIf