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

# install oh-my-zsh
./install/zsh.sh

# install conda
./install/conda.sh
