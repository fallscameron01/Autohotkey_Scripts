/*
Various macros I use on my personal machine.

List of Hotkeys:
F15 = ChatGPT
F16 = Claude
F17 = Open WebUI
F18 = LSFG 2x
F19 = LSFG Adaptive 165 Hz
F21 = Notepad++
F22 = Open terminal and run lfcd
F23 = Open terminal and run sudo lfcd
Win + Numpad5 = Open today\'s Joplin journal entry
Ctrl + Win + Down Arrow = minimize active window
Ctrl + Win + Up Arrow = maximize/restore last minimized window
*/

#Requires AutoHotkey v2.0

; try activating the window until it is active
ActivateWindowUntilActive(windowTitle) {
    loop {
        WinActivate(windowTitle)
        Sleep(100)  ; wait before checking
        if WinActive(windowTitle)
            break
    }
}

; wait for the window to load
WinLoaded(windowTitle) {
    loop {
        if WinExist(windowTitle)
            break
        Sleep(100)  ; wait before checking
    }
}

; wait until windows key isn't pressed
WinKeyPressed() {
    if (GetKeyState("LWin", "P") || GetKeyState("RWin", "P")) { ; check if a win key is pressed
        while (GetKeyState("LWin", "P") || GetKeyState("RWin", "P")) { ; wait until both LWin and RWin are released
            Sleep(100)
        }
    }
}

; move a window to the right half of the secondary monitor, resizing it to fit
MoveActiveWindowRightHalfSecondary(windowTitle) {
    ; move to secondary screen to avoid resize issues
    WinMove(-1500, 500, 500, 500, windowTitle)

    ; Your secondary display is monitor 1
    MonitorGetWorkArea(1, &L, &T, &R, &B)

    W := R - L
    H := B - T
    HalfW := W // 2

    ; Right half of monitor 1
    WinMove(L + HalfW, T, HalfW, H, windowTitle)
}

; F15 (Macro Layer 3 Numpad 1)
; Open ChatGPT window
F15::
{
    ; if WinExist("ahk_class CropAndLock.ReparentCropAndLockWindow")
    if WinExist("ChatGPT — Mozilla Firefox") ; window already exists, activate it
    {
        ActivateWindowUntilActive("ChatGPT — Mozilla Firefox")
    }
    else ; window doesn't exist, need to open
    {
        Run('"C:\Program Files\Mozilla Firefox\firefox.exe" "-taskbar-tab" "f537cc3f-78c8-4f65-8179-eff1a0f13449" "-new-window" "https://chatgpt.com" "-container" "0"') ; open chatgpt
        WinLoaded("ChatGPT — Chatgpt in Mozilla Firefox") ; wait for window to load
        WinRestore("ChatGPT — Chatgpt in Mozilla Firefox")

        MoveActiveWindowRightHalfSecondary("ChatGPT — Chatgpt in Mozilla Firefox")
        Send("^#t") ; Ctrl + Win + T to toggle Always On Top
    }
}

; F16 (Macro Layer 3 Numpad 2)
; Open Claude window
F16::
{
    if WinExist("Claude — Mozilla Firefox") ; window already exists, activate it
    {
        ActivateWindowUntilActive("Claude — Mozilla Firefox")
    }
    else ; window doesn't exist, need to open
    {
        Run('"C:\Program Files\Mozilla Firefox\firefox.exe" "-taskbar-tab" "3e128045-6d2f-4877-9bd7-685713ecd63c" "-new-window" "https://claude.ai/" "-container" "0"') ; open Claude
        WinLoaded("Claude — Claude in Mozilla Firefox") ; wait for window to load
        WinRestore("Claude — Claude in Mozilla Firefox")

        MoveActiveWindowRightHalfSecondary("Claude — Claude in Mozilla Firefox")
        Send("^#t") ; Ctrl + Win + T to toggle Always On Top
    }
}

; F17 (Macro Layer 3 Numpad 3)
; Open WebUI window
F17::
{
    if WinExist("Open WebUI — Mozilla Firefox") ; window already exists, activate it
    {
        ActivateWindowUntilActive("Open WebUI — Mozilla Firefox")
    }
    else ; window doesn't exist, need to open
    {
        Run('"C:\Program Files\Mozilla Firefox\firefox.exe" "-taskbar-tab" "cb8181cf-6a59-4467-ae92-0a29c550d8b9" "-new-window" "http://localhost:3000/" "-container" "0"') ; open Open WebUI
        WinLoaded("Open WebUI — Open WebUI in Mozilla Firefox") ; wait for window to load
        WinRestore("Open WebUI — Open WebUI in Mozilla Firefox")

        MoveActiveWindowRightHalfSecondary("Open WebUI — Open WebUI in Mozilla Firefox")
        Send("^#t") ; Ctrl + Win + T to toggle Always On Top
    }
}

