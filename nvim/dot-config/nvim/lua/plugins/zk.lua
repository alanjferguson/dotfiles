return {
  {
    "zk-org/zk-nvim",
    main = "zk",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    opts = {
      picker = "fzf_lua",
      lsp = {
        -- `config` is passed to `vim.lsp.start(config)`
        config = {
          name = "zk",
          cmd = { "zk", "lsp" },
          filetypes = { "markdown" },
          -- on_attach = ...
          -- etc, see `:h vim.lsp.start()`
        },
      },
      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
      },
    },
    keys = {
      { "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", mode = "n", desc = "New note" },
      { "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", mode = "n", desc = "Open notes" },
      { "<leader>zt", "<Cmd>ZkTags<CR>", mode = "n", desc = "Open note with tag" },
      {
        "<leader>zf",
        "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
        mode = { "n", "v" },
        desc = "Search notes",
      },
    },
  },
}
