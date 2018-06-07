@echo off
title KENO
:start
cls
set /p tcount="How many random numbers until game end (usually 20)? "
if %tcount% gtr 80 goto start
:disp
cls
echo Random number displaying-
echo.
echo 1) Automatically (one number every custom amount of seconds)
echo 2) Manually (new number on keypress)
echo.
set /p auto="Enter 1 or 2: "
if %auto%==1 goto setseconds
if %auto%==2 goto continue
goto disp
:setseconds
cls
set /p secondnumber="How many seconds between each number (Max. 100)? "
if %secondnumber% gtr 100 goto setseconds
goto continue
:continue
cls
set tails=0
set heads=0
set try=1
rem This sets all numbers to be 2 characters.
set a01=--
set a02=--
set a03=--
set a04=--
set a05=--
set a06=--
set a07=--
set a08=--
set a09=--
set a10=--
set a11=--
set a12=--
set a13=--
set a14=--
set a15=--
set a16=--
set a17=--
set a18=--
set a19=--
set a20=--
set a21=--
set a22=--
set a23=--
set a24=--
set a25=--
set a26=--
set a27=--
set a28=--
set a29=--
set a30=--
set a31=--
set a32=--
set a33=--
set a34=--
set a35=--
set a36=--
set a37=--
set a38=--
set a39=--
set a40=--
set a41=--
set a42=--
set a43=--
set a44=--
set a45=--
set a46=--
set a47=--
set a48=--
set a49=--
set a50=--
set a51=--
set a52=--
set a53=--
set a54=--
set a55=--
set a56=--
set a57=--
set a58=--
set a59=--
set a60=--
set a61=--
set a62=--
set a63=--
set a64=--
set a65=--
set a66=--
set a67=--
set a68=--
set a69=--
set a70=--
set a71=--
set a72=--
set a73=--
set a74=--
set a75=--
set a76=--
set a77=--
set a78=--
set a79=--
set a80=--
:a
rem The chooser. Chooses a random number in 80.
set /a num= %random% %%80 +1
rem Checks whether the number is already on the board.
rem All vars start with 'a' so they don't get mistaken.
if %num%==%a01% goto a 
if %num%==%a02% goto a 
if %num%==%a03% goto a 
if %num%==%a04% goto a 
if %num%==%a05% goto a 
if %num%==%a06% goto a 
if %num%==%a07% goto a 
if %num%==%a08% goto a 
if %num%==%a09% goto a 
if %num%==%a10% goto a 
if %num%==%a11% goto a 
if %num%==%a12% goto a 
if %num%==%a13% goto a 
if %num%==%a14% goto a 
if %num%==%a15% goto a 
if %num%==%a16% goto a 
if %num%==%a17% goto a 
if %num%==%a18% goto a 
if %num%==%a19% goto a 
if %num%==%a20% goto a 
if %num%==%a21% goto a 
if %num%==%a22% goto a 
if %num%==%a23% goto a 
if %num%==%a24% goto a 
if %num%==%a25% goto a 
if %num%==%a26% goto a 
if %num%==%a27% goto a 
if %num%==%a28% goto a 
if %num%==%a29% goto a 
if %num%==%a30% goto a 
if %num%==%a31% goto a 
if %num%==%a32% goto a 
if %num%==%a33% goto a 
if %num%==%a34% goto a 
if %num%==%a35% goto a 
if %num%==%a36% goto a 
if %num%==%a37% goto a 
if %num%==%a38% goto a 
if %num%==%a39% goto a 
if %num%==%a40% goto a 
if %num%==%a41% goto a 
if %num%==%a42% goto a 
if %num%==%a43% goto a 
if %num%==%a44% goto a 
if %num%==%a45% goto a 
if %num%==%a46% goto a 
if %num%==%a47% goto a 
if %num%==%a48% goto a 
if %num%==%a49% goto a 
if %num%==%a50% goto a 
if %num%==%a51% goto a 
if %num%==%a52% goto a 
if %num%==%a53% goto a 
if %num%==%a54% goto a 
if %num%==%a55% goto a 
if %num%==%a56% goto a 
if %num%==%a57% goto a 
if %num%==%a58% goto a 
if %num%==%a59% goto a 
if %num%==%a60% goto a 
if %num%==%a61% goto a 
if %num%==%a62% goto a 
if %num%==%a63% goto a 
if %num%==%a64% goto a 
if %num%==%a65% goto a 
if %num%==%a66% goto a 
if %num%==%a67% goto a 
if %num%==%a68% goto a 
if %num%==%a69% goto a 
if %num%==%a70% goto a 
if %num%==%a71% goto a 
if %num%==%a72% goto a 
if %num%==%a73% goto a 
if %num%==%a74% goto a 
if %num%==%a75% goto a 
if %num%==%a76% goto a 
if %num%==%a77% goto a 
if %num%==%a78% goto a 
if %num%==%a79% goto a 
if %num%==%a80% goto a 
rem Checks the random number, and changes the board vars accordingly.
if %num%==1 set "a01=1 " 
if %num%==2 set "a02=2 " 
if %num%==3 set "a03=3 " 
if %num%==4 set "a04=4 " 
if %num%==5 set "a05=5 " 
if %num%==6 set "a06=6 " 
if %num%==7 set "a07=7 " 
if %num%==8 set "a08=8 " 
if %num%==9 set "a09=9 " 
if %num%==10 set "a10=10" 
if %num%==11 set "a11=11" 
if %num%==12 set "a12=12" 
if %num%==13 set "a13=13" 
if %num%==14 set "a14=14" 
if %num%==15 set "a15=15" 
if %num%==16 set "a16=16" 
if %num%==17 set "a17=17" 
if %num%==18 set "a18=18" 
if %num%==19 set "a19=19" 
if %num%==20 set "a20=20" 
if %num%==21 set "a21=21" 
if %num%==22 set "a22=22" 
if %num%==23 set "a23=23" 
if %num%==24 set "a24=24" 
if %num%==25 set "a25=25" 
if %num%==26 set "a26=26" 
if %num%==27 set "a27=27" 
if %num%==28 set "a28=28" 
if %num%==29 set "a29=29" 
if %num%==30 set "a30=30" 
if %num%==31 set "a31=31" 
if %num%==32 set "a32=32" 
if %num%==33 set "a33=33" 
if %num%==34 set "a34=34" 
if %num%==35 set "a35=35" 
if %num%==36 set "a36=36" 
if %num%==37 set "a37=37" 
if %num%==38 set "a38=38" 
if %num%==39 set "a39=39" 
if %num%==40 set "a40=40" 
if %num%==41 set "a41=41" 
if %num%==42 set "a42=42" 
if %num%==43 set "a43=43" 
if %num%==44 set "a44=44" 
if %num%==45 set "a45=45" 
if %num%==46 set "a46=46" 
if %num%==47 set "a47=47" 
if %num%==48 set "a48=48" 
if %num%==49 set "a49=49" 
if %num%==50 set "a50=50" 
if %num%==51 set "a51=51" 
if %num%==52 set "a52=52" 
if %num%==53 set "a53=53" 
if %num%==54 set "a54=54" 
if %num%==55 set "a55=55" 
if %num%==56 set "a56=56" 
if %num%==57 set "a57=57" 
if %num%==58 set "a58=58" 
if %num%==59 set "a59=59" 
if %num%==60 set "a60=60" 
if %num%==61 set "a61=61" 
if %num%==62 set "a62=62" 
if %num%==63 set "a63=63" 
if %num%==64 set "a64=64" 
if %num%==65 set "a65=65" 
if %num%==66 set "a66=66" 
if %num%==67 set "a67=67" 
if %num%==68 set "a68=68" 
if %num%==69 set "a69=69" 
if %num%==70 set "a70=70" 
if %num%==71 set "a71=71" 
if %num%==72 set "a72=72" 
if %num%==73 set "a73=73" 
if %num%==74 set "a74=74" 
if %num%==75 set "a75=75" 
if %num%==76 set "a76=76" 
if %num%==77 set "a77=77" 
if %num%==78 set "a78=78" 
if %num%==79 set "a79=79" 
if %num%==80 set "a80=80" 
rem Checks whether to add a point onto tails or heads.
if %num% gtr 40 set /a tails=%tails%+1
if %num% lss 41 set /a heads=%heads%+1
rem Putting the CLS below causes less blank time.
if %try%==80 goto b
:b
cls
@echo 	 Heads=%heads% Tails=%tails% Number=%num%
@echo	--------------------------------------
@echo	   H 	%a01% %a02% %a03% %a04% %a05% %a06% %a07% %a08% %a09% %a10%
@echo	   E 	%a11% %a12% %a13% %a14% %a15% %a16% %a17% %a18% %a19% %a20%
@echo	   A 	%a21% %a22% %a23% %a24% %a25% %a26% %a27% %a28% %a29% %a30%
@echo	   D	%a31% %a32% %a33% %a34% %a35% %a36% %a37% %a38% %a39% %a40%
@echo	--------------------------------------
@echo	   T 	%a41% %a42% %a43% %a44% %a45% %a46% %a47% %a48% %a49% %a50%
@echo	   A 	%a51% %a52% %a53% %a54% %a55% %a56% %a57% %a58% %a59% %a60%
@echo	   I 	%a61% %a62% %a63% %a64% %a65% %a66% %a67% %a68% %a69% %a70%
@echo	   L 	%a71% %a72% %a73% %a74% %a75% %a76% %a77% %a78% %a79% %a80%
@echo	--------------------------------------
if %try%==%tcount% goto headtailwin
set /a try=%try%+1
if %auto%==2 goto manual
goto automatic
:manual
pause
goto a
:automatic
timeout /t %secondnumber% > nul
goto a
:headtailwin
timeout /t 3 > nul
if %heads%==%tails% goto equal
if %heads% gtr %tails% goto headwin
goto tailwin
:equal
echo Heads and tails were equal!
pause
exit
:tailwin
echo Tails won!
pause
exit
:headwin
echo Heads won!
pause
exit