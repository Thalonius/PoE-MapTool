#SingleInstance, force

Menu, Tray, Add, Search, OpenGui
Menu, Tray, Default, Search
Menu, Tray, NoStandard
InitMapList()
Gui, Add, ComboBox, x10 y10 vMapName gMapSelected, %MapList%
Gui, Add, Text, xs+0 y+10 w50 section, Name
Gui, Add, Edit, x+10 ys-3 w250 vSelectedMapName ReadOnly
Gui, Add, Text, xs+0 y+10 w50 section, Tier
Gui, Add, Edit, x+10 ys-3 w250 vSelectedMapTier ReadOnly
Gui, Add, Text, xs+0 y+10 w50 section, Layout
Gui, Add, Edit, x+10 ys-3 w250 r3 vSelectedMapInfo ReadOnly
Gui, Add, Text, xs+0 y+10 w50 section, Boss
Gui, Add, Edit, x+10 ys-3 w250 r3 vSelectedMapBossInfo ReadOnly
Gui, Add, Text, xs+0 y+10 w50 section, Maven
Gui, Add, Edit, x+10 ys-3 w250 vSelectedMapMaveninfo ReadOnly
Gui, Add, Text, xs+0 y+10 w50 section, Soul
Gui, Add, Edit, x+10 ys-3 w250 vSelectedMapDivineVessel ReadOnly
Return

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

OpenGui:
Gui, Show, , Map Search
Return

MapSelected:
GuiControlGet, MapName, , MapName
ReadMapData(MapName)
GuiControl, , SelectedMapName, %MapName%
GuiControl, , SelectedMapTier, %MapTier%
GuiControl, , SelectedMapInfo, %MapInfo%
GuiControl, , SelectedMapBossInfo, %BossInfo%
GuiControl, , SelectedMapMaveninfo, %MavenInfo%
GuiControl, , SelectedMapDivineVessel, %DivineVessel%
Return

GuiEscape:
GuiClose:
Gui, Hide
Return