@echo off
set all=0
mode 1000
title Number Checker
@echo This is for those annoying YouTube comments that list loads of numbers and ask what number is missing.
@echo.
@echo What's the first number? (E.G. 4 5 6 7 8, the first number is 4)
set /p stno=""
@echo Good!
@echo.
@echo What's the last number?
set /p lstno=""
@echo Okay... please save all the numbers in the comment to a text document called numbers.txt on your desktop, or just press any key.
pause
:check
cd C:/Users/%username%/Desktop
if EXIST numbers.txt cls & echo File Found! & goto found
echo File not found! Please paste all the numbers on the text document open now and save it.
echo. 2>numbers.txt
start numbers.txt
pause
goto check
:found
echo Right, let's begin.
pause
goto stuff
:stuff
set /a stno=%stno%+1
cls
echo Checking for missing numbers... up to %stno%- Sorry, it's quite slow!
set all=%all% %stno%
if %stno%==%lstno% goto end
goto stuff
:end
echo Sorry, no numbers were found different!
pause
exit