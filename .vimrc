set nocompatible
filetype indent plugin on
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number
set wildmenu
syntax on
set ruler
set showmode
set showcmd
set scrolloff=4
set ignorecase
set smartcase
set smartindent
set showbreak=+
set title
set titlestring=vim\ -\ %t
set noerrorbells
set mouse=a
set encoding=UTF-8

" Requires Vim compiled with clipboard support enabled
" On Arch, that means installing gvim, not vim, using pacman
set clipboard=unnamedplus

call plug#begin()

Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'airblade/vim-gitgutter'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --java-completer --rust-completer --clangd-completer' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'rakr/vim-one', { 'as': 'vimone' }
Plug 'drewtempelmeyer/palenight.vim', { 'as': 'palenight' }
Plug 'mhartington/oceanic-next'
Plug 'arcticicestudio/nord-vim'
Plug 'frazrepo/vim-rainbow'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'

" Should be the last plugin to load
Plug 'ryanoasis/vim-devicons'

call plug#end()

let g:rainbow_active=1
let g:airline_theme='oceanicnext'

set completeopt-=preview

"colorscheme dracula
"colorscheme onehalfdark
"colorscheme one
"colorscheme palenight
colorscheme OceanicNext
"colorscheme nord

set background=dark

let mapleader="\<Space>"

noremap <Leader>c :set invcursorline<CR>

" Remap <C-l> so I can use the combination elsewhere
noremap <C-s> <C-l>

" h, j, k are unused, l has been rebound
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <C-n> :vertical res -5<CR>
nnoremap <C-p> :vertical res +5<CR>

noremap <Leader>tt :TagbarToggle<CR>
noremap <Leader>nt :NERDTreeToggle<CR>

