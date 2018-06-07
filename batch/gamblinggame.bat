@echo off
set try=1
set /p low="What is the lowest possible number? "
set /p hi="What is the highest possible number? "
set /a th=%hi%-%low%
:a
cls
set /a num=%random% %% %th%
set /a idk=%low%+%num%
echo Lowest=%low% Highest=%hi% Tries=%try%
echo.
echo The number chosen is %idk%.
echo.
set /a try= %try%+1
pause
goto a