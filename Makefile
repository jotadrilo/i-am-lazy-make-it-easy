# force bash shell
SHELL = /bin/bash

# define target-specific settings
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	LINUX = 1
    PKG = apt-get
	VSCODECONF = ~/.config/Code/User
endif
ifeq ($(UNAME_S),Darwin)
	OSX = 1
    PKG = brew
	VSCODECONF = ~/Library/Application\ Support/Code/User
	ITERMCONF = ~/Library/Preferences
endif

# flags not to re-run tasks
BREW := $(shell brew help 2>/dev/null)
ZSH := $(shell grep /usr/local/bin/zsh /etc/shells)
STOW := $(shell stow --version 2>/dev/null)
ITERM := $(shell ls /Applications/iTerm.app/ 2>/dev/null)
GCLOUD := $(shell gcloud --version 2>/dev/null)
GPG := $(shell gpg --version 2>/dev/null)
GIT := $(shell git help 2>/dev/null)
GITSECRET := $(shell git-secret help 2>/dev/null)
ARC := $(shell arc help 2>/dev/null)

all: tools zsh .files scripts

#
# common tasks
#

brew:
ifndef BREW
	@echo "=> Installing brew..."
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install -o /tmp/homebrew
	/usr/bin/ruby /tmp/homebrew
	rm /tmp/homebrew
endif
apt-get:
stow: brew
ifndef STOW
	@echo "=> Installing stow..."
	$(PKG) install stow
endif

#
# specific tasks
#

# useful tools
tools: $(PKG) git iterm2
	# "true" fallback will allow already installed apps not to fail
	tools=( \
	  ag \
	  awscli \
	  curl \
	  jq \
	  nvm \
	  s3cmd \
	  shfmt \
	  unzip \
	  vim \
	  wget \
	); \
	for tool in $${tools[*]}; \
	do \
	  echo "=> Installing $$tool"; \
	  $(PKG) install $$tool || true; \
	done
git: $(PKG)
ifndef GIT
	@echo "=> Installing git..."
	$(PKG) install git || true
endif
git-secret: $(PKG)
ifndef GITSECRET
	@echo "=> Installing git-secret..."
ifeq ($(PKG),brew)
	# "true" fallback will allow already installed apps not to fail
	brew install git-secret || true
endif
ifeq ($(PKG),apt-get)
	echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | sudo tee -a /etc/apt/sources.list
	wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install git-secret
endif
endif
iterm2:
ifndef ITERM
ifdef OSX
	@echo "=> Installing iterm2..."
	mkdir -p /tmp/iterm2
	curl -fsSL https://iterm2.com/downloads/stable/latest -o /tmp/iterm2/latest.zip
	unzip -q /tmp/iterm2/latest.zip -d /tmp/iterm2/
	mv /tmp/iterm2/iTerm.app /Applications/
	rm -rf /tmp/iterm2
endif
endif
gpg:
ifndef GPG
	@echo "=> Installing gpg-suite..."
	# "true" fallback will allow already installed apps not to fail
	brew cask install gpg-suite || true
endif
extra-tools: $(PKG) gpg
ifeq ($(PKG),brew)
	# "true" fallback will allow already installed apps not to fail
	tools=( \
	  docker \
	  flycut \
	  google-chrome \
	  gpg-suite \
	  lastpass \
	  pritunl \
	  spotify \
	  visual-studio-code \
	); \
	for tool in $${tools[*]}; \
	do \
	  echo "=> Installing $$tool"; \
	  brew cask install $$tool || true; \
	done
endif

# useful scripts
scripts: stow reveal-scripts
	mkdir -p /usr/local/bin/extras
	# tool functions
	cp functions/tools/* /usr/local/bin/extras
hide-scripts: git-secret
	# enc functions
	git-secret hide
reveal-scripts: git-secret stow
	mkdir -p /usr/local/bin/extras
	# enc functions
	git-secret reveal -f
	grep functions/enc/ .gitsecret/paths/mapping.cfg | cut -d: -f1 | xargs -I % cp % /usr/local/bin/extras/

# zsh
zsh: $(PKG) .zsh .oh-my-zsh
.zsh:
ifndef ZSH
	@echo "=> Installing zsh..."
	$(PKG) install zsh zsh-completions
	@echo " => Setting zsh as default shell..."
	echo /usr/local/bin/zsh | sudo tee -a /etc/shells
	chsh -s /usr/local/bin/zsh
endif

# dotfiles
.submodules: git
	git submodule init
	git submodule update
.home: stow reveal-home
	@echo "=> Stowing home dotfiles..."
	cd dotfiles && stow -t ~ -R home
hide-home: git-secret
	git-secret hide
reveal-home: git-secret stow
	git-secret reveal -f
	@echo "=> Stowing home/enc dotfiles..."
	cd dotfiles/home && stow -t ~ -R enc --ignore='.*\.secret'
.iterm2:
ifdef OSX
	@echo "=> Stowing iterm2 dotfiles..."
	config=$(ITERMCONF)/com.googlecode.iterm2.plist; \
	if [[ ! -f $$config.orig ]]; then mv $$config $$config.orig; fi; \
	cp dotfiles/iterm2/com.googlecode.iterm2.plist $$config
endif
.oh-my-zsh: stow
	@echo "=> Stowing oh-my-zsh dotfiles..."
	cd dotfiles && stow -t ~ -R oh-my-zsh
.spacemacs-emacs: stow
	@echo "=> Stowing spacemacs-emacs dotfiles..."
	cd dotfiles && stow -t ~ -R spacemacs-emacs
.vim: stow
	@echo "=> Stowing vim dotfiles..."
	cd dotfiles && stow -t ~ -R vim
.vscode: stow
	@echo "=> Stowing vscode dotfiles..."
	cd dotfiles && stow -t $(VSCODECONF) -R vscode

.files: .submodules .home .oh-my-zsh .spacemacs-emacs .vim .vscode

# go
go: $(PKG)
ifeq ($(PKG),brew)
	@echo "=> Installing go..."
	brew install go
endif

# gcloud
gcloud:
ifndef GCLOUD
	@echo "=> Installing gcloud..."
	curl https://sdk.cloud.google.com | bash
endif

# kubectl
kubectl: gcloud
	@echo "=> Installing kubectl..."
	gcloud components install kubectl

# nodejs
nvm: $(PKG)
	@echo "=> Installing nvm..."
ifeq ($(PKG),brew)
	brew install nvm || true
	mkdir -p $$HOME/.nvm
endif
nodejs: nvm
	@echo "=> Installing node.js..."
	export NVM_DIR="$$HOME/.nvm"; \
	source /usr/local/opt/nvm/nvm.sh; \
	nvm install --lts

# arcanist
arc: git
ifndef ARC
	@echo "=> Installing arcanist..."
	sudo mkdir -p /usr/local/php
	sudo git clone git://github.com/facebook/libphutil.git /usr/local/php/libphutil
	sudo git clone git://github.com/facebook/arcanist.git /usr/local/php/arcanist
	ln -s /usr/local/php/arcanist/bin/arc /usr/local/bin/arc
endif

# debug
print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true

