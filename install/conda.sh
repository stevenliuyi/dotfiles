#!/bin/bash

# check if anaconda exists, install if not
if test ! $(which conda); then
    mkdir -p downloads
    cd downloads
    # download anaconda installer based on os
    print_info "downloading Anaconda..."
    if is_macos; then
        wget "https://repo.continuum.io/archive/Anaconda3-4.3.1-MacOSX-x86_64.sh" -O "Anaconda3-4.3.1.sh"
    fi
    if is_ubuntu; then
        wget "https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh" -O "Anaconda3-4.3.1.sh"
    fi
    # install
    print_info "installing Anaconda..."
    bash "Anaconda3-4.3.1.sh" -b

    # clear up
    cd $DOTFILES
    rm -rf downloads
else
    print_info "Anaconda is already installed"
fi

# upgrade
print_info "upgrading Anaconda..."
conda upgrade -y --all

# add conda-forge to channels
conda config --add channels conda-forge

# install packages
conda install -y bcolz
conda install tensorflow

# check if the environment exists
ENV=$(head -n 1 $DOTFILES/install/conda_environment.yml | cut -f2 -d ' ')
source activate $ENV
if [ $? -eq 0 ]; then
    print_info "environment $ENV already exists"
else
    # create environment from file
    print_info "environment $ENV does not exists, starting creating..."
    conda env create -f $DOTFILES/install/conda_environment.yml
fi
