@echo off
set num=1
:a
echo if %%num%%==%%a%num%%% goto a >> num.txt
set /a num=%num%+1
if %num%==81 exit
goto a