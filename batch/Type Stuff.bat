@echo off
title Type stuff!
set text= 
:a
cls
set /p new=%text%
set text=%text%%new%
goto a