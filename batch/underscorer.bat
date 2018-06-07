@echo off
cd C:\Users\%username%\Desktop
set /p conv="Folder name to put _ into (on desktop): "
set conv2=%conv: =_%
mkdir %conv2%
xcopy "%cd%/%conv%/" "%cd%/%conv2%" /s
pause