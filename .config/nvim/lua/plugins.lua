local plugins = {

    -- {
    --     "navarasu/onedark.nvim",
    --     config = onedark_colorscheme
    -- },

    { "tiagovla/tokyodark.nvim" },
    { "ankushbhagats/pastel.nvim" },


    {
        "akinsho/horizon.nvim",
    },

    {
        "Shatur/neovim-ayu",
    },

    {
        "NTBBloodbath/doom-one.nvim",
        config = doomone_colorscheme
    },

    {
        "serhez/teide.nvim",
        config = pica_del_teide_colorscheme
    },

    {
        'sainnhe/edge',
        config = edge_colorscheme
    },

    {
        'olimorris/onedarkpro.nvim',
        priority = 1000,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = colorizer_config,
    },

    {
        "farmergreg/vim-lastplace",
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = ts_config,
        branch = "main",
        lazy = false,
    },

    {
        "nvim-lua/plenary.nvim",
    },

    {
        "nvim-telescope/telescope.nvim",
        version = "*",

        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
            "nvim-telescope/telescope-ui-select.nvim"
        },
        config = telescope_config,
    },

    {
        "nvim-lualine/lualine.nvim",
        config = lualine_config,
    },

    {
        "MunifTanjim/nui.nvim",
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        config = neotree_config,
        depends = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
    },

    {
        "neovim/nvim-lspconfig",
    },

    {
        "saghen/blink.indent",
        config = blink_indent_config,
    },

    {
        "saghen/blink.pairs",
        version = "*",
        dependencies = {
            "saghen/blink.download",
        },
        config = blink_pairs_config,
    },


    {
        "saghen/blink.cmp",
        version = "*",
        config = blink_config,
    },

    {
        "xzbdmw/colorful-menu.nvim"
    },

    {
        "scalameta/nvim-metals",
        config = metals_config,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = gitsigns_config,
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = todo_config,
    },

    {
        "rcarriga/nvim-notify",
        config = notify_config,
    },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = noice_config,
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = tiny_inline_diagnostic_config,
    },

    {
        "https://git.sr.ht/~chinmay/clangd_extensions.nvim",
    },

    {
        'dmtrKovalenko/fff.nvim',
        lazy = false,
        opts = fff_opts,
        keys = fff_keys,
        build = function()
            require('fff.download').download_or_build_binary()
        end
    },

    {
        'mfussenegger/nvim-jdtls',
    },

    {
        'fpeterek/nvim-surfers',
        config = surfers_config,
    },

    -- Should be the last plugins to load
    {
        "nvim-tree/nvim-web-devicons",
    },
}

-- require('vim._core.ui2').enable()
require("lazy").setup(plugins)
