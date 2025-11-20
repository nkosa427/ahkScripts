# Claude Code Project Overview

This document provides important context and "common sense" information for the Claude Code agent when working on this AutoHotkey scripts repository.

## Main Script: `main.ahk`

-   **`main.ahk`** is the central AutoHotkey script that is executed.
-   It includes all other necessary script files using `#include` directives.
-   All game and program-specific keybinds should be added as includes in `main.ahk` to be active.

## Code Organization

The repository is structured as follows:

-   `games/`: Contains AutoHotkey script files for specific games.
-   `programs/`: Contains AutoHotkey script files for specific programs.
-   `functions/`: Contains reusable functions used across multiple scripts.
-   `default_keybinds.ahk`: Contains global default keybinds.
-   `browser_keybinds.ahk`: Contains keybinds specific to web browsers.

## Script info
- Keybinds should generally be stored in ascending order based on the key it's from. So F13 will always be before binds that use F20. Also store modifications like PrintScreen & F13 below the regular F13 bind if it's there. 

## Git Workflow

When making changes, please adhere to the following Git workflow:

1.  **Create a new branch** for the feature or bugfix.
2.  **Commit your changes** to the new branch with a descriptive commit message.
3.  **Open a pull request** to merge the changes into the `main` branch.
4.  **Do not push directly to `main`**.

Don't ask me for branch names or commit log suggestions, etc. Just make it easy to understand if we ever need to go back.

## Adding keybinds
When I ask to add a keybind to a game/program, search to see if that file already exists. It should be linked in main.ahk so use that as the starting point.

## Keybinding Conventions

-   All game or program-specific keybinds should be enclosed within a `#HotIf WinActive("ahk_exe ProcessName.exe")` block, ending with `#HotIf`.
-   Keybindings should generally follow the format `FXX:: Send("key")`.
-   Keybinding files should be placed in the appropriate directory (`games/` or `programs/`).
