#!/usr/bin/env bash
dotfiles=(
    ".environment"
    ".gitattributes"
    ".gitconfig"
    ".gitignore"
    ".spacemacs"
    ".tmux.conf"
    ".vimrc"
)
for dotfile in "${dotfiles[@]}"; do
    if [ ! -f $HOME/$dotfile ]; then
	echo installing $dotfile
	ln -fs $PWD/$dotfile $HOME/$dotfile
    fi
done
