-- hack to fix lsp
local vim = vim

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

-- statuscolumn
vim.opt.signcolumn = "yes" -- always show so window width doesn't change

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

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = "win32yank"
end

--------------------------------------------------------------------------------
-- dependencies
--------------------------------------------------------------------------------

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/nvim-mini/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
local MiniDeps = require("mini.deps")
MiniDeps.setup({ path = { package = path_package } })

local add = MiniDeps.add
local now = MiniDeps.now
local later = MiniDeps.later

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

local function nmap(lhs, rhs, desc)
  map("n", lhs, rhs, desc)
end

local function vmap(lhs, rhs, desc)
  map("v", lhs, rhs, desc)
end

-- now(function() require("mini.basics").setup({extra_ui=true}) end)

add("https://github.com/Makaze/AnsiEsc")

--------------------------------------------------------------------------------
-- colorscheme
--------------------------------------------------------------------------------

add({
  source = "https://github.com/miikanissi/modus-themes.nvim",
  depends = {
    { source = "https://github.com/f-person/auto-dark-mode.nvim" },
  },
})

now(function()
  require("modus-themes").setup({
    style = "auto",
    variant = "tinted",
    dim_inactive = false,
  })

  require("auto-dark-mode").setup({
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      vim.cmd([[ colorscheme modus ]])
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      vim.cmd([[ colorscheme modus ]])
    end,
  })
end)

--------------------------------------------------------------------------------
-- treesitter
--------------------------------------------------------------------------------

if vim.fn.has('nvim-0.11.0') == 1 then
  add({
    source = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    depends = {
      { source = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
      { source = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    },
  })

  later(function()
    local ts_parsers = {
      "c",
      "lua",
      "markdown",
      "python",
    }
    local nts = require("nvim-treesitter")
    nts.install(ts_parsers)
    -- vim.api.nvim_create_autocmd('PackChanged', {callback = function() nts.update() end })
    vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
      callback = function(args)
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if not lang then
          return
        end
        if vim.treesitter.language.add(lang) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.treesitter.start()
        end
      end,
    })

    require("treesitter-context").setup({
      max_lines = 3,
      multiline_threshold = 1,
      min_window_height = 20,
    })

    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
    end
  end)
end

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

if vim.fn.has('nvim-0.11.0') == 1 then
  add({
    source = "https://github.com/neovim/nvim-lspconfig",
  })

  add({
    source = "https://github.com/mrcjkb/rustaceanvim",
  })

  later(function()
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
  end)
end

--------------------------------------------------------------------------------
-- DIAGNOSTICS
--------------------------------------------------------------------------------

add({
  source = "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
})

later(function()
  require("tiny-inline-diagnostic").setup()
  vim.diagnostic.config({
    virtual_text = false,
  })
end)

--------------------------------------------------------------------------------
-- Mini things
--------------------------------------------------------------------------------

now(function()
  require("mini.icons").setup()
  require("mini.statusline").setup()
  require("mini.starter").setup()
end)

now(function()
  require("mini.completion").setup()
  require("mini.trailspace").setup()
  require("mini.indentscope").setup()
  require("mini.git").setup()
  require("mini.diff").setup()

  local MiniFiles = require("mini.files")
  MiniFiles.setup()
  nmap("<leader>fe", function()
    MiniFiles.open()
  end, "Open File Explorer")

  local MiniPick = require("mini.pick")
  MiniPick.setup()
  nmap("<leader>:", function()
    MiniPick.command_history()
  end, "Command History")
  nmap("<leader>/", function()
    MiniPick.builtin.grep_live()
  end, "Grep")
  nmap("<leader>fb", function()
    MiniPick.builtin.buffers()
  end, "Buffers")
  nmap("<leader>fc", function()
    MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } })
  end, "Find Config File")
  nmap("<leader>ff", function()
    MiniPick.builtin.files()
  end, "Find Files")
  nmap("<leader>sh", function()
    MiniPick.builtin.help()
  end, "Help Pages")
  nmap("<leader>fr", function()
    MiniPick.builtin.resume()
  end, "Resume")

  local MiniExtra = require("mini.extra")
  MiniExtra.setup()
  nmap("<leader>fE", function()
    MiniExtra.pickers.explorer()
  end, "Open File Explorer")
  nmap("<leader>sd", function()
    MiniExtra.pickers.diagnostic()
  end, "Diagnostics")

  local MiniNotify = require('mini.notify')
  MiniNotify.setup()

  -- search
  -- nmap('<leader>s"', function()
  --   MiniPick.registers()
  -- end, "Registers")
  -- nmap("<leader>s/", function()
  --   MiniPick.search_history()
  -- end, "Search History")
  -- nmap("<leader>sa", function()
  --   MiniPick.autocmds()
  -- end, "Autocmds")
  -- nmap("<leader>sc", function()
  --   MiniPick.command_history()
  -- end, "Command History")
  -- nmap("<leader>sC", function()
  --   MiniPick.commands()
  -- end, "Commands")
  -- nmap("<leader>sH", function()
  --   MiniPick.highlights()
  -- end, "Highlights")
  -- nmap("<leader>si", function()
  --   MiniPick.icons()
  -- end, "Icons")
  -- nmap("<leader>sj", function()
  --   MiniPick.jumps()
  -- end, "Jumps")
  -- nmap("<leader>sk", function()
  --   MiniPick.keymaps()
  -- end, "Keymaps")
  -- nmap("<leader>sl", function()
  --   MiniPick.loclist()
  -- end, "Location List")
  -- nmap("<leader>sm", function()
  --   MiniPick.marks()
  -- end, "Marks")
  -- nmap("<leader>sM", function()
  --   MiniPick.man()
  -- end, "Man Pages")
  -- nmap("<leader>sq", function()
  --   MiniPick.qflist()
  -- end, "Quickfix List")
  -- nmap("<leader>su", function()
  --   MiniPick.undo()
  -- end, "Undo History")
