#!/bin/bash

set -e

source ./scripts/logging.sh

install_package() {
  local package_name="$1"

  if command -v apt &>/dev/null; then
    # Install the specified package on Debian/Ubuntu
    apt-get -qq update &> /dev/null
    # apt-get install -qq -y "$package_name" &> /dev/null
    apt-get install -qq -y "$package_name"
  elif command -v brew &>/dev/null; then
    # Install the specified package on macOS using Homebrew
    brew install "$package_name"
  else
    fail "Unsupported package manager. Please install the package manually."
    exit 1
  fi
}

install_oh_my_zsh() {
  # Check if oh-my-zsh is installed
  OMZDIR="$HOME/.oh-my-zsh"
  if [ ! -d "$OMZDIR" ]; then
    info 'Installing oh-my-zsh'
    # Answer Y to the prompt questions "Do you want to change your default shell to zsh? [Y/n]"
    echo "Y" | /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    info 'Updating oh-my-zsh'
    omz update
  fi
}

install_oh_my_fish() {
  info 'Installing oh-my-fish'
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install-fish
  chmod u+x install-fish
  ./install-fish --noninteractive
}

change_default_shell() {
  current_shell=$(ps -p $$ -o comm=)
  if [ "$(uname)" == "Darwin" ]; then
      if [ "$current_shell" != "fish" ]; then
          info 'Changing default shell to fish'
          chsh -s $(which fish)
      else
          info 'Already using fish'
      fi
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
      if [ "$current_shell" != "zsh" ]; then
        info 'Changing default shell to zsh'
        chsh -s $(which zsh)
      else
        info 'Already using zsh'
      fi
  else
      fail 'Unsupported platform'
  fi
}

info 'Running pre installation script'

install_package zsh
install_package fish

install_oh_my_zsh
install_oh_my_fish

change_default_shell