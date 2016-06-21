ini := A_ScriptDir . "\info.ini"
csvF := A_ScriptDir . "\Inventory.csv"

FileRead, Inv, %csvF%

loop, parse, Inv, `n, `r
{
	StringSplit, Field, A_Loopfield, `,
  if (Field2 = "")
    Continue
  StringSplit, Label, Field2, `-
  IniRead, Highest, %ini%, Labels, %Label1%, 0
  if (Label2 > Highest)
    iniwrite, %Label2%, %ini%, Labels, %Label1%
}

;~ IniRead, Highest, %ini%, Labels, %Label1%, 0

;~ lblnum := 10


;~ IniWrite, %lblnum%, %ini%, Labels, %LabelName%

;~ cols := "a|b|c|d|e|f"
;~ StringSplit, cols, cols, |
;~ MsgBox, %cols0%