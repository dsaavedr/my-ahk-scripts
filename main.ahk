/*
    #: Windows key
    +: Shift
    ^: Ctrl
    !: Alt
*/

SetTitleMatchMode, 2
DetectHiddenWindows, On

If !WinExist("games.ahk")
{
  !Numpad1::
  Run, "D:\Storage\Google Drive\AHK Scripts\games.ahk"
  Return
}

; TEST
/*
^k::
  MsgBox Wow!
  MsgBox this is
  Run, Notepad.exe
  winactivate, Untitled - Notepad
  WinWaitActive, Untitled - Notepad
  send, 7 lines{!}{enter}
  sendinput, inside the ctrl{+}j hotkey
Return
*/

::pug init::
sendinput,
  (
doctype html{enter}
html(lang='en')
{Tab}head
{Tab}meta(charset='utf-8')
meta(http-equiv='X-UA-Compatible', content='IE=edge')
meta(name='viewport', content='width=device-width, initial-scale=1')
title HTML document
{backspace}body
  )
Return

; Guillemets

+^SC033::Send {�}		; SHIFT + CTRL + ","
+^SC034::Send {�}		; SHIFT + CTRL + "."

; Change selected text to specific font

#+l::
Send !H
Sleep 1
Send FF
Send Century Gothic {tab} 10 {enter}
Return

::hh1::<h1></h1>
::hh2::<h2></h2>
::hh3::<h3></h3>

^SC033::Send {<}		; CTRL + ","
^SC034::Send {>}		; CTRL + "."

; Center active window

#+c::
  WinGetActiveStats, Title, Width, Height, X, Y
  WinMove, %Title%,, (A_ScreenWidth-Width)/2, (A_ScreenHeight-Height)/2
Return

; Move active window to second desktop (indifferent between left and right keys; assumes only two desktops)	

#^+Left::
#^+Right::
Send #{tab}         ; WIN+TAB=Open the desktop view
Sleep 500
Send +{F10} ; SHIFT+F10=context menue. M=move. Enter for the first desktop in the list.
Sleep 750
Send {Down}
Sleep 100
Send {Down}
Sleep 350
Send {Right}
Sleep 250
Send {Enter}
Sleep 100
Send #{tab}   	    ; WIN+TAB=Close the desktop view
return

; Copies selected text and searches Google for it	

+Capslock::
Send, ^c
Sleep 50
Run, http://www.google.com/search?q=%clipboard%
Return

; Types out copied text

^+Capslock::
SendRaw, %clipboard%
Return

; Locks computer and turns off monitor
 
#l::
Sleep, 200
DllCall("LockWorkStation")
Sleep, 500
SendMessage,0x112,0xF170,2,,Program Manager
return

; Enclosing in quotes

^'::EncQuote("'")
^+'::EncQuote("""")

EncQuote(q)
{
  oldClipboard = %clipboard%
  Clipboard := 
  SendInput ^c
  Sleep 100
  if (Clipboard = "")
  {  
    TrayTip, Enclose in quote, Nothing copied - aborting
	SetTimer, HideTrayTip, 2000
  }
  else
  {
    ;Clipboard = %q%%clipboard%%q%
    ;Sleep 200
    ;SendInput ^v
    SendInput %q%%clipboard%%q%
  }
  Clipboard = %oldClipboard%
}

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}

; Media shortcuts, inactive when VSCode is active

#IfWinNotActive Visual Studio Code
  ^!Left::           		; CTRL+ALT+LEFT for previous
  send, {Media_Prev}
  Return
  ^!Right::  			      ; CTRL+ALT+RIGHT for next
  send, {Media_Next}
  Return
  ^!Space::			        ; CTRL+ALT+SPACE for pause/play
  send, {Media_Play_Pause}
  Return
  ^!Up::
  send, {Volume_Up}
  Return
  ^!Down::
  send, {Volume_Down}
  Return