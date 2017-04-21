#!/bin/bash

#set up vundle for plugin management
if [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    print_info "Vundle is already intalled"
else
    print_info "downloading Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install plugins
print_info "installing vim plugins..."
vim +PluginInstall +qall

# vimim symlink
if [ -d "$HOME/.vim/bundle/VimIM/plugin" ]; then
    print_info "wubi98 for VimIM added"
    ln -svf "$DOTFILES/vim/vimim.wubi98.txt" "$HOME/.vim/bundle/VimIM/plugin/"
fi

# compile YouCompleteMe
if [ -d "$HOME/.vim/bundle/YouCompleteMe" ]; then
    print_info "compiling YouCompleteMe..."
    $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
    # YCM_CORES=1 ./install.py --clang-completer # for limited memory
else
    print_info "YouCompleteMe doesn't exist"
fi
