while true; do
	if ping -q -c 1 google.com > /dev/null 2>&1; then
		value=$(dig +short myip.opendns.com @208.67.222.222)
		old_value=$(cat ~/.cache/pub_ip)
		if [[ $value != $old_value ]]; then
			echo $value > ~/.cache/pub_ip
			tmux refresh-client -S > /dev/null 2>&1
		fi
	else
		echo "No Internet" > ~/.cache/pub_ip
		tmux refresh-client -S > /dev/null 2>&1
	fi
	sleep 10
done
