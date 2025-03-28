#HotIf WinActive("ahk_exe Vidupe.exe")
F13:: {
	Send("{Left}")
	Sleep(125)
	Send("{Left}")
	Sleep(150)
	Send("{Enter}")
	Sleep(125)
    Send("{Right}")
    Sleep(125)
    Send("{Right}")
	Sleep(150)
    Send("{Enter}")
}
F15:: {
	Send("{Right}")
	Sleep(125)
	Send("{Right}")
	Sleep(150)
	Send("{Enter}")
	Sleep(125)
    Send("{Left}")
    Sleep(125)
    Send("{Left}")
	Sleep(150)
    Send("{Enter}")
}
#HotIf