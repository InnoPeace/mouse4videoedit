#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
Autohotkey script - Turn a Budget Mouse into Video Editing Power Tool
Youtube: Mouse4VideoEdit
Created by: InnoPeace
Publish date: Oct 1, 2020
*/

; Mouse action

; Win - Scroll Wheel
#WheelUp:: Send, {Volume_Up}
#WheelDown:: Send, {Volume_Down}
#MButton:: Send, {Volume_Mute}

; Ctrl - Scroll Wheel
^WheelUp::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, =
} else if winactive("ahk_exe chrome.exe"){ ;Chrome
	Send, ^=
} else if winactive("ahk_exe Code.exe"){ ;Visual Studio Code
	Send, ^=
} else {
	Send, ^{WheelUp}
}
return

^WheelDown::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, -
} else if winactive("ahk_exe chrome.exe"){ ;Chrome
	Send, ^-
} else if winactive("ahk_exe Code.exe"){ ;Visual Studio Code
	Send, ^-
} else {
	Send, ^{WheelDown}
}
return

^MButton::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, \
} else if winactive("ahk_exe chrome.exe"){ ;Chrome
	Send, ^0
} else if winactive("ahk_exe Code.exe"){ ;Visual Studio Code
	Send, ^{Numpad0}
} else {
	Send, ^{MButton}
}
return

; Shift - Scroll Wheel
+WheelUp::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, {Left}
} else {
	send, +{WheelUp}
}
return

+WheelDown::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, {Right}
} else {
	Send, +{WheelDown}
}
return

; +MButton::

; Ctrl-Shift Scroll Wheel
^+WheelUp::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, +{Left}
} else {
	Send, ^+{WheelUp}
}
return

^+WheelDown::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, +{Right}
} else {
	Send, ^+{WheelDown}
}
return

; Alt - Scroll Wheel
!WheelUp::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, {Up}
} else if winactive("ahk_exe chrome.exe"){ ;Chrome
	Send, ^{PgUp}
} else {
	Send, !{WheelUp}
}
return

!WheelDown::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, {Down}
} else if winactive("ahk_exe chrome.exe"){ ;Chrome
	Send, ^{PgDn}
} else {
	Send, !{WheelDown}
}
return

!MButton::
if winactive("ahk_exe chrome.exe"){ ;Chrome
	Send, ^1
} else {
	Send, !{MButton}
}
return

; XButtons
XButton1::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, {Delete}
} else {
	Send, {XButton1}
}
return
XButton2::
if winactive("ahk_exe Adobe Premiere Pro.exe"){ ;Premiere
	Send, +{Delete}
} else {
	Send, {XButton2}
}
return

^XButton1:: WebSite_Clipboard("https://s.taobao.com/search?q=","","http://www.taobao.com")
^XButton2:: WebSite_Clipboard("https://www.youtube.com/results?search_query=","","https://www.youtube.com/")
+XButton1:: WebSite_Clipboard("https://www.amazon.com/s?k=","","http://www.amazon.com")
+XButton2:: WebSite_Clipboard("https://www.google.com/search?q=","","https://www.google.com")
!XButton1::
	IfWinNotExist, ahk_class CabinetWClass
        Run, explorer.exe
    GroupAdd, myexplorers, ahk_class CabinetWClass
    if WinActive("ahk_exe explorer.exe")
        GroupActivate, myexplorers, r
    else
        WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
    ;maybe need to unstick modifiers
    sleep 2
	;Send {AltUp}
Return
!XButton2:: WebSite_Clipboard("https://www.google.com/search?q=","","http://www.google.com")
#XButton1:: WebSite_Clipboard("https://translate.google.com/#view=home&op=translate&sl=auto&tl=zh-TW&text=","","https://translate.google.com/")
#XButton2:: WebSite_Clipboard("https://hk.dictionary.search.yahoo.com/search;?p=","&fr=sfp&iscqry=","https://hk.dictionary.search.yahoo.com/")

; Wheel Left/Right
;+WheelLeft:: Send, {Volume_Up}
;+WheelRight:: Send, {Volume_Down}

;將關鍵字帶入網址查詢(version:190624)
WebSite_Clipboard(UrlA,UrlB,website_name:=""){
    ;備份並清空剪貼簿
    clipboard_save = %ClipboardAll%
    Clipboard :=""
    ;獲取選取的關鍵字
    Send, ^{c}
    Sleep 200
    keyWord = %Clipboard%
    ;恢復先前的剪貼簿
    Clipboard = %clipboard_save%
    ;若沒有選取文字被選取，則跳出輸入文字框讓使用者輸入關鍵字，複製到剪貼簿
    if (keyWord=""){
        ;若未設定網站名稱，則用
        Run %website_name%
    }
    ;將關鍵字做解碼處理，並嵌入搜尋網址中
    if (ErrorLevel=0 and keyWord!=""){
        Copy= % UriEncode(keyWord)
        Run %UrlA%%Copy%%UrlB%
    }
    return
}

;讓關鍵字轉化為網址解碼形式，得以讓關鍵字正確被搜尋
;參考自https://rosettacode.org/wiki/URL_encoding#AutoHotkey
UriEncode(Uri){
    VarSetCapacity(Var, StrPut(Uri, "UTF-8"), 0)
    StrPut(Uri, &Var, "UTF-8")
    f := A_FormatInteger
    SetFormat, IntegerFast, H
    While Code := NumGet(Var, A_Index - 1, "UChar")
        If (Code >= 0x30 && Code <= 0x39 ; 0-9
            || Code >= 0x41 && Code <= 0x5A ; A-Z
            || Code >= 0x61 && Code <= 0x7A) ; a-z
            Res .= Chr(Code)
        Else
            Res .= "%" . SubStr(Code + 0x100, -1)
    SetFormat, IntegerFast, %f%
    Return, Res
}