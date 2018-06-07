@echo off
title Calculator
:randomtitle
set /a num=%random% %%7 +1
if %num% == 1 goto title1
if %num% == 2 goto title2
if %num% == 3 goto title3
if %num% == 4 goto title4
if %num% == 5 goto title5
if %num% == 6 goto title6
if %num% == 7 goto title7
:title1
set /p calculation= "Enter your equation NOW: "
goto calcmain
:title2
set /p calculation= "Enter your bloody equation, you fat moron: "
goto calcmain
:title3
set /p calculation= "After this, I SWEAR I won't do your crap ever again: "
goto calcmain
:title4
set /p calculation= "Lazy bastard, enter your equation: "
goto calcmain
:title5
set /p calculation= "Please stop asking me your stupid number questions: "
goto calcmain
:title6
set /p calculation= "I give up: "
goto calcmain
:title7
set /p calculation= "Insert your crap here: "
goto calcmain
:calcmain
if %calculation% == matrix goto matrix
if %calculation% == MATRIX goto matrix
set /a answer= %calculation%
set /a desc=%random% %%7 +1
if %num% == 1 goto desc1
if %num% == 2 goto desc2
if %num% == 3 goto desc3
if %num% == 4 goto desc4
if %num% == 5 goto desc5
if %num% == 6 goto desc6
if %num% == 7 goto desc7
:desc1
@echo The answer's obviously %answer%, DUH.
pause
cls
goto randomtitle
:desc2
@echo Are you REALLY that STUPID? It's %answer%!
pause
cls
goto randomtitle
:desc3
@echo Earth to Einstein, the answer's %answer%.
pause
cls
goto randomtitle
:desc4
@echo Do it yourself, lazy. Fine then, it's %answer%.
pause
cls
goto randomtitle
:desc5
@echo Really? REALLY? I DO THIS IN MY SLEEP! %answer%!!!
pause
cls
goto randomtitle
:desc6
@echo I can't damn believe I have to put up with your nonsense. Go outside for once,
@echo fatty. Oh yeah, and the answer's %answer%.
pause
cls
goto randomtitle
:desc7
@echo No comment.
pause
cls
goto randomtitle
:matrix
goto matrixstart
:matrixstart
echo b r E w e 4 e T r 8 M e F r a c h a S t 3 D a C r a s p e s T e 4 h 2 w r e G 2
ping -w .9 >nul
echo R E 9 8 8 R a t r e g 6 n u m A b R E X e Y A T u C 7 a D R a c r u C e B E p e
ping -w .9 >nul
echo c E B E s A d R u B R 3 H e R u D 7 g u d U 7 T a b u T 5 e p E 2 a v e 6 8 a Z
ping -w .9 >nul
echo n u r A X a j a s t a 9 h a 6 e h e G a s u t r a t r A y a f E q u 8 u b R u d
ping -w .9 >nul
echo k u v e 4 E 6 3 e t r a d r e f e y e q e 6 U H e z U b r u R a s 2 4 3 r A N a
ping -w .9 >nul
echo v u P R a b R u c e d U s w a h a c r a t h U 7 r a h u t u h u V e 7 U k u S a
ping -w .9 >nul
echo T e D r e 8 A p r a d a b u f U c u c E h E t 7 c r 5 s P a f r e t h u t 9 u t
ping -w .9 >nul
echo b R u G e p a R e s a P H e P a 2 U d 4 P r e F A b a t h a t h U s w a d R U d
ping -w .9 >nul
echo v U Y a C R e T R 9 k u b e D r a T 6 u j e 5 2 4 e B a f 2 u b 5 w A p a y U Y
ping -w .9 >nul
echo b r E w e 4 e n r 8 M e F r a c h a S t 3 D a C r a s p e s T e 4 a 2 w r e G 2
ping -w .9 >nul
echo k u v e 4 E 6 3 e t r a d r e f e y e q e 6 U H e z U b r u R a s 2 4 3 r A N a
ping -w .9 >nul
echo v u P R a b s u c e d U s w a 3 a c r a t h U 7 r a k u t u h u V e 7 U k u S a
ping -w .9 >nul
echo n u r A X a j a s t a 9 h a 6 e h e G a s u t r a t r A y a f E q u 8 u b u u d
ping -w .9 >nul
echo b r E w e 4 e T r 8 M e F r a c h a S t 3 D a C r a s p e s T e 4 h 2 w r e G 2
ping -w .9 >nul
echo R E 9 8 8 R a t r e g 6 n u m A b R E X e Y A T u C 7 a D R a c r u C e B E p e
ping -w .9 >nul
echo c E B E s A d R u B R 3 H e R u D 7 g u d U 7 T a b u T 5 e p E 2 a v e 6 8 a Z
ping -w .9 >nul
echo n u r A X a j a s t a 9 h a 6 e h e G a s u t r a t r A y a f E q u 8 u b R u d
ping -w .9 >nul
echo v u P R a b s u c e d U s w a 3 a c r a t h U 7 r a k u t u h u V e 7 U k u S a
ping -w .9 >nul
echo n u r A X a j a s t a 9 h a 6 e h e G a s u t r a t r A y a f E q u 8 u b u u d
ping -w .9 >nul
echo R E 9 8 8 R a t r e g 6 n u m A b R E X e Y A T u C 7 a D R a c r u C e B E p e
ping -w .9 >nul
echo c E B E s A d R u B R 3 H e R u D 7 g u d U 7 T a b u T 5 e p E 2 a v e 6 8 a Z
ping -w .9 >nul
echo n u r A X a j a s t a 9 h a 6 e h e G a s u t r a t r A y a f E q u 8 u b R u d
ping -w .9 >nul
echo k u v e 4 E 6 3 e t r a d r e f e y e q e 6 U H e z U b r u R a s 2 4 3 r A N a
ping -w .9 >nul
echo k u v e 4 E 6 3 e t r a d r e f e y e q e 6 U H e z U b r u R a s 2 4 3 r A N a
ping -w .9 >nul
echo v u P R a b R u c e d U s w a h a c r a t h U 7 r a h u t u h u V e 7 U k u S a
ping -w .9 >nul
echo T e D r e 8 A p r a d a b u f U c u c E h E t 7 c r 5 s P a f r e t h u t 9 u t
ping -w .9 >nul
echo b R u G e p a R e s a P H e P a 2 U d 4 P r e F A b a t h a t h U s w a d R U d
ping -w .9 >nul
echo v U Y a C R e T R 9 k u b e D r a T 6 u j e 5 2 4 e B a f 2 u b 5 w A p a y U Y
ping -w .9 >nul
echo b r E w e 4 e n r 8 M e F r a c h a S t 3 D a C r a s p e s T e 4 a 2 w r e G 2
ping -w .9 >nul
echo k u v e 4 E 6 3 e t r a d r e f e y e q e 6 U H e z U b r u R a s 2 4 3 r A N a
ping -w .9 >nul
echo v u P R a b s u c e d U s w a 3 a c r a t h U 7 r a k u t u h u V e 7 U k u S a
ping -w .9 >nul
echo n u r A X a j a s t a 9 h a 6 e h e G a s u t r a t r A y a f E q u 8 u b u u d
ping -w .9 >nul
echo R E 9 8 8 R a t r e g 6 n u m A b R E X e Y A T u C 7 a D R a c r u C e B E p e
ping -w .9 >nul
echo c E B E s A d R u B R 3 H e R u D 7 g u d U 7 T a b u T 5 e p E 2 a v e 6 8 a Z
ping -w .9 >nul
echo n u r A X a j a s t a 9 h a 6 e h e G a s u t r a t r A y a f E q u 8 u b R u d
ping -w .9 >nul
echo k u v e 4 E 6 3 e t r a d r e f e y e q e 6 U H e z U b r u R a s 2 4 3 r A N a
ping -w .9 >nul
cls
@echo NO. 
timeout /t 2 /nobreak > nul
@echo Just. 
timeout /t 1 /nobreak > nul
@echo No.
timeout /t 2 /nobreak > nul
cls
goto randomtitle