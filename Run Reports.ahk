#NoEnv
#SingleInstance, Force
#NoTrayIcon
#Include %A_ScriptDir%\lib\SGDIPrint.ahk
;~ #Include %A_ScriptDir%\SGDIPrint.ahk

SplashTextOn, 400, 200, Please Wait, Please wait...`nHave some digital patience...
SetBatchLines, -1
csvF := "inventory.csv"
ini := "Report.ini"
Clipboard := ""
FileAppend, %ClipboardAll%, %ini%

Report := "", ItemList := "", IList := "", OHList := ""
Ttl := 0, OHTtl := 0, ITtl := 0

Columns := "Location|Label|Item|Model|QTY|Serial|MAC|IssuedTo|Status"
Lists := "ItemList|OHList|IList"

FileRead, Finv, %csvF%
StringReplace, FInv, FInv, `,, |, All
StringReplace, FInv, FInv, ~, `,, All
;~ StringReplace, FInv, FInv, Issuable Location, Boxes, All

Loop, Parse, FInv, `n, `r
{
	if not A_Loopfield
		continue
	StringSplit, Field, A_Loopfield,`|
	Loop, Parse, Columns, |
	{
		F := "Field" . A_Index
		%A_LoopField% := %F%
	}
	Ttl += QTY
	iniread, StoredQty, %ini%, Item Qty, %Item%, 0
	StoredQty += QTY
	IniWrite, %StoredQty%, %ini%, Item Qty, %Item%

	if (ItemList <> "")
		ItemList .= "|"
	ItemList .= Item
	if (Status = "On-Hand")
	{
		OHTtl += QTY
		iniread, StoredQty, %ini%, On-Hand Qty, %Item%, 0
		StoredQty += QTY
		IniWrite, %StoredQty%, %ini%, On-Hand Qty, %Item%
		if (OHList <> "")
			OHList .= "|"
		OHList .= Item
	}
	if (Status = "Issued")
	{
		ITtl += QTY
		iniread, StoredQty, %ini%, Issued Qty, %Item%, 0
		StoredQty += QTY
		IniWrite, %StoredQty%, %ini%, Issued Qty, %Item%
		if (IList <> "")
			IList .= "|"
		IList .= Item
	}
}

Loop, Parse, Lists, |
	Sort, %A_Loopfield%, D| U

TotalItems:
Report := "Total Quantity of Items: " . Ttl . "`n"

Loop, parse, ItemList, |
{
	iniread, StoredQty, %ini%, Item Qty, %A_Loopfield%, 0
	Report .= "`t" . A_Loopfield . ":  " .  StoredQty . "`n"
}
if OHTtl
	gosub, OnHandItems
if ITtl
	gosub, IssuedItems
gosub, BuildGUI
Return

OnHandItems:
Report .= "`nTotal Items Available For Issue: " . OHTtl . "`n"
Loop, parse, OHList, |
{
	iniread, StoredQty, %ini%, On-Hand Qty, %A_Loopfield%, 0
	Report .= "`t" . A_Loopfield . ":  " .  StoredQty . "`n"
}
Return

IssuedItems:
Report .= "`nTotal items issued: " . ITtl . "`n"
Loop, parse, IList, |
{
	iniread, StoredQty, %ini%, Issued Qty, %A_Loopfield%, 0
	
	Report .= "`t" . A_Loopfield . ":  " .  StoredQty . "`n"
}
Return


BuildGUI:
FileDelete, %ini%
Gui, Report: New
Gui,  +ToolWindow
gui, font, s15, Segoi UI
Gui, Margin, 20, 20
Gui, add, text, vReported, %Report%
GuiControlGet, Reported, Pos
Sleep, 50
Center := ReportedW//2 + 20
PrintX := Center - 35
OkX := PrintX - 80
SaveX := Center + 45
Gui, Add, Button, h40 w70 x%OkX% gGuiClose, Close
Gui, Add, Button, ypos+0 x%PrintX% h40 w70 gPrint, Print
Gui, Add, Button, ypos+0 x%SaveX% h40 w70 gSave, Save
SplashTextOff
Gui, Show,,Report
Return

GuiClose:
GuiEscape:
ExitApp

Save:
gui, +OwnDialogs
FileName := "Report" . " - " . A_MM . "-" . A_DD . "-" . A_YYYY . ".txt"
FileSelectFile, PathFileName, S16, %A_MyDocuments%\%FileName%, Save Report, Text Documents (*.txt; *.doc)
if (PathFileName = "")
	Return
FileAppend, %Report%, %PathFileName%
Run, notepad.exe %PathFileName%
ExitApp

Print:
PrintText := "`n" . Report
pToken := SGDIPrint_GDIPStartup()
;~ pPrinterName := SGDIPrint_GetDefaultPrinter()
hdc := SGDIPrint_GetHDCfromPrintDlg()
;~ hdc := SGDIPrint_GetHDCfromPrinterName(pPrinterName,1,1,1)
SGDIPrint_BeginDocument(hdc, "Report")
G := SGDIPrint_printerfriendlyGraphicsFromHDC(hdc)

NewText := SGDIPrint_TextFillUpRect(G, PrintText, 100, 100, SGDIPrint_HDC_Width - 200, SGDIPrint_HDC_Height - 200)

SGDIPrint_EndDocument(hDC)
SGDIPrint_DeleteGraphics(G)
SGDIPrint_GDIPShutdown(pToken)

Return


