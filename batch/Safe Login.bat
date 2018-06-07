@echo off
cd C:/Users/%username%/desktop
if NOT exist %cd%/Users mkdir Users
cd %cd%/Users
:a
cls
cd C:/Users/%username%/Desktop/Users
title Create an account
echo Create an account
:b
echo.
echo Enter your username below
echo.
set /p user="User: "
echo.
echo Enter your password below
echo.
set /p pass="Pass: "
cls
echo Checking...
if exist %user%.txt timeout /t 2 /nobreak > nul & echo. & echo Name already exists! & goto b
echo Pwd : %pass% > %user%.txt
timeout /t 2 /nobreak > nul
cls
timeout /t 1 /nobreak > nul
title Success
echo Account Created!
echo.
pause
goto a