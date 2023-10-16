#!/bin/bash

set -e

if_darwin() {
    if [ "$(uname)" == "Darwin" ]; then
        if [ $# -ge 1 ]; then
            local command="$1"
            shift  # Remove the first argument (the command name)

            # Check if the command is a function
            if declare -F "$command" &>/dev/null; then
                echo "Executing function: $command with parameters: $@"
                "$command" "$@"
            # Check if the command is an executable
            elif command -v "$command" &>/dev/null; then
                echo "Executing command: $command with parameters: $@"
                "$command" "$@"
            else
                echo "Invalid command: $command is neither a function nor a valid command."
            fi
        else
            echo "No command provided."
        fi
    else
        echo "Not a Darwin platform, skipping execution of command."
    fi
}

install_brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

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
    echo 'Installing oh-my-zsh'
    # Answer Y to the prompt questions "Do you want to change your default shell to zsh? [Y/n]"
    echo "Y" | /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo 'Updating oh-my-zsh'
    omz update
  fi
}

install_oh_my_fish() {
  echo 'Installing oh-my-fish'
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install-fish
  chmod u+x install-fish
  ./install-fish --noninteractive
}
