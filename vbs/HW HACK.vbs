Res = Msgbox ("Happy Wheels Hacked! Visit site?", vbYesNo + 64, "SUCCESS")
Select Case Res
Case vbYes
set shell = CreateObject("Shell.Application")
shell.Open "http://www.totaljerkface.com/happy_wheels.tjf"
Case vbNo
End Select
