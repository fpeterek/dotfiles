vim.opt.compatible = false
vim.opt.backspace = "indent,eol,start"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
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
vim.opt.background = "dark"
vim.opt.colorcolumn = '100'
vim.opt.wrap = false

vim.opt.completeopt = "fuzzy,menuone,noselect,popup"

vim.opt.pumheight = 7

vim.g.python_indent = {
    open_paren = 'shiftwidth()',
    continue = 'shiftwidth() * 2',
    closed_paren_align_last_line = false,
}


vim.cmd("au VimLeave * set guicursor=a:ver25")

ts_config = function()
    require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = {
            "c", "cpp", "rust", "java", "kotlin", "scala", "python", "lua", "vim", "bash",
            "regex", "markdown", "markdown_inline", "haskell",
        },

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

cmp_nvim_lsp_config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local servers = { 'clangd', 'rust_analyzer', 'pylsp', 'kotlin_language_server', 'hls' }

    for _, lsp in ipairs(servers) do
      vim.lsp.config(lsp, {
        capabilities = capabilities,
      })
    end
end

nvim_cmp_config = function()
    local cmp = require('cmp')

    cmp.setup {

      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      }),
      sources = {
        { name = 'nvim_lsp' },
        -- { name = 'buffer' },
        -- { name = 'path' },
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
    metals_conf.capabilities = capabilities

    metals_conf.on_attach = lsp_on_attach
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
    conf = require('lualine-conf')
    require('lualine').setup(conf)
end

ibl_config = function()
    require('ibl').setup({
        indent = {
            char = '▏'
        },
        scope = {
            enabled = false
        }
    })
end

todo_config = function()
    require('todo-comments').setup()
end

notify_config = function()
    require('notify').setup({
        stages = 'static'
    })
    vim.notify = require('notify')
end

noice_config = function()
    require("noice").setup({
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },

        cmdline = {
            enable = true,
            view = "cmdline",
        },

        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        },

        messages = {
            enabled = true,
            view = "mini",
            view_error = "mini",
            view_warn = "mini",
        },

        views = {
            -- cmdline_popup = {
            --     position = {
            --         row = "45%",
            --         col = "50%",
            --     },
            --     size = {
            --         width = 60,
            --         height = "auto",
            --     },
            -- },
            popupmenu = {
                relative = "editor",
                position = {
                    row = "55%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = {
                        Normal = "Normal",
                        FloatBorder = "DiagnosticInfo"
                    },
                },
            },
        },
    })
end

trouble_config = function()
    require('trouble').setup()
end

surfers_config = function()
    require('nvim-surfers').setup({
        use_tmux = true,
    })
end

gitsigns_config = function()
    require('gitsigns').setup()
end

lsp_lines_config = function()
    vim.diagnostic.config({ 
        virtual_text = true,
        virtual_lines = {
            only_current_line = true,
            highlight_whole_line = false,
        },
    })
    require('lsp_lines').setup({
    })
end

colorizer_config = function()
    require('colorizer').setup()
end
