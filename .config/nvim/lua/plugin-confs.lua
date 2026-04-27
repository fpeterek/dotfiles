ts_config = function()
    ts = require('nvim-treesitter')

    ts.install {
        "asm", "nasm",

        "c", "cpp", "rust", "zig",
        "cmake", "printf",

        "java", "kotlin", "scala", "clojure", "swift",

        "python", "lua",

        "vim",

        "bash", "awk", "dockerfile",

        "regex",

        "haskell",

        "yaml",

        "markdown", "markdown_inline",
        "latex", "bibtex"
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
        },
        source_selector = {
            winbar = true,
        },
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols"
        }
    })
end

cmp_nvim_lsp_config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local servers = {
        'clangd', 'rust_analyzer', 'pylsp', 'kotlin_language_server',
        'hls', 'sourcekit'
    }

    for _, lsp in ipairs(servers) do
      vim.lsp.config(lsp, {
        capabilities = capabilities,
      })
    end
end

nvim_cmp_config = function()
    local cmp = require('cmp')

    cmp.setup {
        formatting = {
            format = function(entry, vim_item)
                local highlights_info = require("colorful-menu").cmp_highlights(entry)

                -- highlight_info is nil means we are missing the ts parser, it's
                -- better to fallback to use default `vim_item.abbr`. What this plugin
                -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                if highlights_info ~= nil then
                    vim_item.abbr_hl_group = highlights_info.highlights
                    vim_item.abbr = highlights_info.text
                end

                return vim_item
            end,
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.recently_used,
                require("clangd_extensions.cmp_scores"),
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },

        mapping = cmp.mapping.preset.insert({
            -- ['<C-Space>'] = cmp.mapping.complete(),
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
            enabled = false,
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

tiny_inline_diagnostic_config = function()
    vim.diagnostic.config({ 
        virtual_text = false,
    })
    require('tiny-inline-diagnostic').setup({
        signs = {
            diag = 'ඞ',
        },
        options = {
            add_messages = {
                display_count = true,
            },
            multilines = {
                enabled = true,
            },
        },
    })
end

colorizer_config = function()
    require('colorizer').setup()
end

telescope_config = function()
    local telescope = require('telescope')

    telescope.setup({
        defaults = {
        },
        pickers = {
            lsp_definitions = {
                theme = "cursor",
            },
            lsp_implementation = {
                theme = "cursor",
            },
            lsp_type_definitions = {
                theme = "cursor",
            },
            lsp_references = {
                theme = "ivy",
            },
            lsp_incoming_calls = {
                theme = "cursor",
            },
            lsp_outgoing_calls = {
                theme = "cursor",
            },

            current_buffer_fuzzy_find = {
                theme = "ivy",
            },
            spell_suggest = {
                theme = "ivy",
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_cursor { }
            }
        }
    })

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
end
