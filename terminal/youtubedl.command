cd Downloads

while true; do

echo -n 'LINK: '
read link

# FOR SOUNDCLOUD:
# youtube-dl -f bestaudio --audio-format best $link

# FOR YOUTUBE:
# youtube-dl -f bestvideo+bestaudio $link

# FOR YOUTUBE MP4:
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 $link

done
