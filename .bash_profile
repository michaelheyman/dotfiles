# Aliases
alias ls='ls -1hF'
alias ll='ls -l'

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Case insensitive tab-to-completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
