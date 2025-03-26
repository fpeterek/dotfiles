local plugins = {
    "navarasu/onedark.nvim",

    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = comment_config
    },

    {
        "numToStr/FTerm.nvim",
        config = fterm_config,
        lazy = false
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
        config = ts_config
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        config = rainbow_config
    },

    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    {
        "nvim-lualine/lualine.nvim",
        config = lualine_config
    },
    "MunifTanjim/nui.nvim",

    {
        "nvim-neo-tree/neo-tree.nvim",
        config = neotree_config
    },

    {
        "neovim/nvim-lspconfig",
        config = nvim_lspconfig_config
    },

    {
        "hrsh7th/cmp-nvim-lsp",
        config = cmp_nvim_lsp_config
    },

    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    {
        "hrsh7th/nvim-cmp",
        config = nvim_cmp_config
    },

    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

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

    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {},
        -- config = trouble_config,
    },

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = lsp_lines_config,
    },

    {
        'fpeterek/nvim-surfers',
        config = surfers_config,
    },

    -- Should be the last plugins to load
    -- "ryanoasis/vim-devicons",
    "nvim-tree/nvim-web-devicons",
}

require("lazy").setup(plugins)