end)

add({ source = "https://github.com/dhananjaylatkar/cscope_maps.nvim" })
later(function()
  require("cscope_maps").setup({
    cscope = {
      exec = "gtags-cscope",
      picker = "mini-pick",
    },
  })
end)

add({ source = "https://github.com/zk-org/zk-nvim" })
later(function()
  require("zk").setup({
    picker = "minipick",
    lsp = vim.fn.has('nvim-0.11.0') == 1 and {
      -- `config` is passed to `vim.lsp.start(config)`
      config = {
        name = "zk",
        cmd = { "zk", "lsp" },
        filetypes = { "markdown" },
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start()`
      },
    } or {},
    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
    },
  })
end)

add({ source = "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
later(function()
  require('render-markdown').setup()
end)

nmap("<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New note")
nmap("<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Open notes")
nmap("<leader>zt", "<Cmd>ZkTags<CR>", "Open note with tag")
map(
  { "n", "v" },
  "<leader>zf",
  "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
  "Search notes"
)

add({ source = "https://github.com/stevearc/conform.nvim" })
later(function()
  require('conform').setup()
end)

add({
  source = "https://github.com/folke/noice.nvim",
  depends = {
    { source = "https://github.com/MunifTanjim/nui.nvim"},
  },
})

later(function()
  require('noice').setup()
end)

add({
  source = "https://github.com/coder/claudecode.nvim",
  depends = {
    { source = "https://github.com/folke/snacks.nvim" },
  },
})
later(function()
  require("claudecode").setup()
end)
nmap("<leader>ac", "<cmd>ClaudeCode<cr>", "Toggle Claude")
nmap("<leader>af", "<cmd>ClaudeCodeFocus<cr>", "Focus Claude")
nmap("<leader>ar", "<cmd>ClaudeCode --resume<cr>", "Resume Claude")
nmap("<leader>aC", "<cmd>ClaudeCode --continue<cr>", "Continue Claude")
nmap("<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", "Select Claude model")
nmap("<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", "Add current buffer")
vmap("<leader>as", "<cmd>ClaudeCodeSend<cr>", "Send to Claude")
-- Diff management
nmap("<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", "Accept diff")
nmap("<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", "Deny diff")

now(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    triggers = {
      -- Leader triggers
      { mode = { "n", "x" }, keys = "<Leader>" },

      -- `[` and `]` keys
      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },

      -- Built-in completion
      { mode = "i", keys = "<C-x>" },

      -- `g` key
      { mode = { "n", "x" }, keys = "g" },

      -- Marks
      { mode = { "n", "x" }, keys = "'" },
      { mode = { "n", "x" }, keys = "`" },

      -- Registers
      { mode = { "n", "x" }, keys = '"' },
      { mode = { "i", "c" }, keys = "<C-r>" },

      -- Window commands
      { mode = "n", keys = "<C-w>" },

      -- `z` key
      { mode = { "n", "x" }, keys = "z" },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },

    window = { delay = 100 },
  })
end)
