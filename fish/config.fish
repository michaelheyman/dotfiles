# This command must be ran at least once. However, leaving it on slows down the shell
# rvm default

# set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths

# Enable --no-rehash when updating pyenv
#   It updated the paths to the shims from pyenv-old-version to pyenv-new-version
# source (pyenv init - --no-rehash | psub)
# source (pyenv virtualenv-init - | psub)

# jenv config
#
# The following line is supposedly the recommended setup for jenv, but all it seems to
# do is add ~/.jenv/shims to the path and duplicate that value on every shell reload:
#
# status --is-interactive; and source (jenv init -|psub)
#
# This attempts to do the same thing:
fish_add_path $HOME/.jenv/shims
# TODO: look at jenv addons (export addon?) that may set JAVA_HOME automatically, based on
# some documented ideas here: https://github.com/jenv/jenv
set -x JAVA_HOME (/usr/libexec/java_home -v '1.8.*')

fish_add_path $HOME/Documents/scripts
# set -gx PATH /usr/local/bin $PATH
set -U __done_min_cmd_duration 5000

# Go config
#
set -x GOPATH $HOME/go
# The following command is extremely slow and affect every single shell session.
# Therefore, I'm hardcoding the path to the Go binary in the fish shell. Return
# here if you have issues with GOROOT.
# set -x GOROOT (brew --prefix golang)/libexec
set -x GOROOT /usr/local/opt/go/libexec
fish_add_path $GOPATH/bin
# Bypass module sum validation for modules that live in this prefix
set -gx GOPRIVATE github.com/cambiahealth
#
# Download packages to $GOPATH/src instead of $GOPATH/mod. This allows Goland to
# resolve its imports
# Actually, this makes `go mod download` throw a "go: modules disabled by GO111MODULE=off; see 'go help modules'"
# set -gx GO111MODULE off
# set --erase GO111MODULE

# Maybe these/this are/is needed to have RubyMine run cucumber internally?
# source ($HOME/.rvm/scripts/rvm)
# rvm default
