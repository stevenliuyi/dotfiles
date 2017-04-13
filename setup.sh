#!/usr/bin/env bash

# dotfile directory
export DOTFILES=~/.dotfiles

# symlinks
ln -sfv "$DOTFILES/shell/.bash_profile" ~
ln -sfv "$DOTFILES/vim/.vimrc" ~
