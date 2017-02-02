#!/bin/bash
services=$(ls $INSTPATH/Utils/*_listener.sh) 
for listener in $services; do
	if [[ $(ps -ef | grep -c "[sh] $listener") == 0 ]]; then
		sh $listener &
	fi
done
