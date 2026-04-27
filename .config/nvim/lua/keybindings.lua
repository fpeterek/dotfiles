
local lsp_opts = { noremap=true, silent=true }

vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', lsp_opts)

vim.api.nvim_set_keymap('n', '<leader>cl', '<cmd>set invcursorline<cr>', { noremap=true })

-- Remap <C-l> so I can use the combination elsewhere"
vim.api.nvim_set_keymap('n', '<C-s>', '<C-l>', { noremap=true })

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap=true })

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>vertical res -5<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>vertical res +5<cr>', { noremap=true })

vim.api.nvim_set_keymap('i', '<C-Space>', '<C-x><C-n>', { noremap=true })

-- Whilst, technically, lsp_on_attach is a variable, I choose to define it here
-- as the variable is used to define keybindings
lsp_buf_keybindings = function(bufnr)
    -- [g]oto
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', lsp_opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', lsp_opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', lsp_opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', lsp_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', lsp_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>Telescope lsp_implementation<CR>', lsp_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>Telescope lsp_type_definitions<CR>', lsp_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', lsp_opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gc', '<cmd>Telescope lsp_incoming_calls<CR>', lsp_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gC', '<cmd>Telescope lsp_outgoing_calls<CR>', lsp_opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gh', '<cmd>ClangdSwitchSourceHeader<CR>', lsp_opts)

    -- [r]ename
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_opts)

    -- [c]ode
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', lsp_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', lsp_opts)

    -- [s]how
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ss', '<cmd>lua vim.lsp.buf.signature_help()<CR>', lsp_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sh', '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>si', '<cmd>ClangdSymbolInfo<CR>', lsp_opts)
end


vim.api.nvim_set_keymap('n', '<leader>tb', '<cmd>TagbarToggle<cr>', { noremap=true })

vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>Telescope find_files<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope git_files<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>Telescope registers<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>TodoTelescope theme=ivy<cr>', { noremap=true })

vim.api.nvim_set_keymap('n', "<leader>nt", "<cmd>Neotree toggle<cr>", { noremap=true })
vim.api.nvim_set_keymap('n', "<leader>nf", "<cmd>Neotree filesystem<cr>", { noremap=true })
vim.api.nvim_set_keymap('n', "<leader>nb", "<cmd>Neotree buffers<cr>", { noremap=true })
vim.api.nvim_set_keymap('n', "<leader>ng", "<cmd>Neotree git_status<cr>", { noremap=true })
vim.api.nvim_set_keymap('n', "<leader>ns", "<cmd>Neotree document_symbols<cr>", { noremap=true })

