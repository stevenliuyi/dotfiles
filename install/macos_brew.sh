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
brew tap homebrew/science

print_info "installing packages through Homebrew..."
apps=(autojump awscli cmake ffmpeg git p7zip tmux tmux-mem-cpu-load wget R unrar shellcheck htop trash the_silver_searcher node mpich yarn watchman gradle octave gpg git-crypt)
brew install "${apps[@]}"

print_info "installing apps through Homebrew Cask..."
cask_apps=(iterm2 caffeine google-chrome mactex rstudio macvim xquartz java android-sdk virtualbox genymotion)
brew cask install "${cask_apps[@]}"

# clean up
brew cleanup
brew cask cleanup
