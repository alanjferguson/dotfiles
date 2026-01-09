-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--
--------------------------------------------------------------------------------
-- leader key mappings
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- file reading/writing
--------------------------------------------------------------------------------
vim.opt.swapfile = false -- disable swap file because they get annoying!
vim.opt.autoread = true -- auto reload with changes - useful for e.g. Claude
vim.opt.undofile = true -- use this instead of swap files

--------------------------------------------------------------------------------
-- appearance stuff
--------------------------------------------------------------------------------

-- cursor
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.wrap = false

--------------------------------------------------------------------------------
-- search settings
--------------------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

--------------------------------------------------------------------------------
-- splits and tabs
--------------------------------------------------------------------------------
vim.opt.splitbelow = true
vim.opt.splitright = true

--------------------------------------------------------------------------------
-- clipboard
--------------------------------------------------------------------------------
-- -- force OSC-52 clipboard, fixes bug where sometimes this capability isn't
-- -- detected but I at the moment only use terminals that have this support
-- vim.g.clipboard = "copy"

vim.opt.completeopt = "menu,menuone"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = true, -- always lazy load
    version = false, -- always use latest
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
  performance = {
    rtp = {
      --disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
