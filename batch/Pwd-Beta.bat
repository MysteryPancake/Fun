@ECHO OFF
color 0f
SET letter=abcdefghijklmnopqrstuvwxyz1234567890\
:q
set tmp16=%letter%
:p
set tmp15=%letter%
:o
set tmp14=%letter%
:n
set tmp13=%letter%
:m
set tmp12=%letter%
:l
set tmp11=%letter%
:k
set tmp10=%letter%
:j
set tmp9=%letter%
:i
set tmp8=%letter%
:h
set tmp7=%letter%
:g
set tmp6=%letter%
:f
set tmp5=%letter%
:e
set tmp4=%letter%
:d
set tmp3=%letter%
:c
set tmp2=%letter%
:b
set tmp=%letter%
:a
SET char16=%tmp16:~0,1%
SET char15=%tmp15:~0,1%
SET char14=%tmp14:~0,1%
SET char13=%tmp13:~0,1%
SET char12=%tmp12:~0,1%
SET char11=%tmp11:~0,1%
SET char10=%tmp10:~0,1%
SET char9=%tmp9:~0,1%
SET char8=%tmp8:~0,1%
SET char7=%tmp7:~0,1%
SET char6=%tmp6:~0,1%
SET char5=%tmp5:~0,1%
SET char4=%tmp4:~0,1%
SET char3=%tmp3:~0,1%
SET char2=%tmp2:~0,1%
SET char=%tmp:~0,1%
SET tmp=%tmp:~1%
echo %char16%%char15%%char14%%char13%%char12%%char11%%char10%%char9%%char8%%char7%%char6%%char5%%char4%%char3%%char2%%char%
IF NOT "%tmp%"=="\" GOTO a
SET tmp2=%tmp2:~1%
IF NOT "%tmp2%"=="\" GOTO b
SET tmp3=%tmp3:~1%
IF NOT "%tmp3%"=="\" GOTO c
SET tmp4=%tmp4:~1%
IF NOT "%tmp4%"=="\" GOTO d
SET tmp5=%tmp5:~1%
IF NOT "%tmp5%"=="\" GOTO e
SET tmp6=%tmp6:~1%
IF NOT "%tmp6%"=="\" GOTO f
SET tmp7=%tmp7:~1%
IF NOT "%tmp7%"=="\" GOTO g
SET tmp8=%tmp8:~1%
IF NOT "%tmp8%"=="\" GOTO h
SET tmp9=%tmp9:~1%
IF NOT "%tmp9%"=="\" GOTO i
SET tmp10=%tmp10:~1%
IF NOT "%tmp10%"=="\" GOTO j
SET tmp11=%tmp11:~1%
IF NOT "%tmp11%"=="\" GOTO k
SET tmp12=%tmp12:~1%
IF NOT "%tmp12%"=="\" GOTO l
SET tmp13=%tmp13:~1%
IF NOT "%tmp13%"=="\" GOTO m
SET tmp14=%tmp14:~1%
IF NOT "%tmp14%"=="\" GOTO n
SET tmp15=%tmp15:~1%
IF NOT "%tmp15%"=="\" GOTO o
SET tmp16=%tmp16:~1%
IF NOT "%tmp16%"=="\" GOTO p
pause