set ssh (echo $SSH_CLIENT)

for FUNC_FILE in (ls $INSTPATH/Utils/Functions/Fish/Universal | grep .fish)
	source $INSTPATH/Utils/Functions/Fish/Universal/$FUNC_FILE
end

switch ( uname -s )
	case Darwin

		for FUNC_FILE in (ls $INSTPATH/Utils/Functions/Fish/macOS | grep .fish)
			source $INSTPATH/Utils/Functions/Fish/macOS/$FUNC_FILE
		end

		for SRC_FILE in (ls $INSTPATH/Constants/Fish/macOS | grep .fish )
			source $INSTPATH/Constants/Fish/macOS/$SRC_FILE
		end
		
	case Linux
		
	case '*'
		echo Unknown OS
end

set HOST (hostname | awk -F. '{ print $1 }')

# Determine if an SSH session is active and set the colors
# for the prompt accordingly
if [ "$ssh" = "" ]
	set PCOLOR $localColor
	set FCOLOR white
	set GITCOLOR magenta
else
	set FCOLOR black
	set PCOLOR $remoteColor
	set PSTMT "$USER@$HOST: "
end

function in_git
	git -C "$dir" rev-parse --is-inside-working-tree >/dev/null ^/dev/null
end

# Set PS1 given the set of values
function fish_prompt
	set_color $FCOLOR -b $PCOLOR
	printf " %s" $PSTMT
	python $INSTPATH/Utils/dynamic_path.py
	printf " "
	set_color $PCOLOR -b normal
	printf ""
	set_color normal

	if in_git
		set_color black -b $GITCOLOR
		printf ""
		# Git icon
		set_color white -b $GITCOLOR
		if git status | grep 'Your branch is up-to-date with' > /dev/null
			printf " \uE0A0 "
		else
			printf " \u27A5 "
		end
		printf "%s \uE0B1 %s" (git rev-parse --abbrev-ref HEAD) (git rev-parse --short=8 HEAD)
		if not git diff --quiet HEAD
			printf "± "
		else
			printf " "
		end
		# Ending arrow
		set_color $GITCOLOR -b normal
		printf "\uE0B0 "
		set_color normal	
	end

	printf " "

end
set fish_greeting

# This determines whether or not there is a tmux session active
if [ "$ssh" = "" ]
	if [ "$TMUX" = "" ]
		if [ (tmux ls | grep -c $USER) = "1" ]
			tmux a -t $USER
		else
			tmux new -s $USER
		end
	end
end
