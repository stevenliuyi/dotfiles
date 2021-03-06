#!/bin/bash

# check if Hombrew exist, install if not
if test ! "$(which brew)"; then
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

brew tap jzelinskie/duckdns

apps=(autojump awscli cmake ffmpeg git p7zip tmux tmux-mem-cpu-load wget R unrar shellcheck htop trash the_silver_searcher node mpich yarn watchman octave gpg git-crypt duckdns charmbracelet/homebrew-tap/glow)
brew install "${apps[@]}"

print_info "installing apps through Homebrew Cask..."
cask_apps=(iterm2 insomniax google-chrome mactex rstudio macvim xquartz java android-sdk virtualbox genymotion google-cloud-sdk osxfuse)
brew cask install "${cask_apps[@]}"

# gradle is dependent on java
brew install gradle 

# sshfs is dependent on osxfuse
brew install sshfs

# clean up
brew cleanup
