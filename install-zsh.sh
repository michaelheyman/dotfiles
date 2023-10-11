#!/bin/bash

# Check if the package manager is available
if command -v apt &>/dev/null; then
  # Install Zsh on Debian/Ubuntu
  apt -qq update &> /dev/null
  apt install -qq -y zsh &> /dev/null
elif command -v brew &>/dev/null; then
  # Install Zsh on macOS using Homebrew
  brew install zsh
else
  echo "Unsupported package manager. Please install Zsh manually."
  exit 1
fi
