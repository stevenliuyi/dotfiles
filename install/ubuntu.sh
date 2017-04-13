#!/bin/bash

# update apt
sudo apt-get update

# install packages
packages = "awscli build-essential curl python-pip"

for pkg in $packages; do
    # check if the package is already installed
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        echo "$pkg is already installed"
    else
        if sudo apt-get -qq install $pkg; then
            echo "$pkg is successfully installed"
        else
            echo "error installing $pkg"
        fi
    fi
done
