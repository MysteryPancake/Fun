@echo off
cd C:/Users/%username%/Desktop
title Random number generator generator
set /p low="What is the lowest possible number? "
set /p hi="What is the highest possible number? "
@echo echo off > result.bat
@echo set try=1 >> result.bat
@echo set /a th=%hi%-%low% >> result.bat
@echo :a >> result.bat
@echo cls >> result.bat
@echo set /a num=%%random%% %%%% %%th%% >> result.bat
@echo set /a idk=%low%+%%num%% >> result.bat
@echo echo Lowest=%low% Highest=%hi% Tries=%%try%% >> result.bat
@echo echo. >> result.bat
@echo echo The number chosen is %%idk%%. >> result.bat
@echo echo. >> result.bat
@echo set /a try= %%try%%+1 >> result.bat
@echo pause >> result.bat
@echo goto a >> result.bat
echo A file named 'result.bat' has been saved to your desktop.
pause