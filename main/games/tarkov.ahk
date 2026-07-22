#HotIf WinActive("ahk_exe EscapeFromTarkov.exe")
PrintScreen & F13:: Send("y")
F18:: Send("t")
F21:: Send("{Tab}")
PrintScreen & F23:: Send("{F11}")
F24:: {
	Send("{m down}")
	KeyWait("F24")
	Send("{m up}")
}
#HotIf