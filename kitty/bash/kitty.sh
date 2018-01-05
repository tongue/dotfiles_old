#!/usr/bin/env bash

if [ $# -eq 0 ]
then
	exec python3 ~/projects/applications/kitty --config ~/dotfiles/kitty/kitty.conf
else
	exec python3 ~/projects/applications/kitty --config ~/dotfiles/kitty/kitty.conf --session ~/dotfiles/kitty/sessions/$1
fi
