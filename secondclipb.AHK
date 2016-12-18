;;;;;;;;;;;;;;; Secondary Clipboard ;;;;;;;;;;;;;;;;;;
; Add Windows key as modifier to ctrl+[x/c/v] to access it.
; Include after auto-execute section of script.

^#c::
    clipsaved := ClipboardAll
    Clipboard =
    Sendinput ^c
    Sleep, 100
    if Clipboard
        secondaryclipboard := Clipboard
    Clipboard := clipsaved
Return

^#x::
    clipsaved := ClipboardAll
    Clipboard =
    Sendinput ^x
    Sleep, 100
    if Clipboard
        secondaryclipboard := Clipboard
    Clipboard := clipsaved
Return

^#v::
    if secondaryclipboard
    {
        clipsaved := ClipboardAll
        Clipboard := secondaryclipboard
        Sendinput ^v
        Sleep, 100
        Clipboard := clipsaved
    }

Return