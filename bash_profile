# Aliases
alias ls='ls -1hF'
alias ll='ls -l'
#alias subl='python3 ~/.subliminal/subl.py'

# Tell ls to be colourful
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Case insensitive tab-to-completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
