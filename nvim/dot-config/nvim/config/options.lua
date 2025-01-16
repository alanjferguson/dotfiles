-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Better whitespace chars
vim.opt.list = false
vim.opt.listchars = {
  tab = "> ",
  trail = " ",
  nbsp = "+",
}

-- Disable Autoformat everywhere
vim.g.autoformat = false
