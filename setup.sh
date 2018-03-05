#!/usr/bin/env bash

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

function is_ubuntu_desktop() {
    [[ ! "$XDG_CURRENT_DESKTOP" == "" ]] || return 1
}

function is_nvidia() {
    lspci | grep -q "NVIDIA" || return 1
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
    printf "\n\n"
}

function print_question() {
    # print output in yellow
    printf "\e[0;33m  [DOTFILES] %s\e[0m" "$1"
}

function print_info() {
    # print output in purple
    printf "\n\e[0;35m  [DOTFILES] %s\e[0m\n\n" "$1"
}

# install chosen packages
function install() {
    if [[ "$install" == "all" ]]; then
        source "$2"
    elif [[ "$install" == "basic" && "$1" == "packages using apt" ]]; then
        source "$2"
    elif [[ "$install" == "basic" && "$1" == "packages using Homebrew" ]]; then
        source "$2"
    elif [[ "$install" == "basic" ]]; then
        :
    else
        ask_for_confirmation "do you want to install $1?"
        if answer_is_yes; then
            source "$2"
        fi
    fi
    
}

##################################################
# main
##################################################

while getopts ":abh" opt; do
    case $opt in
        a )
            install="all"
            ;;
        b )
            install="basic"
            ;;
        h )
            echo "DOTFILES - Yi Liu
https://github.com/stevenliuyi/dotfiles

Usage: ./setup.sh [options]

Options:
-a      Install all tools available
-b      Install packages via apt (Ubuntu) or Homebrew (macOS)
-h      Show help information
"

            exit
            ;;
        \? )
            print_info "Invalid option encountered"
            exit
            ;;
        : )
            ;;
    esac
done

# dotfile directory
if [ ! -d "$HOME/.dotfiles" ]; then
    print_info "cannot find dotfiles directory, please make sure it's at ~/.dotfiles "
    exit
fi
export DOTFILES=~/.dotfiles

# symlinks
ln -sfv "$DOTFILES/shell/.bash_profile" ~
ln -sfv "$DOTFILES/shell/.bashrc" ~
ln -sfv "$DOTFILES/shell/.zshrc" ~
ln -sfv "$DOTFILES/shell/.cshrc" ~
ln -sfv "$DOTFILES/vim/.vimrc" ~
ln -sfv "$DOTFILES/tmux/.tmux.conf" ~

mkdir -p "$HOME/.ssh"
ln -sfv "$DOTFILES/conf/ssh.config" ~/.ssh/config
ln -sfv "$DOTFILES/conf/id_rsa" ~/.ssh/id_rsa
ln -sfv "$DOTFILES/conf/id_rsa.pub" ~/.ssh/id_rsa.pub

# protect private key
chmod 600 $DOTFILES/conf/id_rsa

source ~/.bash_profile

print_info "symlinks are created"

# copy instead of creating symlink since password is store in the file
cp $DOTFILES/conf/.pypirc ~

# tool installation
if [ "$install" == "all" ]; then
    print_info "all tools available will be installed"
elif [ "$install" == "basic" ]; then
    if is_ubuntu; then
        print_info "packages will be installed via apt"
    fi
    
    if is_macos; then
        print_info "packages will be installed via Homebrew"
    fi
else
    ask_for_confirmation "do you want to continue to install some tools?"
    if answer_is_yes; then
        ask_for_confirmation "do you want to install all tools available (otherwise you need to choose specific ones to install)?"
        if answer_is_yes; then
            install="all"
        fi
    else
        exit
    fi
fi

# install packages for ubuntu
if is_ubuntu; then
    install "packages using apt" "./install/ubuntu.sh"
fi

# install packages for ubuntu desktop
if is_ubuntu ; then
    if is_ubuntu_desktop; then
        install "packages for Ubuntu desktop environment" "./install/ubuntu_desktop.sh"
    fi
fi

# install packages for mac os
if is_macos; then
    install "packages using Homebrew" "./install/macos_brew.sh"
fi
    
# install conda
install "Anaconda" "./install/conda.sh"

# install yarn
install "yarn packages" "./install/yarn.sh"

# install packages using pip and other sources (for both ubuntu and macos)
install "packages using PyPI and other sources" "./install/packages.sh"

# install vim plugins
install "vim plugins" "./install/vim.sh"

# install oh-my-zsh
install "oh-my-zsh" "./install/zsh.sh"

# install gpu driver for ubuntu
if is_ubuntu; then
    if is_nvidia; then
        install "CUDA and cuDNN on ubuntu" "./install/ubuntu_gpu.sh"
    fi
fi

# configurations
if test ! "$(which gpg)"; then
    print_info "GPG is not installed"
else
    print_info "configuring gpg..."
    gpg --import $DOTFILES/conf/public_key.asc

    if test ! "$(which git-crypt)"; then
        print_info "git-crypt is not installed"
    else
        print_info "decrypting private files using git-crypt"
        git-crypt unlock
    fi
fi
