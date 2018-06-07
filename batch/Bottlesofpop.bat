@echo off
color 0a
rem Bottles on the wall
rem Made by Mysterypancake1
set /a bottle=99
rem It is 99, right? (Just change it to your preference if wished)
:a
rem It needs to stop at 0.
cls
if %bottle% gtr 2 goto continue
goto ending
:continue
rem It simply removes a bottle every time.
echo %bottle% bottles of pop on the wall, %bottle% bottles of pop.
echo		  	 ___________
echo			 ===========
echo		 	/           \
echo		       /             \
echo		       [             ]
echo		       [  ---------  ]
echo		       [ /         \ ]
echo		       [/           \]
echo		       [             ]
echo		       [             ]
echo		       [   P  O  P   ]
echo		       [             ]
echo		       [             ]
echo		       [             ]
echo		       [\           /]
echo		       [ \         / ]
echo		       [  ---------  ]
echo		       [             ]
echo		       \   _______   /
echo		        --/       \--
timeout /t 4 /nobreak > nul
set /a bottle=%bottle%-1
echo Take one down, pass it around, %bottle% bottles of pop on the wall.
timeout /t 4 /nobreak > nul
goto a
:ending
cls
rem This bit is for correct plural use
echo 2 bottles of pop on the wall, 2 bottles of pop.
timeout /t 4 /nobreak > nul
echo Take one down, pass it around, 1 bottle of pop on the wall.
timeout /t 4 /nobreak > nul
cls
rem This bit is the actual ending (press any key to quit).
echo 1 bottle of pop on the wall, 1 bottle of pop.
timeout /t 4 /nobreak > nul
echo Take it down, pass it around, no bottles of pop on the wall!
pause
exit