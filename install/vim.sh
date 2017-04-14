#!/bin/bash

#set up vundle for plugin management
if [ -d "$HOME/.vim/bundle/Vundle.vim"]; then
    print_info "Vundle is already intalled"
else
    print_info "downloading Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install plugins
print_info "installing vim plugins..."
vim +PluginInstall +qall

# compile YouCompleteMe
if [ -d "$HOME/.vim/bundle/YouCompleteMe"]; then
    print_info "compiling YouCompleteMe..."
    cd $HOME/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
else
    print_info "YouCompleteMe doesn't exist"
fi
    
# YCM_CORES=1 ./install.py --clang-completer # for limited memory

cd $DOTFILES
