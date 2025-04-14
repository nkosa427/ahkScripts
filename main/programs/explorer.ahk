
#HotIf WinActive("ahk_class CabinetWClass")
MButton:: {
    Send("{LButton}{AppsKey}e")
}

F13:: {
	Send("{Shift down}")
	KeyWait("F13")
	Send("{Shift up}")
}

F16:: Send("!{Tab}")

F18 & WheelUp:: Send("{Up}")

F18 & WheelDown:: Send("{Down}")

PrintScreen & F18:: Send("{F2}")

PrintScreen & F20:: Send("^r")

#HotIf
