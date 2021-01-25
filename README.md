# I am lazy, make it easy

This project is meant to get a custom and quick setup when you move to a new laptop. It is based on a `Makefile` that will take care of running all tasks to install dependencies and configuration files.

## I said I'm lazy, install it

Too long, don't read

```
git clone --recursive https://github.com/jotadrilo/i-am-lazy-make-it-easy
cd i-am-lazy-make-it-easy && make
```

## I am lazy, but I want to know which tools will get installed

### Homebrew

Package manager for macOS ([more](https://brew.sh/)).

> NOTE: Only in macOS systems.

### Useful tools

Common tools for developing, etc.

- ag
- awscli
- curl
- git
- iterm2
- jq
- s3cmd
- shfmt
- unzip
- vim
- wget

### Extra tools

Bigger tools for developing, etc.

- docker
- flycut
- google-chrome
- gpg-suite
- lastpass
- pritunl
- spotify
- visual-studio-code

### Vim colors

By installing the vim dotfiles, you will also get the following vim colors:

- [alchemie](https://github.com/Lowentwickler/dotfiles/master/colors/alchemie.vim)
- [deus](https://github.com/ajmwagar/vim-deus)
- [duoduo](https://github.com/Yggdroot/duoduo)
- [flattened](https://github.com/romainl/flattened)
- [forgotten](https://github.com/nightsense/forgotten)
- [material-monokai](https://github.com/skielbasa/vim-material-monokai)
- [rupza](https://github.com/felipesousa/rupza/master/colors/rupza.vim)
- [solarized8](https://github.com/lifepillar/vim-solarized8)
- [solor_dark](https://github.com/beigebrucewayne/min_solo)
- [VisualStudioDark](https://github.com/Heorhiy/VisualStudioDark.vim)

### Zsh

Interactive terminal ([more](http://www.zsh.org/)).

### Oh-my-zsh

Framework for managing your zsh configuration ([more](http://ohmyz.sh/)).

### Stow

Symlink farm manager ([more](https://www.gnu.org/software/stow/)).

## I don't want to install everything

There are a few tasks that you can run:

### tools

`tools` will install [useful tools](#useful-tools).

```
make tools
```

### extra-tools

`extra-tools` will install [useful extra tools](#extra-tools).

```
make tools
```

### scripts

`scripts` will install my custom scripts.

```
make scripts
```

### enc-scripts

`enc-scripts` will install my custom encrypted scripts.

```
make enc-scripts
```

### zsh

`zsh` will install zsh and oh-my-zsh dotfiles.

```
make zsh
```

### go

`go` will install go
> NOTE: macOS only (yet)

```
make go
```

### gcloud

`gcloud` will install google-cloud-sdk

```
make gcloud
```

### kubectl

`kubectl` will install kubectl

```
make kubectl
```

### nodejs

`nodejs` will install the long term support (LTS) Node.js version using nvm

```
make nodejs
```
