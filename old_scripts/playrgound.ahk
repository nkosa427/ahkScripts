#Requires AutoHotkey v2.0
#SingleInstance Force

; #HotIf WinActive("ahk_class Progman") || WinActive("ahk_class WorkerW") ; Desktop
F13::
	{
	   ToolTip("No command for F13", 10, 10)
	}

F16::
	{
	   ToolTip("No command for F16", 10, 10)
	}
; #HotIf