
function usage
	set PROG_NAME "tunnel - Open an SSH tunnel"
	set USAGE     "usage: tunnel <option>"
	set OPEN_OPT  "* open   - Open the SSH tunnel to \$SOCKS_HOST and set the proxy information system wide."
	set CLOSE_OPT "* close  - Close the SSH tunnel to \$SOCKS_HOST and remove the system-wide proxy information."
	set STAT_OPT  "* status - Get the status of the SSH tunnel, including the value of \$SOCKS_HOST and \$SOCKS_PORT as well as the PID of the SSH session."
	printf "%s\n\n%s\n%s\nOptions:\n  %s\n  %s\n  %s\n  %s" $argv $PROG_NAME $USAGE $OPEN_OPT $CLOSE_OPT $STAT_OPT
end

# Activate an SSH tunnel
function tunnel
	if test "$argv" -eq ""
		usage "No option specified. Please specify an option below."
		return 1
end
	switch $argv
		# Open the tunnel connection 
		case open
			if test (ps -ef | grep "ssh -D $SOCKS_PORT -fCqN $SOCKS_HOST" | grep -cv grep) -eq "1"
				echo Tunnel is already open. Refusing to open a new tunnel.
				return 1
			else
				ssh -D $SOCKS_PORT -fCqN $SOCKS_HOST > ~/.tunnel.log ^ ~/.tunnel.log &
				sleep 2
				export TUNNEL_PID=(ps -ef | grep "ssh -D $SOCKS_PORT -fCqN $SOCKS_HOST" | grep -v grep | awk '{ print $2 }')
				export http_proxy=socks5://127.0.0.1:$SOCKS_PORT
				export https_proxy=$http_proxy
				printf "Host *\n\tProxyCommand=nc -X 5 -x 127.0.0.1:$SOCKS_PORT %%h %%p" >> ~/.ssh/config 
				sudo networksetup -setsocksfirewallproxy Wi-Fi 127.0.0.1 $SOCKS_PORT 
				echo Tunnel is now open.
			end
		# Close the tunnel connection
		case close
			kill $TUNNEL_PID
			sudo networksetup -setsocksfirewallproxystate Wi-Fi off
			export TUNNEL_PID=""
			export http_proxy=""
			export https_proxy=""
			sed -i " " "/Host */d;/ProxyCommand=nc -X 5 -x 127.0.0.1:$SOCKS_PORT %h %p/d" ~/.ssh/config
			echo Tunnel is now closed.
		# Get the status of the tunnel
		case status
			if test (echo $TUNNEL_PID) -eq ""
				echo Tunnel is currently down.
			else
				echo Tunnel is up.
				echo Socks Host: $SOCKS_HOST
				echo Socks Port: $SOCKS_PORT
				echo Tunnel Pid: $TUNNEL_PID
			end
		# Print the usage
		case '*'
			usage "Invalid option: $argv"
			return 1
	end
end
