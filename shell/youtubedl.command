cd Downloads

while true; do

echo
echo 'VIDEO WITH AUDIO'
echo ' 1. YouTube to MP4 (Recommended)'
echo ' 2. Choose me if option 1 fails'
echo ' 3. Choose me if option 2 fails'
echo
echo 'AUDIO ONLY'
echo ' 4. YouTube to WAV'
echo ' 5. SoundCloud'
echo
echo 'ARCHIVE'
echo ' 6. YouTube to MP4 + Metadata'
echo ' 7. Choose me if option 6 fails'
echo ' 8. Choose me if option 7 fails'
echo
echo 'If everything fails, update YouTube-DL with youtube-dl -U'
echo
read -p 'Please choose an option: ' option
echo

if ((option >= 1 && option <= 8)); then
	read -p 'Please paste a link: ' link
	case $option in
		1) # YOUTUBE MP4 BEST QUALITY
			youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --add-metadata $link
			;;
		2) # YOUTUBE MP4 DECENT QUALITY
			youtube-dl -f bestvideo+bestaudio --add-metadata $link
			;;
		3) # YOUTUBE MP4 BAD QUALITY
			youtube-dl -f best --add-metadata $link
			;;
		4) # YOUTUBE WAV
			youtube-dl -f bestaudio -x --audio-format wav --add-metadata $link
			;;
		5) # SOUNDCLOUD
			youtube-dl -f bestaudio --audio-format best --add-metadata --embed-thumbnail $link
			;;
		6) # YOUTUBE MP4 BEST QUALITY WITH DATA
			youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata $link
			;;
		7) # YOUTUBE MP4 DECENT QUALITY WITH DATA
			youtube-dl -f bestvideo+bestaudio --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata $link
			;;
		8) # YOUTUBE MP4 BAD QUALITY WITH DATA
			youtube-dl -f best --write-thumbnail --write-description --write-info-json --write-annotations --add-metadata $link
			;;
		*)
			echo 'Invalid option, please try again.'
			;;
	esac
else
	echo 'Invalid option, please try again.'
fi

done