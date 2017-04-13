#!/usr/bin/env bash

# dotfile directory
export DOTFILES=~/.dotfiles

# check operating system
function is_macos() {
    [[ "$(uname)" == "Darwin" ]] || return 1
}

function is_ubuntu() {
    [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

# symlinks
ln -sfv "$DOTFILES/shell/.bash_profile" ~
ln -sfv "$DOTFILES/vim/.vimrc" ~
ln -sfv "$DOTFILES/shell/.zshrc" ~

# for ubuntu
if is_ubuntu; then
    source ./install/ubuntu.sh
fi

# for mac os
if us_macos; then
    source ./install/macos_brew.sh
fi

# install oh-my-zsh
source ./install/zsh.sh

# install conda
source ./install/conda.sh
