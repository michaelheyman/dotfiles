alias dlf "docker logs --follow"
alias dns-reset "sudo killall -HUP mDNSResponder; sleep 2"
alias dps "docker ps"
alias dih "docker_inspect_health"

# Kubernetes aliases
alias k "AWS_PROFILE=dev AWS_DEFAULT_REGION=us-west-2 CLUSTER=dev-eks01 janus kubectl"
alias kgp "kubectl get pods"
alias kd "kubectl describe"

# GitHub aliases
alias gd 'git diff'
alias gl 'git log'
alias glo 'git log --oneline'
alias gp 'git pull'
alias gs 'git status'
alias gc 'git checkout'

alias wifi 'networksetup -setairportnetwork en0 Regence_Tenant1 Flo3jul1'

# File containing secrets that must NOT be version controlled
source $OMF_CONFIG/secrets.fish

# Load `gcloud components` onto path, such as gke-gcloud-auth-plugin
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# Configure kubectl completion. This probably only needs to be ran once.
# See: https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-fish/
# kubectl completion fish | source

# Configure helm completion. This probably only needs to be ran once.
# See: https://helm.sh/docs/helm/helm_completion_fish/
# helm completion fish | source

# fish doesn't support aliases with parameters, so functions are the
# workaround
function docker_inspect_health
    docker inspect -f "{{json .State.Health }}" $argv | jq
end
