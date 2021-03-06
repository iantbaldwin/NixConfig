#!/bin/bash

check_and_run() {
if ps -ef | grep '[i]Tunes\|[i]Tunes ' | grep -v 'iTunesHelper' | grep -v 'com.apple.iTunesLibraryService' > /dev/null; then
		width=$(tput cols)
		track=$(osascript -e 'tell application "iTunes" to if player state is playing then name of current track')
		if ps -ef | grep '[i]Tunes\|[i]Tunes ' | grep -v 'iTunesHelper' | grep -v 'com.apple.iTunesLibraryService' > /dev/null; then
			artist=$(osascript -e 'tell application "iTunes" to if player state is playing then artist of current track')
			if [[ ! -z "$track" && ! -z "$artist" ]]; then
				if [[ $width -lt 200 ]]; then
					printf "♫ %s" "$track"
				else
					printf "♫ %s - %s" "$artist" "$track"
				fi
			else
				printf ""
			fi
		else
			printf ""
		fi
	else
		printf ""
	fi
}

#set -g status-left "#[fg=colour7,bg=colour6] #S #[fg=colour6,bg=$BG_COLOR,nobold,nounderscore,noitalics]"
while true; do
	old_track=$(cat ~/.cache/itunes_track)
	track=$(check_and_run "tell application \"iTunes\" to if player state is playing then name of current track")
	artist=$(check_and_run "tell application \"iTunes\" to if player state is playing then artist of current track")
	#track=$(check_and_run)
	if [[ $track == "" ]]; then
		#echo	"##[fg=colour6,bg=$BG_COLOR,nobold,nounderscore,noitalics]" > ~/.cache/itunes_track
		#echo	"#[fg=colour7,bg=$BG_COLOR,nobold,nounderscore,noitalics]● " > ~/.cache/itunes_track
		echo "" > ~/.cache/itunes_track
	else
		#printf "#[fg=colour6,bg=colour3,nobold,nounderscore,noitalics]#[fg=$BG_COLOR,bg=colour3,nobold,nounderscore,noitalics] %s #[fg=colour3,bg=$BG_COLOR,nobold,nounderscore,noitalics]" "$track" > ~/.cache/itunes_track
		printf "#[fg=colour2,bg=$BG_COLOR,nobold,nounderscore,noitalics] %s #[fg=colour7,bg=$BG_COLOR,nobold,nounderscore,noitalics]$STATUS_SEP" "$track" > ~/.cache/itunes_track
	fi
	if [[ $track != $old_track ]]; then
		tmux refresh-client -S > /dev/null 2>&1
	fi
done
