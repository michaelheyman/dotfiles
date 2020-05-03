# Aliases
alias ls='ls -1hF'
alias ll='ls -l'
alias ..="cd .."
alias ...="cd ../.."

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Case insensitive tab-to-completion
# bind "set completion-ignore-case on"
# bind "set show-all-if-ambiguous on"

#export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

#if [ "$(uname)" == Darwin ]; then
#    # Setting PATH for Python 3.5
#    # The orginal version is saved in .bash_profile.pysave
#    PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
#    export PATH
#fi

# Make vim the default man pager
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

export PATH="$HOME/.elan/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
source $HOME/.autoproxy
export PATH="$HOME/.cargo/bin:$PATH"
