@echo off
cd C:\Users\%username%\Desktop
FINDSTR /C:"1" %CD%\unlck.txt
if %errorlevel%==1 goto 0
goto win
:0
echo 0 > unlck.txt
FINDSTR /C:"1" %CD%\unlck.txt
if %errorlevel%==1 goto enterpass
goto win
:enterpass
cls
set /p pass= "Enter password: "
if /i %pass%==password goto win
goto enterpass
:win
cls
echo 1 > unlck.txt
echo Password saved!
echo The password= PASSWORD
pause
exit