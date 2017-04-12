if &shell =~# 'fish$'
  set shell=sh
endif

set path+=**

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes for comment
Plug 'dag/vim-fish'
Plug 'kien/ctrlp.vim'

" Add plugins to &runtimepath
call plug#end()

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

syntax enable
set background=dark
colorscheme solarized

filetype plugin indent on
set nofoldenable

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set number
set hlsearch
set mouse=a
set wildmenu
