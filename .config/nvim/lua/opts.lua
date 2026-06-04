vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true
vim.opt.cindent     = true
vim.opt.shiftround  = true

vim.opt.number         = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.opt.wildmenu = true

vim.opt.scrolloff     = 4
vim.opt.sidescrolloff = 12
vim.opt.smoothscroll  = true

vim.opt.smartcase  = true
vim.opt.hlsearch   = false
vim.opt.inccommand = "split"

vim.opt.breakat     = " ^I!@*-+;:,./?(){}[]<>="
vim.opt.showbreak   = "↪"
vim.opt.breakindent = true
vim.opt.linebreak   = true
vim.opt.wrap        = false

vim.opt.title       = true
vim.opt.titlestring = "nvim - %t"

vim.opt.mouse = "a"

vim.opt.cursorline  = true
vim.opt.colorcolumn = '100'

vim.opt.foldcolumn  = "1"
vim.opt.signcolumn  = "yes:3"

vim.opt.clipboard     = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.background    = "dark"

vim.opt.list      = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣',
    extends = '…',
}

vim.opt.completeopt = "fuzzy,menuone,noselect,popup"

vim.opt.splitbelow = true
vim.opt.splitright = true


vim.g.python_indent = {
    open_paren = 'shiftwidth()',
    continue = 'shiftwidth()',
    closed_paren_align_last_line = false,
}


vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function()
        -- There may be a better way to do this, idk
        -- But if there is a parser for the current filetype, we start Treesitter
        -- This is easier than writing the filetypes explicitely
        if vim.treesitter.get_parser(bufnr) then
            -- Indentation - experimental
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.treesitter.start()
        end
    end,
})

