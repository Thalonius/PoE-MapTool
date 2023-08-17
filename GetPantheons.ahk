#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FileRead, MapInfo, MapInfo.ini
BrineKingArr := []
SolarisArr := []
LunarisArr := []
ArakaaliArr := []
AbberathArr := []
GarukhanArr := []
GruthkulArr := []
RalakeshArr := []
RyslathaArr := []
ShakariArr := []
TukohamaArr := []
YugulArr := []

Loop, Parse, MapInfo, `r, `n
{
    if InStr(A_LoopField, "[")
    {
        MapName := SubStr(A_LoopField, 2, StrLen(A_LoopField)-2)
        if (MapName <> "General")
        {
            IniRead, DivineInfo, MapInfo.ini, %MapName%, DivineVessel, %Empty%
            if (DivineInfo <> "")
            {            
                IniRead, MapTier, MapInfo.ini, %MapName%, Tier
                God := StrSplit(DivineInfo, " - " , " ")
                Pantheon := StrReplace(God[1], " ", "") 
                %Pantheon%Arr.Push("T" MapTier " " MapName " - " God[2])
                ;MsgBox, % Tier MapName " - " DivineInfo
                ;ExitApp
            }
        }
    }
}

PantheonList := BuildSection("BrineKing")
PantheonList := PantheonList "`r" BuildSection("Solaris")
PantheonList := PantheonList "`r" BuildSection("Lunaris")
PantheonList := PantheonList "`r" BuildSection("Arakaali")
PantheonList := PantheonList "`r" BuildSection("Abberath")
PantheonList := PantheonList "`r" BuildSection("Garukhan")
PantheonList := PantheonList "`r" BuildSection("Gruthkul")
PantheonList := PantheonList "`r" BuildSection("Ralakesh")
PantheonList := PantheonList "`r" BuildSection("Ryslatha")
PantheonList := PantheonList "`r" BuildSection("Shakari")
PantheonList := PantheonList "`r" BuildSection("Tukohama")
PantheonList := PantheonList "`r" BuildSection("Yugul")
Clipboard := PantheonList
MsgBox, Created Pantheon List and copied it to Clipboard!
ExitApp

BuildSection(GodName)
{
    SectionText := GodName "`r"
    for index,element in %GodName%Arr
        SectionText := SectionText element "`r"
    Return SectionText
}

MsgBox, % MapInfo