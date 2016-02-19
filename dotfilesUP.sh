#!/bin/bash
# Created by: Matthew Lange
# Created on: 2/19/2016

# go to home directory
cd

# clone the git repo
#git clone https://github.com/mblange/dotfiles.git

# copy .bashrc if it exits then link it
function linkDotFile {
	if [ -f ~/$1 ]; then
		mv $1 $1.orig;
		ln -sv /home/matt/.dotfiles/$1 ~/$1;
	else
		ln -sv /home/matt/.dotfiles/$1 ~/$1;
	fi
}

# list of files:
dotfiles=(.bashrc .bash_profile .aliases .vimrc .inputrc .tmux.conf)

#run function
for i in dotfiles; do
	linkDotFile i;
done

# reload bashrc
. ~/.bashrc 
