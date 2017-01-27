#!/bin/bash
pids=$(ps -ef | grep '.*_listener.sh' | awk '{print $2}')
for pid in $pids; do
	kill $pid > /dev/null 2>&1
done
