# File containing secrets that must NOT be version controlled.
# Expected location: ~/.shell/secrets.sh
if test -e $HOME/.shell/secrets.sh
    bass source $HOME/.shell/secrets.sh
end
