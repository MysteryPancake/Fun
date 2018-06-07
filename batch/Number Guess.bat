@ECHO OFF
title Chance
@echo Hi! Welcome to the number-guesser!
@echo.
@echo What you have to do is set your chance (e.g. 2433 possibilities)
@echo and then simply enter what you think the ONE number
@echo that will be randomly selected will be (e.g. 643 will get 
@echo selected out of all the numbers between 1 and 2433)
@echo.
@echo Have fun guessing!
@echo.
:enter
set /p chance= "1 in (e.g. 1000): "
set /p enterednum= "Enter your number guess (e.g. 354): "
set /a pcgen= %random% %% %chance% +1
@echo Your PC chose %pcgen% out of %chance% different numbers. You chose %enterednum%.
if %enterednum% == %pcgen% goto win
goto lose
:win
@echo You have the same numbers! You won! Play again?
set /p quitconfirm= "Type 'yes' or 'no': "
if %quitconfirm% == yes goto clsthenmenu
if %quitconfirm% == no goto exitgame
cls
goto win
:lose
@echo You did not get the same numbers. Play again?
set /p quitconfirm= "Type 'yes' or 'no': "
if %quitconfirm% == yes goto clsthenmenu
if %quitconfirm% == no goto exitgame
cls
goto lose
:exitgame
cls
@echo Bye, then!
timeout /t 2 /nobreak > nul
exit
:clsthenmenu
cls
goto enter