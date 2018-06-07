@echo off
set /p cusnum= "What number (1 to ???)? "
if %cusnum% lss 1 goto warning
set /a count=0
:a
set /a num=%random% %% %cusnum% +1
if %num%==%cusnum% goto end
set /a count=%count%+1
echo #%count% - %num%
goto a
:end
set /a count=%count%+1
if %count%==1 goto onealt
echo #%count% - %cusnum%
echo It took %count% tries to get the number %cusnum%.
pause
exit
:onealt
echo #%count% - %cusnum%
echo It took %count% try to get the number %cusnum%.
pause
exit
:warning
echo You have to enter a POSITIVE number! RESTART!
pause
exit