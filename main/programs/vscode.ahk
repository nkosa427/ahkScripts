
#HotIf WinActive("ahk_exe Code.exe") or WinActive("ahk_exe Code - Insiders.exe")
F13:: Send("!{F12}")	; Peek Definition
F15:: Send("^{PgDn}")
F18:: Send("^{PgUp}")
F19:: Send("^{i}")
PrintScreen & F19:: Send("^{/}")
#HotIf
