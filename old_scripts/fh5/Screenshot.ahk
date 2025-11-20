#Requires AutoHotkey v2.0

; Include GDI+ library
#Include <Gdip_All>

CaptureScreenshot(defaultX := 0, defaultY := 0, defaultWidth := 100, defaultHeight := 100, defaultSavePath := A_WorkingDir "\screenshot.png") {
    ShowInputGui(defaultX, defaultY, defaultWidth, defaultHeight, defaultSavePath)
}

; Function to show the input GUI with coordinate fields
ShowInputGui(inputX, inputY, inputWidth, inputHeight, inputPath) {
    ; Create input GUI
    inputGui := Gui("AlwaysOnTop", "Screenshot Settings")
    
    ; Current Forza window info
    forzaActive := WinExist("Forza Horizon 5")
    winX := 0, winY := 0, winWidth := 0, winHeight := 0
    
    if (forzaActive) {
        WinGetPos(&winX, &winY, &winWidth, &winHeight, "Forza Horizon 5")
        inputGui.Add("Text", "x10 y10", "Forza Window: " winX "," winY " (size: " winWidth "x" winHeight ")")
    } else {
        inputGui.Add("Text", "x10 y10 cRed", "Warning: Forza Horizon 5 window not found")
    }
    
    ; Add input fields with supplied values
    inputGui.Add("Text", "x10 y40", "X Coordinate:")
    xInput := inputGui.Add("Edit", "x100 y40 w60", inputX)
    
    inputGui.Add("Text", "x10 y70", "Y Coordinate:")
    yInput := inputGui.Add("Edit", "x100 y70 w60", inputY)
    
    inputGui.Add("Text", "x10 y100", "Width:")
    widthInput := inputGui.Add("Edit", "x100 y100 w60", inputWidth)
    
    inputGui.Add("Text", "x10 y130", "Height:")
    heightInput := inputGui.Add("Edit", "x100 y130 w60", inputHeight)
    
    inputGui.Add("Text", "x10 y160", "Save Path:")
    pathInput := inputGui.Add("Edit", "x100 y160 w300", inputPath)
    browseBtn := inputGui.Add("Button", "x410 y160 w80", "Browse...")
    browseBtn.OnEvent("Click", BrowseSavePath)
    
    ; Add live preview checkbox
    livePreviewCb := inputGui.Add("Checkbox", "x10 y190 vLivePreview", "Live preview (may affect performance)")

    ; Add live preview timer
    previewTimer := 0
    previewGui := 0
    pToken := 0
    pBitmap := 0
    tempFile := A_Temp "\preview_screenshot.png"
    
    ; Add capture button
    captureBtn := inputGui.Add("Button", "x10 y220 w80", "Capture")
    captureBtn.OnEvent("Click", CaptureNow)
    
    ; Add cancel button
    cancelBtn := inputGui.Add("Button", "x100 y220 w80", "Cancel")
    cancelBtn.OnEvent("Click", CancelCapture)
    
    ; Show the GUI
    inputGui.Show("w500 h260")
    
    shouldSave := false
    userCancelled := false
    savePath := ""
    
    ; Function to browse for save path
    BrowseSavePath(*) {
        selectedFile := FileSelect("S", pathInput.Value, "Save Screenshot As", "Image Files (*.png; *.jpg; *.bmp)")
        if (selectedFile != "")
            pathInput.Value := selectedFile
    }
    
    ; Function to capture screenshot
    CaptureNow(*) {
        ; Get values from input fields
        x := Integer(xInput.Value)
        y := Integer(yInput.Value)
        width := Integer(widthInput.Value)
        height := Integer(heightInput.Value)
        savePath := pathInput.Value
        
        ; Validate inputs
        if (width <= 0 || height <= 0) {
            MsgBox("Width and height must be positive values.", "Invalid Input", "Iconx")
            return
        }
        
        if (savePath = "") {
            MsgBox("Please specify a save path.", "Invalid Input", "Iconx")
            return
        }
        
        ; Disable live preview if active
        DisableLivePreview()
        
        ; Close the input GUI
        inputGui.Destroy()
        
        ; Capture and show the screenshot
        try {
            result := TakeScreenshot(x, y, width, height, savePath)
            
            ; If user canceled in the preview dialog, bring back the input form with the same values
            if (!result) {
                ShowInputGui(x, y, width, height, savePath)
            }
        } catch Error as e {
            ShowMessage("Error: " e.Message, 3000)
            ; In case of error, bring back the input form with the same values
            ShowInputGui(x, y, width, height, savePath)
        }
    }
    
    ; Function to cancel - but preserve values for when we re-open
    CancelCapture(*) {
        ; Disable live preview cleanly
        DisableLivePreview()
        
        ; Get the current values for reuse
        x := Integer(xInput.Value)
        y := Integer(yInput.Value)
        width := Integer(widthInput.Value)
        height := Integer(heightInput.Value)
        savePath := pathInput.Value
        
        ; Close the window
        inputGui.Destroy()
        
        ; Show message and return
        ShowMessage("Screenshot operation cancelled", 2000)
    }
    
    ; Function to disable live preview and clean up resources
    DisableLivePreview() {
        if (previewTimer) {
            SetTimer(previewTimer, 0)
            previewTimer := 0
            
            if (previewGui) {
                previewGui.Destroy()
                previewGui := 0
            }
            
            if (pToken) {
                if (pBitmap)
                    Gdip_DisposeImage(pBitmap)
                Gdip_Shutdown(pToken)
                pToken := 0
                pBitmap := 0
            }
            
            try {
                FileDelete(tempFile)
            }
        }
    }
    
    ; Function for live preview
    UpdateLivePreview() {
        static lastUpdate := 0
        
        ; Limit updates to avoid excessive resource usage (update max once per 500ms)
        if (A_TickCount - lastUpdate < 500)
            return
            
        lastUpdate := A_TickCount
        
        ; Get current values
        try {
            x := Integer(xInput.Value)
            y := Integer(yInput.Value)
            width := Integer(widthInput.Value)
            height := Integer(heightInput.Value)
            
            if (width <= 0 || height <= 0)
                return
                
            ; Adjust coordinates if Forza window is active
            adjX := x
            adjY := y
            
            if (forzaActive) {
                adjX += winX
                adjY += winY
            }
            
            ; Capture the screenshot
            Screen := adjX . "|" . adjY . "|" . width . "|" . height
            Gdip_SaveBitmapToFile(Gdip_BitmapFromScreen(Screen), tempFile)
            
            ; Update the preview image
            if (!previewGui) {
                previewGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20", "Live Preview")
                previewGui.BackColor := "Black"
                previewPic := previewGui.Add("Picture", "w" width " h" height, tempFile)
                previewGui.Show("NoActivate")
            } else {
                ; Get the control by its hwnd - we need to update an existing gui
                WinSetTransparent(220, previewGui)
                previewGui.Move(, adjX, adjY, width, height)
                GuiCtrlFromHwnd(previewGui.hwnd).Value := tempFile
            }
        } catch Error as e {
            ; Silently fail for live preview - it's not critical
        }
    }
    
    ; Monitor changes to the checkbox
    inputGui.OnEvent("Close", CloseInputGui)

    CloseInputGui(*) {
        DisableLivePreview()
        ShowMessage("Screenshot operation cancelled", 2000)
    }
    
    ; Event for checkbox state change
    livePreviewCb.OnEvent("Click", ToggleLivePreview)
    
    ToggleLivePreview(*) {
        if (livePreviewCb.Value) {
            ; Initialize GDI+ for live preview
            pToken := Gdip_Startup()
            
            ; Set up timer for live preview
            previewTimer := (*) => UpdateLivePreview()
            SetTimer(previewTimer, 500)  ; Update every 500ms
        } else {
            ; Turn off live preview
            DisableLivePreview()
        }
    }
    
    ; Wait for the input GUI to close
    WinWaitClose(inputGui)
}

