#!/bin/bash

# Rename dotfiles folder
mv ~/dotfiles ~/.dotfiles

# Link dotfiles to home directory
ln -sv ~/.dotfiles/.vimrc ~
