cd Downloads

while true; do

echo -n 'LINK: '
read link

# FOR YOUTUBE:
# youtube-dl -f bestvideo+bestaudio --write-sub --write-auto-sub --all-subs $link

# FOR YOUTUBE MP4:
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --write-sub --write-auto-sub --all-subs $link

# FOR SUBTITLES ONLY:
# youtube-dl --skip-download --write-sub --write-auto-sub --all-subs $link

done