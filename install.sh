#!/bin/bash

# Rename dotfiles folder
mv ~/dotfiles ~/.dotfiles

# Delete bash_profile vimrc and osx
rm ~/.bash_profile
rm ~/.vimrc
rm ~/.osx

# Create symlink between source and destination
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/osx ~/.osx
