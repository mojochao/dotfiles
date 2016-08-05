#!/usr/bin/env bash
dotfiles=(
    ".gitconfig"
    ".gitignore"
    ".tmux.conf"
)
for dotfile in "${dotfiles[@]}"; do
    if [ ! -f $HOME/$dotfile ]; then
	echo installing $dotfile
	ln -fs $PWD/$dotfile $HOME/$dotfile
    fi
done
