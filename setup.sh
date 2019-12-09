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
zsh-history-substring-search \
golangci/tap/golangci-lint

brew tap homebrew/cask-fonts && brew cask install font-source-code-pro font-source-code-pro-for-powerline

echo "Setting up symlinks..."

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Remove junk files
find ./ -name ".DS_Store" -depth -exec rm {} \;

stow home --no-folding

# Install neovim plugins
nvim +PlugInstall

