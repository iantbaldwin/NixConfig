#!/bin/bash

curDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
usrshell=$(basename $SHELL)

homeColor="\"[32m\""
remoteColor="\"[31m\""
colorReset="\"[0m\""

# Link vimrc
ln -sF $curDir/vimrc $HOME/.vimrc

# Create vim directories if needed
mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/ftplugin

# Link VIM filetype plugins
ln -sF $curDir/ftplugin/c.vim $HOME/.vim/ftplugin/c.vim
ln -sF $curDir/ftplugin/java.vim $HOME/.vim/ftplugin/java.vim
ln -sF $curDir/ftplugin/asm.vim $HOME/.vim/ftplugin/asm.vim

# Link YCM_CONF
ln -sF $curDir/ycm_extra_conf.py $HOME/.vim/.ycm_extra_conf.py

# Link shell profile
if [ "$usrshell" == "fish" ]; then
	mkdir -p $HOME/.config
	printf "set INSTPATH $curDir \n" > config.fish
	cat fishconfig >> config.fish
	ln -sF $curDir/config.fish $HOME/.config/fish/config.fish
elif [ "$usrshell" == "bash" ]; then
	printf "#!/bin/bash\n
homeColor=$homeColor\n
remoteColor=$remoteColor\n
RESET=$colorReset\n
NIXCONFIG=$curDir \n" > bash_profile
	cat bashconfig >> bash_profile
	ncsu=$(uname -a | grep -c ncsu)
	if [ "$ncsu" == "1" ]; then
		ln -sF $curDir/bash_profile $HOME/.mybashrc
	else
		ln -sF $curDir/bash_profile $HOME/.bash_profile
	fi
fi
