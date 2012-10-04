#!/bin/bash
# Setup the Vim Config
directory="$HOME/.vim"
file_vimrc="$HOME/.vimrc"
name_suffix=`date +%s`
if [ -f $file_vimrc ]; then
	echo "renaming .vimrc to .vimrc.old.$name_suffix"
	mv ~/.vimrc ~/.vimrc.old.$name_suffix
fi
if [ -d $directory ]; then
	echo "renaming .vim to .vim.old.$name_suffix"
	mv ~/.vim ~/.vim.old.$name_suffix
fi
git submodule init
git submodule update
if [ -f "_vimrc" ] && [ -d "_vim" ]; then
	cp _vimrc ~/.vimrc
	cp -r _vim ~/.vim
	echo "Yay! You have install the ultimate vim configuration :)"
else
	echo "Error! Unable to locate _vim and _vimrc files :("
fi
