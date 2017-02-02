#!/bin/sh

while true; do
	mem_usage=$(vm_stat | grep -o 'Pages active:\s*[0-9]*' | awk '{ print $3 * 4096 }')
	mem_free=$(echo "scale=2; (16000000000 - $mem_usage)/1000000000" | bc)
	printf "Mem: %sGB" $mem_free > ~/.cache/memory_status
	sleep 60
done
