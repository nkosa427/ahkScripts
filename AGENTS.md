# Agent Guidelines for AHK Project

This document provides instructions for AI agents (like Roo or Claude) when adding or modifying scripts in this repository.

## Project Overview
- **Language**: AutoHotkey (AHK) v2.0
- **Main Entry Point**: [`main/main.ahk`](main/main.ahk)
- **Structure**:
  - [`main/games/`](main/games/): Game-specific keybinds.
  - [`main/programs/`](main/programs/): Program-specific keybinds.
  - [`main/functions/`](main/functions/): Reusable logic and helper functions.
  - [`main/Lib/`](main/Lib/): External libraries (e.g., UIA-v2).
  - [`main/default_keybinds.ahk`](main/default_keybinds.ahk): Global default keybinds.
  - [`main/browser_keybinds.ahk`](main/browser_keybinds.ahk): Browser-specific keybinds.

## Keybinding Standards

### Trigger Keys
- **Primary Keys**: `F13` through `F24`.
- **Custom Modifiers**: `PrintScreen` and `ScrollLock` are frequently used as modifiers.
- **Combinations**: Use the `&` operator for custom modifiers (e.g., `PrintScreen & F14::`).
- **Mouse Wheel**: Combinations like `F20 & WheelUp::` are common for volume or navigation.

### Context Sensitivity
- Always use `#HotIf` to restrict keybinds to specific applications.
- Use `WinActive("ahk_exe ProcessName.exe")` for process-based filtering.
- Use `ahk_group` for grouping multiple processes (e.g., `ahk_group browsers`).

### File Organization & Ordering
- **Ascending Order**: Keybinds within a file should be sorted by the primary key (e.g., `F13` before `F14`).
- **Modifier Placement**: Modified versions of a key (e.g., `PrintScreen & F13`) should be placed immediately after the base keybind (`F13`).
- **Modularity**: Keep game-specific logic in `main/games/` and program-specific logic in `main/programs/`.

## Adding a New Script
1. **Create the File**: Place it in `main/games/` or `main/programs/` as appropriate.
2. **Include in Main**: Add a `#include` directive in [`main/main.ahk`](main/main.ahk).
3. **Use Boilerplate**:
   ```autohotkey
   #HotIf WinActive("ahk_exe example.exe")
   
   F13:: {
       ; Your logic here
   }
   
   #HotIf
   ```

## Common Functions & Libraries
- **Global Helpers**: `copy()`, `paste()`, `enter()`, `backspace()` are defined in [`main/main.ahk`](main/main.ahk).
- **Window Helpers**: `winHasTitle(name)`, `activateIfOpen(exeName)`.
- **UIA Support**: The project includes `UIA-v2` for advanced UI automation. Use `#include "%A_ScriptDir%\Lib\UIA-v2\Lib\UIA.ahk"` if needed.

## Git Workflow
- Work in branches.
- Use descriptive commit messages.
- Do not push directly to `main`.
