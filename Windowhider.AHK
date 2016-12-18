;;;;;;;;;;;;;;; Window hider/shower with GUI (top);;;;
; As this script has an OnExit command, it's a bit more complicated to
; include into another script, as the OnExit will overwrite or be overwritten
; if the base script has an OnExit line, and it has it's own auto-execute.
; Some adjustment is required if this script is not run stand-alone.


OnExit, Exitscript

hidden_win_array := Object()

Return

;;;;;;;;;;;;;;; Window hider/shower with GUI ;;;;
!#h::
    WinGet, lastwindow, , A
    hidden_win_array.Push(lastwindow)
    Send !{ESC}
    WinHide, ahk_id %lastwindow%
Return

UnhideWindow:
!#y::
    lastwindow := hidden_win_array.Pop()
    WinShow, ahk_id %lastwindow%
    WinActivate, ahk_id %lastwindow%
Return

HiddenWindowGUI:
!#g:: ; Fancy GUI that lists hidden windows and unhides at mouseclick
    if (hidden_win_array.Length() == 0)
    {
        MsgBox, No hidden windows.
    }
    else
    {
        DetectHiddenWindows, On
        Gui, +AlwaysOnTop +Delimiter`n -SysMenu
        Gui, font, s10, Consolas
        Gui, Add, Text,, Select a window to unhide
        max_length := 0
        for index, win_id in hidden_win_array
        {
            WinGetTitle, win_title, ahk_id %win_id%
            StringReplace, win_title, win_title, `n, 'n, All ; Get rid delimiters in string
            curr_length := StrLen(win_title)
            if (curr_length > max_length)
                max_length := curr_length
            win_titles := win_titles . "`n" . win_title
            if (index == 1)
                win_titles := win_title
        }
        size := index
        if (size > 20)
            size := 20
        listbox_width := max_length * 8
        if (listbox_width > 300)
            listbox_width := 300
        
        Gui, Add, ListBox, R%size% W%listbox_width% Vindex altSubmit gWinShowCallback, %win_titles%
        Gui, Add, Button, gUnhideAll, All Windows
        Gui, Add, Button, gExitHiddenWindowsBox, Close
        Gui, Show, , Hidden Windows
        DetectHiddenWindows, Off
    }
Return

WinShowCallback:
    GuiControlGet, win_index,, index
    win_id := hidden_win_array.RemoveAt(win_index)
    WinShow, ahk_id %win_id%
    Gui, Destroy
    if (hidden_win_array.Length() != 0)
        Gosub, HiddenWindowGUI
Return

UnhideAll:
    While (hidden_win_array.Length() != 0)
    {
        Sleep, 50
        Gosub, UnhideWindow
    }
    if (hidden_win_array.Length() == 0)
        Gui, Destroy
Return

ExitHiddenWindowsBox:
    Gui, Destroy
Return

Exitscript:
    Gosub, UnhideAll
    ExitApp
Return