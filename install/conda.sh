#!/bin/bash

# check if anaconda exists, install if not
if test ! "$(which conda)"; then
    mkdir -p downloads
    cd downloads
    # download anaconda installer based on os
    print_info "downloading Anaconda..."
    if is_macos; then
        wget "https://repo.continuum.io/archive/Anaconda3-5.0.0-MacOSX-x86_64.sh" -O "Anaconda3-5.0.0.sh"
    fi
    if is_ubuntu; then
        wget "https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh" -O "Anaconda3-5.0.0.sh"
    fi
    # install
    print_info "installing Anaconda..."
    bash "Anaconda3-5.0.0.sh" -b

    # clear up
    cd "$DOTFILES"
    rm -rf downloads

    if [ -d "$HOME/anaconda3/bin" ]; then
        # add to path so command conda can be found
        export PATH=$HOME/anaconda3/bin:$PATH
    fi
else
    print_info "Anaconda is already installed"
fi

# upgrade
print_info "upgrading Anaconda..."
conda upgrade -y --all

# add conda-forge to channels
conda config --add channels conda-forge

# install packages
packages="bcolz tensorflow twine yapf pygments"
for package in $packages; do
    conda install -y "$package"
done

# check if the environment exists
ENV=$(head -n 1 "$DOTFILES/conda/py3.yml" | cut -f2 -d ' ')
source activate "$ENV"
if [ $? -eq 0 ]; then
    print_info "environment $ENV already exists"
else
    # create environment from file
    print_info "environment $ENV does not exists, starting creating..."
    conda env create -f "$DOTFILES/conda/py3.yml"
fi

ENV=$(head -n 1 "$DOTFILES/conda/py2.yml" | cut -f2 -d ' ')
source activate "$ENV"
if [ $? -eq 0 ]; then
    print_info "environment $ENV already exists"
else
    # create environment from file
    print_info "environment $ENV does not exists, starting creating..."
    conda env create -f "$DOTFILES/conda/py2.yml"
fi
