# check if pip is alredy installed
if test ! $(which pip); then
    print_info "pip doesn't exist"
else
    print_info "installing packages through pip..."
    pip install powerline-status
fi

# powerline fonts
if [ -e $HOME/Library/Fonts/3270Medium.ttf ]; then
    print_info "powerline fonts are already installed"
else
    print_info "installing powerline fonts"
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
    cd .. && rm -rf fonts # clean-up
fi

# tmux plugin manager
# check if tmux is installed
if test $(which tmux); then
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        print_info "Tmux Plugin Manager is already installed"
    else
        print_info "installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        print_info "installing Tmux plugins"
        ~/.tmux/plugins/tpm/bin/install_plugins
    fi
fi
