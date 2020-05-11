@echo off
:start
set /p number="Type a number: "
IF /i %number% == 1 GOTO one
IF /i %number% == 2 GOTO two
IF /i %number% == 3 GOTO three
echo "NOT ONE, TWO OR THREE";
goto start
:one
echo "ONE"
:two
echo "TWO"
:three
echo "THREE"
GOTO start