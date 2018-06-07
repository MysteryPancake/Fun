@echo off
set YEAR=%DATE:~-4%
set /p lol="What do you want to do? "
set lol=%lol:my=your%
set lol=%lol:me=you%
set lol=%lol:I want to=You%
set lol=%lol:i =you %
echo %lol%. The end.
echo.
echo Written by %username%.
echo © %year%
pause