@echo off

:loop

set /p link=LINK: 

:: FOR SOUNDCLOUD:
:: youtube-dl.exe -f bestaudio --audio-format best --add-metadata --embed-thumbnail %link%

:: BAD FOR YOUTUBE:
:: youtube-dl.exe -f best --add-metadata %link%

:: FOR YOUTUBE:
:: youtube-dl.exe -f bestvideo+bestaudio --add-metadata %link%

:: FOR YOUTUBE WAV:
:: youtube-dl.exe -f bestaudio -x --audio-format wav --add-metadata %link%

:: FOR YOUTUBE MP4:
youtube-dl.exe -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --add-metadata %link%

:: BAD FOR YOUTUBE WITH DATA:
:: youtube-dl.exe -f best --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata %link%

:: FOR YOUTUBE WITH DATA:
:: youtube-dl.exe -f bestvideo+bestaudio --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata %link%

:: FOR YOUTUBE MP4 WITH DATA:
:: youtube-dl.exe -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata %link%

goto loop