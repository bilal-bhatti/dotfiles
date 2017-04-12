#!/bin/sh

echo "Setting up your Mac..."

# Remove junk files
find ./ -name ".DS_Store" -depth -exec rm {} \;

stow home --no-folding

# Install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

# Install plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

