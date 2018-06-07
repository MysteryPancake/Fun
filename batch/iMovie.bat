@echo off
title Trailer Generator
:titlescreen
cls
@echo.
@echo WELCOME TO IMOVIE- TRAILER CREATOR
@echo.
@echo Please type 'begin'.
@echo.
set /p gamestart=""
if /i %gamestart%==begin goto beforebegin
goto titlescreen
:beforebegin
cls
set /p title="Enter the movie title here: "
set /p auth="Enter the creator here: "
goto begin
:begin
cls
@echo How many characters? (Up to 5 accepted)
@echo.
set /p chars="Type the number here: "
if %chars%==0 goto begin
if %chars% lss 6 goto continue
goto begin
:continue
cls
if %chars%==1 set cnt=end
if %chars%==2 set cnt=cnt5
if %chars%==3 set cnt=cnt4
if %chars%==4 set cnt=cnt3
if %chars%==5 set cnt=cnt2
@echo What are the names?
@echo.
set /p name1="Please type a name: "
:cnthlf
set /p gender1="Please type the gender (Boy/Girl): "
if /i %gender1%==boy goto %cnt%
if /i %gender1%==girl goto %cnt%
cls
goto cnthlf
:cnt2
set /p name2="Please type a name: "
:cnthlf2
set /p gender2="Please type the gender (Boy/Girl): "
if /i %gender2%==boy goto cnt3
if /i %gender2%==girl goto cnt3
cls
goto cnthlf2
:cnt3
set /p name3="Please type a name: "
:cnthlf3
set /p gender3="Please type the gender (Boy/Girl): "
if /i %gender3%==boy goto cnt4
if /i %gender3%==girl goto cnt4
cls
goto cnthlf3
:cnt4
set /p name4="Please type a name: "
:cnthlf4
set /p gender4="Please type the gender (Boy/Girl): "
if /i %gender4%==boy goto cnt5
if /i %gender4%==girl goto cnt5
cls
goto cnthlf4
:cnt5
set /p name5="Please type a name: "
:cnthlf5
set /p gender5="Please type the gender (Boy/Girl): "
if /i %gender5%==boy goto end
if /i %gender5%==girl goto end
cls
goto cnthlf5
:end
@echo ALL FINISHED!
pause
goto movie
:movie
cls
timeout /t 1 /nobreak > nul
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo					A film by %auth%
timeout /t 3 /nobreak > nul
cls
timeout /t 2 /nobreak > nul
cls
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo 					%title%
timeout /t 4 /nobreak > nul
cls
timeout /t 1 /nobreak > nul
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo					STARRING...
timeout /t 2 /nobreak > nul

:britishboy
cls
@echo          888888
@echo          888888
@echo          888888
@echo          888888
@echo        8888888888
@echo           88888
@echo         8888888
@echo         8888888
@echo         8888888
@echo           8888
@echo         8888888
@echo       88888888888
@echo      888888888888
@echo      88 888888 88
@echo      88 888888 88
@echo     88  888888  88
@echo     88  888888  88
@echo    888  888888  888
@echo    8 8  888888  8 8
@echo         88  88
@echo         88   88
@echo         88   88
@echo         88   88
@echo        888   888
@echo      88888   88888
@echo			%name1%
:britishlady
@echo           8888888
@echo       888888888888888
@echo           8888888
@echo          888888888
@echo          888888888
@echo          88888 888
@echo           8888  888
@echo         8888888 888
@echo       88888888888 8
@echo      8888888888888
@echo      88 888888 888
@echo     88 8888888  88
@echo     88 8888888  88
@echo     88  888888  88
@echo    888  888888  888
@echo    8 8  888888  8 8
@echo         888888
@echo         88  888
@echo         88   88
@echo         88   88
@echo         88   88
@echo      88888   88888
@echo    8888  8   8  8888