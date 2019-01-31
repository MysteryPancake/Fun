cd Downloads

while true; do

echo -n 'LINK: '
read link

# FOR SOUNDCLOUD:
# youtube-dl -f bestaudio --audio-format best --add-metadata --embed-thumbnail $link

# BAD FOR YOUTUBE:
# youtube-dl -f best --add-metadata $link

# FOR YOUTUBE:
# youtube-dl -f bestvideo+bestaudio --add-metadata $link

# FOR YOUTUBE MP4:
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --add-metadata $link

# BAD FOR YOUTUBE WITH DATA:
# youtube-dl -f best --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata $link

# FOR YOUTUBE WITH DATA:
# youtube-dl -f bestvideo+bestaudio --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata $link

# FOR YOUTUBE MP4 WITH DATA:
# youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata $link

done