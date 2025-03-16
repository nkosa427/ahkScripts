#Requires AutoHotkey v2.0
#SingleInstance Force

; Include GDI+ library
#Include <Gdip_All>

; Include the message system
#Include ShowMessages.ahk

; Include screenshot functionality
#Include Screenshot.ahk

PressKey(key, times := 1, baseDelay := 100) {
    ; Validate inputs
    if !(key is String) || key == ""
        throw ValueError("`key` must be a non-empty string", -1)
    if !(times is Integer) || times < 1
        throw ValueError("`times` must be a positive integer", -1)
    if baseDelay < 0
        throw ValueError("`baseDelay` cannot be negative", -1)

    Loop times {
        ; Calculate the display time (max of 2000ms or the random delay)
        randomDelay := Random(
            Max(0, baseDelay - 100), 
            baseDelay + 100
        )
        displayTime := Max(2000, randomDelay)
        
        ShowMessage(times > 1 ? 
            Format("Pressing {} ({}/{})`nBase Delay: {}ms (Actual: {}ms)", key, A_Index, times, baseDelay, randomDelay) :
            Format("Pressing {}`nBase Delay: {}ms (Actual: {}ms)", key, baseDelay, randomDelay),
            displayTime)
        
        Send key
        Sleep randomDelay
    }
}

HoldSpace(minutes := 0, seconds := 0) {
    ; Validate inputs
    if minutes < 0 || seconds < 0
        throw ValueError("Minutes/seconds cannot be negative.")
    
    totalMs := (minutes * 60 + seconds) * 1000
    if totalMs <= 0
        throw ValueError("Duration must be greater than 0.")
    
    ShowMessage(Format("Holding Space for {}m {}s", minutes, seconds), totalMs)
    Send "{Space Down}"   ; Press and hold Spacebar
    Sleep totalMs         ; Wait for the specified duration
    Send "{Space Up}"     ; Release Spacebar
}

RunAutoSequence() {
    ShowMessage("Starting auto sequence", 2000)
    PressKey("{Esc}", 1, 3000)
    
    ; Verify the screen state after pressing Esc
    if !VerifyScreenMatch(324, 182, 100, 25, A_WorkingDir "\pause_campaign 324x182 w100 h25.png") {
        ShowMessage("Screen verification failed - sequence aborted", 3000)
        return
    }
    
    ShowMessage("Screen verification passed, continuing sequence", 2000)
    
    PressKey("{PgDn}", 6, 700)
    Sleep 1500
    PressKey("{Enter}", 1, 2400)

    ;Eventlab
    PressKey("{Enter}", 1, 2400)

    ;My History
    PressKey("{PgDn}", 14, 200)
    Sleep 1200
    PressKey("{Enter}", 1, 4000)

    ;Choose Race Type
    PressKey("{Enter}", 1, 5000)

    ;Car select
    PressKey("{Enter}", 1, 0)
    ShowMessage("Sleeping for 40s", 40000)
    Sleep 40000

    ;Start Race
    PressKey("{Enter}", 1, 7000)

    ;Hold space key for 1m 15s
    HoldSpace(1, 14)

    PressKey("{Enter}", 1, 2500)
    PressKey("{Enter}", 10, 1300)
    
    ShowMessage("Auto sequence completed successfully", 2000)
}

; Add global variable for loop control
global isRunning := false

F3::
{
    try {
        ; Define the coordinates and save path
        x := 324
        y := 182
        width := 100
        height := 100
        savePath := A_WorkingDir . "\screenshot.png"

        ; Capture the screenshot
        CaptureScreenshot(x, y, width, height, savePath)
        ShowMessage("Screenshot captured and saved to " savePath)
    } catch Error as e {
        ShowMessage("Error: " e.Message)
    }
}

F1::  
{
    global isRunning
    if (isRunning) {
        isRunning := false
        ShowMessage("Stopping auto-sequence loop")
        return
    }

    isRunning := true
    
    while (isRunning) { 
        RunAutoSequence()
        ShowMessage("Auto-sequence loop completed", 9000)

        if !WinActive("Forza Horizon 5") {
            isRunning := false
            ShowMessage("Forza Horizon 5 window lost focus - stopping")
            break
        }
        Sleep 9000
        ShowMessage("Starting auto-sequence loop")
    }
}

VerifyScreenMatch(x, y, width, height, referencePath, similarity := 0.9) {
    if !FileExist(referencePath)
        throw ValueError("Reference image does not exist: " referencePath)

    ShowMessage("Verifying screen match...", 2000)

    ; Initialize GDI+
    pToken := Gdip_Startup()

    ; Capture current screen region
    Screen := x . "|" . y . "|" . width . "|" . height
    tempFile := A_Temp "\temp_verify.png"
    
    ; Capture and save current screen
    pBitmap := Gdip_BitmapFromScreen(Screen)
    Gdip_SaveBitmapToFile(pBitmap, tempFile)
    Gdip_DisposeImage(pBitmap)
    ShowMessage("Screenshot saved to " tempFile, 2000)

    ; Load both images for comparison
    pBitmap1 := Gdip_CreateBitmapFromFile(tempFile)
    pBitmap2 := Gdip_CreateBitmapFromFile(referencePath)

    ; Get dimensions
    Width1 := Gdip_GetImageWidth(pBitmap1)
    Height1 := Gdip_GetImageHeight(pBitmap1)
    Width2 := Gdip_GetImageWidth(pBitmap2)
    Height2 := Gdip_GetImageHeight(pBitmap2)

    ShowMessage(Format("Image 1: {}x{} | Image 2: {}x{}", Width1, Height1, Width2, Height2), 2000)

    ; Ensure dimensions match
    if (Width1 != Width2 || Height1 != Height2) {
        Gdip_DisposeImage(pBitmap1)
        Gdip_DisposeImage(pBitmap2)
        Gdip_Shutdown(pToken)
        FileDelete(tempFile)
        ShowMessage("Image dimensions do not match: " Width1 "x" Height1 " vs " Width2 "x" Height2, 3000)
        return false
    }

    ; Compare the images
    matchCount := 0
    totalPixels := Width1 * Height1

    Loop Height1 {
        y := A_Index - 1
        Loop Width1 {
            x := A_Index - 1
            if (Gdip_GetPixel(pBitmap1, x, y) = Gdip_GetPixel(pBitmap2, x, y))
                matchCount++
        }
    }

    ; Clean up
    Gdip_DisposeImage(pBitmap1)
    Gdip_DisposeImage(pBitmap2)
    Gdip_Shutdown(pToken)
    FileDelete(tempFile)

    ; Return true if similarity threshold is met
    ShowMessage(Format("Match count: {} / {} ({}%)", matchCount, totalPixels, Round((matchCount / totalPixels) * 100, 2)), 3000)
    return (matchCount / totalPixels) >= similarity
}