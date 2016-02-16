#!/bin/bash

# Install vimrc and bash_profile
ln -s vimrc ~/.vimrc
ln -s bash_profile ~/.bash_profile

# Install VIM filetype plugins
ln -s ftplugin/c.vim ~/.vim/ftplugin/c.vim
ln -s ftplugin/java.vim ~/.vim/ftplugin/java.vim

# Copy YCM_CONF
ln -s ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py
