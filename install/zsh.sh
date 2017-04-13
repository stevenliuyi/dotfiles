#!/bin/bash

# check if zsh is installed
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # check if oh-my-zsh is installed
    if [[ ! -d $HOME/.oh-my-zsh/ ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    else
        echo "oh-my-zsh is already installed"
    fi
    # set zsh to be the default shell
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
else
    echo "zsh isn't installed"
fi
