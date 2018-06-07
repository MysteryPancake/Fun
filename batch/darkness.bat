@echo off
mode 1000
set battery=out
set batcheck=out
set surcheck=i
set surcheck2=i
set torcheck=i
set torcheck2=i
set batspcheck=i
set batspcheck2=i
set surcheck3=i
set surcheck4=i
set sheltercheck=i
set sheltercheck2=i
set contrapcheck=i
set contrapcheck2=i
:start1
if %battery%==in set batcheck=in
cls
echo Your car has crashed in a dark forest.
echo You have nothing but a battery and a torch.
echo It is midnight, and you can barely see anything.
echo.
echo 1) Go back and check if the car will work.
echo 2) Go forward deeper into the forest.
echo 3) Try to put the battery in the torch.
echo.
set /p act1=
if %act1%==1 goto ch1
if %act1%==2 goto ch2batchk
if %act1%==3 goto ch3
goto start1
:ch1
cls
echo You try to restart the car, but whatever you do,
echo the car just sits there, branches inches deep
echo into the steaming front bonnet of the car.
if %battery%==in echo The torch did not reveal anything useful.
pause
goto start1
:ch3batin
cls
echo The battery is already in.
pause
goto start1
:ch3
if %batcheck%==in goto ch3batin
cls
set battery=in
echo The battery slots into the torch, and after a few
echo minutes of hitting it, the torch flickers on.
pause
goto start1
:ch2batchk
if %battery%==in goto ch2
cls
echo You try to continue into the forest, but it is too dark
echo with branches and sticks swooping at your face with every
echo trip and turn. You cannot go on without light.
pause
goto start1
:ch2
cls
echo The torch lights up the area, and it is now easy to see.
echo You continue, hoping to find somewhere to stay.
pause
goto start2
:start2
if %surcheck%==n set surcheck2=y
if %torcheck%==n set torcheck2=y
if %surcheck4%==n set surcheck3=y
if %sheltercheck%==n set sheltercheck2=y
if %contrapcheck%==n set contrapcheck2=y
if %batspcheck%==n set batspcheck2=y
cls
echo It is getting lighter, maybe even close to morning.
echo Your surroundings are getting more easy to see.
echo You can hear some pouring, it sounds like a waterfall close by.
echo.
echo 1) Head toward the pouring sound to investigate.
echo 2) Further check your surroundings.
echo 3) Try to make a home to sleep in.
echo 4) Break your torch apart in case there are any useful things in it.
echo.
set /p act2=
if %act2%==1 goto a2ch1
if %act2%==2 goto a2ch2
if %act2%==3 goto a2ch3
if %act2%==4 goto a2ch4
goto start2
:a2ch1d
cls
echo You have inserted the springs and batteries.
echo.
echo The contraption starts up.
echo A flap slides away revealing a slot with a spear-shaped imprint on it.
echo.
echo 1) Place the spear into the imprint
echo.
set /p spearplace=
if %spearplace%==1 goto start3
goto a2ch1d
pause
exit
:a2ch1c
if %surcheck3%==y goto a2ch1d
cls
echo You have inserted the springs and batteries.
echo.
echo The contraption starts up.
echo A flap slides away revealing a slot with a spear-shaped imprint on it.
pause
goto start2
:a2ch1b
set batspcheck=n
if %batspcheck2%==y goto a2ch1c
cls
echo The contraption is missing battery springs.
echo.
echo 1) Insert the springs and batteries from the torch into the device.
echo.
set /p inprings=
if %inprings%==1 goto a2ch1c
goto a2ch1b
:a2ch1a
if %torcheck2%==y goto a2ch1b
cls
echo The contraption is missing battery springs.
pause
goto start2
if
:a2ch1
set contrapcheck=n
if %contrapcheck2%==y goto a2ch1a
cls
echo You head toward the pouring sound and find something horrible.
pause
echo.
echo Hundreds of unidentified bloodstained corpses plunged deep into
echo long, recently built spears.
echo.
echo You are terrified, and stumble backwards into a tree.
echo Your shirt gets stuck against the tree, and as you
echo turn to remove it, you spot a strange looking contraption
echo built into the stem.
echo.
echo You take a closer look at the contraption and see a place
echo for batteries, but the springs are missing.
echo.
pause
goto start2
:a2ch2
set surcheck=n
if %surcheck2%==y goto a2ch2a
cls
echo Your surroundings are covered in vines, leaves and thick, dry mud.
echo There are many small rocks and twigs scattered all over the dense floor.
pause
goto start2
:a2ch2a
set surcheck4=n
if %surcheck3%==y goto a2ch2b
cls
echo You found an interesting spear at the base of a tree,
echo which looks recently crafted.
echo You have picked up the spear, as it looks functioning.
pause
goto start2
:a2ch2b
cls
echo You look for more items, but you cannot find anything else.
pause
goto start2
:a2ch3
set sheltercheck=n
if %sheltercheck2%==y goto a2ch3a
cls
echo You gather some sticks and other items and craft a decent shelter with them.
pause
goto start2
:a2ch3a
cls
echo You already built a shelter.
pause
goto start2
:a2ch4
set torcheck=n
if %torcheck2%==y goto a2ch4a
cls
echo You have disassembled your torch and have found several small but
echo powerful springs.
echo You also found the battery from before.
pause
goto start2
:a2ch4a
cls
echo You have gutted the torch as best you can, but still can't find anything new.
pause
goto start2
:start3
cls
echo Once the spear is inserted, the machine starts to emit a low buzz, as the
echo flap shuts.
pause