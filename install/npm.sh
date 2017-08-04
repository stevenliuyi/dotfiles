#!/bin/bash

# check if npm exists, install if not
if test ! "$(which npm)"; then
    print_info "installing npm..."
    curl -L https://www.npmjs.com/install.sh | sh
else
    print_info "npm is already installed"
fi

# install npm packages
packages="create-react-app prop-types escape-string-regexp sort-by react-router-dom form-serialize"
for package in $packages; do
    npm install -g "$packages"
done
