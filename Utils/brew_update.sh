/sbin/ping -t 1 google.com > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
	/usr/local/bin/brew update 2>&1 >/dev/null
	/usr/local/bin/brew outdated >| ~/.brewoutdated
fi
