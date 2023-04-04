;##### Copy Tier List from Filter Information Post into Clipboard and run the Updater #####

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


TierList := Clipboard

if SubStr(TierList, 1, 6) != "Tier 1"
{
    MsgBox, Please copy the Tier List into Clipboard and start again!
    ExitApp
}

MapInfoFile := A_ScriptDir "\MapInfo.ini"
FileRead, MapInfo, %MapInfoFile%

; Clear all Tier Info
NewMapInfo := ""
SkipTierReplacement := False
Loop, Parse, MapInfo, `r, `n
{
    if A_LoopField = [Forge of the Phoenix Map]
        SkipTierReplacement := True

    if (SkipTierReplacement = False) AND (InStr(A_LoopField, "Tier", 1) > 0)
        NewMapInfo := NewMapInfo "Tier = `r`n"
    Else
        NewMapInfo := NewMapInfo A_LoopField "`r`n"
}

FileDelete, %MapInfoFile%
FileAppend, %NewMapInfo%, %MapInfoFile%

; Write new Tier Info
Loop, Parse, TierList, `r, `n
{
    if SubStr(A_LoopField, 1, 5) = "Tier "
    {
        Tier := SubStr(A_LoopField, 6)
        if Tier is not Integer
        {
            MsgBox, Invalid Tier format in Clipboard
            ExitApp, [ ExitCode]
        }
    }
    Else if A_LoopField != 
    {
        IniWrite, %A_Space%%Tier%, %MapInfoFile%, %A_LoopField% Map, Tier
    }
}
ExitApp