#HotIf WinActive("ahk_exe KingdomCome.exe")
F21:: Send("i")
F22:: Send("{Esc down}")
F22 Up:: Send("{Esc up}")
F24:: Send("m")
PrintScreen & F24::Send("j")
#HotIf