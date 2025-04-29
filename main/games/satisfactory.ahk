; Satisfactory Keybinds

#HotIf WinActive("ahk_exe FactoryGameSteam-Win64-Shipping.exe")
SetKeyDelay 50, 50 ; Add delay for key presses within this context

F13::
{
    PressKeyWithDelay("h", 50)
}

PrintScreen & F13::
{
    PressKeyWithDelay("1", 50)
}

PrintScreen & F14::
{
    PressKeyWithDelay("2", 50)
}

PrintScreen & F15::
{
    PressKeyWithDelay("3", 50)
}

F16::
{
    PressKeyWithDelay("q", 50)
}

PrintScreen & F16::
{
    PressKeyWithDelay("4", 50)
}

PrintScreen & F17::
{
    PressKeyWithDelay("5", 50)
}

F18::
{
    PressKeyWithDelay("e", 50)
}

PrintScreen & F18::
{
    PressKeyWithDelay("6", 50)
}

F19::
{
    PressKeyWithDelay("b", 50)
}

PrintScreen & F19::
{
    PressKeyWithDelay("7", 50)
}

PrintScreen & F20::
{
    PressKeyWithDelay("8", 50)
}

F21::
{
    PressKeyWithDelay("Tab", 50)
}

PrintScreen & F21::
{
    PressKeyWithDelay("9", 50)
}

F22::
{
    PressKeyWithDelay("Esc", 50)
}

F24::
{
    PressKeyWithDelay("m", 50)
}

PrintScreen & F24::
{
    PressKeyWithDelay("0", 50)
}

#HotIf ; End of game-specific hotkeys
