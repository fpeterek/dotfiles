local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- TODO: Check if there's a better way to do this
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function()
      if vim.treesitter.get_parser(bufnr) then
          vim.treesitter.start()
      end
  end,
})

require("keybindings")
require("opts")
require("plugins")
require("colors")
require("lsps")

