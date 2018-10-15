#!/bin/bash

# update apt
print_info "updating apt..."
sudo apt-get update

# install packages
packages="awscli binutils build-essential cmake curl gcc g++ make software-properties-common texlive texlive-generic-extra texlive-latex-extra tmux p7zip p7zip-rar python-pip zsh vim autojump r-base r-base-dev gdebi-core unrar shellcheck htop trash-cli silversearcher-ag nodejs mpich yarn octave oracle-java8-set-default android-sdk virtualbox gnupg git-crypt google-cloud-sdk openssh-server sshfs"

for pkg in $packages; do
    # check if the package is already installed
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        print_info "$pkg is already installed"
    else
        # setup repositories

        # r
        if [ "$pkg" == "r-base" ]; then
            ubuntu_codename=$(lsb_release -c|cut -f2)
            sudo sh -c "echo \"deb http://cran.rstudio.com/bin/linux/ubuntu ${ubuntu_codename}/\" >> /etc/apt/sources.list"
            sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
            sudo apt-get update
        fi

        # yarn
        if [ "$pkg" == "yarn" ]; then
            curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
            echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
            sudo apt-get update
        fi

        # JDK
        if [ "$pkg" == "oracle-java8-set-default" ]; then
            sudo add-apt-repository ppa:webupd8team/java
            sudo apt-get update
        fi

        # Google Cloud
        if [ "$pkg" == "google-cloud-sdk" ]; then
            # Create an environment variable for the correct distribution
            export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
            # Add the Cloud SDK distribution URI as a package source
            echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
            # Import the Google Cloud Platform public key
            curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
            sudo apt-get update
        fi

        if sudo apt-get -qq install "$pkg"; then
            print_info "$pkg is successfully installed"
        else
            print_info "error installing $pkg"
        fi
    fi
done
