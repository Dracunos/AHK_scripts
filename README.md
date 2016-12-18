###A couple AHK scripts I made

Be mindful of conflicting hotkeys/exit scripts/etc if including or using with other scripts.

#### Clipboard History

This script maintains a history of previously copied/cut items. The history is accessible with ctrl+alt+shift+c. Click on an item in the list and it will be copied to the current clipboard. It should only work with plain text.

This script can simply be #include'ed into an existing AHK script after the auto-execute/top portion.

#### Secondary Clipboard

This script is simply a secondary clipboard (hotkeys, no context menu). Similar to your PC's main clipboard accessible via hotkeys ctrl+x for cut, ctrl+c for copy, and ctrl+v for paste, this clipboard is accessible via ctrl+windowskey+x/c/v for the same operations.

This script can simply be #include'ed into an existing AHK script after the auto-execute/top portion.

#### Window Hider/Shower with GUI

This script will hide the current active window with windowskey+alt+h, and show it with windowskey+alt+y. It can hide numerous windows, which are un-hidden via hotkey starting from the most recently hidden window (last in first out). Alternatively, you can use the hotkey windowskey+alt+g to show a list of titles of windows currently hidden by this script. Click on the title to unhide that window, or click 'All Windows' to unhide all of them. On exiting this script, all windows will be unhidden. If a window is hidden but the exit script isn't called (by ending task on the script, for example), you may need to end the task of that window and restart the application to get that window back (or use some autohotkey magic).

This script cannot be simply #include'ed into an existing autohotkey script. The top portion of the script must be in the autoexecute section, and the rest of the script must be after auto-execute. Additionally, only one 'OnExit' command can exist in a single script, so if included this one may overwrite or be overwritten by one in the base script if it exists. This script is meant to be used stand-alone.