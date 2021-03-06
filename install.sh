#!/bin/bash

curDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
usrshell=$(basename $SHELL)

if [ "$usrshell" == "bash" ]; then
	localColor="\"[32m\""
	remoteColor="\"[31m\""
elif [ "$usrshell" == "fish" ]; then
	localColor="cyan"
	remoteColor="yellow"
fi

rm -rf $HOME/.vimrc $HOME/.vim/ftplugin/* $HOME/.vim/.ycm_extra_conf.py

# Link vimrc
ln -sF $curDir/Config/Vim/vimrc $HOME/.vimrc

# Create vim directories if needed
mkdir -p $HOME/.vim
mkdir -p $HOME/.vim/ftplugin
mkdir -p $HOME/.vim/after/ftplugin

# Link VIM filetype plugins
plugins=$(ls $curDir/Config/Vim/ftplugin/)
for plugin in $plugins; do
	ln -sf $curDir/Config/Vim/ftplugin/$plugin $HOME/.vim/ftplugin/$plugin
done
#ln -sF $curDir/Config/Vim/ftplugin/c.vim $HOME/.vim/ftplugin/c.vim
#ln -sF $curDir/Config/Vim/ftplugin/java.vim $HOME/.vim/ftplugin/java.vim
#ln -sF $curDir/Config/Vim/ftplugin/asm.vim $HOME/.vim/ftplugin/asm.vim
#ln -sF $curDir/Config/Vim/ftplugin/rb.vim $HOME/.vim/ftplugin/rb.vim
#ln -sF $curDir/Config/Vim/ftplugin/py.vim $HOME/.vim/ftplugin/py.vim

plugins=$(ls $curDir/Config/Vim/after/ftplugin/)
for plugin in $plugins; do
	ln -sf $curDir/Config/Vim/after/ftplugin/$plugin $HOME/.vim/after/ftplugin/$plugin
done

# Link YCM_CONF
ln -sF $curDir/Config/Vim/ycm_extra_conf.py $HOME/.vim/.ycm_extra_conf.py

ln -sF $curDir/Config/SSH/config $HOME/.ssh/config

# Link shell profile
mkdir -p $curDir/Compiled
mkdir -p $HOME/.bin

# Install Mac OS Software
if [ "$(uname -s)" == "Darwin" ]; then
	export SEP="●"
	echo Installing for macOS
	# Install Brew
	if command -v brew >/dev/null 2>&1; then
		echo "Brew already installed. Skipping..."
	else
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	rm -rf $HOME/.brewupdate
	mkdir -p $HOME/.cache
	echo "*/30	*	*	*	*	sh $curDir/Utils/brew_update.sh" > $curDir/Compiled/brewupdate
	ln -sF $curDir/Compiled/brewupdate $HOME/.brewupdate
	crontab $HOME/.brewupdate

	# Setup development environment
	mkdir -p $HOME/Development
	mkdir -p $HOME/Development/golang/bin
	mkdir -p $HOME/Development/golang/packages
	mkdir -p $HOME/Development/golang/src/git.elektrikfish.com/iantbaldwin/

	# Install Software Tools
	for tool in fish ctags cmake vim "tmux --with-utf8proc" reattach-to-user-namespace cloc docker docker-completion jq bash procmail gpg monkeysphere go; do
		if brew list $tool >/dev/null 2>&1; then
			echo "$tool already installed. Skipping..."
		else
			brew install $tool
		fi
	done


	# Setup vim
	if [ -e $HOME/.vim/bundle/Vundle.vim ]; then
		echo "Vim already setup. Skipping..."
	else
		git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
		vim +PluginInstall +qall
		python $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
	fi


	if command -v gcc_d >/dev/null 2>&1; then
		echo "C environment already setup. Skippinng..."
	else
		docker pull iantbaldwin/gcc-val:latest
		ln -sF $curDir/Utils/gcc_d.sh /usr/local/bin/gcc_d
		chmod +x /usr/local/bin/gcc_d
		ln -sF $curDir/Utils/valgrind_d.sh /usr/local/bin/valgrind_d
		chmod +x /usr/local/bin/valgrind_d
	fi

	if command -v run_listeners > /dev/null 2>&1; then
		echo "Listener control already setup. Skipping..."
	else
		ln -sF $curDir/Utils/run_listeners.sh /usr/local/bin/run_listeners
		chmod +x /usr/local/bin/run_listeners
		ln -sF $curDir/Utils/kill_listeners.sh /usr/local/bin/kill_listeners
		chmod +x /usr/local/bin/kill_listeners
	fi
fi

#### FISH ####
if [ "$usrshell" == "fish" ]; then
	rm -rf $HOME/.config/fish/config.fish
	printf "#!$(which fish)\n
set remoteColor $remoteColor \n
set localColor $localColor \n
set INSTPATH $curDir \n" > $curDir/Compiled/config.fish
	echo "export INSTPATH=$curDir" > $curDir/Constants/Fish/macOS/instpath.fish
	cat $curDir/Config/Fish/config.fish >> $curDir/Compiled/config.fish
	echo 'set -gx PATH $PATH $HOME/Development/golang/bin $HOME/.bin' >> $curDir/Compiled/config.fish
	echo 'set -gx GOPATH $HOME/Development/golang' >> $curDir/Compiled/config.fish
	ln -sF $curDir/Compiled/config.fish $HOME/.config/fish/config.fish
	cat $curDir/Config/Tmux/Tmux.conf > $curDir/Compiled/tmux.conf
	echo "source $curDir/tmuxline_solarized" >> $curDir/Compiled/tmux.conf
	ln -sF $curDir/Compiled/tmux.conf ~/.tmux.conf

#### BASH ####
elif [ "$usrshell" == "bash" ]; then
	printf "#!/bin/bash\n
localColor=$localColor\n
remoteColor=$remoteColor\n
NIXCONFIG=$curDir \n" > $curDir/Compiled/bash_profile
	cat $curDir/Config/Bash/bash.config >> $curDir/Compiled/bash_profile
	ncsu=$(uname -a | grep -c ncsu)
	if [ "$ncsu" == "1" ]; then
		rm -rf $HOME/.mybashrc
		ln -sF $curDir/Compiled/bash_profile $HOME/.mybashrc
	else
		rm -rf $HOME/.bash_profile
		ln -sF $curDir/Compiled/bash_profile $HOME/.bash_profile
	fi
fi

#### FISHER #####
if [ "$usrshell" == "fish" ] && [ ! -e $HOME/.config/fish/functions/fisher.fish ]; then
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	fish -c 'soruce ~/.config/fish/functions/fisher.fish; and fisher git_util'
else
	echo "Fisher already installed. Skipping..."
fi
