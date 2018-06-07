@echo off
set /p t="What should be listed? "
cls
:a
set /a ans=%ans%+%t%
echo %ans%
goto a