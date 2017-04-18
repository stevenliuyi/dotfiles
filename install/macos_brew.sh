#!/bin/bash

# check if Hombrew exist, install if not
if test ! $(which brew); then
    print_info "Homebrew doesn't exist, start downloading and installing..." 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    print_info "Homebrew already exists"
fi

# update
print_info "updating Homebrew and exisiting packages..."
brew update
brew upgrade

# install
print_info "installing packages through Homebrew..."
apps=(awscli brew-cask cmake ffmpeg git p7zip tmux tmux-mem-cpu-load wget)
brew install "${apps[@]}"

print_info "installing apps through Homebrew Cask..."
cask_apps=(mactex)
brew cask install "${cask_apps[@]}"
