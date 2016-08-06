#!/bin/bash

# Rename dotfiles folder
mv ~/dotfiles ~/.dotfiles

# Setup vim
mkdir -pv ~/.vim/undo
mkdir -pv ~/.vim/autoload ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -pv ~/.vim/bundle/syntastic

# Delete bash_profile vimrc and osx
rm ~/.bash_profile
rm ~/.vimrc
rm ~/.osx

# Create symlink between source and destination
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/osx ~/.osx
