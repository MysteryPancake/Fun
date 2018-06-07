@echo off
:a
SET timey=%time%
SET hour=%timey:~0,2%
SET restofhour=%timey:~2,3%
SET seconds=%timey:~6,2%
SET mili=%timey:~9,2%
if %hour% gtr 12 set /a hour= %hour%-12
if %seconds%==01 set plu=second
if NOT %seconds%==01 set plu=seconds
echo The time is %hour%%restofhour% and %seconds% %plu% (and %mili% miliseconds).
goto a