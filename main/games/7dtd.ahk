#HotIf WinActive("ahk_exe 7DaysToDie.exe")
Toggle := false
ToggleLMB := false

PrintScreen & F15:: holdShiftW(Toggle)
PrintScreen & F18:: holdLMB(ToggleLMB)
F21:: Send("{Tab}")
F24:: Send("m")
#HotIf