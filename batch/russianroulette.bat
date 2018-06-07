@echo off
title Russian Roulette
:main
cls
timeout /t 1 /nobreak >nul
echo ============================================
echo Welcome to Russian Roulette
echo ============================================
echo.
timeout /t 1 /nobreak >nul
echo 1) 1 Bullet in the chamber
echo 2) 2 Bullets in the chamber
echo 3) 3 Bullets in the chamber
echo 4) 4 Bullets in the chamber
echo 5) 5 Bullets in the chamber
echo 6) 6 Bullets in the chamber
echo 7) Keel over and die
echo 8) Close the program
echo.
set /p input=#
if %input% == 1 goto 1b
if %input% == 2 goto 2b
if %input% == 3 goto 3b
if %input% == 4 goto 4b
if %input% == 5 goto 5b
if %input% == 6 goto 6b
if %input% == 7 goto death
if %input% == 8 goto nope
goto main
:1b
cls
echo.
timeout /t 1 /nobreak >nul
echo The chamber has been spun.
timeout /t 2 /nobreak >nul
goto 1ba
:1ba
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo.
set /p input=#
if %input% == 1 goto 1bafire
if %input% == 2 goto main
goto 1ba
:1bafire
set /a num=%random% %%6 +1
if %num% == 1 goto death
if %num% == 2 goto 1ba2fire
if %num% == 3 goto 1ba2fire
if %num% == 4 goto 1ba2fire
if %num% == 5 goto 1ba2fire
if %num% == 6 goto 1ba2fire
:1ba2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 1bb
:1bb
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 1bbfire
if %input% == 2 goto main
if %input% == 3 goto 1b
goto 1bb
:1bbfire
set /a num=%random% %%5 +1
if %num% == 1 goto death
if %num% == 2 goto 1bb2fire
if %num% == 3 goto 1bb2fire
if %num% == 4 goto 1bb2fire
if %num% == 5 goto 1bb2fire
:1bb2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 1bc
:1bc
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 1bcfire
if %input% == 2 goto main
if %input% == 3 goto 1b
goto 1bc
:1bcfire 
set /a num=%random% %%4 +1
if %num% == 1 goto death
if %num% == 2 goto 1bc2fire
if %num% == 3 goto 1bc2fire
if %num% == 4 goto 1bc2fire
:1bc2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 1bd
:1bd
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 1bdfire
if %input% == 2 goto main
if %input% == 3 goto 1b
goto 1bd
:1bdfire 
set /a num=%random% %%3 +1
if %num% == 1 goto death
if %num% == 2 goto 1bd2fire
if %num% == 3 goto 1bd2fire
:1bd2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 1be
:1be
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 1befire
if %input% == 2 goto main
if %input% == 3 goto 1b
goto 1be
:1befire 
set /a num=%random% %%2 +1
if %num% == 1 goto death
if %num% == 2 goto 1be2fire
:1be2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 1bf
:1bf
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 1bffire
if %input% == 2 goto main
if %input% == 3 goto 1b
goto 1bf
:1bffire 
set /a num=%random% %%1 +1
if %num% == 1 goto death
:2b
cls
echo.
timeout /t 1 /nobreak >nul
echo The chamber has been spun.
timeout /t 2 /nobreak >nul
goto 2ba
:2ba
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo.
set /p input=#
if %input% == 1 goto 2bafire
if %input% == 2 goto main
goto 2ba
:2bafire
set /a num=%random% %%6 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto 2ba2fire
if %num% == 4 goto 2ba2fire
if %num% == 5 goto 2ba2fire
if %num% == 6 goto 2ba2fire
:2ba2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 2bb
:2bb
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 2bbfire
if %input% == 2 goto main
if %input% == 3 goto 2b
goto 2bb
:2bbfire
set /a num=%random% %%5 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto 2bb2fire
if %num% == 4 goto 2bb2fire
if %num% == 5 goto 2bb2fire
:2bb2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 2bc
:2bc
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 2bcfire
if %input% == 2 goto main
if %input% == 3 goto 2b
goto 2bc
:2bcfire 
set /a num=%random% %%4 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto 2bc2fire
if %num% == 4 goto 2bc2fire
:2bc2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 2bd
:2bd
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 2bdfire
if %input% == 2 goto main
if %input% == 3 goto 2b
goto 2bd
:2bdfire 
set /a num=%random% %%3 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto 2bd2fire
:2bd2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 2be
:2be
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto death
if %input% == 2 goto main
if %input% == 3 goto 2b
goto 2be
:3b
cls
echo.
timeout /t 1 /nobreak >nul
echo The chamber has been spun.
timeout /t 2 /nobreak >nul
goto 3ba
:3ba
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo.
set /p input=#
if %input% == 1 goto 3bafire
if %input% == 2 goto main
goto 3ba
:3bafire
set /a num=%random% %%6 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto death
if %num% == 4 goto 3ba2fire
if %num% == 5 goto 3ba2fire
if %num% == 6 goto 3ba2fire
:3ba2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 3bb
:3bb
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 3bbfire
if %input% == 2 goto main
if %input% == 3 goto 3b
goto 3bb
:3bbfire
set /a num=%random% %%5 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto death
if %num% == 4 goto 3bb2fire
if %num% == 5 goto 3bb2fire
:3bb2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 3bc
:3bc
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 3bcfire
if %input% == 2 goto main
if %input% == 3 goto 3b
goto 3bc
:3bcfire 
set /a num=%random% %%4 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto death
if %num% == 4 goto 3bc2fire
:3bc2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 3bd
:3bd
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto death
if %input% == 2 goto main
if %input% == 3 goto 3b
goto 3bd
:4b
cls
echo.
timeout /t 1 /nobreak >nul
echo The chamber has been spun.
timeout /t 2 /nobreak >nul
goto 4ba
:4ba
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo.
set /p input=#
if %input% == 1 goto 4bafire
if %input% == 2 goto main
goto 4ba
:4bafire
set /a num=%random% %%6 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto death
if %num% == 4 goto death
if %num% == 5 goto 4ba2fire
if %num% == 6 goto 4ba2fire
:4ba2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 4bb
:4bb
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 4bbfire
if %input% == 2 goto main
if %input% == 3 goto 4b
goto 4bb
:4bbfire
set /a num=%random% %%5 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto death
if %num% == 4 goto death
if %num% == 5 goto 4bb2fire
:4bb2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 4bc
:4bc
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto 4bcfire
if %input% == 2 goto main
if %input% == 3 goto 4b
goto 4bc
:5b
cls
echo.
timeout /t 1 /nobreak >nul
echo The chamber has been spun.
timeout /t 2 /nobreak >nul
goto 5ba
:5ba
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo.
set /p input=#
if %input% == 1 goto 5bafire
if %input% == 2 goto main
goto 5ba
:5bafire
set /a num=%random% %%6 +1
if %num% == 1 goto death
if %num% == 2 goto death
if %num% == 3 goto death
if %num% == 4 goto death
if %num% == 5 goto death
if %num% == 6 goto 5ba2fire
:5ba2fire
cls
echo Click...
timeout /t 1 /nobreak >nul
echo nothing happend!
timeout /t 2 /nobreak >nul
goto 5bb
:5bb
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo 3) Respin
echo.
set /p input=#
if %input% == 1 goto death
if %input% == 2 goto main
if %input% == 3 goto 5b
goto 5bb
:6b
cls
echo.
timeout /t 1 /nobreak >nul
echo The chamber has been spun.
timeout /t 2 /nobreak >nul
goto 6ba
:6ba
cls
echo.
echo 1) Fire the revolver
echo 2) Leave now
echo.
set /p input=#
if %input% == 1 goto death
if %input% == 2 goto main
goto 6ba
:death
cls
echo Click...
timeout /t 1 /nobreak >nul
color c7
echo BOOM!!!
timeout /t 2 /nobreak >nul
exit
:nope
cls
echo Wait a sec, are you sure?
echo Type yes or no.
set /p input=#
if %input% == no goto main
if %input% == yes exit
goto nope