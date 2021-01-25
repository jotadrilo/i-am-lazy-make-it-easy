# shellcheck disable=SC2148
# shellcheck disable=SC1090

# ag - Follow symlinks and search in all files
alias ag='\ag -fu'
alias agb='\ag -u --ignore "bazel-.*"'

# kubectl
alias kc=kubectl

# native tools
alias sed=gsed

# kubecfg
alias kubecfgsort="yq -y -s 'sort_by(\"\(.kind)/\(.metadata.name)\")| .[]'"

# override gst alias
alias gst='git status $(\gls | grep -v inventory | grep -v bots)'
alias gstu='git status -uno $(\gls | grep -v inventory | grep -v bots)'

# kubectlsecret
alias kcs='kubectlsecret'
