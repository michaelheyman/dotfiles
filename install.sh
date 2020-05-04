#!/usr/bin/env bash

DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}

link_file () {
    local src=$1 dst=$2

    local overwrite= backup= skip= append=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ] && [ "$append_all" == "false" ]; then
            local currentSrc="$(readlink $dst)" # check if destination is already symlinked

            if [ "$currentSrc" == "$src" ]; then
                skip=true;
            else
                user "File already exists: $dst ($(basename "$src")), what do you want to do?"
                user "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all, [a]ppend, [A]ppend all?"
                read -n 1 action

                case "$action" in
                    o )
                        overwrite=true;;
                    O )
                        overwrite_all=true;;
                    b )
                        backup=true;;
                    B )
                        backup_all=true;;
                    s )
                        skip=true;;
                    S )
                        skip_all=true;;
                    a )
                        append=true;;
                    A )
                        append_all=true;;
                    * )
                        ;;
                esac
            fi
        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}
        append=${append:-$append_all}

        if [ "$overwrite" == "true" ]; then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [ "$backup" == "true" ]; then
            mv "$dst" "${dst}.backup"
            success "moved $dst to ${dst}.backup"
        fi

        if [ "$skip" == "true" ]; then
            success "skipped $src"
        fi

        if [ "$append" == "true" ]; then
            cat $src >> $dst
            success "appended $src to $dst"
        fi
    fi

    if [ "$skip" != "true" ] && [ "$append" != "true" ]; then  # "false" or empty
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}

command_exists () {
    type "$1" &> /dev/null;
}

install_dotfiles () {
    info 'installing dotfiles'

    local overwrite_all=false backup_all=false skip_all=false append_all=false

    for src in $(find $PWD -maxdepth 1 -type f ! -name "*.*")   # find files in PWD with no extension
    do
        dst="$HOME/.$(basename "$src")"    # reduces filepath to filename
        link_file "$src" "$dst"
    done
}

install_package () {
    info "installing $1"
    if [ "$(uname)" == Darwin ]; then
        brew install $1
    elif [ "$(uname)" == Linux ]; then
        sudo apt-get install $1
    fi
}

install_vim () {
    mkdir -pv $HOME/.vim/autoload $HOME/.vim/bundle $HOME/.vim/undo
    if [ -d $HOME/.vim/bundle/Vundle.vim ]; then
        fail "Vundle directory already exists, unable to clone to it"
        return
    fi
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    success "vim installed"
}

install_os () {
    if [ "$(uname)" == Darwin ]; then
        spath="./sublime/Preferences.sublime-settings"
        sdest="~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/.$(basename "${spath%.*}")"
        link_file "$spath" "$sdest"

        # install homebrew
        if ! command_exists brew; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

    elif [ "$(uname)" == Linux ]; then
        if [ ! -a ~/.inputrc ]; then
            echo '$include /etc/inputrc' > ~/.inputrc;
        fi

        echo 'set completion-ignore-case On' >> ~/.inputrc;
    fi
}

install_dotfiles

# TODO: remove opinionated packages, make it an explicit option
# declare -a packages=('git' 'vim');
# for package in "${packages[@]}"; do
#     if ! command_exists $package; then
#         install_package $package
#     fi
# done

install_vim
# install_os

echo ''
echo '  All installed!'
