set nocompatible
filetype indent plugin on
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
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
set showbreak=↪
set nolinebreak

" Clipboard support requires xclip to be installed on the system
" sudo pacman -S xclip
set clipboard=unnamedplus

call plug#begin()

" Plug 'airblade/vim-gitgutter'
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'sonph/onehalf', { 'rtp': 'vim' }
"Plug 'rakr/vim-one', { 'as': 'vimone' }
"Plug 'drewtempelmeyer/palenight.vim', { 'as': 'palenight' }
Plug 'mhartington/oceanic-next'
Plug 'arcticicestudio/nord-vim'
Plug 'rose-pine/neovim'
Plug 'navarasu/onedark.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'EdenEast/nightfox.nvim'
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
Plug 'scalameta/nvim-metals'

Plug 'lewis6991/gitsigns.nvim'

" Should be the last plugin to load
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

lua << EOF

require('gitsigns').setup()

require'lualine'.setup()

require'lspconfig'.clangd.setup{}

require'lspconfig'.rust_analyzer.setup{}

require'lspconfig'.kotlin_language_server.setup{}

require'lspconfig'.pylsp.setup{}

require'lspconfig'.hls.setup{}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

local lsp_opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>do', '<cmd>lua vim.diagnostic.open_float()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', lsp_opts)

local lsp_on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>hs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>sh', '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_opts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pylsp', 'kotlin_language_server', 'hls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_on_attach,
    capabilities = capabilities,
  }
end

local metals_conf = require('metals').bare_config()

metals_conf.settings = {
    showImplicitArguments = true
}

metals_conf.on_attach = lsp_on_attach
metals_conf.capabilities = capabilities
metals_conf.init_options.statusBarProvider = "on"

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_conf)
  end,
  group = nvim_metals_group,
})

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
  ensure_installed = { "c", "cpp", "rust", "java", "kotlin", "scala" },

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

require('rose-pine').setup({
    disable_italics = true
})

-- require'shade'.setup({
--   overlay_opacity = 50,
--   opacity_step = 1,
--   keys = {
--     brightness_up    = '<C-Up>',
--     brightness_down  = '<C-Down>',
--     toggle           = '<Leader>s',
--   }
-- })

require('neo-tree').setup({
    close_if_last_window = true,
    filesystem = {
        hide_dotfiles = false,
    },
    never_show = {
        '.git',
        'venv',
    }
})
EOF

au VimLeave * set guicursor=a:ver25

let g:rainbow_active=1

set signcolumn=yes
set completeopt-=preview

let g:material_style="darker"
let g:rose_pine_variant='moon'

set termguicolors

let ayucolor='mirage'
"colorscheme ayu
"colors material
colors onedark
" colors carbonfox

"colorscheme rose-pine
"colors nightfox

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
nnoremap <leader>fa <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

nnoremap <leader>tt :TagbarToggle<CR>

