@echo off
set /a addnum=1
set /a test=0
set remark=
echo %test%
:a
set /a test=%test%+%addnum%
if %test%==100 set remark= - WOAH!
if %test%==300 set remark= - Uh... dude?
if %test%==400 set remark= - Um, ever heard of 'security'?
if %test%==600 set remark= - At least it can't get worse...
if %test%==700 set remark= - Spoke too soon... & set addnum=2
if %test%==800 set remark= - Woah! NEW WORLD RECORD!
if %test%==1000 set remark= - What. Just. What. & set addnum=4
if %test%==1500 set remark= - This is literally impossible.
if %test%==2015 set remark= - You have more viruses than the year!
if %test%==2500 set remark= - Screw this, just wipe your hard drive!
if %test%==3000 set remark= - I swear, if it gets to 4000...
if %test%==4000 set remark= - That's it. Go talk to the helpdesk- scan cancelling... & set addnum=1
if %test%==4734 goto comp
cls
echo Norton- Virus Scan
echo.
echo Scanning...
echo Virus total: %test% %remark%
ping -w 0 > nul
goto a
:comp
cls
echo Norton- Virus Scan
echo.
echo Scanning...
echo Virus total: 4734 - Cancellation complete!
pause
exit