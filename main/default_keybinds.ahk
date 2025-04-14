;;;;;;;;;;;;;;;;;;;;;;;; DEFAULT KEYBINDS ;;;;;;;;;;;;;;;;;;;;;;;;

	;------------------------------------------ No command for F13
	; F13::

	;------------------------------------------ Switch to next desktop (Ctrl+Win+Right)
	; PrintScreen & F13:: {
	; 	desktopRight()
	; }
	;------------------------------------------ Copy (Depends on window)
	F14:: copy()

	;------------------------------------------ Paste (Depends on window)
	PrintScreen & F14:: paste()

	; ;------------------------------------------ Up Arrow (Up)
	; F15:: Send("{Up}")

	;------------------------------------------ No command for F16
	F16::
	{
	;    ToolTip("No command for F16", 10, 10)
	}

	;------------------------------------------ Switch to previous desktop (Ctrl+Win+Left)
	; PrintScreen & F16:: desktopLeft()

	;------------------------------------------ Go the first desktop (Ctrl+Win+Left several times)
	NumpadMult & F16:: goToFirstDesktop()

	;------------------------------------------ Enter (Enter)
	F17:: enter()

	;------------------------------------------ Backspace (Backspace)
	PrintScreen & F17:: backspace()

	; ;------------------------------------------ Down Arrow (Down)
	; F18:: Send("{Down}")

	;------------------------------------------ No command for F19
	;F19::
	;{
	;    return
	;}

	F19 & WheelUp:: {
		desktopRight()
	}

	F19 & WheelDown:: {
		desktopLeft()
	}

	;------------------------------------------ Select All (Ctrl+A)
	F19 & MButton:: Send("^a")

	;------------------------------------------ Select All (Ctrl+A)
	PrintScreen & F19:: Send("^a")

	;------------------------------------------ No command for F20
	; F20::

	;------------------------------------------ Volume Up (F20 + Scroll Up)
	F20 & WheelUp:: Send("{Volume_Up}")

	;------------------------------------------ Volume Down (F20 + Scroll Down)
	F20 & WheelDown:: Send("{Volume_Down}")


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

	;------------------------------------------ No command for F23
	; F23:: 
	
	;------------------------------------------ Brightness Up (Alt+PgUp)
	F23 & WheelUp:: Send("!{PgUp}")

	;------------------------------------------ Brightness Down (Alt+PgDn)
	F23 & WheelDown:: Send("!{PgDn}")

	;------------------------------------------ No command for F24
	;F24::
	;{
	;    return
	;}

	;------------------------------------------ Cut (Ctrl+X)
	F24:: Send("^x")

	;------------------------------------------ Close (Depends on window)
	; PrintScreen & F24:: {
	; }

	; NumpadMult:: {
	; }
	; PrintScreen:: {
	; }
	; PrintScreen & NumpadMult:: {
	; }
