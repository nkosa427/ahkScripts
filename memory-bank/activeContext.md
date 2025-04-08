# Active Context

## Current Work Focus
- [x] Debug and fix `PressKeyWithDelay` function.
- [ ] Update `progress.md` to reflect the fix and debugging steps.

## Recent Changes
- [x] Updated the systemPatterns.md and techContext.md files with information about the 'main/' directory.
- [x] Added `main/games/satisfactory.ahk` and included it in `main/main.ahk`.
- [x] Added F22 hotkey to send {Esc} in `main/games/satisfactory.ahk`.
- [x] Added `SetKeyDelay 50, 50` to the Satisfactory context in `main/games/satisfactory.ahk`.
- [x] Modified F22 hotkey in `main/games/satisfactory.ahk` to use `Send {Esc Down}`, `Sleep 50`, `Send {Esc Up}`.
- [x] Added F21 hotkey in `main/games/satisfactory.ahk` to use `Send {Tab Down}`, `Sleep 50`, `Send {Tab Up}`.
- [x] Created `main/functions/game_functions.ahk` with `PressKeyWithDelay(key, delay)` function.
- [x] Included `main/functions/game_functions.ahk` in `main/main.ahk`.
- [x] Refactored F21 and F22 hotkeys in `main/games/satisfactory.ahk` to use `PressKeyWithDelay`.
- [x] Updated `systemPatterns.md` to reflect the new functions directory and pattern.
- [x] Debugged `PressKeyWithDelay`:
    - Verified function inclusion in `main.ahk`.
    - Confirmed `#HotIf WinActive` condition was correct.
    - Reverted F21 hotkey to inline `SendInput`/`Sleep` (worked).
    - Modified F22 hotkey to use block syntax `{}` (failed).
    - Modified `PressKeyWithDelay` to use `Send` instead of `SendInput` (failed).
    - Modified `PressKeyWithDelay` to explicitly set `SendMode "Input"` (failed).
    - Modified `PressKeyWithDelay` to use string concatenation (`"{" . key . " Down/Up}"`) instead of embedded variable (`"{%key% Down/Up}"`) (SUCCESS).
- [x] Updated `PressKeyWithDelay` in `main/functions/game_functions.ahk` to use string concatenation with `Send`.
- [x] Updated F21 hotkey in `main/games/satisfactory.ahk` to use the fixed `PressKeyWithDelay` function with block syntax.

## Next Steps
- [ ] Update `progress.md` with debugging details and fix.

## Active Decisions and Considerations
- [x] Use block syntax `{}` for hotkeys calling functions or containing multiple commands.
- [x] Use string concatenation (`"{" . key . " Down/Up}"`) for dynamic key names within `Send` commands inside functions, as embedded variables (`{%key% ...}`) might not parse correctly in that context.

## Important Patterns and Preferences
- [x] Read a file, then update it.
- [x] Use reusable functions for common actions like key presses with delays.

## Learnings and Project Insights
- [x] The 'main/' directory contains the core AHK scripts for keybinds and automation.
- [x] The `Send` command in AHK v2 might have issues parsing embedded variables (`{%var%}`) when called from within a function triggered by a hotkey; using string concatenation (`"{" . var . " ...}"`) is a reliable workaround.
