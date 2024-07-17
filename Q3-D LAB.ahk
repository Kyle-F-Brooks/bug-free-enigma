; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
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
        MouseClick, Left, 900, 600 ;click dsp Initialiser
        Sleep, 100
        Loop, 2 {
            ; click discovery
            MouseClick, Left, 960, 440 
            Sleep, 8000
        }
        Loop {
            WinActivate, ahk_exe ProManagerPlus.exe
            MouseClick, Left, 102, 41, 2
            Sleep, 500
            MouseClick, Left, 1000, 70
            Sleep, 500
            PixelGetColor, colourQ3, 54, 67
            PixelGetColor, colourHighlight, 100, 70
            ; check pixel colour for word Bias Q3
            if (colourQ3 = 0xFFFFFF) 
            {
                MouseClick, Left, 65, 910 ; go back
                Sleep, 100
                MouseClick, Left, 960, 600 ;click dsp Initialiser
                Sleep, 100
                Loop, 2 
                {
                    MouseClick, Left, 960, 440 ; click discovery
                    Sleep, 8000
                }
            }
            else if (colourHighlight = 0xFFFFFF)
            {
                Break ; break the loop
            }
            else
            {
                MouseClick, Left, 960, 440 ; click discovery
                Sleep, 8000
            }
        }
        MouseClick, Left, 1620, 910 ; click next
        Sleep, 100
        MouseClick, Left, 850, 725 ; click custom model
        Sleep, 100
        MouseClick, Left, 420, 240 ; click product name
        Send, {Down}
        Send, {Enter}
        if (firmwareUpdate)
        {
            MouseClick, Left, 420, 280
            ; Change here dependent on firmware position in list
            Send, {Down}
            ; Send, {Down}
            Send, {Enter}
        }
        else if (!firmwareUpdate)
        {
            MouseClick, Left, 586, 279
        }
        Sleep, 100
        MouseClick, Left, 1620, 900
        processing := true
        while(processing){
            WinActivate, ahk_exe ProManagerPlus.exe
            PixelGetColor, colourInit, 834,863
            PixelGetColor, colourFail, 870,862
            if (colourFail = 0xA00000){
                Sleep, 1000
                MouseClick, Left, 1630, 865
                Sleep, 100
            }
            else if (colourInit = 0x00DD00){
                processing := false
                MouseClick, Left, 60, 910
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
MouseClick, Left, 1620, 910
Sleep, 100
MouseClick, Left, 850, 725
Sleep, 100
MouseClick, Left, 420, 240
Send, {Down}
Send, {Enter}
if (firmwareUpdate)
{
    MouseClick, Left, 420, 280
    ; change here dependent on firmware position
    Send, {Down}
    ; Send, {Down}
    Send, {Enter}
}
else if (!firmwareUpdate)
{
    MouseClick, Left, 586, 279
}
Sleep, 100
MouseClick, Left, 1620, 900
processing := true
while(processing)
{
    WinWaitActive, ahk_exe ProManagerPlus.exe
    PixelGetColor, colour, 834,863
    If (colour = 0x00DD00)
    {
        processing := false
        MouseClick, Left, 60, 910
    }
}
return

F4::
WinMaximize,
InputBox, totalAmps ,Q3 Firmware Updater, How many amps are currently connected?,, 250, 160
if ErrorLevel
{
    return
}
else
{
    Loop, %totalAmps%
    {
        WinActivate, ahk_exe ProManagerPlus.exe
        MouseClick, Left, 900, 600 ; Click DSP Initialiser
        Sleep, 100
        Loop, 2 {
            ; click discovery
            MouseClick, Left, 960, 440 
            Sleep, 5000
        }
        WinActivate, ahk_exe ProManagerPlus.exe
        MouseClick, Left, 269, 40 ;Click Firmware to sort
        Sleep, 500
        MouseClick, Left, 1000, 70
        Sleep, 500
        MouseClick, Left, 1620, 910 ; click "next->"
        Sleep, 100
        MouseClick, Left, 850, 725 ; click "custom model"
        Sleep, 100
        MouseClick, Left, 113, 94 ; click "only updatefirmware"
        Sleep, 100
        MouseClick, Left, 420, 280
        ; change here dependent on firmware position
        Send, {Down}
        ; Send, {Down}
        Send, {Enter}
        Sleep, 100
        MouseClick, Left, 1620, 900
        processing := true
        while(processing)
        {
            WinWaitActive, ahk_exe ProManagerPlus.exe
            PixelGetColor, colour, 834,863 ;"Successful initialisation"
            If (colour = 0x00DD00)
            {
                processing := false
                MouseClick, Left, 60, 910 ;Click "Remote Entities"
            }
        }
    }
}

^!v:: ;ctrl+alt+ve
ExitApp
; ^!z::  ; Control+Alt+Z hotkey.
; MouseGetPos, MouseX, MouseY
; PixelGetColor, colour, %MouseX%, %MouseY%
; MsgBox The colour at the current cursor position is %colour%.
; return
