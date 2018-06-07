@echo off
title Text saver
cd C:/Users/%username%/Desktop
:enterchoice
cls
@echo What would you like to do?
@echo.
@echo 1) Create a new single-line text entry
@echo 2) Display last saved text on screen
@echo 3) Open the text in notepad (to copy-paste)
@echo 4) Delete last saved text
@echo.
set /p choice= "Type the number here: "
if %choice%==1 goto entersent
if %choice%==2 goto disp
if %choice%==3 goto open
if %choice%==4 goto del
goto enterchoice
:entersent
cls
:nocls
set /p sentence= "Enter your text here: "
@echo %sentence% > text.txt
goto enterchoice
:disp
cls
@echo The last saved text:
if exist %CD%\text.txt type %CD%\text.txt
if NOT exist "%CD%\text.txt" echo ERROR- NO TEXT FOUND!
pause
goto enterchoice
:open
cls
if exist %CD%\text.txt start %CD%/text.txt
if NOT exist "%CD%\text.txt" echo ERROR- NO TEXT FOUND!
pause
goto enterchoice
:del
set /p sure= "Are you sure (Y/N)? "
if /i %sure%==y goto delcheck
if /i %sure%==n goto enterchoice
if /i %sure%==yes del delcheck
if /i %sure%==no goto enterchoice
goto enterchoice
:delcheck
if exist %CD%\text.txt del text.txt
if NOT exist "%CD%\text.txt" goto enterchoice
goto enterchoice