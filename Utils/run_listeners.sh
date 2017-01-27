services="itunes ip battery"
for listener in $services; do
	if [[ $(ps -ef | grep -c "$listener"_listener.sh) -ne 2 ]]; then
		sh ~/.NixConfig/Utils/"$listener"_listener.sh &
	fi
done
