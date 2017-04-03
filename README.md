## Vim Configuration

This is my personal vim configuration. It can be installed by following the steps below.

* Clone the repository in the home directory.
```
$ git clone https://github.com/stevenliuyi/vimrc/ ~/.vim
```

* Create a symlink to the vimrc file.
```
$ ln -fs ~/.vim/vimrc ~/.vimrc
```

* Set up [Vundle](https://github.com/VundleVim/Vundle.vim) for plugin management.
```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

* Install plugins:
```
$ vim +PluginInstall +qall
```
