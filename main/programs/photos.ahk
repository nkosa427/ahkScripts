#HotIf WinActive("ahk_exe ApplicationFrameHost.exe") and winHasTitle("Photos")
F16 & WheelUp:: Send("^{=}")
F16 & WheelDown:: Send("^{-}")
PrintScreen & F19:: Send("^w")
F22:: Send("^0")
#HotIf