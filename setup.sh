#!/usr/bin/env bash

# dotfile directory
export DOTFILES=~/.dotfiles

##################################################
# utils
##################################################

# check operating system
function is_macos() {
    [[ "$(uname)" == "Darwin" ]] || return 1
}

function is_ubuntu() {
    [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

# interface
function answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

function ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -n 1
    printf "\n"
}

function print_question() {
    # print output in yellow
    printf "\e[0;33m  [?] $1\e[0m"
}

function print_info() {
    # print output in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

# install chosen packages
function install() {
    if ! $install_all; then
        ask_for_confirmation "do you want to install $1?"
    fi
    if answer_is_yes || $install_all; then
        source $2
    fi
    
}

##################################################
# main
##################################################

# symlinks
ln -sfv "$DOTFILES/shell/.bash_profile" ~
ln -sfv "$DOTFILES/vim/.vimrc" ~
ln -sfv "$DOTFILES/shell/.zshrc" ~
print_info "symlinks are created"

ask_for_confirmation "do you want to continue to install some tools?"
if answer_is_yes; then
    ask_for_confirmation "do you want to install all tools available (otherwise you need to choose specific ones to install)?"
    if answer_is_yes; then
        install_all=true
    else
        install_all=false
    fi
else
    exit
fi
    
# for ubuntu
if is_ubuntu; then
    install "packages using apt" " ./install/ubuntu.sh"
fi

# for mac os
if is_macos; then
    install "packages using Homebrew" "./install/macos_brew.sh"
fi

# install conda
install "Anaconda" "./install/conda.sh"

# install vim plugins
install "vim plugins" "./install/vim.sh"

# install oh-my-zsh
install "oh-my-zsh" "./install/zsh.sh"
