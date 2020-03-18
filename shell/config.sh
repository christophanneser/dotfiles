#!/bin/bash

include () {
    [[ -f "$1" ]] && source "$1"
}

export DOTFILES=$HOME/Documents/dotfiles
export SHELLCONF=$DOTFILES/shell

export TERM=xterm-256color

export HISTFILE=~/.bash_history
export HISTSIZE=10000
export SAVEHIST=10000
export REPORTTIME=10
export EDITOR='vim'

export CMAKE_INCLUDE_PATH=$HOME/.local/include:$CMAKE_INCLUDE_PATH
export CMAKE_LIBRARY_PATH=$HOME/.local/lib:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$HOME/.local:$CMAKE_PREFIX_PATH
export CMAKE_INSTALL_PREFIX=$HOME/.local:$CMAKE_INSTALL_PREFIX

export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export NPM_PACKAGES=$HOME/.npm_packages

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$NPM_PACKAGES/bin:$PATH

include $SHELLCONF/aliases.sh
include $SHELLCONF/functions.sh

source $SHELLCONF/colors/gruvbox_256palette.sh
