
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
PrintScreen & F18:: Send("{F2}")
PrintScreen & F20:: Send("^r")
#HotIf
