@echo off
cd C:/Users/%username%/Desktop
:a
cls
set /p note= "Type a note (A, B, C, D, E, F, G): "
if /i %note%==a start %cd%/Stuff/notes/a.aiff
if /i %note%==b start %cd%/Stuff/notes/b.aiff
if /i %note%==c start %cd%/Stuff/notes/c.aiff
if /i %note%==d start %cd%/Stuff/notes/d.aiff
if /i %note%==e start %cd%/Stuff/notes/e.aiff
if /i %note%==f start %cd%/Stuff/notes/f.aiff
if /i %note%==g start %cd%/Stuff/notes/g.aiff
goto a