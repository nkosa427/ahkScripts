;;;;;;;;;;;;;;;;;;;;;;;; DEFAULT KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

	;------------------------------------------ No command for F13
	F13::
	{
	   ToolTip("No command for F13", 10, 10)
	}

	;------------------------------------------ Switch to next desktop (Ctrl+Win+Right)
	PrintScreen & F13:: {
		; ToolTip("Sending Desktop Right", 10, 10)
		Send("^#{Right}")
	}
	;------------------------------------------ Copy (Depends on window)
	F14:: copy()

	;------------------------------------------ Paste (Depends on window)
	PrintScreen & F14:: paste()

	;------------------------------------------ Up Arrow (Up)
	F15:: Send("{Up}")

	;------------------------------------------ No command for F16
	F16::
	{
	;    ToolTip("No command for F16", 10, 10)
	}

	;------------------------------------------ Switch to previous desktop (Ctrl+Win+Left)
	PrintScreen & F16:: Send("^#{Left}")

	;------------------------------------------ Go the first desktop (Ctrl+Win+Left several times)
	NumpadMult & F16:: goToFirstDesktop()

	;------------------------------------------ Enter (Enter)
	F17:: enter()

	;------------------------------------------ Backspace (Backspace)
	PrintScreen & F17:: backspace()

	;------------------------------------------ Down Arrow (Down)
	F18:: Send("{Down}")

	;------------------------------------------ No command for F19
	;F19::
	;{
	;    return
	;}

	;------------------------------------------ Volume Up (F19 + Scroll Up)
	F19 & WheelUp:: Send("{Volume_Up}")

	;------------------------------------------ Volume Down (F19 + Scroll Down)
	F19 & WheelDown:: Send("{Volume_Down}")

	;------------------------------------------ Select All (Ctrl+A)
	F19 & MButton:: Send("^a")

	;------------------------------------------ Select All (Ctrl+A)
	PrintScreen & F19:: Send("^a")

	;------------------------------------------ Brightness Up (Alt+PgUp)
	F20:: Send("!{PgUp}")

	;------------------------------------------ Delete (del)
	NumpadMult & F20:: Send("{Del}")

	;------------------------------------------ No command for F21
	;F21::
	;{
	;    return
	;}

	;------------------------------------------ Escape (Esc)
	F22:: Send("{Esc}")

	;------------------------------------------ Task View (Win+Tab)
	PrintScreen & F22:: Send("#{Tab}")

	;------------------------------------------ Brightness Down (Alt+PgDn)
	F23:: Send("!{PgDn}")

	;------------------------------------------ Volume Mute (F23)
	PrintScreen & F23:: SoundSetMute(-1)

	;------------------------------------------ No command for F24
	;F24::
	;{
	;    return
	;}

	;------------------------------------------ Cut (Ctrl+X)
	F24:: Send("^x")

	;------------------------------------------ Close (Depends on window)
	PrintScreen & F24:: close()

	NumpadMult:: {
	}
	PrintScreen:: {
	}
	PrintScreen & NumpadMult:: {
	}
