#!/bin/bash
curDir=$(pwd)
#echo $curDir

# Install vimrc and bash_profile
ln -sF $curDir/vimrc ~/.vimrc
ln -sF $curDir/bash_profile ~/.bash_profile

# Install VIM filetype plugins
ln -sF $curDir/ftplugin/c.vim ~/.vim/ftplugin/c.vim
ln -sF $curDir/ftplugin/java.vim ~/.vim/ftplugin/java.vim
ln -sF $curDir/ftplugin/asm.vim ~/.vim/ftplugin/asm.vim

# Copy YCM_CONF
ln -sF $curDir/ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py
