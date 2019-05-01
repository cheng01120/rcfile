set ai
set nu
set ts=2
set sw=2
set incsearch
set hls
set smartindent
set showmatch
set nocompatible
" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

set nobackup
set nocp incsearch
set formatoptions=tcqr
set hlsearch
set smartcase
set ic
set confirm
set showcmd
set ruler
set restorescreen
set wildmode=longest,full
set km=startsel
set slm=mouse,key
"
" John Dierdorf changes to function keys
"
map <f4> :wq
"map <f3> :q
"map <F4> :x
"map <F5> gq}
"imap <f2>map <f3>map <F4>   

"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
set wmh=0

execute pathogen#infect()
syntax on
filetype plugin indent on
:highlight Comment ctermfg=lightblue
:hi Directory gui=italic,bold guifg=Yellow guibg=Blue
set clipboard=unnamedplus
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
