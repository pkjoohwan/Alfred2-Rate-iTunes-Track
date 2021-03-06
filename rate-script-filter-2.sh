## Check if iTunes is running and playing a song
if [ $(osascript -e 'if application "iTunes" is running then return true') ]; then
	iTunesPlaying=$(osascript -e 'tell application "iTunes" to if player state is playing then return true')
fi

## If iTunes is playing, start grabbing the data
if [[ $iTunesPlaying == true ]]; then
	valid="yes"
	title=$(osascript -e 'tell application "iTunes" to "" & artist of current track & " - " & name of current track')
	rating=$(osascript -e 'tell application "iTunes" to rating of current track')

	## Convert to star ratings
	case $rating in
		10) stars="½☆☆☆☆";;
		20) stars="★☆☆☆☆" ;;
		30) stars="★½☆☆☆" ;;
		40) stars="★★☆☆☆" ;;
		50) stars="★★½☆☆" ;;
		60) stars="★★★☆☆" ;;
		70) stars="★★★½☆" ;;
		80) stars="★★★★☆" ;;
		90) stars="★★★★½" ;;
		100) stars="★★★★★" ;;
		*) stars="• • • • •" ;;
	esac
	
	subtitle="Current rating: $stars"
else
	title="No song playing"
	subtitle=""
	valid="no"
fi


## XML to Alfred
echo '<?xml version="1.0"?><items>'
echo "<item arg=\"{query}\" uid=\"rating\" valid=\"$valid\">"
echo "<title>$title</title>"
echo "<subtitle>$subtitle</subtitle>"
echo "<icon>info.png</icon></item></items>"
echo "</items>"