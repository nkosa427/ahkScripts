; Satisfactory Keybinds

#HotIf WinActive("ahk_exe FactoryGameSteam-Win64-Shipping.exe")
SetKeyDelay 50, 50 ; Add delay for key presses within this context

F21::
{
    PressKeyWithDelay("Tab", 50)
}

F22::
{
    PressKeyWithDelay("Esc", 50)
}

F24::
{
    PressKeyWithDelay("m", 50)
}

#HotIf ; End of game-specific hotkeys
