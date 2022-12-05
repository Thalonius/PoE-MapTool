#IfWinActive Path of Exile
~^f::
ToolTip
if ClipboardAll <>
	ClipboardBackup := ClipboardAll
Else
	ClipboardBackup := Clipboard
Clipboard := ""
Send ^c
ClipWait, 2
if ErrorLevel = 0
{
	ItemInfo := Clipboard
	ItemClass := SubStr(ItemInfo, 13, InStr(ItemInfo,"`r")-13)
	if (ItemClass = "Maps")
		CheckMapModifier()
	Else
		CheckItem(True)
}
Clipboard := ClipboardBackup
Return
#IfWinActive

#include MapModified.include
#include CheckItem.include

ResetToolTip:
ToolTip
return