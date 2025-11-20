#Requires AutoHotkey v2.0
#Include ShowMessages.ahk

; Press F1 to see a demo of stacked messages
F1::
{
    ShowMessage("First message - disappears in 3 seconds")
    Sleep(100)
    ShowMessage("Second message - disappears in 5 seconds", 5000)
    Sleep(100)
    ShowMessage("Third message - disappears in 10 seconds", 10000)
    Sleep(100)
    ShowMessage("Fourth message - disappears in 2 seconds", 2000)
    Sleep(100)
    ShowMessage("Fifth message - disappears in 4 seconds", 4000)
}