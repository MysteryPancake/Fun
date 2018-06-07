@ECHO OFF
echo Microsoft Windows [Version 6.1.7601]
echo Copyright (c) 2009 Microsoft Corporation. All rights reserved.
echo.
:menu
set /p input= "C:\Users\%username%>"
if /i %input% == hack goto hackinfo
if /i %input% == hack_lamp_off goto hackfake
if /i %input% == HACK goto hackinfo
if /i %input% == HACMAC goto hackmac
if /i %input% == HACKMAC goto hackmac
if /i %input% == HACK_MAC goto hackmac
if /i %input% == HACK_LAMP_OFF goto hackfake
if /i %input% == tree goto root
if /i %input% == help goto help
if /i %input% == test goto test
if /i %input% == TEST goto test
echo '%input%' is not a recognized as an internal or external command,
echo operable program or batch file.
echo.
goto menu
:hackmac
echo UR MAK HAS BEEN HAKD BOI
pause
exit
:test
goto matrix
:root
tree
goto menu
:hackinfo
echo Incorrect usage of variable 'hack'.
echo.
echo HACK [Entity_Name] [Command]
echo Example: 'HACK_LAMP_OFF'
echo.
goto menu
:hackfake
set /a num=%random% %%7 +1
if %num% == 1 goto 1
if %num% == 2 goto 2
if %num% == 3 goto 3
if %num% == 4 goto 4   
if %num% == 5 goto 5
if %num% == 6 goto 6
if %num% == 7 goto 7
:1
echo Password Required
goto hackfake
:2
echo //furnishings/lamp01//
goto hackfake
:3
echo 'L:/Powerreserve/entity/list/lamp001/'
goto hackfake
:4
echo SYSTEM_PASS_CODE12i.
goto hackfake
:5
echo //root;ent_lamp01_override
goto hackfake
:6
echo //security098?ss1098
goto hackfake
:7
echo Logging_into [D:/furnishings/lamp01/powerreserve/power.txt]
echo Code: 1_533p
echo Password_Accepted
goto accepted
:accepted
echo.
echo Lamp_01 has been Switched_Off.
goto menu
:help
echo HACK	Hacks a website, program or any electronic entity to be manipulated 
echo 	by the user.
echo HELP	Provides Help information for Windows commands.
echo TREE	Graphically displays the folder structure of a drive or path.
echo TEST	Displays the source binary
goto menu
:matrix
set /a num=%random% %%20 +1
if %num% == 1 goto 1
if %num% == 2 goto 2
if %num% == 3 goto 3
if %num% == 4 goto 4   
if %num% == 5 goto 5
if %num% == 6 goto 1
if %num% == 7 goto 2
if %num% == 8 goto 3
if %num% == 9 goto 4   
if %num% == 10 goto 5
if %num% == 11 goto 1
if %num% == 12 goto 2
if %num% == 13 goto 3
if %num% == 14 goto 4   
if %num% == 15 goto 5
if %num% == 16 goto 1
if %num% == 17 goto 2
if %num% == 18 goto 3
if %num% == 19 goto 4   
if %num% == 20 goto menu
:1
echo 101001001010110101001001010110101001001010110101001001010110
goto matrix
:2
echo 000101110010010010101110010010100101110010010010101110010010
goto matrix
:3
echo 011010101101101011010101101101011010101101101011010101101101
goto matrix
:4
echo 111111111111111111011111000011111111111111111111111110111111
goto matrix
:5
echo 000010010001000000100000001000000000010000100000010000011000
goto matrix
