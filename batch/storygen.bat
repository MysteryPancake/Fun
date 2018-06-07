@echo off
title Story Generator 2014
set /p echotitle= "Enter the story title here: "
set /p user= "Enter the Author (I.E. your name) here: "
set /p gen= "Enter the story genre: "
set /p once= "Once upon a time there was a? "
set /p gob= "Is this thing good or bad? "
set /p crc= "What is the main character's name? "
set /p mayor= "What is the mayor's name? "
set /p op= "What was the mayor's opinion of %once%? "
echo Good! Your story is complete!
pause
cls
echo %echotitle% 
echo By %user%
echo (Genre: %gen%)
echo.
echo Once upon a time there was a %once%.
echo This %once% was %gob%.
echo One day %crc% saw the %once%. He thought it was %gob%.
echo In fact, so %gob%, he decided to phone the mayor, 
echo %mayor% to tell him about it.
echo So, %crc% phoned %mayor% and told him about %once%.
echo The mayor thought %once% was %op%.
pause