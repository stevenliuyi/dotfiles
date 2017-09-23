# dotfile directory
export DOTFILES=~/.dotfiles

# source all files in 'source' folder
for file in `find $DOTFILES/source/bash`; do
    [ -f "$file" ] && source "$file"
done
