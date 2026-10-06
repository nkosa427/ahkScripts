# Agent Guidelines for AHK Project

This document provides instructions for AI agents (like Roo or Claude) when adding or modifying scripts in this repository.

## Project Overview
- **Language**: AutoHotkey (AHK) v2.0
- **Main Entry Point**: [`main.ahk`](main.ahk)
- **Structure**:
  - [`games/`](games/): Game-specific keybinds.
  - [`programs/`](programs/): Program-specific keybinds.
  - [`functions/`](functions/): Reusable logic and helper functions.
  - [`Lib/`](Lib/): External libraries (e.g., UIA-v2).
  - [`default_keybinds.ahk`](default_keybinds.ahk): Global default keybinds.
  - [`browser_keybinds.ahk`](browser_keybinds.ahk): Browser-specific keybinds.

## Keybinding Standards

### Trigger Keys
- **Primary Keys**: `F13` through `F24`.
- **Custom Modifiers**: `PrintScreen` and `AppsKey` (Menu key) are frequently used as modifiers. `AppsKey` is reserved for AHK (bound to a mouse button in Razer Synapse) and never reaches Windows on its own.
- **Combinations**: Use the `&` operator for custom modifiers (e.g., `PrintScreen & F14::`).
- **Mouse Wheel**: Combinations like `F20 & WheelUp::` are common for volume or navigation.

### Context Sensitivity
- Always use `#HotIf` to restrict keybinds to specific applications.
- Use `WinActive("ahk_exe ProcessName.exe")` for process-based filtering.
- Use `ahk_group` for grouping multiple processes (e.g., `ahk_group browsers`).

### File Organization & Ordering
- **Ascending Order**: Keybinds within a file should be sorted by the primary key (e.g., `F13` before `F14`).
- **Modifier Placement**: Modified versions of a key (e.g., `PrintScreen & F13`) should be placed immediately after the base keybind (`F13`).
- **Modularity**: Keep game-specific logic in `games/` and program-specific logic in `programs/`.

## Adding a New Script
1. **Create the File**: Place it in `games/` or `programs/` as appropriate.
2. **Include in Main**: Add a `#include` directive in [`main.ahk`](main.ahk).
3. **Use Boilerplate**:
   ```autohotkey
   #HotIf WinActive("ahk_exe example.exe")
   
   F13:: {
       ; Your logic here
   }
   
   #HotIf
   ```

## Common Functions & Libraries
- **Global Helpers**: `copy()`, `paste()`, `enter()`, `backspace()` are defined in [`main.ahk`](main.ahk).
- **Window Helpers**: `winHasTitle(name)`, `activateIfOpen(exeName)`.
- **UIA Support**: The project includes `UIA-v2` for advanced UI automation. Use `#include "%A_ScriptDir%\Lib\UIA-v2\Lib\UIA.ahk"` if needed.

## Git Workflow
- Work in branches.
- Use descriptive commit messages.
- Do not push directly to `main`.
