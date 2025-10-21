#!/bin/bash

# Follow the instructions in Vundle's documentation: https://github.com/VundleVim/Vundle.vim

# Set up Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall
