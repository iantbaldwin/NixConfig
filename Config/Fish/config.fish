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
	set GITCOLOR blue
end

# Set PS1 given the set of values
function fish_prompt
	#set_color $FCOLOR -b $PCOLOR
	set_color $PCOLOR
	printf " %s" $PSTMT
	python $INSTPATH/Utils/dynamic_path.py
	printf " "
	set_color blue
	printf "\uE0B1"
	set_color green
	printf "\uE0B1"
	set_color magenta
	printf "\uE0B1 "
	set_color normal
end


function fish_right_prompt
	function __git_modified_files -d "Counts number of modified files"
			count (command git status --porcelain --ignore-submodules)
	end

	if set branch_name (git_branch_name)
			set -l git_ahead (git_ahead " ↑" " ↓" " ⥄ ")
			set -l git_color
			set -l git_modified_files (__git_modified_files)
			set -l git_changed_files

			if git_is_dirty
					set git_color (set_color red)
			else if git_is_touched
					set git_color (set_color red)
			else
					set git_color (set_color cyan)
			end

			if test "$git_modified_files" -ne 0
					set git_changed_files (set_color yellow)"$git_modified_files changed "
			end

			printf "$git_changed_files$git_color$branch_name$git_ahead "
			set_color $fish_color_normal
	end
end

set fish_greeting
ssh-id

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
