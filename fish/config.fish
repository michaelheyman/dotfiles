# Enable --no-rehash when updating pyenv
#   It updated the paths to the shims from pyenv-old-version to pyenv-new-version
source (pyenv init - --no-rehash | psub)
source (pyenv virtualenv-init - | psub)

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
set -x GOROOT /opt/homebrew/opt/go/libexec
fish_add_path $GOPATH/bin
# Bypass module sum validation for modules that live in this prefix
set -gx GOPRIVATE github.com/vivantehealth
#
# Download packages to $GOPATH/src instead of $GOPATH/mod. This allows Goland to
# resolve its imports
# Actually, this makes `go mod download` throw a "go: modules disabled by GO111MODULE=off; see 'go help modules'"
# set -gx GO111MODULE off
# set --erase GO111MODULE

# Maybe these/this are/is needed to have RubyMine run cucumber internally?
# source ($HOME/.rvm/scripts/rvm)
# rvm default

# Disable help message when opening shell
set fish_greeting
