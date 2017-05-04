#!/bin/bash

mkdir -p fonts
cd fonts

# check if Noto Serif CJK fonts are already intalled
if [ -f /usr/share/fonts/opentype/noto/NotoSerifCJK-ExtraLight.ttc ]; then
    print_info "Noto Serif CJK fonts are already installed"
else
    # download Noto Serif CJK fonts
    weights="ExtraLight Light Regular Medium SemiBold Bold Black"
    for weight in $weights; do
        wget "https://noto-website.storage.googleapis.com/pkgs/NotoSerifCJK-${weight}.ttc.zip"
        unzip -o "NotoSerifCJK-${weight}.ttc.zip"
    done
    
    # install Noto fonts for single user
    # mkdir -p ~/.fonts
    # cp *ttc ~/.fonts
    # fc-cache -f -v
    
    # install Noto fonts for all users
    sudo mkdir -p /usr/share/fonts/opentype/noto
    sudo cp ./*ttc /usr/share/fonts/opentype/noto
    sudo chmod a+r /usr/share/fonts/opentype/noto/*.ttc
    sudo fc-cache -f -v
    
    # clean up
    cd ..
    rm -rf fonts
    print_info "Noto SerifCJK fonts are installed"
fi

mkdir -p ~/.config/fontconfig/conf.d
ln -sfv "$HOME/.dotfiles/conf/font.64-language-selector-prefer.conf" "$HOME/.config/fontconfig/conf.d/64-language-selector-prefer.conf"
