#SingleInstance, Force
#Persistent
aData := []
data := "test,L-Box 01,TestSer0021,L-Box 02,TestSer0022,L-Box 03,TestSer0023,L-Box 04,TestSer0024,L-Box 05,TestSer0025,L-Box 06,TestSer0026,L-Box 07,TestSer0027,L-Box 08,TestSer0028,L-Box 09,TestSer0029,L-Box 10,TestSer0030,L-Box 11,TestSer0031,L-Box 12,TestSer0032,L-Box 13,TestSer0033,L-Box 14,TestSer0034,L-Box 16,TestSer0035,L-Box 17,TestSer0036,L-Box 18,TestSer0037,L-Box 19,TestSer0038,L-Box XX,TestSer0039,L-XBox 01,TestSer0040,L-Box 01,TestSer0041,L-Box 02,TestSer0042,L-Box 03,TestSer0043,L-Box 04,TestSer0044,L-Box 05,TestSer0045,L-Box 06,TestSer0046,L-Box 07,TestSer0047,L-Box 08,TestSer0048,L-Box 09,TestSer0049,L-Box 10,TestSer0050,L-Box 11,TestSer0051,L-Box 12,TestSer0052,L-Box 13,TestSer0053,L-Box 14,TestSer0054,L-Box 16,TestSer0055,L-Box 17,TestSer0056,L-Box 18,TestSer0057,L-Box 19,TestSer0058,L-Box XX,TestSer0059,L-XBox 01,TestSer0060,L-Box 01,TestSer0061,L-Box 02,TestSer0062,L-Box 03,TestSer0063,L-Box 04,TestSer0064,L-Box 05,TestSer0065,L-Box 06,TestSer0066,L-Box 07,TestSer0067,L-Box 08,TestSer0068,L-Box 09,TestSer0069,L-Box 10,TestSer0070,L-Box 11,TestSer0071,L-Box 12,TestSer0072,L-Box 13,TestSer0073,L-Box 14,TestSer0074,L-Box 16,TestSer0075,L-Box 17,TestSer0076,L-Box 18,TestSer0077,L-Box 19,TestSer0078,L-Box XX,TestSer0079,L-XBox 01,TestSer0000"
Loop, Parse, data, csv
		aData.push(A_Loopfield)
Index := 0
msgBox, Ready to go!
Return

Insert::
Index += 1
ControlSetText, Edit1, % aData[Index], Scan Serial
Send, {Enter}
Return


