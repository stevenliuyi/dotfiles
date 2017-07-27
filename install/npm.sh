#!/bin/bash

# check if npm exists, install if not
if test ! "$(which npm)"; then
    print_info "installing npm..."
    curl -L https://www.npmjs.com/install.sh | sh
else
    print_info "npm is already installed"
fi

# install npm packages
packages="create-react-app"
for package in $packages; do
    npm install -g "$packages"
done
