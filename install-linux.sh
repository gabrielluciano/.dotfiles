#!/usr/bin/bash

directories=("tmux" "nvim" "zsh" "alacritty")

for d in "${directories[@]}"; do
    echo "stow $d"
    stow -D $d
    stow $d
done

