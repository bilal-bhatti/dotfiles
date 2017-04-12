if &shell =~# 'fish$'
  set shell=sh
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes for comment

Plug 'dag/vim-fish'

" Add plugins to &runtimepath
call plug#end()

syntax enable
set background=dark
colorscheme solarized

filetype plugin indent on
set nofoldenable

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

