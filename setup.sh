#!/bin/bash
# Setup the Vim Config
directory="~/.vim/"
file_vimrc="~/.vimrc"
name_suffix=`date +%s`
if [ -f $file_vimrc ]; then
	echo "renaming .vimrc to .vimrc.old.$name_suffix"
	mv ~/.vimrc ~/.vimrc.old.$name_suffix
fi
if [ -d $directory ]; then
	echo "renaming .vim to .vim.old.$name_suffix"
	mv ~/.vim ~/.vim.old.$name_suffix
fi
if [ -f "_vimrc" && -d "_vim" ]; then
	cp _vimrc ~/.vimrc
	cp _vim ~/.vim
	cd ~/.vim
	git submodule init
	git submodule update
	echo "Yay! You have install the ultimate vim configuration :)"
else
	echo "Error! Unable to locale _vim and _vimrc files :("
fi
