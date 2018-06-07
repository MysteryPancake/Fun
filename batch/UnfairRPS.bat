@echo off
rem 1-Rock
rem 2-Paper
rem 3-Scissors
title Rock Paper Scissors
:inp
set userinp=o
set /a pcinp=%random%%%3 +1
cls
echo ROCK PAPER SCISSORS
echo.
set /p userinp= "Which one (Rock, Paper, Scissors)? "
if /i %userinp%==Rock goto result
if /i %userinp%==Paper goto result
if /i %userinp%==Scissors goto result
if /i %userinp%==o goto inp
goto inp
:result
echo.
set checkres=%userinp%%pcinp%
if /i %checkres%==rock1 goto tie
if /i %checkres%==paper2 goto tie
if /i %checkres%==scissors3 goto tie
if /i %checkres%==rock2 goto rockpaper
if /i %checkres%==rock3 goto rockscissor
if /i %checkres%==paper1 goto paperrock
if /i %checkres%==paper3 goto paperscissor
if /i %checkres%==scissors1 goto scissorrock
if /i %checkres%==scissors2 goto scissorpaper
:rockpaper
echo You chose Rock. Your PC chose Paper.
echo Paper covers rock.
echo PC WINS!
echo.
echo Retry?
pause
goto inp
:rockscissor
echo You chose Rock. Your PC chose Scissors.
echo Scissors cut rock.
echo PC WINS!
echo.
echo Retry?
pause
goto inp
:paperrock
echo You chose Paper. Your PC chose Rock.
echo Rock smashes paper.
echo PC WINS!
echo.
echo Retry?
pause
goto inp
:paperscissor
echo You chose Paper. Your PC chose Scissors.
echo Scissors cut paper.
echo PC WINS!
echo.
echo Retry?
pause
goto inp
:scissorrock
echo You chose Scissors. Your PC chose Rock.
echo Rock smashes scissors.
echo PC WINS!
echo.
echo Retry?
pause
goto inp
:scissorpaper
echo You chose Scissors. Your PC chose Paper.
echo Paper covers scissors.
echo PC WINS!
echo.
echo Retry?
pause
goto inp
:tie
echo You chose %userinp%. Your PC chose %userinp%.
echo PC's %userinp% is bigger than yours.
echo PC WINS!
echo.
echo Retry?
pause
goto inp