rem Made by Mysterypancake1
rem Very buggy though, typing things like * or & or ^ and ! crash/have weird effects on the tool.
@echo off
setlocal enabledelayedexpansion
:start
cls
echo PIG LATIN TRANSLATOR
echo.
echo Note sentences will be on multiple lines
rem I wish they weren't though :(
echo.
echo Type the word/sentence you want to be translated below (press 'enter' when done)
echo.
rem Stuff below checks that the input is not nul.
set /p word=""
IF "%word%"=="" goto start ELSE goto cont
:cont
cls
echo The translation
echo Original
echo.
echo %word%
echo.
echo Pig latin 
echo.
for %%a in (%word%) do (
set transword=%%a
set First=!transword:~0,1!
rem That gets the first letter to put last
set Rest=!transword:~1!
rem That gets the rest of the word that isn't the first letter
echo !Rest!!First!ay
rem That echoes all letters except the first, then it echoes the first at the end, and then finally an 'ay'.
)
echo.
pause