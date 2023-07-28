local plugins = {
    "navarasu/onedark.nvim",
    "numToStr/Comment.nvim",
    "norcalli/nvim-colorizer.lua",

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
    "nvim-lualine/lualine.nvim",
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

    "lewis6991/gitsigns.nvim",

    "ryanoasis/vim-devicons",
    "kyazdani42/nvim-web-devicons",
}

require("lazy").setup(plugins)
