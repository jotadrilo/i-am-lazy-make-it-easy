# custom scripts
export PATH=$PATH:/usr/local/bin/extras

# nvm
if [ -f /usr/local/opt/nvm/nvm.sh ]; then
  mkdir -p ~/.nvm
  export NVM_DIR=~/.nvm
  source /usr/local/opt/nvm/nvm.sh
fi

# go
if command -v go >/dev/null; then
  go_bin_path=$(go env GOPATH)/bin
  [[ $(command -v go) ]] && export PATH=$PATH:$go_bin_path
fi

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# gcloud
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then . ~/google-cloud-sdk/path.zsh.inc; fi
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then . ~/google-cloud-sdk/completion.zsh.inc; fi

# bazel
if command -v bazelisk >/dev/null; then
  if [[ ! -f /usr/local/bin/bazel ]]; then
    ln -sf "$(which bazelisk)" /usr/local/bin/bazel
  fi
fi

# rubbi-sh
if command -v rubbi-sh >/dev/null; then
  source /usr/local/opt/rubbi-sh/share/alias/.rubbi.sh
fi

# groovy
if command -v groovy >/dev/null; then
  export GROOVY_HOME=/usr/local/opt/groovy/libexec
fi
