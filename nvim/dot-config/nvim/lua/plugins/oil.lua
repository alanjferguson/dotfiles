return {
  "stevearc/oil.nvim",
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    default_file_explorer = true,
  },
  keys = {
    { "<leader>fe", "<Cmd>Oil<CR>", desc = "Open Oil" },
  },
}
