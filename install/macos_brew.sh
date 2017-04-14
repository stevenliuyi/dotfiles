#!/bin/bash

# check if Hombrew exist, install if not
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# update
brew update
brew upgrade

apps=(awscli cmake ffmpeg git wget)
brew install "${apps[@]}"
