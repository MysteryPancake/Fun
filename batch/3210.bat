@echo off
set path=FIVE!
:answer
set /p pass="What is one plus one? "
cls
if /i %pass%==two goto win
goto %path%
:FIVE!
set path=FOUR!
echo -
goto answer
:FOUR!
set path=THREE!
echo -0
goto answer
:THREE!
set path=TWO!
echo -0_
goto answer
:TWO!
set path=ONE!
echo -0_0
goto answer
:ONE!
set path=ZERO!
echo -0_0-
goto answer
:ZERO!
set path=YOU FAILED!
echo -X_X-
goto answer
:YOU FAILED!
@ECHO You will NEVER discover my password!
pause
exit
:win
@echo YOU WEREN'T MEANT TO GET IT RIGHT! Try again!
goto answer