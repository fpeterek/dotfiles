set nocompatible
filetype indent plugin on
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number
set relativenumber
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
set titlestring=nvim\ -\ %t
set noerrorbells
set mouse=a
set encoding=UTF-8
set nohlsearch
set incsearch
set cursorline
set foldcolumn=1

" Clipboard support requires xclip to be installed on the system
" sudo pacman -S xclip
set clipboard=unnamedplus

call plug#begin()

"Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'airblade/vim-gitgutter'
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --java-completer --rust-completer --clangd-completer' }
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'sonph/onehalf', { 'rtp': 'vim' }
"Plug 'rakr/vim-one', { 'as': 'vimone' }
"Plug 'drewtempelmeyer/palenight.vim', { 'as': 'palenight' }
Plug 'mhartington/oceanic-next'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'frazrepo/vim-rainbow'

Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'preservim/tagbar'
Plug 'farmergreg/vim-lastplace'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sunjon/shade.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Should be the last plugin to load
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

lua << EOF

require'lualine'.setup()

require'lspconfig'.clangd.setup{}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- nvim-cmp setup
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  },
}

-- Treesitter

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indentation = {
    enable = true
  }
}

EOF

au VimLeave * set guicursor=a:ver25

let g:rainbow_active=1

set signcolumn=yes
set completeopt-=preview

set termguicolors
let ayucolor='mirage'
colorscheme ayu

set background=dark

let mapleader="\<Space>"

noremap <Leader>c :set invcursorline<CR>

noremap <Leader>nt :NeoTreeShowToggle<CR>

" Remap <C-l> so I can use the combination elsewhere
noremap <C-s> <C-l>

" h, j, k are unused, l has been rebound
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <C-n> :vertical res -5<CR>
nnoremap <C-p> :vertical res +5<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

nnoremap <leader>tt :TagbarToggle<CR>

