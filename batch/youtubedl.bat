@echo off

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
echo If everything fails, update YouTube-DL with youtube-dl -U
echo.
set /p option=Please choose an option: 
echo.

if %option% lss 1 goto INVALID
if %option% gtr 8 goto INVALID

set /p link=Please paste a link: 

goto OPTION%option%

:OPTION1
:: YOUTUBE MP4 BEST QUALITY
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --add-metadata %link%
goto loop

:OPTION2
:: YOUTUBE MP4 DECENT QUALITY
youtube-dl -f bestvideo+bestaudio --add-metadata %link%
goto loop

:OPTION3
:: YOUTUBE MP4 BAD QUALITY
youtube-dl -f best --add-metadata %link%
goto loop

:OPTION4
:: YOUTUBE WAV
youtube-dl -f bestaudio -x --audio-format wav --add-metadata %link%
goto loop

:OPTION5
:: SOUNDCLOUD
youtube-dl -f bestaudio --audio-format best --add-metadata --embed-thumbnail %link%
goto loop

:OPTION6
:: YOUTUBE MP4 BEST QUALITY WITH DATA
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata %link%
goto loop

:OPTION7
:: YOUTUBE MP4 DECENT QUALITY WITH DATA
youtube-dl -f bestvideo+bestaudio --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata %link%
goto loop

:OPTION8
:: YOUTUBE MP4 BAD QUALITY WITH DATA
youtube-dl -f best --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata %link%
goto loop

:INVALID
echo Invalid option, please try again.
goto loop