@echo off
title Russian Roulette (1 bullet)
:main
cls
echo ***************************
echo Welcome to Russian Roulette
echo ***************************
echo.
echo What do you want to do?
echo.
echo 1) Try to survive
echo 2) Chicken out
echo.
echo Note the revolver is loaded with one bullet ONLY.
echo.
set /p input= Type here: 
if %input% == 1 goto b
if %input% == 2 goto quitconfirm
goto main
:b
set /a num=%random% %%6 +1
if %num% == 1 goto death
if %num% == 2 goto fire
if %num% == 3 goto fire
if %num% == 4 goto fire
if %num% == 5 goto fire
if %num% == 6 goto fire
:fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo Nothing happened!
timeout /t 1 /nobreak >nul
goto 1b
:1b
cls
echo 1) Respin the revolver
echo 2) Pass to next person
echo 3) Quit
echo.
set /p input= Type here: 
if %input% == 1 goto b
if %input% == 2 goto nextplayer
if %input% == 3 goto quitconfirm1
goto 1b
:nextplayer
cls
echo Hi, next player!
echo Would you like to respin or quit?
echo.
echo 1) Respin
echo 2) Quit
echo.
set /p input= Type here: 
if %input% == 1 goto b
if %input% == 2 goto quitconfirm2
goto nextplayer
:quitconfirm
cls
echo Are you sure?
echo.
echo 1) Yes
echo 2) No
echo.
set /p input= Type here: 
if %input% == 1 goto chicken
if %input% == 2 goto :main
goto quitconfirm
:quitconfirm1
cls
echo Are you sure?
echo.
echo 1) Yes
echo 2) No
echo.
set /p input= Type here: 
if %input% == 1 goto chicken
if %input% == 2 goto 1b
goto quitconfirm1
:quitconfirm2
cls
echo Are you sure?
echo.
echo 1) Yes
echo 2) No
echo.
set /p input= Type here: 
if %input% == 1 goto chicken
if %input% == 2 goto nextplayer
goto quitconfirm2
:death
cls
echo Click...
timeout /t 1 /nobreak >nul
color c7
echo BANG!!
timeout /t 1 /nobreak >nul
echo You are dead...
timeout /t 1 /nobreak >nul
exit
:chicken
cls
color c7
echo CHICKEN!
timeout /t 2 /nobreak >nul
exit