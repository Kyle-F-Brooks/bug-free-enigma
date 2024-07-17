#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F2::
Loop{
    WinActivate, ahk_exe ArmoniaPlus.exe
    MouseClick, Left, 509, 16
    Sleep, 10000
}

F3::
ExitApp