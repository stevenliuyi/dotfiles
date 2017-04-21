#!/bin/bash

# update apt
print_info "updating apt..."
sudo apt-get update

# install packages
packages="awscli binutils build-essential cmake curl gcc g++ make software-properties-common texlive tmux p7zip p7zip-rar python-pip zsh vim autojump google-chrome-stable r-base r-base-dev gdebi-core nautilus-dropbox"

for pkg in $packages; do
    # check if the package is already installed
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        print_info "$pkg is already installed"
    else
        # setup repositories

        # google chrome
        if [ $pkg == "google-chrome-stable" ]; then
            wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
            sudo apt-get update
        fi

        # r
        if [ $pkg == "r-base" ]; then
            ubuntu_codename=$(lsb_release -c)
            sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu ${ubuntu_codename}/" >> /etc/apt/sources.list'
            sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
            sudo apt-get update
        fi

        if sudo apt-get -qq install $pkg; then
            print_info "$pkg is successfully installed"
        else
            print_info "error installing $pkg"
        fi
    fi
done
