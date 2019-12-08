#!/bin/sh

echo "Setting up Homebrew..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew install stow \
zplug \
git \
wget \
thefuck \
fswatch \
golang \
dep \
awscli \
tree \
cmake \
ctags \
httpie \
scmpuff \
fzf \
z \
fnm \
direnv \
neovim \
zsh-history-substring-search \
docker-credential-helper-ecr \
highlight \
ranger

brew tap homebrew/cask-fonts && brew cask install font-source-code-pro font-source-code-pro-for-powerline

echo "Setting up your Mac..."

# Remove junk files
find ./ -name ".DS_Store" -depth -exec rm {} \;

stow home --no-folding
