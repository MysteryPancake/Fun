@echo off
if EXIST lastopened.txt type lastopened.txt
echo Last opened: %time% %date%
echo.
echo Last opened: %time% %date% >> lastopened.txt
echo. >> lastopened.txt
pause
exit