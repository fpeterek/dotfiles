vim.opt.compatible = false
vim.opt.backspace = "indent,eol,start"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmenu = true
vim.opt.ruler = true
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.scrolloff = 4
vim.opt.smartcase = true
vim.opt.showbreak = "↪"
vim.opt.title = true
vim.opt.titlestring = "nvim - %t"
vim.opt.errorbells = false
vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.foldcolumn = "1"
vim.opt.linebreak = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.showmatch = false
vim.opt.signcolumn = "yes:3"
vim.opt.completeopt = "menu"
vim.opt.background = "dark"

vim.cmd("au VimLeave * set guicursor=a:ver25")

ts_config = function()
    require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "cpp", "rust", "java", "kotlin", "scala", "python" },

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
        },
    }
end

neotree_config = function()
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
end

nvim_lspconfig_config = function()
    require('lspconfig').clangd.setup { }
    require('lspconfig').rust_analyzer.setup { }
    require('lspconfig').kotlin_language_server.setup { }

    require('lspconfig').pylsp.setup {
        settings = {
            pylsp = {
                plugins = {
                    autopep8 = { enabled = false },
                    pycodestyle = { enabled = false },
                    mccabe = { enabled = false },
                    pyflakes = { enabled = false },
                    flake8 = { enabled = true },
                    preload = { enabled = false },
                    yapf = { enabled = true }
                },
                configurationSources = { 'flake8' }
            }
        }
    }

    require('lspconfig').hls.setup { }
end

cmp_nvim_lsp_config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    local servers = { 'clangd', 'rust_analyzer', 'pylsp', 'kotlin_language_server', 'hls' }
    local lspconfig = require('lspconfig')
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = lsp_on_attach,
        capabilities = capabilities,
      }
    end
end

nvim_cmp_config = function()
    local cmp = require('cmp')

    cmp.setup {
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
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
        { name = 'buffer' },
        { name = 'path' },
      },
    }
end

metals_config = function()
    local metals_conf = require('metals').bare_config()

    metals_conf.settings = {
        showImplicitArguments = true
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
end

rainbow_config = function()
    local rainbow_delimiters = require('rainbow-delimiters')

    vim.g.rainbow_delimiters = {
        strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    }
end

lualine_config = function()
    require('lualine').setup()
end

comment_config = function()
    require('Comment').setup()
end

fterm_config = function()
    require('FTerm').setup({
        dimensions = {
            height = 0.9,
            width = 0.9,
        }
    })
end
