#! /bin/bash
#set -g status-left "#[fg=colour7,bg=colour6] #S #[fg=colour6,bg=colour0,nobold,nounderscore,noitalics]"
while true; do
	if ps -ef | grep -c '[/]Applications/iTunes.app/Contents/MacOS/iTunes' > /dev/null; then
		old_track=$(cat ~/.cache/itunes_track)
		track=$(osascript -e 'tell application "iTunes" to if player state is playing then name of current track')
		artist=$(osascript -e 'tell application "iTunes" to if player state is playing then artist of current track')
		#track=$(echo $track | cut -c 1-17)
		#artist=$(echo $artist | cut -c 1-17)
		if [[ $track == "" ]]; then
			echo	"##[fg=colour6,bg=colour0,nobold,nounderscore,noitalics]" > ~/.cache/itunes_track
		else
			printf "#[fg=colour6,bg=colour3,nobold,nounderscore,noitalics]#[fg=colour0,bg=colour3,nobold,nounderscore,noitalics] ♫ %s  %s #[fg=colour3,bg=colour0,nobold,nounderscore,noitalics]" "$artist" "$track" > ~/.cache/itunes_track
		fi
		if [[ $track != $old_track ]]; then
			tmux refresh-client -S > /dev/null 2>&1
		fi
		continue
	fi
	echo "##[fg=colour6,bg=colour0,nobold,nounderscore,noitalics]" > ~/.cache/itunes_track
done
