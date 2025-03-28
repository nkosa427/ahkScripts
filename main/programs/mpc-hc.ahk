
#HotIf WinActive("ahk_exe mpc-hc64.exe")
F13:: Send("^{PgDn}")
F14:: Send("{Right}")
PrintScreen & F14:: Send("^!{Right}")
F15:: Send("^+d")
F16:: Send("^{PgUp}")
F17:: Send("{Left}")
PrintScreen & F17:: Send("^!{Left}")
F18:: Send("^+a")
F21:: Send("{Space}")
PrintScreen & F21:: Send("^c")
#HotIf
