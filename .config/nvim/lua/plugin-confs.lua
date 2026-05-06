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
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_by_name = {
                    '.git',
                    'venv',
                    '.venv',
                },
                always_show = {
                    '.gitignore'
                },
            },
        },
        source_selector = {
            winbar = true,
            sources = {
                {
                    source = "filesystem",
                    display_name = " 󰉓 "
                },
                {
                    source = "buffers",
                    display_name = " 󰈚 "
                },
                {
                    source = "git_status",
                    display_name = " 󰊢 "
                },
                {
                    source = "document_symbols",
                    display_name = " 󰌗 "
                },
            },
        },
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols"
        }
    })
end


metals_config = function()
    local metals_conf = require('metals').bare_config()

    metals_conf.settings = {
        showImplicitArguments = true
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
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
                enabled = true,
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
        lsp = {
            hover = {
                silent = true,
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


blink_config = function()
    require("blink.cmp").setup({
        keymap = {
            preset = 'none',

            ['<CR>'] = { 'accept', 'fallback' },

            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },

            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        },

        sources = {
            default = {
                "lsp", "path", "buffer"
            },
            providers = {
                snippets = {
                    opts = {
                        friendly_snippets = false,
                    },
                },
            },
        },

        signature = { enabled = false, },

        completion = {
            ghost_text = {
                enabled = true,
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 50,
                window = { border = "rounded" }
            },

            menu = {
                border = "rounded",

                draw = {
                    columns = {
                        { "kind_icon", gap = 2 },
                        { "label", gap = 3 },
                        { "kind", gap = 3}
                    },

                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                        kind_icon = {
                            text = function(ctx)
                                return " " .. ctx.kind_icon .. " "
                            end,
                            highlight = function(ctx)
                                return "BlinkCmpKindIcon" .. ctx.kind
                            end,
                        },
                        kind = {
                            text = function(ctx)
                                return " " .. ctx.kind .. " "
                            end,
                        },
                    }, -- components

                }, -- draw

            }, -- menu

        }, -- completion

    }) -- setup
end

