#!/usr/bin/env bash
dotfiles=(
    ".aliases"
    ".environment"
    ".gitattributes"
    ".gitconfig"
    ".gitignore"
    ".spacemacs"
    ".tmux.conf"
    ".vimrc"
    ".lein/profiles.clj"
)
for dotfile in "src/${dotfiles[@]}"; do
    if [ ! -f $HOME/$dotfile ]; then
	echo installing $dotfile
	ln -fs $PWD/$dotfile $HOME/$dotfile
    fi
done
