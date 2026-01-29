Version = 0.0.1
Import:
{
#Requires AutoHotkey v1.1+
#NoEnv
#SingleInstance Force
#Persistent
;DetectHiddenWindows, On
SetTitleMatchMode, RegEx
}

IconChange:
{
	I_Icon = .Icon.png
	ICON [I_Icon]                        ;Changes a compiled script's icon (.exe)
	if I_Icon <>
	IfExist, %I_Icon%
		Menu, Tray, Icon, %I_Icon%   ;Changes menu tray icon 
}

;Designate your monitored cluster file here.
Path:="E:\Programs\.SystemLinks\Sync\MyCluster"
MyCluster:="Commands.ini"
Interval:="300"

Loop
{
    ;CheckModTime()
    CheckFile()
    Sleep % Interval
}

CheckFile()
{
    global
    IniRead, MyClusterFile, %Path%\%MyCluster% ;Retrieve section names
    ;Msgbox % MyClusterFile
    Loop, Parse, MyClusterFile, `r`n
    {
        Cmd:="", State:=""
        IniRead, Cmd, %Path%\%MyCluster%, %A_LoopField%, Cmd
        FileRead, State, %Path%\%A_LoopField%.ini
        ;Msgbox % A_LoopField
        If (InStr(State, "1"))
        {
            ;Msgbox Test
            Run, "%cmd%"
            FileRecycle, %Path%\%A_LoopField%.ini
            FileAppend, 0, %Path%\%A_LoopField%.ini
        }
    }
}

CheckModTime()
{
    global
    FileGetTime, ModifiedTime, %MyCluster%, M
    IniWrite, %ModifiedTime%, %MyCluster%, General, ModifiedDate
    ;Msgbox % ModifiedTime
}