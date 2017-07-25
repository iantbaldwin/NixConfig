while true; do
	value=$(ipconfig getifaddr en0)
	if [ ! -z $value ]; then
		old_value=$(cat ~/.cache/priv_ip)
		if [[ $value != $old_value ]]; then
			echo "#[fg=colour4,bg=$BG_COLOR,nobold,nounderscore,noitalics]$value" > ~/.cache/priv_ip
			tmux refresh-client -S > /dev/null 2>&1
		fi
	else
		echo "#[fg=colour1,bg=default,nobold,nounderscore,noitalics]No LAN" > ~/.cache/priv_ip
		tmux refresh-client -S > /dev/null 2>&1
	fi
	sleep 10
done
