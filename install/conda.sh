#!/bin/bash

# check if anaconda exists, install if not
if test ! $(which conda); then
    mkdir downloads
    cd downloads
    # download anaconda installer based on os
    if is_macos; then
        wget "https://repo.continuum.io/archive/Anaconda3-4.3.1-MacOSX-x86_64.sh" -O "Anaconda3-4.3.1.sh"
    fi
    if is_ubuntu; then
        wget "https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh" -O "Anaconda3-4.3.1.sh"
    fi
    # install
    bash "Anaconda3-4.3.1.sh" -b

    cd $DOTFILES
fi

# upgrade
conda upgrade -y --all

# check if the environment exists
ENV=$(head -n 1 $DOTFILES/install/conda_environment.yml | cut -f2 -d ' ')
source activate $ENV
if [ $? -eq 0 ]; then
    echo "environment $ENV already exists"
else
    # create environment from file
    echo "environment $ENV does not exists"
    conda env create -f $DOTFILES/install/conda_environment.yml
fi
