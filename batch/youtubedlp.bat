@echo off
:: yt-dlp must be installed for this to work
:loop

echo.
echo VIDEO WITH AUDIO
echo  1. YouTube to MP4 (Recommended)
echo  2. Choose me if option 1 fails
echo  3. Choose me if option 2 fails
echo.
echo AUDIO ONLY
echo  4. YouTube to WAV
echo  5. SoundCloud
echo.
echo ARCHIVE
echo  6. YouTube to MP4 + Metadata
echo  7. Choose me if option 6 fails
echo  8. Choose me if option 7 fails
echo.
echo If everything fails, update yt-dlp with: yt-dlp -U
echo.
set /p option=Please choose an option: 
echo.

if %option% lss 1 goto INVALID
if %option% gtr 8 goto INVALID

set /p link=Please paste a link: 

goto OPTION%option%

:OPTION1
:: YOUTUBE MP4 BEST QUALITY
yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/b" --merge-output-format mp4 --add-metadata "%link%"
goto loop

:OPTION2
:: YOUTUBE MP4 DECENT QUALITY
yt-dlp -f "bv+ba/b" --add-metadata "%link%"
goto loop

:OPTION3
:: YOUTUBE MP4 BAD QUALITY
yt-dlp -f best --add-metadata "%link%"
goto loop

:OPTION4
:: YOUTUBE WAV
yt-dlp -f bestaudio -x --audio-format wav --add-metadata "%link%"
goto loop

:OPTION5
:: SOUNDCLOUD
yt-dlp -f bestaudio --audio-format best --add-metadata --embed-thumbnail "%link%"
goto loop

:OPTION6
:: YOUTUBE MP4 BEST QUALITY WITH DATA
yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/b" --merge-output-format mp4 --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata "%link%"
goto loop

:OPTION7
:: YOUTUBE MP4 DECENT QUALITY WITH DATA
yt-dlp -f "bv+ba/b" --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata "%link%"
goto loop

:OPTION8
:: YOUTUBE MP4 BAD QUALITY WITH DATA
yt-dlp -f best --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata "%link%"
goto loop

:INVALID
echo Invalid option, please try again.
goto loop