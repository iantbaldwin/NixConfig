#! /bin/bash
while true; do
	if [[ $(ps -ef | grep -c '/Applications/iTunes.app/Contents/MacOS/iTunes$') == 1 ]]; then
		old_track=$(cat ~/.cache/itunes_track)
		track=$(osascript -e 'tell application "iTunes" to if player state is playing then name of current track')
		artist=$(osascript -e 'tell application "iTunes" to if player state is playing then artist of current track')
		track=$(echo $track | cut -c 1-17)
		artist=$(echo $artist | cut -c 1-17)
		if [[ $track == "" ]]; then
			echo	"##[fg=colour4,bg=colour0,nobold,nounderscore,noitalics]" > ~/.cache/itunes_track
		else
			printf "#[fg=colour3,bg=colour0,nobold,nounderscore,noitalics]#[fg=colour0,bg=colour3,nobold,nounderscore,noitalics] ♫ %s - %s #[fg=colour4,bg=colour3,nobold,nounderscore,noitalics]" "$track" "$artist" > ~/.cache/itunes_track
		fi
		if [[ $track != $old_track ]]; then
			tmux refresh-client -S
		fi
	fi
done
