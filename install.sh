#!/bin/bash
if [ -d ~/.dotfiles ]
then
    echo "You already have a Dotfiles folder. You'll need to remove ~/.dotfiles if you want to install"
    exit
else
    echo "#Cloning Dotfiles"
    git clone https://github.com/michaelheyman/dotfiles.git ~/.dotfiles
fi

echo "Looking for an existing vim config..."
if [ -f ~.vimrc ]
then
    echo "Found ~.vimrc. Backing up to ~.vimrc.backup";
    cp ~.vimrc ~.vimrc.backup
    rm ~.vimrc
else
    echo "#Cloning .vimrc"
fi

echo "Setting up vim..."
mkdir -pv ~/.vim/autoload ~/.vim/bundle ~/.vim/undo
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "Looking for an existing bash profile config..."
if [ -f ~.bash_profile ]
then
    echo "Found ~.bash_profile. Backing up to ~.bash_profile.backup";
    cp ~.bash_profile ~.bash_profile.backup
    rm ~.bash_profile
else
    echo "#Cloning .bash_profile"
fi

if [ "$(uname)" == Darwin ]; then
    echo "Looking for an existing osx config..."
    if [ -f ~.osx ]
    then
        echo "Found ~.osx. Backing up to ~.osx.backup";
        cp ~.osx ~.osx.backup
        rm ~.osx
    else
        echo "#Cloning .osx"
    fi
fi

echo "Symlinking .vimrc to ~/.dotfiles/.vimrc"
ln -s ~/.dotfiles/vimrc ~/.vimrc

echo "Symlinking .bash_profile to ~/.dotfiles/.bash_profile"
ln -s ~/.dotfiles/bash_profile ~/.bash_profile


if [ "$(uname)" == Darwin ]; then
    echo "Symlinking .osx to ~/.dotfiles/.osx"
    ln -s ~/.dotfiles/osx ~/.osx
fi

echo "Dotfiles have been successfuly installed"
echo "Run :PluginInstall inside VIM"
