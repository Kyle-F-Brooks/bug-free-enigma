#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_exe ProManagerPlus.exe

F2::
WinMaximize,
InputBox, totalAmps ,Q3-D Initialiser, How many amps are currently connected?,, 250, 160
if ErrorLevel
{
    return
}
else
{
    firmwareUpdate := false
    Loop{
        InputBox, UserInput, Update Firmware?, Update Firmware? Y/N,,250,130
        StringUpper, UserInput, UserInput
        if ErrorLevel
        {
            return
        }
        else if (UserInput == "Y")
        {
            firmwareUpdate := true
            Break
        }
        else if (UserInput == "N")
        {
            Break
        }
        else 
        {
            MsgBox, Please input Y or N
        }
    }
    Loop, %totalAmps%
    {
        WinActivate, ahk_exe ProManagerPlus.exe
        MouseClick, Left, 900, 600
        Sleep, 100
        Loop, 2 {
            MouseClick, Left, 960, 456
            Sleep, 8000
        }
        Loop {
            WinActivate, ahk_exe ProManagerPlus.exe
            MouseClick, Left, 1000, 70
            Sleep, 500
            PixelGetColor, colourQ3, 54, 67
            PixelGetColor, colourHighlight, 100, 70
            if (colourQ3 = 0xFFFFFF) 
            {
                MouseClick, Left, 65, 940
                Sleep, 100
                MouseClick, Left, 960, 600
                Sleep, 100
                Loop, 2 
                {
                    MouseClick, Left, 960, 456
                    Sleep, 8000
                }
                MouseClick, Left, 1000, 70
            }
            else if (colourHighlight = 0xFFFFFF)
            {
                Break
            }
            else
            {
                MouseClick, Left, 960, 456
                Sleep, 8000
            }
        }
        MouseClick, Left, 1860, 935
        Sleep, 100
        MouseClick, Left, 1000, 725
        Sleep, 100
        MouseClick, Left, 420, 240
        Send, {Down}
        Send, {Enter}
        if (firmwareUpdate)
        {
            MouseClick, Left, 420, 280
            ; Change here dependent on firmware position in list
            Send, {Down}
            ;Send, {Down}
            Send, {Enter}
        }
        else if (!firmwareUpdate)
        {
            MouseClick, Left, 665, 277
        }
        Sleep, 100
        MouseClick, Left, 1860, 935
        processing := true
        while(processing){
            WinWaitActive, ahk_exe ProManagerPlus.exe
            PixelGetColor, colourInit, 935,890
            If (colourInit = 0x00DD00){
                processing := false
                MouseClick, Left, 60, 935
            }
        }
    }
}
; loop back here to line 10/11
return

F3::
firmwareUpdate := false
WinActivate, ahk_exe ProManagerPlus.exe
Loop
{
    InputBox, UserInput, Update Firmware?, Update Firmware? Y/N,,250,130
    StringUpper, UserInput, UserInput
    if ErrorLevel
    {
        return
    }
    else if (UserInput == "Y")
    {
        firmwareUpdate := true
        Break
    }
    else if (UserInput == "N")
    {
        Break
    }
    else 
    {
        MsgBox, Please input Y or N
    }
}
WinMaximize, 
MouseClick, Left, 1860, 935
Sleep, 100
MouseClick, Left, 1000, 725
Sleep, 100
MouseClick, Left, 420, 240
Send, {Down}
Send, {Enter}
if (firmwareUpdate)
{
    MouseClick, Left, 420, 280
    Send, {Down}
    ;Send, {Down}
    Send, {Enter}
}
else if (!firmwareUpdate)
{
    MouseClick, Left, 665, 277
}
Sleep, 100
MouseClick, Left, 1860, 935
processing := true
while(processing)
{
    WinWaitActive, ahk_exe ProManagerPlus.exe
    PixelGetColor, colour, 935,890
    If (colour = 0x00DD00)
    {
        processing := false
        MouseClick, Left, 60, 935
    }
}
return

^!v::
ExitApp
; ^!z::  ; Control+Alt+Z hotkey.
; MouseGetPos, MouseX, MouseY
; PixelGetColor, colour, %MouseX%, %MouseY%
; MsgBox The colour at the current cursor position is %colour%.
; return
