#!/bin/bash

# update apt
print_info "updating apt..."
sudo apt-get update

# install packages
packages="awscli binutils build-essential cmake curl gcc g++ make software-properties-common tmux p7zip p7zip-rar python-pip zsh"

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
