export HOMEBREW_GITHUB_API_TOKEN=3fe366368034695a68bcee2800acf52f9f908dbd
#export PATH=/usr/local/texlive/2015basic/bin/universal-darwin:$PATH
alias exit='killall Terminal;'

set HOST (hostname | awk -F. '{ print $1 }')

function fish_prompt
	set_color green
	printf $HOST\[" " 
	set_color normal
	path_shorten
	set_color green
	printf " "\]": "
	set_color normal
end

