;;;;;;;;;;;;;;; Clipboard History Saver ;;;;;;;;;;;;;;
; Access the history with ctrl+alt+shift+c. Clicking an item will
; add that item back into the current clipboard. Should only work
; with plain text. Include after auto-execute section of script.


~^c::
~^x::
    Sleep, 100
	if not clipboard_saver_array
		clipboard_saver_array := Object()
    if (clipboard_saver_array.Length() > 20)
        clipboard_saver_array.Pop()
    clipsaved := Clipboard
    clipboard_saver_array.Push(clipsaved)
Return

^!+c:: ; GUI list of items to paste
    if (not clipboard_saver_array or clipboard_saver_array.Length() == 0)
    {
        MsgBox, No saved pastes.
    }
    else
    {
        Gui, +AlwaysOnTop +Delimiter`` -SysMenu
        Gui, font, s10, Consolas
        Gui, Add, Text,, Select a paste to put into clipboard
        for index, paste in clipboard_saver_array
        {
            StringReplace, paste, paste, ``, ', All ; Get rid delimiters in string
            pastes := pastes . "``" . paste
            if (index == 1)
                pastes := paste
        }
        size := 20
        listbox_width := 300
        
        Gui, Add, ListBox, R%size% W%listbox_width% Vindex altSubmit gPasteCallback, %pastes%
        Gui, Add, Button, gClearPastes, Clear All
        Gui, Add, Button, gExitPasteBox, Close
        Gui, Show, , Pastes
    }
Return

PasteCallback:
    GuiControlGet, paste_index,, index
    Clipboard := clipboard_saver_array[paste_index]
    Gui, Destroy
Return

ClearPastes:
    clipboard_saver_array := Object()
    Gui, Destroy
Return

ExitPasteBox:
    Gui, Destroy
Return