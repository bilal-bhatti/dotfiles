#!/bin/sh

echo "Setting up your Mac..."

# Make ZSH the default shell environment
#chsh -s $(which zsh)

# Clean up old files, should really back them up
rm -rf ~/.vimrc ~/.vim ~/.config/fish ~/.config/fisherman

# Create directories sans files, and then create symlinks for files
find .config .vim -type d -exec mkdir -p -- ~/{} \;
find .config .vim -type f -exec ln -s -- ~/.dotfiles/{} ~/{} \;

ln -s ~/.dotfiles/.vimrc ~/.vimrc

# Install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

# Install plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

