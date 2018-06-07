@echo off
set /a p=0
set lvl=Amateur
title Cat-Patting Simulator
:a
cls
echo 		Pat the cat!
echo 		Pats-%p% (%lvl%)
echo.
		pause
if %p%==50 set lvl=Beginner
if %p%==100 set lvl=Getting better
if %p%==150 set lvl=Mediocre
if %p%==200 set lvl=Good
if %p%==250 set lvl=Fantastic
if %p%==300 set lvl=Advanced
if %p%==350 set lvl=Super
if %p%==400 set lvl=Amazing
if %p%==450 set lvl=Sick
if %p%==500 set lvl=Epic
if %p%==550 set lvl=Satisfied
if %p%==600 set lvl=Unbelievable
if %p%==650 set lvl=Badass
if %p%==700 set lvl=Professional
if %p%==750 set lvl=Cat studier
if %p%==800 set lvl=Psychic
if %p%==850 set lvl=Wizard
if %p%==900 set lvl=Owner
if %p%==998 set lvl=Hacker
if %p%==1000 set lvl=Cat
if %p%==1100 set lvl=Expert
if %p%==1200 set lvl=Vet
if %p%==1300 set lvl=Feeder
if %p%==1400 set lvl=Genius
if %p%==1500 set lvl=Genie
if %p%==1600 set lvl=Jesus
if %p%==1700 set lvl=God
if %p%==1800 set lvl=The Creator
if %p%==1900 set lvl=Robot
if %p%==2000 set lvl=Legend
if %p%==2100 set lvl=Ninja
if %p%==2200 set lvl=Ninja Trainer
if %p%==2300 set lvl=Master
if %p%==2400 set lvl=Chuck Norris
if %p%==2500 set lvl=Impossible
if %p%==2600 set lvl=Ridiculous
if %p%==2700 set lvl=Hero
if %p%==2800 set lvl=Saviour
if %p%==2900 set lvl=Insane
if %p%==3000 set lvl=Broke the scale
set /a p=%p%+1
goto a