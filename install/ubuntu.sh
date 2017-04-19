#!/bin/bash

# setup google chrome repo
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# update apt
print_info "updating apt..."
sudo apt-get update


# install packages
packages="awscli binutils build-essential cmake curl gcc g++ make software-properties-common texlive tmux p7zip p7zip-rar python-pip zsh vim autojump google-chrome-stable"

for pkg in $packages; do
    # check if the package is already installed
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        print_info "$pkg is already installed"
    else
        if sudo apt-get -qq install $pkg; then
            print_info "$pkg is successfully installed"
        else
            print_info "error installing $pkg"
        fi
    fi
done
