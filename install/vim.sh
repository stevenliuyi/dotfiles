#!/bin/bash

#set up vundle for plugin management
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install plugins
vim +PluginInstall +qall

# compile YouCompleteMe
cd $HOME/.vim/bundle/YouCompleteMe
./install.py --clang-completer
# YCM_CORES=1 ./install.py --clang-completer # for limited memory

cd $DOTFILES
