
#HotIf WinActive("ahk_exe Code.exe")
F13:: Send("!{F12}")	; Peek Definition

F18 & WheelUp:: Send("^{PgDn}")   ; Next tab
F18 & WheelDown:: Send("^{PgUp}") ; Previous tab

F19:: Send("^{i}")
PrintScreen & F19:: Send("^{/}")
#HotIf