; F18 (Macro Layer 3 Numpad 4)
; Open and Activate LSFG 2x
F18::
{
    ; TODO: If already active, deactivate

    Run('"C:\Program Files (x86)\Steam\steamapps\common\Lossless Scaling\LosslessScaling.exe"') ; open LS
    WinLoaded("ahk_exe LosslessScaling.exe") ; wait for window to load
    WinRestore("ahk_exe LosslessScaling.exe")

    ; move to secondary screen to avoid resize issues
    x := 0
    WinGetPos(&x)
    if (x >= 0) {
        WinMove(-1500, 500, 700, 700, "ahk_exe LosslessScaling.exe")
    }

    WinKeyPressed()

    WinMove(-2400, 239, 1200, 1290, "ahk_exe LosslessScaling.exe") ; position on left half of 2nd screen
    Send("{Tab}{Tab}{Down}") ; navigate to 2x profile
    Send("{Alt down}{Esc}{Alt up}") ; switch back to previous window

    Sleep(300)

    Send("^!s") ; activate LS
}

; F19 (Macro Layer 3 Numpad 5)
; Open and Activate LSFG Adaptive 165 Hz
F19::
{
    ; TODO: If already active, deactivate

    Run('"C:\Program Files (x86)\Steam\steamapps\common\Lossless Scaling\LosslessScaling.exe"') ; open LS
    WinLoaded("ahk_exe LosslessScaling.exe") ; wait for window to load
    WinRestore("ahk_exe LosslessScaling.exe")

    ; move to secondary screen to avoid resize issues
    x := 0
    WinGetPos(&x)
    if (x >= 0) {
        WinMove(-1500, 500, 700, 700, "ahk_exe LosslessScaling.exe")
    }

    WinKeyPressed()

    WinMove(-2400, 239, 1200, 1290, "ahk_exe LosslessScaling.exe")  ; position on left half of 2nd screen
    Send("{Tab}{Tab}{Down}{Down}") ; navigate to adaptive 165 hz profile
    Send("{Alt down}{Esc}{Alt up}") ; switch back to previous window

    Sleep(300)

    Send("^!s") ; activate LS
}

; F21 (Macro Layer 3 Numpad 7)
; Open and Activate Notepad++
F21::
{
    if WinExist("ahk_class Notepad++") ; window already exists, activate it and open new file
    {
        ActivateWindowUntilActive("ahk_class Notepad++") ; make sure window is active
        Send("^n") ; Ctrl + N open a new file
    }
    else ; window doesn't exist, need to open
    {
        Run('"C:\Program Files\Notepad++\notepad++.exe"') ; open notepad++
        WinLoaded("ahk_class Notepad++") ; wait for window to load
        WinMaximize()
        Send("^n") ; Ctrl + N open a new file
    }
}

; F22 (Macro Layer 3 Numpad 8)
; Open terminal with lf
F22::
{
    Run('"C:\Users\Cameron\AppData\Local\Microsoft\WindowsApps\wt.exe"') ; open terminal
    Sleep(300)  ; wait before checking
    WinLoaded("ahk_exe WindowsTerminal.exe") ; wait for window to load
    WinMaximize()
    WinKeyPressed() ; make sure windows key isn't pressed so computer doesn't lock
    Send("lfcd{Enter}") ; enter lfcd command
}

; F23 (Macro Layer 3 Numpad 9)
; Open terminal with lf as administrator
F23::
{
    Run('"C:\Users\Cameron\AppData\Local\Microsoft\WindowsApps\wt.exe"') ; open terminal
    Sleep(300)  ; wait before checking
    WinLoaded("ahk_exe WindowsTerminal.exe") ; wait for window to load
    WinMaximize()
    WinKeyPressed() ; make sure windows key isn't pressed so computer doesn't lock
    Send("sudo lfcd{Enter}") ; enter lfcd command
}

; Win + Numpad5
; Open today's Joplin journal entry TODO switch to obsidian
#Numpad5::
{
    Run('"C:\Users\Cameron\scoop\apps\joplin\current\Joplin.exe"') ; open Joplin
    WinLoaded("ahk_exe Joplin.exe") ; wait for window to load
    Sleep(1000)
    WinLoaded("ahk_exe Joplin.exe") ; wait for window to load

    ; move to main screen
    x := 0
    WinGetPos(&x)
    if (x <= 0) {
        WinMove(500, 500, 700, 700, "ahk_exe Joplin.exe")
    }
    WinMaximize()

    Sleep(500)

    Send("^!d") ; open today's journal entry
}

; Win + Ctrl + Down Arrow
; minimize the active window
#^Down::
{
    hWnd := WinExist("A")
    class := WinGetClass("ahk_id " hWnd)

    ; don't minimize desktop or task bar
    if (class = "Progman" || class = "WorkerW" || class = "" || class = "Shell_TrayWnd" || class =
        "Shell_SecondaryTrayWnd")
        return

    ; minimize current window
    WinMinimize("ahk_id " hWnd)

    ; attempt natural focus shift
    Sleep(100)

    ; if same window still active, force focus to next window
    if (WinActive("ahk_id " hWnd)) {
        ; switch to next window by Alt+Esc
        Send("{Alt down}{Esc}{Alt up}")
    }
}

; Win + Ctrl + Up Arrow
; maximize the last minimized window
#^Up::
{
    ; retrieve list of all windows
    winList := WinGetList()

    loop winList.Length ; check all windows in order
    {
        win := winList[winList.Length - A_Index + 1]
        if WinGetMinMax(win) = -1 ; if window is minimized, reactivate
        {
            WinRestore(win)
            WinActivate(win)
            break
        }
    }
}
