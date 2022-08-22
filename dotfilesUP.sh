#!/bin/bash
# Created by: Matthew Lange
# Created on: 2/19/2016

# go to home directory
cd

# id home dir
HDIR=$(pwd)

# clone the git repo
#git clone https://github.com/mblange/dotfiles.git

# copy .bashrc if it exits then link it
function linkDotFile {
	if [ -f ~/$1 ]; then
		mv $1 $1.orig;
		ln -sv $HDIR/.dotfiles/$1 ~/$1;
	else
		ln -sv $HDIR/.dotfiles/$1 ~/$1;
	fi
}

# list of files:
declare -a dotfiles=(.zshrc .zprofile .aliases .vimrc .tmux.conf)

#run function
for i in "${dotfiles[@]}"; do
	linkDotFile $i;
done

# reload bashrc
. ~/.zshrc 

## git stuff ##
# update .gitconfig
read "name?Enter your full name, followed by [ENTER] "

read "email?enter your github email address, followed by [ENTER] "

git config --global user.email "$email"
git config --global user.name "$name"

# set credential store option
cd ~/.dotfiles/
git config credential.helper 'store'
