#!/bin/sh

echo "Update brew forumulas..."
brew update

# Install all our dependencies with bundle (See Brewfile)
brew install awscli \
cmake \
ctags \
dep \
direnv \
docker-credential-helper-ecr \
fnm \
fswatch \
fzf \
git \
golang \
highlight \
httpie \
neovim \
ranger \
scmpuff \
stow \
thefuck \
tree \
wget \
z \
zplug \
zsh-history-substring-search

brew tap homebrew/cask-fonts && brew cask install font-source-code-pro font-source-code-pro-for-powerline

echo "Setting up symlinks..."

# Remove junk files
find ./ -name ".DS_Store" -depth -exec rm {} \;

stow home --no-folding
