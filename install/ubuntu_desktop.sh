#!/bin/bash

# update apt
print_info "updating apt..."
sudo apt-get update

# install packages
packages="google-chrome-stable gdebi-core nautilus-dropbox fcitx-googlepinyin numix-gtk-theme numix-icon-theme-circle ibus-rime librime-data-pinyin-simp gksu inkscape"

for pkg in $packages; do
    # check if the package is already installed
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        print_info "$pkg is already installed"
    else
        # setup repositories

        # numix theme
        if [ $pkg == "numix-gtk-theme" ]; then
            sudo add-apt-repository ppa:numix/ppa
            sudo apt-get update
        fi 

        # google chrome
        if [ $pkg == "google-chrome-stable" ]; then
            wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
            sudo apt-get update
        fi

        if sudo apt-get -qq install $pkg; then
            print_info "$pkg is successfully installed"
        else
            print_info "error installing $pkg"
        fi
    fi
done

# get rid of internal errors
sudo apt-get purge --auto-remove apport

# setup rime
if [ -d "$HOME/.config/ibus/rime" ]; then
    ln -sfv "$DOTFILES/conf/rime.default.custom.yaml" "$HOME/.config/ibus/rime/default.custom.yaml"
    ln -sfv "$DOTFILES/conf/rime.wubi98.dict.yaml" "$HOME/.config/ibus/rime/wubi98.dict.yaml"
    ln -sfv "$DOTFILES/conf/rime.wubi98.schema.yaml" "$HOME/.config/ibus/rime/wubi98.schema.yaml"
fi

# install fonts
source $HOME/.dotfiles/install/ubuntu_fonts.sh
