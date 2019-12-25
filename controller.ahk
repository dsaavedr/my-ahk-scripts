#InstallKeybdHook
#Persistent

; THIS MAKES A CONTROLLER INTO A MOUSE

; 1) Volume control

#Persistent
SetTimer, RightStick, 10
RightStick:
GetKeyState, JoyU, JoyU
MsgBox JoyU
if JoyU > 90
{
  Send {Volume_Up}
  sleep 50
}
else if JoyU < 10
{
  Send {Volume_Down}
  sleep 50
}
else
return

; 2) Magnifier app

if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

Joy5::
KeyWait, Joy5, T0.3 
if ErrorLevel ; key was held 0.3+ second
{
  While GetKeyState("Joy5") ; While key is being held
  {
    Send, #{NumpadSub} ; Repeatedly zoom out
    Sleep, 10
  }
WinClose Magnifier   ; And close the magnifier when you let go
Return
}
else ; key was held for less than 0.3 second
  send #{NumpadAdd}  ; Zoom in
return

; 3) Mouse

Joy1::LButton
Joy2::RButton

#Persistent
SetTimer, LeftStick, 10
return

LeftStick:
GetKeyState, JoyX, JoyX
MsgBox JoyX
return