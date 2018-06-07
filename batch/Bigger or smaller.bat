@ECHO OFF
@echo Try to guess the random number chosen between 1 and 5000!
@echo.
:easyorhard
@echo Would you like to try in easy or hard mode?
@echo.
@echo In hard mode, you only get one guess at the number, and if you get it wrong,
@echo you get no hints and must retry with a different number next time.
@echo.
@echo In easy mode, you get infinite guesses at the number chosen from the certain
@echo area you define (e.g. 1 in 10) and if you get it wrong, you get told 
@echo whether the number is bigger and smaller until you get it.
@echo.
set /p easyhardinput= "Type 'easy' or 'hard': "
cls
if /i %easyhardinput% == hard goto choicehard
if /i %easyhardinput% == easy goto choiceeasy
cls
goto easyorhard
:choicehard
set /a num=%random% %% 50 +1
set /p inputhrd= "Enter your guess: "
if %inputhrd% gtr %num% goto smallhard
if %inputhrd% lss %num% goto bighard
if %inputhrd% == %num% goto correct
goto wrong2
:choiceeasy
set /p chnc= "Enter the amount to guess from: "
set /a num=%random% %% %chnc% +1
:choiceeasyh
set /p input= "Enter your guess: "
if %input% gtr %num% goto small
if %input% lss %num% goto big
if %input% == %num% goto correct
goto wrong
:small
@echo The number is smaller
goto choiceeasyh
:smallhard
cls
@echo Nope, smaller, try again next time.
pause
exit
:big
@echo The number is bigger
goto choiceeasyh
:bighard
cls
@echo Nope, bigger, try again next time.
pause
exit
:correct
cls
@echo You got it! The number was %num%.
pause
exit
:wrong
echo You have to enter a NUMBER. Try again.
goto choiceeasy
:wrong2
echo You have to enter a NUMBER. Try again.
goto choicehard