#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
#brew update

# Install all our dependencies with bundle (See Brewfile)
#brew tap homebrew/bundle
#brew bundle

# Make ZSH the default shell environment
#chsh -s $(which zsh)

# Clean up old files, should really back them up
rm -rf ~/.vimrc ~/.nvm ~/.vim ~/.config/fish ~/.config/fisherman

# Create directories sans files, and then create symlinks for files
find .config .vim -type d -exec mkdir -p -- ~/{} \;
find .config .vim -type f -exec ln -s -- ~/.dotfiles/{} ~/{} \;

ln -s ~/.dotfiles/.vimrc ~/.vimrc

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

# Install fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

# Install plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set macOS preferences
# We will run this last because this will reload the shell
#source .macos
