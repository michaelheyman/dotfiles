#!/bin/bash

# Rename dotfiles folder
mv ~/dotfiles ~/.dotfiles

# Create symlink between source and destination
ln -s ~/.bash_profile ~/.dotfiles/bash_profile
ln -s ~/.vimrc ~/.dotfiles/vimrc
