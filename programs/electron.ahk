#HotIf WinActive("ahk_exe electron.exe")
F14:: Send("^{Insert}")
F15:: Send("{Right}")
F16:: activateIfOpen("firefox.exe")
F18:: Send("{Left}")
PrintScreen & F14:: Send("+{Insert}")
#HotIf