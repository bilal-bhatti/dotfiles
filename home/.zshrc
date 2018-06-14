# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install

fpath=(/usr/local/share/zsh-completions $fpath)

export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/opt/python2/bin:$PATH

# begin: zplug - Z Shell plugins using zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "lukechilds/zsh-nvm"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:"pure.zsh", from:github, as:theme
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-history-substring-search", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:2
zplug "joel-porquet/zsh-dircolors-solarized", hook-load:"setupsolarized dircolors.ansi-universal"
zplug "ndbroadbent/scm_breeze", hook-build:"$ZPLUG_HOME/repos/ndbroadbent/scm_breeze/install.sh"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_FUZZY=fuzzy_words

[ -s ~/.scm_breeze/scm_breeze.sh ] && source ~/.scm_breeze/scm_breeze.sh
# end: zplug

eval "$(fasd --init auto)"
alias ls='ls --color'

if [ -d "/usr/local/android-tools" ] ; then
     export PATH="/usr/local/android-tools:$PATH"
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/bilal/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/bilal/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/bilal/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/bilal/.nvm/versions/node/v6.10.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

