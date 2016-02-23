#!/bin/bash

# Rename dotfiles folder
mv ~/dotfiles ~/.dotfiles

# Setup vim
git clone git@github.com:Lokaltog/vim-distinguished.git ~/.vim/ 
mkdir -pv ~/.vim/undo
mkdir -pv ~/.vim/autoload ~/.vim/bundle
curls -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
mkdir -pv ~/.vim/bundle/syntastic
git clone git@github.com:scrooloose/syntastic.git ~/.vim/bundle/syntastic

# Delete bash_profile vimrc and osx
rm ~/.bash_profile
rm ~/.vimrc
rm ~/.osx

# Create symlink between source and destination
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/osx ~/.osx
