# File containing secrets that must NOT be version controlled.
# Expected location: ~/.config/fish/secrets.fish
if test -e $HOME/.config/fish/secrets.fish
    source $HOME/.config/fish/secrets.fish
end
