local plugins = {

    -- {
    --     "navarasu/onedark.nvim",
    --     config = onedark_colorscheme
    -- },

    "akinsho/horizon.nvim",

    {
        "NTBBloodbath/doom-one.nvim",
        config = doomone_colorscheme
    },

    {
        "rose-pine/neovim",
        config = rosepine_colorscheme
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
        config = colorizer_config
    },

    {
        "preservim/tagbar",
    },

    "farmergreg/vim-lastplace",

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = ts_config,
        branch = "main",
        lazy = false,
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        config = rainbow_config
    },

    "nvim-lua/plenary.nvim",

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
        config = lualine_config
    },
    "MunifTanjim/nui.nvim",

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

    "neovim/nvim-lspconfig",

    {
        "hrsh7th/cmp-nvim-lsp",
        config = cmp_nvim_lsp_config
    },

    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    {
        "xzbdmw/colorful-menu.nvim"
    },

    {
        "hrsh7th/nvim-cmp",
        config = nvim_cmp_config
    },
    {
        "scalameta/nvim-metals",
        config = metals_config
    },

    {
        "lewis6991/gitsigns.nvim",
        config = gitsigns_config,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = ibl_config
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

    -- {
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = lsp_lines_config,
    -- },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = tiny_inline_diagnostic_config
    },

    {
        "https://git.sr.ht/~chinmay/clangd_extensions.nvim",
    },

    {
        'fpeterek/nvim-surfers',
        config = surfers_config,
    },

    -- Should be the last plugins to load
    "nvim-tree/nvim-web-devicons",
}

require("lazy").setup(plugins)
