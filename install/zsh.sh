#!/bin/bash

# check if zsh is installed
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # check if oh-my-zsh is installed
    if [[ ! -d $HOME/.oh-my-zsh/ ]]; then
        ZSH=~/.oh-my-zsh
        print_info "downloading oh-my-zsh"
        git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
        export ZSH=$ZSH
        # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    else
        print_info "oh-my-zsh is already installed"
    fi
    # set zsh to be the default shell
    if [[ ! $SHELL == $(which zsh) ]]; then
        sudo chsh "$USER" -s "$(which zsh)"
        print_info "set oh-my-zsh to be the default shell"
    else
        print_info "oh-my-zsh is already the default shell"
    fi
else
    print_info "zsh isn't installed"
fi
