# This command must be ran at least once. However, leaving it on slows down the shell
# rvm default

# source $OMF_CONFIG/../fish/functions/autoproxy.fish
# set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths

# Enable --no-rehash when updating pyenv
#   It updated the paths to the shims from pyenv-old-version to pyenv-new-version
source (pyenv init - --no-rehash | psub)
source (pyenv virtualenv-init - | psub)
source (jenv init - | psub)

set PATH $HOME/Documents/scripts $PATH
# set -gx PATH /usr/local/bin $PATH
set -x JAVA_HOME (/usr/libexec/java_home -v '1.8.*')
set -U __done_min_cmd_duration 5000

# Go config
# set -gx GOPRIVATE github.com/cambiahealth
set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin
set -a PATH $GOPATH/bin
# set -gx GOROOT /usr/local/opt/go/libexec

# Maybe these/this are/is needed to have RubyMine run cucumber internally?
# source ($HOME/.rvm/scripts/rvm)
# rvm default