; Helper function to take and preview a screenshot
TakeScreenshot(x, y, width, height, savePath) {
    ShowMessage("Capturing screenshot at " x "," y " with dimensions " width "x" height, 2000)
    
    ; Validate inputs
    if !(x is Integer) || !(y is Integer) || !(width is Integer) || !(height is Integer)
        throw ValueError("x, y, width, and height must be integers.", -1)
    if !(savePath is String) || savePath == ""
        throw ValueError("savePath must be a non-empty string.", -1)

    ; Adjust coordinates based on Forza window if active
    adjX := x
    adjY := y
    
    if WinExist("Forza Horizon 5") {
        WinGetPos(&winX, &winY, &winWidth, &winHeight, "Forza Horizon 5")
        adjX += winX
        adjY += winY
        ShowMessage("Adjusted coordinates: " adjX "," adjY)
    } else {
        ShowMessage("Using screen coordinates: " adjX "," adjY)
    }

    ; Capture the screenshot
    pToken := Gdip_Startup()
    ShowMessage("GDI+ started")
    
    ; Correct format is "x|y|w|h" as a single string parameter
    Screen := adjX . "|" . adjY . "|" . width . "|" . height
    ShowMessage("Screen coordinates: " Screen)
    pBitmap := Gdip_BitmapFromScreen(Screen)
    ShowMessage("Bitmap created")
    
    ; Create preview GUI
    previewGui := Gui("AlwaysOnTop", "Screenshot Preview")
    previewGui.Add("Text", "x10 y10", "Coordinates: " x "," y " | Size: " width "x" height)
    
    ; Save the bitmap to a temporary file for preview
    tempFile := A_Temp . "\preview_screenshot.png"
    Gdip_SaveBitmapToFile(pBitmap, tempFile)
    
    ; Display the image (limit display size for very large screenshots)
    maxDisplayWidth := 1024
    maxDisplayHeight := 768
    displayWidth := width
    displayHeight := height
    
    if (width > maxDisplayWidth || height > maxDisplayHeight) {
        aspectRatio := width / height
        if (width > height) {
            displayWidth := maxDisplayWidth
            displayHeight := maxDisplayWidth / aspectRatio
        } else {
            displayHeight := maxDisplayHeight
            displayWidth := maxDisplayHeight * aspectRatio
        }
    }
    
    previewGui.Add("Picture", "x10 y40 w" displayWidth " h" displayHeight, tempFile)
    
    ; Add save/cancel buttons
    previewGui.Add("Button", "x10 y" (displayHeight + 50) " w80", "Save").OnEvent("Click", Save)
    previewGui.Add("Button", "x100 y" (displayHeight + 50) " w80", "Back").OnEvent("Click", Back)
    
    ; Show the GUI
    previewGui.Show("w" (displayWidth + 20) " h" (displayHeight + 100))
    
    shouldSave := false
    shouldGoBack := false
    
    ; Button event handlers
    Save(*) {
        shouldSave := true
        previewGui.Destroy()
    }
    
    Back(*) {
        shouldGoBack := true
        previewGui.Destroy()
    }
    
    ; Wait for the user to make a decision
    WinWaitClose(previewGui)
    
    ; Save the file if requested
    if (shouldSave) {
        Gdip_SaveBitmapToFile(pBitmap, savePath)
        ShowMessage("Bitmap saved to " savePath)
    } else {
        ShowMessage("Screenshot was canceled")
    }
    
    ; Clean up resources
    Gdip_DisposeImage(pBitmap)
    FileDelete(tempFile)
    Gdip_Shutdown(pToken)
    ShowMessage("GDI+ shut down")
    
    ; Return false if user wants to go back to the input form
    return shouldSave && !shouldGoBack
}