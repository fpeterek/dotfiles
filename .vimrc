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

call plug#begin()

Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'airblade/vim-gitgutter'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --java-completer --rust-completer' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'rakr/vim-one', { 'as': 'vimone' }
Plug 'drewtempelmeyer/palenight.vim', { 'as': 'palenight' }
Plug 'mhartington/oceanic-next'
Plug 'arcticicestudio/nord-vim'

call plug#end()

"colorscheme dracula
"colorscheme onehalfdark
"colorscheme one
"colorscheme palenight
colorscheme OceanicNext
"colorscheme nord

set background=dark

