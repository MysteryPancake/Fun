@echo off
title Hangman
set path2=Three2
set path=Three
set f=_
set f2=_
set f3=_
set f4=_
set f5=_
set f6=_
set f7=_
set f8=_
set f9=_
set f10=_
set f11=_
set f12=_
set b=_
set b2=_
set b3=_
set b4=_
set b5=_
set b6=_
:guess
cls
set anti=%f%%f2%%f3%%f4%%f5%%f4%%f6%%f7%%f6%%f3%%f%%f8%%f9%%f4%%f6%%f10%%f11%%f7%%f2%%f3%%f%%f12%%f4%%f%%f2%%f4%%f6%%f11%
@echo %anti%
set /p letter="Guess a letter: "
if /i %letter%==a set f=A
if /i %letter%==n set f2=N
if /i %letter%==t set f3=T
if /i %letter%==i set f4=I
if /i %letter%==d set f5=D
if /i %letter%==s set f6=S
if /i %letter%==e set f7=E
if /i %letter%==b set f8=B
if /i %letter%==l set f9=L
if /i %letter%==h set f10=H
if /i %letter%==m set f11=M
if /i %letter%==r set f12=R
set anti=%f%%f2%%f3%%f4%%f5%%f4%%f6%%f7%%f6%%f3%%f%%f8%%f9%%f4%%f6%%f10%%f11%%f7%%f2%%f3%%f%%f12%%f4%%f%%f2%%f4%%f6%%f11%
if "%anti%"=="ANTIDISESTABLISHMENTARIANISM" goto win
if /i "%letter%"=="antidisestablishmentarianism" goto win
if /i %letter%==a goto guess
if /i %letter%==n goto guess
if /i %letter%==t goto guess
if /i %letter%==i goto guess
if /i %letter%==d goto guess
if /i %letter%==s goto guess
if /i %letter%==e goto guess
if /i %letter%==b goto guess
if /i %letter%==l goto guess
if /i %letter%==h goto guess
if /i %letter%==m goto guess
if /i %letter%==r goto guess
goto %path%
:win
cls
@echo ANTIDISESTABLISHMENTARIANISM
@echo.
@echo You completed the word! Continue?
@echo.
set /p exitorstay="Y/N? "
if /i %exitorstay%==Y goto guess2
if /i %exitorstay%==N exit
if /i %exitorstay%==yes goto guess2
if /i %exitorstay%==no exit
goto win
:Three
set path=Two
goto guess
:Two
set path=One
@echo Hint: The opposition of the disestablishment of a certain church...
pause
goto guess
:One
set path=Zero
goto guess
:Zero
@Echo Too many wrong letters, you lost!
pause
exit
:guess2
cls
set hangman=%b%%b2%%b3%%b4%%b5%%b2%%b3%
@echo %hangman%
set /p hanglet="Guess a letter: "
if /i %hanglet%==h set b=H
if /i %hanglet%==a set b2=A
if /i %hanglet%==n set b3=N
if /i %hanglet%==g set b4=G
if /i %hanglet%==m set b5=M
set hangman=%b%%b2%%b3%%b4%%b5%%b2%%b3%
if "%hangman%"=="HANGMAN" goto win2
if /i "%hanglet%"=="HANGMAN" goto win2
if /i %hanglet%==h goto guess2
if /i %hanglet%==a goto guess2
if /i %hanglet%==n goto guess2
if /i %hanglet%==g goto guess2
if /i %hanglet%==m goto guess2
goto %path2%
:Three2
set path2=Two2
goto guess2
:Two2
set path2=One2
@echo Hint: The name of a certain game...
pause
goto guess2
:One2
set path2=Zero2
goto guess2
:Zero2
@Echo Too many wrong letters, you lost!
pause
exit
:win2
cls
@echo HANGMAN
@echo.
@echo You completed the word! Continue?
@echo.
set /p exitorstay="Y/N? "
if /i %exitorstay%==Y goto guess3
if /i %exitorstay%==N exit
if /i %exitorstay%==yes goto guess3
if /i %exitorstay%==no exit
goto win2