source ~/.antigen-repo/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle osx
antigen bundle common-aliases
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme bureau

# Tell Antigen that you're done.
antigen apply

export NVM_DIR="$HOME/.nvm"

export GOPATH=/Volumes/TerraDrive/Users/bilal/Projects/Go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

# get some colors using dircolors
export PATH="/usr/local/opt/coreutils/bin:$PATH"
eval `gdircolors ~/.dircolors/dircolors.ansi-dark-custom`
alias ls='gls --color=auto'

