# Progress

## What Works
- [x] Creation of the memory bank files and the ability to read and update them.
- [x] Updated the systemPatterns.md and techContext.md files with information about the 'main/' directory.
- [x] Added `main/games/satisfactory.ahk` for the game Satisfactory.
- [x] Included `satisfactory.ahk` in `main/main.ahk`.
- [x] Added F22 hotkey to send {Esc} in `main/games/satisfactory.ahk`.
- [x] Added `SetKeyDelay 50, 50` to the Satisfactory context in `main/games/satisfactory.ahk`.
- [x] Modified F22 hotkey in `main/games/satisfactory.ahk` to use `Send {Esc Down}`, `Sleep 50`, `Send {Esc Up}`.
- [x] Added F21 hotkey in `main/games/satisfactory.ahk` to use `Send {Tab Down}`, `Sleep 50`, `Send {Tab Up}`.
- [x] Created `main/functions/game_functions.ahk` with `PressKeyWithDelay(key, delay)` function.
- [x] Included `main/functions/game_functions.ahk` in `main/main.ahk`.
- [x] Refactored F21 and F22 hotkeys in `main/games/satisfactory.ahk` to use `PressKeyWithDelay`.
- [x] Updated `systemPatterns.md` and `activeContext.md`.
- [x] Successfully debugged and fixed `PressKeyWithDelay` function by using string concatenation for key names within the `Send` command.
- [x] Updated F21 and F22 hotkeys in `satisfactory.ahk` to use the fixed function and block syntax `{}`.

## What's Left to Build
- [ ] Add specific keybinds to `satisfactory.ahk`.

## Current Status
- [x] The memory bank is updated with information about the 'main/' directory and the new `PressKeyWithDelay` function.
- [x] `satisfactory.ahk` now uses the *working* reusable `PressKeyWithDelay` function for F21 and F22 hotkeys.

## Known Issues
- [x] The `Send` command in AHK v2 might have issues parsing embedded variables (`{%var%}`) when called from within a function triggered by a hotkey; using string concatenation (`"{" . var . " ...}"`) is a reliable workaround.

## Evolution of Project Decisions
- [x] Use markdown files for persistent storage and to read and update them at the start of each session.
- [x] Use block syntax `{}` for hotkeys calling functions or containing multiple commands.
- [x] Prefer string concatenation over embedded variables for dynamic key names in `Send` commands within functions called by hotkeys.
