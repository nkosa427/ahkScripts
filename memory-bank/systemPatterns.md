# System Patterns

## System Architecture
- [x] A set of AHK files organized in directories.
- [x] The main script is `main.ahk`, which includes other files for keybinds and functions.
- [x] `browser_keybinds.ahk` contains keybinds specific to browsers.
- [x] `default_keybinds.ahk` contains default keybinds that apply to all windows.
- [x] The `games/` directory contains AHK files for specific games.
- [x] The `programs/` directory contains AHK files for specific programs.

## Key Technical Decisions
- [x] Use AHK for scripting keybinds and automating tasks.

## Design Patterns in Use
- [x] Include files for modularity.
- [x] Use functions to encapsulate logic.

## Component Relationships
- [x] `main.ahk` includes `default_keybinds.ahk`, `browser_keybinds.ahk`, and files from the `programs/` and `games/` directories.

## Critical Implementation Paths
- [x] `main.ahk` is executed to load all keybinds and functions.
