@echo off
mode 1000
set d=%random%
set f=b
:g
cls
set /p dr= "How many times should the music be randomly generated (1: Infinite, 2: 2 times)? "
if %dr%==1 set lol=a & goto cont
if %dr%==2 set lol=h & goto cont
goto g
:cont
cd C:/Users/%username%/Desktop
:a
set conv=%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
set conv=%conv:1=A%
set conv=%conv:2=B%
set conv=%conv:3=C%
set conv=%conv:4=D%
set conv=%conv:5=E%
set conv=%conv:6=F%
set conv=%conv:7=G%
set conv=%conv:8=%
set conv=%conv:9=%
set conv=%conv:0=%
if %f%==a goto b
echo %conv% > %d%.txt
set f=a
goto a
:b
echo CLOSE THIS AT ANY TIME TO STOP YOUR HARD DRIVE BEING USED UP!
echo %conv% >> %d%.txt
goto %lol%
:h
exit