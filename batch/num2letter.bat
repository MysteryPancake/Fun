@echo off
:a
color 19
set conv=%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
set conv=%conv:1=A%
set conv=%conv:2=E%
set conv=%conv:3=T%
set conv=%conv:4=D%
set conv=%conv:5=E%
set conv=%conv:6=P%
set conv=%conv:7=S%
set conv=%conv:8=H%
set conv=%conv:9=U%
set conv=%conv:0=K%
echo %conv%
ping -w .9 >nul
goto a