@echo off
set first=firsttime
set ran=%random%
:a
set conv=%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
set conv=%conv:1=A%
set conv=%conv:2=E%
set conv=%conv:3=T%
set conv=%conv:4=D%
set conv=%conv:5=E%
set conv=%conv:6=P%
set conv=%conv:7=S%
set conv=%conv:8=R%
set conv=%conv:9=L%
set conv=%conv:0=K%
goto %first%
:firsttime
set first=second
echo %conv% > %ran%.txt
goto a
:second
echo %conv% >> %ran%.txt
goto a