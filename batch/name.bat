@echo off
cd C:\Users\%username%\desktop
if exist %CD%\name.txt goto hiname
if NOT exist "%CD%\name.txt" goto typename
:typename
cls
set /p name= "What is your name? "
@echo %name% > name.txt
goto hiname
:hiname
cls
set /p name= < name.txt
@echo Hello, %name%.
timeout /t 1 /nobreak > nul
goto hiname