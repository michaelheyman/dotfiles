#!/usr/bin/env bash

# cd "$(dirname "$0")/.."
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
    echo ''
    exit
}

link_file () {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
            local currentSrc="$(readlink $dst)" # check if destination is already symlinked

            if [ "$currentSrc" == "$src" ]; then
                skip=true;
            else
                user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
                [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
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
                    * )
                        ;;
                esac
            fi
        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

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
    fi

    if [ "$skip" != "true" ]; then  # "false" or empty
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}

install_dotfiles () {
    info 'installing dotfiles'

    local overwrite_all=false backup_all=false skip_all=false

    for src in $(find $PWD -type f ! -name "*.*" -maxdepth 1)   # find files in PWD with no extension
    do
        dst="$HOME/.$(basename "${src%.*}")"    # reduces filepath to filename
        link_file "$src" "$dst"
    done
}

install_vim () {
    mkdir -pv ~$HOME/.vim/autoload ~$HOME/.vim/bundle ~$HOME/.vim/undo
    git clone https://github.com/VundleVim/Vundle.vim.git ~$HOME/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    success "vim installed"
}

install_os () {
    if [ "$(uname)" == Darwin ]; then
        spath="./sublime/Preferences.sublime-settings"
        sdest="~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/.$(basename "${spath%.*}")"
        link_file "$spath" "$sdest"

    elif [ "$(uname)" == Linux ]; then
        if [ ! -a ~/.inputrc ]; then
            echo '$include /etc/inputrc' > ~/.inputrc;
        fi

        echo 'set completion-ignore-case On' >> ~/.inputrc;
    fi
}

install_dotfiles
install_vim
install_os

echo ''
echo '  All installed!'
