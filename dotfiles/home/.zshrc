# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# shellcheck disable=SC2148

# Path to zsh installation
export ZSH=~/.oh-my-zsh

# Themes
export ZSH_THEME="ys" # default: robbyrussell

# Path to zplug installation.
export ZPLUG_HOME=~/.zplug

# First time clone
if [[ ! -d $ZPLUG_HOME ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source "${ZPLUG_HOME}/init.zsh" && zplug update
else
    source "${ZPLUG_HOME}/init.zsh"
fi

# Fix for common-aliases plugin
autoload -Uz is-at-least

# Features from oh-my-zsh
oh_my_zsh_libs=(
    directories
    key-bindings
    compfix
)
for p in ${oh_my_zsh_libs[*]}; do
    zplug "lib/$p", from:oh-my-zsh
done

# Plugins from oh-my-zsh
oh_my_zsh_plugins=(
# plugins=(
    # Others
    colored-man-pages
    colorize
    jsontools
    docker
    docker-compose
    kubectl
    # Aliases
    common-aliases
    extract
    git
    git-extras
)

if [[ "$OSTYPE" = darwin* ]] ; then
    oh_my_zsh_plugins+=(osx brew-cask)
fi
for p in ${oh_my_zsh_plugins[*]}; do
    zplug "plugins/$p", from:oh-my-zsh
done

# Plugins from zplug
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zpm-zsh/ls"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug "stedolan/jq", \
      from:gh-r, \
      as:command, \
      rename-to:jq

zplug "junegunn/fzf-bin", \
      from:gh-r, \
      as:command, \
      rename-to:fzf
zplug "junegunn/fzf", as:command, \
      use:"bin/fzf-tmux"
zplug "junegunn/fzf", use:shell/key-bindings.zsh, \
      on:"junegunn/fzf-bin", defer:3

zplug "jhawthorn/fzy", \
      as:command, \
      hook-build:"make"

#
# Completions
#
fpath+=(~/.zsh/completions)
fpath+=(~/git-subrepo/share/zsh-completion)

# This has to load before zplug loads
source ~/.zshrc-wincent-min

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -rq; then
        echo
        zplug install
    fi
fi

# Then, source plugins
zplug load # --verbose

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

optional_files=(
    ~/.aliases.sh
    ~/.extras.zshrc
    ~/.profile
    # bitnami
    ~/.bitnami.aliases.sh
    ~/.bitnami.zshrc
)

for f in ${optional_files[*]}; do
    test -f "$f" && source "$f"
done
