#! /bin/bash

while true; do
	declare -i value
	old_value=$(cat ~/.cache/battery_status | grep -o '[0-9]\{1,3\}%' | tr -d %)
	value=$(pmset -g batt | grep -o '[0-9]\{1,3\}%' | tr -d %)
	if pmset -g batt | grep -c ' charging' > /dev/null; then
			charge_symbol="↑"
			charging=0
	else
			charge_symbol=""
			charging=1
	fi
	old_charge=$(cat ~/.cache/charge_status)
	echo $charging > ~/.cache/charge_status
	if [[ $value == "" ]]; then
		echo "" > ~/.cache/battery_status
	else
		echo " [$value%]$charge_symbol" > ~/.cache/battery_status
	fi
	if [[ $value != $old_value || $charging != $old_charge ]]; then
		tmux refresh-client -S
	fi
	sleep 3
done
