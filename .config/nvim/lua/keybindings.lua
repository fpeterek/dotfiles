
local lsp_opts = { noremap=true, silent=true }

vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<leader>dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', lsp_opts)

vim.api.nvim_set_keymap('n', '<leader>cl', '<cmd>set invcursorline<cr>', { noremap=true })

-- Remap <C-l> so I can use the combination elsewhere"
vim.api.nvim_set_keymap('n', '<C-s>', '<C-l>', { noremap=true })

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap=true })

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>vertical res -5<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>vertical res +5<cr>', { noremap=true })

-- Whilst, technically, lsp_on_attach is a variable, I choose to define it here
-- as the variable is used to define keybindings
lsp_on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', lsp_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sh', '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_opts)
end

vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>TagbarToggle<cr>', { noremap=true })

vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>Telescope find_files<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope git_files<cr>', { noremap=true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap=true })

vim.api.nvim_set_keymap('n', "<leader>nt", "<cmd>Neotree toggle<cr>", { noremap=true })

vim.keymap.set('n', '<leader>ddg', function() require("duck").hatch("🦆", 3) end, { noremap = true })
vim.keymap.set('n', '<leader>ddk', function() require("duck").cook() end, { noremap = true })
