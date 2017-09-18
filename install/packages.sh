#!/bin/bash

# check if pip is alredy installed
packages="powerline-status floyd-cli"
if test ! "$(which pip)"; then
    print_info "pip doesn't exist"
else
    print_info "installing packages through pip..."
    for pkg in $packages; do
        pip install "$pkg"
    done
fi

# powerline fonts
if is_macos; then
    fonts_folder="$HOME/Library/Fonts/"
elif is_ubuntu; then
    fonts_folder="$HOME/.local/share/fonts/"
fi

if [ -e "${fonts_folder}3270Medium.ttf" ]; then
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
if test "$(which tmux)"; then
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        print_info "Tmux Plugin Manager is already installed"
    else
        print_info "installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        print_info "installing Tmux plugins"
        ~/.tmux/plugins/tpm/bin/install_plugins
    fi
fi

# rstudio
if is_ubuntu; then
    # check if rstudio is installed
    if test ! "$(which rstudio)"; then
        print_info "installing RStudio..."
        wget https://download1.rstudio.org/rstudio-1.0.143-amd64.deb
        sudo gdebi --non-interactive rstudio-1.0.143-amd64.deb
        rm rstudio-1.0.143-amd64.deb # clean up
    else
        print_info "RStudio is already installed"
    fi
fi

# watchman
if is_ubuntu; then
    # check if watchman is installed
    if test ! "$(which watchman)"; then
        print_info "installing watchman..."
        git clone https://github.com/facebook/watchman.git
        cd watchman
        git checkout v4.7.0 # the latest stable release
        ./autogen.sh
        ./configure
        make
        sudo make install
        cd .. && rm -rf watchman # clean-up
    else
        print_info "wathman is already installed"
    fi
fi

# genymotion
if is_ubuntu; then
    # check if genymotion is installed
    if [ ! -d "~/genymotion" ]; then
        # check if virtualbox is installed
        if test "$(which virtualbox)"; then
            print_info "installing genymotion"
            wget https://dl.genymotion.com/releases/genymotion-2.10.0/genymotion-2.10.0-linux_x64.bin
            chmod +x genymotion-2.10.0-linux_x64.bin
            ./genymotion-2.10.0-linux_x64.bin -d ~
            rm genymotion-2.10.0-linux_x64.bin # clean-up
        else
            print_info "virtualbox isn't installed"
        fi
    else
        print_info "genymotion is already installed"
    fi
fi
