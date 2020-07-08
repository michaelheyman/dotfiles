alias dlf "docker logs --follow"
alias dns-reset "sudo killall -HUP mDNSResponder; sleep 2"
alias dps "docker ps"
alias dih "docker_inspect_health"

alias gd 'git diff'
alias gl 'git log'
alias glo 'git log --oneline'
alias gp 'git pull'
alias gs 'git status'
alias gc 'git checkout'

alias wifi 'networksetup -setairportnetwork en0 Regence_Tenant1 Flo3jul1'

# File containing secrets that must NOT be version controlled
source $OMF_CONFIG/secrets.fish

# fish doesn't support aliases with parameters, so functions are the
# workaround
function docker_inspect_health
    docker inspect -f "{{json .State.Health }}" $argv | jq
end
