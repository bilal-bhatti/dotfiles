if &shell =~# 'fish$'
  set shell=sh
endif

set path+=**

" set , as <leader>
let mapleader=","

" map : to ;
nnoremap ; :
syntax enable
set background=dark
colorscheme solarized
filetype plugin indent on
set nofoldenable
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set number
"set hlsearch
set mouse=a
set wildmenu

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes for comment
Plug 'dag/vim-fish'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'Valloric/YouCompleteMe'
Plug 'editorconfig/editorconfig-vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'roman/golden-ratio'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'dhruvasagar/vim-vinegar'
Plug 'junegunn/rainbow_parentheses.vim'

" Add plugins to &runtimepath
call plug#end()

" CtrlP settings
let g:ctrlp_cmd='CtrlP :pwd'
let g:ctrlp_dotfiles = 1
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" ack.vim settings
let g:ack_working_path_mode="r"
let g:ackprg = 'ag --vimgrep'

" NERDTree settings
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" map JsBeautify to ctl+f
map <c-f> :call JsBeautify()<cr>

" set mappings for YouCompleteMe commands
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>

" configure netrw
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" Map pane navigation 
noremap <C-k> <C-W>k<C-W>_
noremap <C-j> <C-W>j<C-W>_
noremap <C-l> <C-W>l<C-W>_
noremap <C-h> <C-W>h<C-W>_

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Highlight current line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" RainbowParentheses settings
augroup rainbow_lisp
  autocmd!
  autocmd FileType js,lisp,clojure,scheme RainbowParentheses
augroup END

