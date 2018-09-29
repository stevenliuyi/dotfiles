#!/bin/bash

# check if yarn exists, install if not
if test ! "$(which yarn)"; then
    print_info "installing npm..."
    curl -o- -L https://yarnpkg.com/install.sh | bash
else
    print_info "yarn is already installed"
fi

# install yarn packages
packages="create-react-app n heroku-cli create-react-native-app eslint wikidata-cli hexo-cli nodemon ngrok source-map-explorer"
for package in $packages; do
    yarn global add "$package"
done
