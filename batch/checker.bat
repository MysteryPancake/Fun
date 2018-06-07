@echo off
title Number checker
set both=0
set num=0
:a
set /a num=%num%+1
cls
echo Checking for missing numbers... up to %num%- Sorry, it's quite slow!
set both=%both% %num%
goto a