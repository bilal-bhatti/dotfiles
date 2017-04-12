set -gx NVM_DIR $HOME/.nvm

set -gx GOPATH $HOME/Projects/Go
set -gx GOBIN $GOPATH/bin

set -gx PATH /usr/local/opt/coreutils/bin $GOBIN $PATH

function fish_user_key_bindings
  bind \e\e 'thefuck-command-line'  # Bind EscEsc to thefuck
end

# setup dircolors for ls, requires coreutils installed
# brew install coreutils
set -l colorfile ~/.dotfiles/dircolors-solarized/dircolors.ansi-dark 

set -gx LS_COLORS (/usr/local/opt/coreutils/bin/gdircolors -c $colorfile | string split ' ')[3]

# The value should always be quoted but be conservative and check first.
if string match -qr '^([\'"]).*\1$' -- $LS_COLORS
  set LS_COLORS (string match -r '^.(.*).$' $LS_COLORS)[2]
end

alias ls '/usr/local/opt/coreutils/bin/gls --color=auto'

set pure_symbol_prompt "~>"

~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
