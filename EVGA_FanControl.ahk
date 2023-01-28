; Script     EVGA_FanControl.ahk
; License:   MIT License
; Author:    Bence Markiel (bceenaeiklmr)
; Github:    https://github.com/bceenaeiklmr/EVGA_FanControl
; Date       28.01.2023
; Version    0.1

#Requires AutoHotkey >=2.0
#Warn

p := [] ; params
for Arg in A_Args {
    if (Arg ~= "\d")
        p.Push(Arg)
}

EVGA(p[1], p[2], p[3])

EVGA(fan1, fan2, fan3) {

    static Wintitle := "Precision X1 ahk_exe PrecisionX_x64.exe"

    ; store current mouse speed
    MouseSpeed := A_DefaultMouseSpeed
    TitleMatch := A_TitleMatchMode
    SetDefaultMouseSpeed(0)
    SetTitleMatchMode(2)

    ; run or activate EVGA control panel
    Run("C:\Program Files\EVGA\Precision X1\PrecisionX_x64.exe 0")
    (WinExist(Wintitle)) ? WinActivate(Wintitle)
                         : WinWaitActive(Wintitle)

    ; click into the first fan field (two tabs = next fan's field)
    Click(750, 470)
    ; set the fan values 
    Fans := [fan1, fan2, fan3]
    for v in Fans
        Send("^a{Delete}" v (A_index !== Fans.Length ? "{Tab 2}" : ""))
    
    ; save and apply the new settings
    Click(870, 730)
    Sleep(200)
    Click(650, 730)
    
    ; minimize the window, restore settings
    WinMinimize(Wintitle)
    SetDefaultMouseSpeed(MouseSpeed)
    SetTitleMatchMode(TitleMatch)

    return
}
