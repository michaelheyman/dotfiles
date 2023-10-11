#!/bin/bash

set -e

echo 'Running pre installation script'

if ! [ -x "$(command -v zsh)" ]; then
  echo 'Installing zsh'
  ./install-zsh.sh
fi

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
  echo 'Installing oh-my-zsh'
  # Answer Y to the prompt questions "Do you want to change your default shell to zsh? [Y/n]"
  echo "Y" | /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo 'Updating oh-my-zsh'
  upgrade_oh_my_zsh
fi

current_shell=$(ps -p $$ -o comm=)

# Change default shell
if [ "$current_shell" != "zsh" ]; then
  echo 'Changing default shell to zsh'
  chsh -s $(which zsh)
else
  echo 'Already using zsh'
fi
