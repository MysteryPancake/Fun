@echo off
cd C:/Users/%username%/Desktop
echo This only works if the first and second folder have no spaces :(
set /p mainfolder= "What is the main folder called (on desktop)? "
for /f "usebackq" %%m in (`dir /b %CD%\%mainfolder%`) do (
    copy "%CD%\%mainfolder%\%%m\*.*" "%CD%/%mainfolder%"
)


pause