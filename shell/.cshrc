# dotfile directory
setenv DOTFILES ~/.dotfiles

# source all files in 'source' folder
foreach file (`find $DOTFILES/source/csh`)
    if (-f $file) then
        source $file
    endif
end
