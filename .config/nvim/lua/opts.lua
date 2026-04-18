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


vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function()
        -- There may be a better way to do this, idk
        -- But if there is a parser for the current filetype, we start Treesitter
        -- This is easier than writing the filetypes explicitely
        if vim.treesitter.get_parser(bufnr) then
            -- Folding - if I ever want it
            -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- vim.wo[0][0].foldmethod = 'expr'

            -- Indentation - experimental
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            vim.treesitter.start()
        end
    end,
})
