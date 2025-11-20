#Requires AutoHotkey v2.0
; Message display system that shows multiple messages stacked vertically

; Global variables to store active messages
global g_aMessages := []
global g_iNextID := 1
global g_iMsgWidth := 300  ; Default message width
global g_iMsgHeight := 30   ; Default message height
global g_iDefaultTimeout := 4000  ; Default timeout in ms
global g_iBaseX := A_ScreenWidth - g_iMsgWidth - 20  ; Default X position (right side)
global g_iBaseY := A_ScreenHeight - 100  ; Start position from bottom

; Show a message with specified timeout
ShowMessage(sText, iTimeout := 0)
{
    ; Declare access to global variables
    global g_aMessages, g_iNextID, g_iMsgWidth, g_iMsgHeight, g_iDefaultTimeout, g_iBaseX, g_iBaseY
    
    if (iTimeout = 0)
        iTimeout := g_iDefaultTimeout
    
    ; Create a unique ID for this message
    iMsgID := g_iNextID++
    
    ; Calculate Y position based on existing messages
    iY := g_iBaseY
    for i, msg in g_aMessages
        iY -= (g_iMsgHeight + 5)  ; Add 5px spacing between messages
    
    ; Create GUI - v2 syntax
    myGui := Gui("+AlwaysOnTop -Caption +ToolWindow +LastFound")
    WinSetTransparent(220)
    myGui.BackColor := "202020"
    myGui.SetFont("s10 cWhite", "Segoe UI")
    myGui.Add("Text", "w" . g_iMsgWidth . " Center", sText)
    myGui.Show("x" . g_iBaseX . " y" . iY . " NoActivate")
    
    ; Add message to tracking array
    g_aMessages.Push({id: iMsgID, y: iY, text: sText, gui: myGui})
    
    ; Set timer to remove the message
    SetTimer(() => RemoveMessage(iMsgID), -iTimeout)
    
    return
}

; Remove a message and adjust positions of remaining messages
RemoveMessage(iMsgID)
{
    ; Declare access to global variables
    global g_aMessages, g_iMsgHeight
    
    ; Find the message in the array
    iIndex := 0
    
    for i, msg in g_aMessages
    {
        if (msg.id = iMsgID)
        {
            iIndex := i
            break
        }
    }
    
    if (iIndex > 0)
    {
        ; Remove the message GUI
        g_aMessages[iIndex].gui.Destroy()
        
        ; Remove from array
        g_aMessages.RemoveAt(iIndex)
        
        ; Shift remaining messages down
        iShift := g_iMsgHeight + 5
        for i, msg in g_aMessages
        {
            if (i >= iIndex)
            {
                newY := msg.y + iShift
                msg.y := newY
                msg.gui.Show("y" . newY . " NoActivate")
            }
        }
    }
}

; Example usage:
; ShowMessage("Hello World")
; Sleep(500)
; ShowMessage("Second message", 5000)
; Sleep(500)
; ShowMessage("Third message", 10000)