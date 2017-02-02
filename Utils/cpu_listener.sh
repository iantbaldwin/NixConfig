#!/bin/sh
while true; do
	cpu_usage=$(uptime | grep -o ':\s\d\{1,2\}\.\d\d' | awk '{ print $2 }')
	echo "CPU: $cpu_usage" > ~/.cache/cpu_usage
	sleep 30
done
