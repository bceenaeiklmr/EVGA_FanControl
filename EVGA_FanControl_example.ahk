; Script     EVGA_FanControl_example.ahk
; License:   MIT License
; Author:    Bence Markiel (bceenaeiklmr)
; Github:    https://github.com/bceenaeiklmr/EVGA_FanControl
; Date       28.01.2023
; Version    0.1

#c::ShowMain(1)
MButton::ShowMain()

; create menus
Main := Menu()
Sys  := Menu()
GPU  := Menu()

FanOff  := EVGA_RunAsAdmin.Bind(0,   0,  0)
FanLow  := EVGA_RunAsAdmin.Bind(20, 20,  0)
FanGame := EVGA_RunAsAdmin.Bind(33, 33, 33)

GPU.Add("Off`t0 0 0", FanOff)
GPU.Add("Low`t20 20 0", FanLow)
GPU.Add("Game`t33 33 33", FanGame)

Main.Add("System", Sys)

Sys.Add("My computer",  (*) => Run("::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"))
Sys.Add("Recycle bin",  (*) => Run("::{645FF040-5081-101B-9F08-00AA002F954E}"))
Sys.Add("Downloads",    (*) => Run("C:\users\" A_UserName "\Downloads"))
Sys.Add("My documents", (*) => Run(A_MyDocuments))
Sys.Add("My desktop",   (*) => Run(A_Desktop))

Sys.Add('GPU', GPU)

; set icons
Main.SetIcon("System",        "Shell32.dll",  16)
Sys.SetIcon("My computer",    "Shell32.dll",  16)
Sys.SetIcon("Recycle bin",    "Shell32.dll",  32)
Sys.SetIcon("My documents",   "Shell32.dll",  39)
Sys.SetIcon("Downloads",      "Shell32.dll",  46)
Sys.SetIcon("My desktop",     "Shell32.dll",   5)
Sys.SetIcon("GPU",            "Shell32.dll",  13)
GPU.SetIcon("Off`t0 0 0",     "Shell32.dll", 138) ; 294
GPU.SetIcon("Low`t20 20 0",   "Shell32.dll", 138)
GPU.SetIcon("Game`t33 33 33", "Shell32.dll", 138)

; #############################################

EVGA_RunAsAdmin(Fan1 := 0, Fan2 := 0, Fan3 := 0, *) {
   Run '*RunAs "' A_ScriptDir '\EVGA_FanControl.ahk" /restart ' fan1 ' ' fan2 ' ' fan3
}

ShowMain(Instant := 1) {
    if !Instant {
        Pressed := 0
        while getKeyState(A_thisHotkey,"P") {
            if (A_TimeSinceThisHotkey > 500) {
                Main.Show()
                Pressed := 1
            }
        }
        if !Pressed
            Send "{" A_thisHotkey "}"
    } else
        Main.Show()
}
