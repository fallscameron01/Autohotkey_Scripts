/*
Various macros I use on my personal machine.

List of Hotkeys:
Win + Numpad1 = ChatGPT
Win + Numpad2 = LSFG 2x
Win + Numpad3 = New Notepad++
Win + Numpad4 = lfcd terminal
Ctrl + Win + Numpad4 = lfcd admin terminal
Ctrl + Win + Down Arrow = minimize
Ctrl + Win + Up Arrow = maximize the last minimized window
*/

#Requires AutoHotkey v2.0

; try activating the window until it is active
ActivateWindowUntilActive(windowTitle) {
    loop {
        WinActivate(windowTitle)
        Sleep(100)  ; Wait before checking
        if WinActive(windowTitle)
            break
    }
}

; wait for the window to load
WinLoaded(windowTitle) {
    loop {
        if WinExist(windowTitle)
            break
        Sleep(100)  ; Wait before checking
    }
}

; wait until windows key isn't pressed
WinKeyPressed() {
    ; Check if either LWin or RWin is pressed
    if (GetKeyState("LWin", "P") || GetKeyState("RWin", "P")) {
        ; Wait until both LWin and RWin are released
        while (GetKeyState("LWin", "P") || GetKeyState("RWin", "P")) {
            Sleep(100)
        }
    }
}

; Win + Numpad1
; Open ChatGPT window
#Numpad1::
{
    ; if WinExist("ahk_class CropAndLock.ReparentCropAndLockWindow")
    if WinExist("ChatGPT — Mozilla Firefox") ; window already exists, activate it
    {
        ActivateWindowUntilActive("ChatGPT — Mozilla Firefox")
        ; Send("^#t") ; Ctrl + Win + T to toggle Always On Top
    }
    else ; window doesn't exist, need to open
    {
        Run('"C:\Program Files\Mozilla Firefox\firefox.exe" --new-window "https://chatgpt.com/"') ; open chatgpt
        WinLoaded("ChatGPT — Mozilla Firefox") ; wait for window to load
        WinRestore("ChatGPT — Mozilla Firefox")

        ; move to main screen to avoid resize issues
        x := 0
        WinGetPos(&x)
        if (x <= 0) {
            WinMove(500, 500, 700, 700, "ChatGPT — Mozilla Firefox")
        }

        WinMove(1811, 221, 757, 1167, "ChatGPT — Mozilla Firefox") ; move and resize the window
        Send("^#t") ; Ctrl + Win + T to toggle Always On Top

        ; TODO: Crop and Lock the window to make it look cleaner
    }
}

; Win + Numpad2
; Open and Activate LSFG 2x
; TODO: open LS > Press Tab twice, Press Down Arrow once > minimize or put window somewhere > switch back to original tab and press shortcut

; Win + Numpad3
; Open and Activate Notepad++
#Numpad3::
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

; Win + Numpad4
; Open terminal with lf
#Numpad4::
{
    Run('"C:\Users\Cameron\AppData\Local\Microsoft\WindowsApps\wt.exe"') ; open terminal
    Sleep(300)  ; Wait a bit before checking
    WinLoaded("ahk_exe WindowsTerminal.exe") ; wait for window to load
    WinMaximize()
    WinKeyPressed() ; make sure windows key isn't pressed so computer doesn't lock
    Send("lfcd{Enter}") ; enter lfcd command
}

; Win + CTRL + Numpad4
; Open terminal with lf as administrator
#^Numpad4::
{
    Run('"C:\Users\Cameron\AppData\Local\Microsoft\WindowsApps\wt.exe"') ; open terminal
    Sleep(300)  ; Wait a bit before checking
    WinLoaded("ahk_exe WindowsTerminal.exe") ; wait for window to load
    WinMaximize()
    WinKeyPressed() ; make sure windows key isn't pressed so computer doesn't lock
    Send("sudo lfcd{Enter}") ; enter lfcd command
}

; Win + Ctrl + Down Arrow
; minimize the active window
#^Down::
{
    WinMinimize("A")
}

; Win + Ctrl + Up Arrow
; maximize the last minimized window
#^Up::
{
    ; Retrieve a list of all windows
    winList := WinGetList()

    loop winList.Length ; check all windows in order
    {
        win := winList[A_Index]
        if WinGetMinMax(win) = -1 ; if window is minimized
        {
            WinRestore(win)
            WinActivate(win)
            break
        }
    }
}
